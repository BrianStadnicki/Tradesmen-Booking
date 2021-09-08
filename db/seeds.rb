# Role categories
role_category_user = RoleCategory.create!(name: 'User', description: 'Permissions around general')
role_category_business = RoleCategory.create!(name: 'Business', description: 'Permissions around business management')
role_category_tradesmen = RoleCategory.create!(name: 'Tradesmen Profile',
                                               description: 'Permissions around tradesmen')

# User Roles
role_user_admin = Role.create!(name: 'Admin', description: 'Administrator over everything', category: role_category_user)
role_user_tradesman = Role.create!(name: 'Tradesman', description: 'Tradesman do the work', category: role_category_user)
role_user_booker = Role.create!(name: 'Booker', description: 'Able to book tradesmen, through a business',
                                category: role_category_user)

# Business roles
role_business_owner = Role.create!(name: 'Owner', description: 'Owns the business', category: role_category_business)
role_business_admin = Role.create!(name: 'Admin', description: 'Administrator over the business',
                                   category: role_category_business)
role_business_employee = Role.create!(name: 'Employee',
                                      description: 'Employee over business, can manage jobs but not business',
                                      category: role_category_business)

# Tradesmen roles
role_tradesmen_owner = Role.create!(name: 'Owner', description: 'Owns the tradesmen profile',
                                    category: role_category_tradesmen)
role_tradesmen_admin = Role.create!(name: 'Admin', description: 'Administrator over tradesmen profile',
                                    category: role_category_tradesmen)
role_tradesmen_employee = Role.create!(name: 'Employee',
                                       description: 'Employee of tradesmen profile, can manage jobs but not profile',
                                       category: role_category_tradesmen)

# Tradesmen trades
tradesmen_trade_plumber = TradesmenTrade.create!(name: 'Plumber')
tradesmen_trade_electrician = TradesmenTrade.create!(name: 'Electrician')
tradesmen_trade_builder = TradesmenTrade.create!(name: 'Builder')
tradesmen_trade_painter = TradesmenTrade.create!(name: 'Painter')

# Users

# Admin
user_admin = User.create!(name: 'An Admin', email: '05bs001@gmail.com',
                          phone: '0746435464', role: role_user_admin, password: 'password',
                          password_confirmation: 'password')
# Tradesmen owners
user_tradesmen_1_owner = User.create!(name: 'N1 Tradesman Owner', email: '05bs002@gmail.com',
                                      phone: '0746435164',
                                      role: role_user_tradesman, password: 'password',
                                      password_confirmation: 'password')
user_tradesman_2_owner = User.create!(name: 'N2 Tradesman Owner', email: '05bs003@gmail.com',
                                      phone: '07464356164',
                                      role: role_user_tradesman, password: 'password',
                                      password_confirmation: 'password')
# Tradesmen admins
user_tradesmen_1_admin = User.create!(name: 'N1 Tradesman Admin', email: '05bs012@gmail.com',
                                      phone: '0746435164',
                                      role: role_user_tradesman, password: 'password',
                                      password_confirmation: 'password')
user_tradesman_2_admin = User.create!(name: 'N2 Tradesman Admin', email: '05bs013@gmail.com',
                                      phone: '07464356164',
                                      role: role_user_tradesman, password: 'password',
                                      password_confirmation: 'password')
# Tradesmen employees
user_tradesmen_1_employee = User.create!(name: 'N1 Tradesman Employee', email: '05bs008@gmail.com',
                                         phone: '0746435164',
                                         role: role_user_tradesman, password: 'password',
                                         password_confirmation: 'password')
user_tradesmen_2_employee = User.create!(name: 'N2 Tradesman Employee', email: '05bs009@gmail.com',
                                         phone: '0746435164',
                                         role: role_user_tradesman, password: 'password',
                                         password_confirmation: 'password')
# Booker owners
user_booker_1_owner = User.create!(name: 'Owner booker1', email: '05bs005@gmail.com',
                                   phone: '0746235164',
                                   role: role_user_booker, password: 'password',
                                   password_confirmation: 'password')
user_booker_2_owner = User.create!(name: 'Owner booker2', email: '05bs007@gmail.com',
                                   phone: '0746135164',
                                   role: role_user_booker, password: 'password',
                                   password_confirmation: 'password')
# Booker admins
user_booker_1_admin = User.create!(name: 'Admin booker1', email: '05bs010@gmail.com',
                                   phone: '0746235164',
                                   role: role_user_booker, password: 'password',
                                   password_confirmation: 'password')
user_booker_2_admin = User.create!(name: 'Admin booker1', email: '05bs011@gmail.com',
                                   phone: '0746235164',
                                   role: role_user_booker, password: 'password',
                                   password_confirmation: 'password')
# Booker employees
user_booker_1_employee = User.create!(name: 'Employee booker1', email: '05bs004@gmail.com',
                                      phone: '0746235164',
                                      role: role_user_booker, password: 'password',
                                      password_confirmation: 'password')
user_booker_2_employee = User.create!(name: 'Employee booker2', email: '05bs006@gmail.com',
                                      phone: '0756235164',
                                      role: role_user_booker, password: 'password',
                                      password_confirmation: 'password')
# Businesses
business_1 = Business.create!(name: 'Lettings agent uno', description: 'The first', address: 'adsfsdfadf',
                              phone: '34544335', owner: user_booker_1_owner)
business_2 = Business.create!(name: 'Council duo', description: '2nd ones', address: 'adff s fdsdf',
                              phone: '343 434345', owner: user_booker_2_owner)

# Business users
BusinessUser.create!(business: business_1, user: user_booker_1_owner, role: role_business_owner)
BusinessUser.create!(business: business_1, user: user_booker_1_admin, role: role_business_admin)
BusinessUser.create!(business: business_1, user: user_booker_1_employee, role: role_business_employee)
BusinessUser.create!(business: business_2, user: user_booker_2_owner, role: role_business_owner)
BusinessUser.create!(business: business_2, user: user_booker_2_admin, role: role_business_admin)
BusinessUser.create!(business: business_2, user: user_booker_2_employee, role: role_business_employee)

# Tradesmen profiles
tradesmen_profile_1 = TradesmenProfile.create!(name: 'First Plumbings', description: 'The first', phone: '34234',
                                               owner: user_tradesmen_1_owner)
tradesmen_profile_2 = TradesmenProfile.create!(name: 'Second electrics & painting', description: 'Premier service',
                                               phone: '34234234324', owner: user_tradesman_2_owner)

tradesmen_profile_1.save!
tradesmen_profile_2.save!

# Tradesmen profile users
TradesmenProfileUser.create!(tradesmen_profile_id: tradesmen_profile_1.id, user: user_tradesmen_1_owner,
                             role: role_tradesmen_owner)
TradesmenProfileUser.create!(tradesmen_profile_id: tradesmen_profile_1.id, user: user_tradesmen_1_admin,
                             role: role_tradesmen_admin)
TradesmenProfileUser.create!(tradesmen_profile_id: tradesmen_profile_1.id, user: user_tradesmen_1_employee,
                             role: role_tradesmen_employee)
TradesmenProfileUser.create!(tradesmen_profile_id: tradesmen_profile_2.id, user: user_tradesman_2_owner,
                             role: role_tradesmen_owner)
TradesmenProfileUser.create!(tradesmen_profile_id: tradesmen_profile_2.id, user: user_tradesman_2_admin,
                             role: role_tradesmen_admin)
TradesmenProfileUser.create!(tradesmen_profile_id: tradesmen_profile_2.id, user: user_tradesmen_2_employee,
                             role: role_tradesmen_employee)

# Tradesmen profile trades
TradesmenProfilesTrades.create!(tradesmen_profile_id: tradesmen_profile_1.id, tradesmen_trade: tradesmen_trade_plumber)
TradesmenProfilesTrades.create!(tradesmen_profile_id: tradesmen_profile_2.id, tradesmen_trade: tradesmen_trade_electrician)
TradesmenProfilesTrades.create!(tradesmen_profile_id: tradesmen_profile_2.id, tradesmen_trade: tradesmen_trade_painter)
