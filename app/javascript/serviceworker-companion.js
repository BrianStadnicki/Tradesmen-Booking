const registerServiceWorker = async () => {
    const registration = await navigator.serviceWorker.register('/service-worker.js', { scope: '/' })
    console.log("Service worker registered")
    return registration
}

const requestNotificationPermission = async (registration) => {
    const permission = await self.Notification.requestPermission()
    if(permission !== 'granted') {
        throw new Error('Permission not granted for Notification');
    } else {
        console.log('Permission granted!');
        try {
            const options = {
                applicationServerKey: urlB64ToUint8Array("BJ2mZ3uSBnh6Zho2MNgXpqdqF3c1vRXS-34ULfGdn9L8woat7ayX6hgzJce3FzMqBpFjplgJl-oaH3nDpJbJWSM"),
                userVisibleOnly: true,
            }
            return await registration.pushManager.subscribe(options)
        } catch (err) {
            console.log('Error while registering notifications', err)
            registration.pushManager.getSubscription().then(subscription => {
                subscription.unsubscribe().then(function () {
                    console.log('Unsubscribed from current notifications')
                }).catch(function (e) {
                    console.log('Failed to unsubscribe', e)
                })
            })
        }
    }
}

const saveNotificationSubscription = async subscription => {
    if (!(self.localStorage.getItem("notification_subscription") && self.localStorage.getItem("notification_subscription") === JSON.stringify(subscription))) {
        console.log("Registering notification subscription with server")
        let userID = self.localStorage.getItem("user_id")
        await fetch('/users/' + userID + '/edit')
                .then(response => response.text())
                .then(doc => new DOMParser().parseFromString(doc, "text/html"))
                .then(formDoc => {
                    fetch('/users/' + userID, {
                        method: 'put',
                        redirect: 'manual',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json',
                            'X-Requested-With': 'XMLHttpRequest',
                            'X-CSRF-Token': formDoc.querySelector("[name='csrf-token']").content
                        },
                        body: JSON.stringify( {user: { notification_subscription: JSON.stringify(subscription) }})
                    }).then(response => {
                        if (response.ok) {
                            self.localStorage.setItem("notification_subscription", JSON.stringify(subscription))
                        }
                    })
                })
    }
}

const main = async () => {
    const registration = await registerServiceWorker()
    const subscription = await requestNotificationPermission(registration)
    await saveNotificationSubscription(subscription)
}

main()

const urlB64ToUint8Array = base64String => {
    const padding = '='.repeat((4 - (base64String.length % 4)) % 4)
    const base64 = (base64String + padding).replace(/\-/g, '+').replace(/_/g, '/')
    const rawData = atob(base64)
    const outputArray = new Uint8Array(rawData.length)
    for (let i = 0; i < rawData.length; ++i) {
        outputArray[i] = rawData.charCodeAt(i)
    }
    return outputArray
}
