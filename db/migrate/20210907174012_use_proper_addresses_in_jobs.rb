class UseProperAddressesInJobs < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :address
    add_column :jobs, :address_house_street, :string
    add_column :jobs, :address_city_town, :string
    add_column :jobs, :address_province_state, :string
    add_column :jobs, :address_post_code, :string
  end
end
