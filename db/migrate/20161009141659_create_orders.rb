class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :listing, index: true, foreign_key: true
      t.string :ip
      t.string :express_token
	  t.string :express_payer_id
      t.timestamps
    end
  end
end
