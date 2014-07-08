class AddAuthDataToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :auth_data, :text
  end
end
