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
        .then(doc => new DOMParser().parseFromString(doc, "text/html"))
        .then(doc => {
            let menuLoading = document.getElementById("navbarDropdownMenuLinkNotificationsMenuLoading")
            menuLoading.style.display = "none"
            if (doc.body.innerHTML !== "") {
                let menu = document.getElementById("navbarDropdownMenuLinkNotificationsMenu")
                while (doc.body.childNodes.length) {
                    menu.insertBefore(doc.body.firstChild, menuLoading)
                }
            } else {
                loading.remove()
            }
        })
}
