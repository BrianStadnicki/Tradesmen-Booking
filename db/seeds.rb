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
["Bell hanger", "Boilermaker", "Carpenter", "Carpet layer", "Dredger", "Electrician", "Elevator mechanic", "Fencer", "Glazier", "Heavy equipment operator", "HVAC Technician", "Insulation", "Ironworker", "Laborer", "Landscaper", "Linemen", "Mason", "Millwright", "Painter", "Pile driver", "Pipefitter", "Plasterer", "Plumber", "Sheet metal worker", "Steel fixer", "Waterproofer", "Welder"].each do |type|
  TradesmenTrade.create!(name: type)
end
