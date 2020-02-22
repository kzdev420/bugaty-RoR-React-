class AddDealsCategory < ActiveRecord::Migration[5.0]
  class Category < ApplicationRecord
  end

  def up
    Category.create(name: 'Deals')
  end

  def down
    Category.find_by(name: 'Deals').delete
  end
end
