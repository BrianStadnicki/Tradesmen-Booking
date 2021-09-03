document.addEventListener("turbolinks:load", function () {
    let currentPage = 2
    let notificationsLeft = true
    let requestLock = false
    document.getElementById("navbarDropdownMenuLinkNotificationsMenu").addEventListener("scroll", function (event) {
        console.log(notificationsLeft, requestLock)
        if(notificationsLeft && !requestLock && this.scrollTop + this.clientHeight + 10 >= this.scrollHeight) {
            console.log("scrolled to bottom")
            document.getElementById("navbarDropdownMenuLinkNotificationsMenuLoading").style.display = "block"
            requestLock = true
            fetch("/users/current_id")
                .then(response => response.json())
                .then(current_id => {
                    fetch("/users/" + current_id.id + "/notifications?page=" + currentPage)
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
                            requestLock = false
                        })
                })
        }
    })
})
