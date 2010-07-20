class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :jabber_id, :integer
      t.column :email_id, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
