document.addEventListener("turbolinks:load", function () {
    let currentPage = 2
    let notificationsLeft = true
    let fetchNotificationsRequestLock = false
    let userID = self.localStorage.getItem("user_id")
    document.getElementById("navbarDropdownMenuLinkNotificationsMenu").addEventListener("scroll", function (event) {
        if (notificationsLeft && !fetchNotificationsRequestLock && this.scrollTop + this.clientHeight + 10 >= this.scrollHeight) {
            document.getElementById("navbarDropdownMenuLinkNotificationsMenuLoading").style.display = "block"

            fetchNotificationsRequestLock = true
            fetch("/users/" + userID + "/notifications?page=" + currentPage)
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
                        notificationsLeft = false
                    }
                    currentPage += 1
                    fetchNotificationsRequestLock = false
                })
        }
    })
})
