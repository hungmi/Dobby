class Rent < ActiveRecord::Base
  enum pay_state: { unpaid: 0, paid: 1 }

  has_many :payment_infos, dependent: :destroy

  include Tokenable
  include Receiptable
  
  validates :total, :house_name, :room_name, presence: true

  def make_payment!(result)
    self.paid!
    self.generate_receipt_num
    self.payment_infos.create do |pi|
      pi.merchant_id = result["MerchantID"]
      pi.total = result["Amt"]
      pi.trade_no = result["TradeNo"]
      pi.merchant_order_no = result["MerchantOrderNo"]
      pi.check_code = result["CheckCode"]
      pi.ip = result["IP"]
      pi.payment_type = result["PaymentType"]
      pi.pay_time = result["PayTime"]
      pi.card_6no = result["Card6No"]
      pi.card_4no = result["Card4No"]
    end
  end
end
