module Receiptable
  extend ActiveSupport::Concern

  included do 
    validates :receipt_num, uniqueness: true, allow_blank: true
  end

  def generate_receipt_num
    self.update(receipt_num: rand(100000..999999).to_s)
  end
end