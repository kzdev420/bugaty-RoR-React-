# frozen_string_literal: true

class CreatePaymentRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_requests do |t|
      t.integer :request_type, null: false
      t.integer :state, null: false
      t.decimal :price, precision: 10, scale: 2
      t.decimal :delivery_cost, precision: 10, scale: 2
      t.string :payment_method, null: false
      t.string :discount_code
      t.text :message
      t.text :reply_message
      t.text :details
      t.references :user, foreign_key: true
      t.references :listing, foreign_key: true

      t.timestamps
    end

    add_index :payment_requests, :request_type
    add_index :payment_requests, :state
  end
end
