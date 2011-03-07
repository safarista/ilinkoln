class AddLocationToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :location, :string
  end

  def self.down
    remove_column :members, :location
  end
end
