# README

## Local SSL Development
`rails s -b 'ssl://localhost:3000?key=config/certs/localhost-key.pem&cert=config/certs/localhost.pem'`

## Notifications
`bundle exec sidekiq`

## Create Admin seed
`User.create!(name: "Admin", email: "tradesmenbook@gmail.com", confirmed_at: Date.new, phone: "07543709205", role: Role.user_category.find_by(name: "Admin"), password: "ipoidfugodsfkgeaprfgsd$££$%%£$%£$%fdskpalosdf£4234235345345ASDFASDFTErete£$%^$%GT")`
