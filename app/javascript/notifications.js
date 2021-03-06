document.addEventListener("turbolinks:load", function () {

    let currentPage = 2
    let notificationsLeft = true
    let userID = self.localStorage.getItem("user_id")
    let fetchNotificationLock = false
    {
        const callback = function(mutationsList, observer) {
            fetchNotifications(userID, 1)
            observer.disconnect()
        }
        const observer = new MutationObserver(callback)
        observer.observe(document.getElementById("navbarDropdownMenuLinkNotificationsMenu"), { attributes: true })
    }

    document.getElementById("navbarDropdownMenuLinkNotificationsMenu").addEventListener("scroll", async function (event) {
        if (!fetchNotificationLock && notificationsLeft && this.scrollTop + this.clientHeight + 10 >= this.scrollHeight) {
            fetchNotificationLock = true
             if (await fetchNotifications(userID, currentPage) === false) {
                 notificationsLeft = false
                 fetchNotificationLock = false
             } else {
                 currentPage += 1
                 fetchNotificationLock = false
             }
        }
    })
})

async function fetchNotifications(userID, page) {
    let loading = document.getElementById("navbarDropdownMenuLinkNotificationsMenuLoading")
    if (!loading) return false
    loading.style.display = "block"

    return fetch("/users/" + userID + "/notifications?page=" + page)
        .then(response => response.text())
        .then(notificationsDoc => new DOMParser().parseFromString(notificationsDoc, "text/html"))
        .then(notificationsDoc => {
            let menuLoading = document.getElementById("navbarDropdownMenuLinkNotificationsMenuLoading")
            menuLoading.style.display = "none"
            if (notificationsDoc.body.innerHTML !== "") {

                prepareForms(notificationsDoc)

                let menu = document.getElementById("navbarDropdownMenuLinkNotificationsMenu")
                while (notificationsDoc.body.childNodes.length) {
                    menu.insertBefore(notificationsDoc.body.firstChild, menuLoading)
                }
            } else {
                loading.remove()
            }
        })
}

window.updateNotifications = async function updateNotifications(userID) {
    incrementNotificationsBadge()
    let menu = document.getElementById("navbarDropdownMenuLinkNotificationsMenu")
    if (menu.childElementCount !== 1) {
        return fetch("/users/" + userID + "/notifications?page=1")
            .then(response => response.text())
            .then(notificationsDoc => new DOMParser().parseFromString(notificationsDoc, "text/html"))
            .then(notificationsDoc => {
                if (notificationsDoc.body.innerHTML !== "") {
                    let newestExisting = menu.firstElementChild.id.split('-')[1]
                    notificationsDoc.body.childNodes.forEach(notification => {
                        if (notification.tagName) {
                            if (notification.id.split('-')[1] > newestExisting) {
                                prepareForms(notification)
                                menu.insertBefore(notification, menu.firstChild)
                            }
                        }
                    })
                }
            })
    }
}

function incrementNotificationsBadge() {
    let badge = document.querySelector("#navbarDropdownMenuLinkNotifications > .badge")
    badge.style.display = "inline-block"
    badge.textContent++
}

function decrementNotificationsBadge() {
    let badge = document.querySelector("#navbarDropdownMenuLinkNotifications > .badge")
    if (badge.style.display === "none") return
    badge.textContent--
    if (badge.textContent === "0") {
        badge.style.display = "none"
    }
}

function prepareForms(element) {
    element.querySelectorAll("li > form").forEach(form => {
        form.addEventListener("submit", function (event) {
            event.preventDefault()
            form.getElementsByClassName("btn")[0].disabled = true
            let formData = new FormData(event.target)
            if (formData.get("notification[read]") === 'false') {
                incrementNotificationsBadge()
            } else {
                decrementNotificationsBadge()
            }
            fetch(event.target.action, {
                method: "POST",
                body: new URLSearchParams(formData)
            })
                .then(response => response.text())
                .then(notificationDoc => new DOMParser().parseFromString(notificationDoc, "text/html"))
                .then(notificationDoc => {
                    prepareForms(notificationDoc)
                    form.parentNode.parentNode.replaceChild(notificationDoc.body.firstChild, form.parentNode)
                })
        })
    })
}
