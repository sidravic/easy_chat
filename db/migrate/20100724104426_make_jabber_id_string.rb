class MakeJabberIdString < ActiveRecord::Migration
  def self.up
    remove_column :users, :jabber_id
    add_column :users, :jabber_id, :string

  end

  def self.down
    remove_column :users, :jabber_id
    add_column :users, :jabber_id, :integer
  end
end
