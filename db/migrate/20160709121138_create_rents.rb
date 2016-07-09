class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.string :token
      t.string :receipt_num
      t.integer :pay_state, default: 0
      t.integer :total
      t.string :payment_method
      t.string :house_name
      t.string :room_name
      t.string :billing_mail

      t.timestamps null: false
    end
  end
end
