class ChangeModelTable < ActiveRecord::Migration
  def self.up
    add_column :users, :crypted_password, :string
    add_column :users, :password_salt, :string
    add_column :users, :persistence_token, :string
    add_column :users, :perishable_token, :string
    rename_column :users, :email_id, :email
    add_column :users, :login_count, :integer
    add_column :users, :current_login_ip, :string 
  end

  def self.down
    remove_column :users, :crypted_password
    remove_column :users, :password_salt
    remove_column :users, :persistence_token
    remove_column :users, :perishable_token
    rename_column :users, :email, :email_id
    remove_column :users, :login_count
    remove_column :users, :current_login_ip
  end
end
