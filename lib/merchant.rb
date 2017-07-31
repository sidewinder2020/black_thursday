require 'pry'

class Merchant
  attr_reader :merchant_info

  def initialize(merchant_info, mr)
    @mr            = mr
    @merchant_info = merchant_info
  end

  def name
    merchant_info[:name]
  end

  def id
    merchant_info[:id]
  end

  def items
    @mr.find_all_by_merchant_id(id)
  end

  def invoices
    @mr.get_all_invoices_by_merchant_id(id)
  end

  def customers
    customer_list = []
    invoices.each do |invoice|
      customer_list << invoice.customer
    end
    customer_list.uniq
  end

end
