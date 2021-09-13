document.addEventListener("turbolinks:load", function () {

    let currentPage = 2
    let fetchPageLock = false
    let pagesLeft = true

    window.onscroll = async function (event) {
        if (document.getElementById("main-paginated") && !fetchPageLock && pagesLeft && window.innerHeight + window.pageYOffset >= document.body.offsetHeight - 100) {
            fetchPageLock = true
            if (!await fetchAndInsert(currentPage)) {
                pagesLeft = false
                fetchPageLock = false
            } else {
                currentPage += 1
                fetchPageLock = false
            }
        }
    }
})

function fetchAndInsert(page) {
    return fetch(getUrlWithParameter(window.location.href, "page", page))
        .then(response => response.text())
        .then(doc => new DOMParser().parseFromString(doc, "text/html"))
        .then(doc => {
            let currentTable = document.getElementById("main-paginated")
            let fetchedTable = doc.getElementById("main-paginated")
            while (fetchedTable.childNodes.length) {
                currentTable.appendChild(fetchedTable.childNodes[0])
            }
        })
}

function getUrlWithParameter(url, parameter, value) {
    if (url.includes("?" + parameter + "=")) {
        return url.replace("?" + parameter + "=" + getUrlParameterFromURL(url, parameter), "?" + parameter + "=" + value)
    } else if (url.includes("&" + parameter + "=")) {
        return url.replace("&" + parameter + "=" + getUrlParameterFromURL(url, parameter), "&" + parameter + "=" + value)
    } else if (url.indexOf("?") !== url.length - 1 && url.indexOf("?") !== -1) {
        return url + "&" + parameter + "=" + value
    } else if (url.indexOf("?") !== -1) {
        return url + parameter + "=" + value
    } else {
        return url + "?" + parameter + "=" + value
    }
}

function getUrlParameterFromURL(url, param) {
    let urlParams = url.substring(url.indexOf("?") + 1)
    let urlVariables = urlParams.split("&")

    for (let i = 0; i < urlVariables.length; i++) {
        let parameterName = urlVariables[i].split("=")

        if (parameterName[0] === param) {
            return typeof parameterName[1] === undefined ? true : decodeURIComponent(parameterName[1])
        }
    }
    return false
}
