document.addEventListener("turbolinks:load", function () {
    let tradesmenSignUpBtn = document.getElementById("sign-up-tradesmen-btn")
    if (!tradesmenSignUpBtn) return
    tradesmenSignUpBtn.onclick = function () {
        document.getElementById("sign-up-options").style.display = "none"
        document.getElementById("tradesmen-sign-up-form").style.display = "block"
        return false
    }
})
