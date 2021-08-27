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
                applicationServerKey: urlB64ToUint8Array("BD87MR72mMzHzoMk8pekLiZy7gfiKsLFV-fPP5z9XSJxQ7e0vUYLwfoFABuMwoWfVndK4AvpHs7T4KSy2nGjIBA"),
                userVisibleOnly: true,
            }
            const subscriptions = await registration.pushManager.subscribe(options)
            console.log(JSON.stringify(subscriptions))
        } catch (err) {
            console.log('Error while registering notifications', err)
        }
    }
}

const main = async () => {
    const registration = await registerServiceWorker()
    const permission = await requestNotificationPermission(registration)
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
