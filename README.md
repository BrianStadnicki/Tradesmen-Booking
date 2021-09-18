# README

## Local SSL Development
`rails s -b 'ssl://localhost:3000?key=config/certs/localhost-key.pem&cert=config/certs/localhost.pem'`

## Notifications
`bundle exec sidekiq`

## Create Admin seed
` User.create!(name: "Admin", email: "05bs001@gmail.com", phone: "345345345", role: Role.user_category.find_by(name: "Admin"), password: "password")`
