document.addEventListener("turbolinks:load", function () {
    let currentPage = 2
    let notificationsLeft = true
    let fetchNotificationsRequestLock = false
    let fetchCurrentIDRequestLock = false
    let currentID
    document.getElementById("navbarDropdownMenuLinkNotificationsMenu").addEventListener("scroll", function (event) {
        if (notificationsLeft && !fetchNotificationsRequestLock && this.scrollTop + this.clientHeight + 10 >= this.scrollHeight) {
            document.getElementById("navbarDropdownMenuLinkNotificationsMenuLoading").style.display = "block"
            if (!currentID && !fetchCurrentIDRequestLock) {
                fetchCurrentIDRequestLock = true
                fetch("/users/current_id")
                    .then(response => response.json())
                    .then(current_id => {
                        currentID = current_id.id
                        fetchCurrentIDRequestLock = false
                    })
            } else {
                fetchNotificationsRequestLock = true
                fetch("/users/" + currentID + "/notifications?page=" + currentPage)
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
        }
    })
})
