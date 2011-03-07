class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string  :provider
      t.string  :uid
      t.string  :twitter
      t.string  :avatar
      t.boolean :admin,    :default => false,  :null => false
      t.string  :name
      t.string  :title
      t.string  :company
      t.string  :contact
      t.text    :description
      t.text    :aboutus

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
