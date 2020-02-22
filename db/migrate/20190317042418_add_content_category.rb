class AddContentCategory < ActiveRecord::Migration[5.0]
  class Category < ApplicationRecord
  end

  def up
    Category.create(name: 'Content', payable: false)
  end

  def down
    Category.find_by(name: 'Content').delete
  end
end
