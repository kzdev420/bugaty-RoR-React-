class AddSomeFiledsToSearch < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :longitude, :float
    add_column :searches, :latitude, :float
  end
end
