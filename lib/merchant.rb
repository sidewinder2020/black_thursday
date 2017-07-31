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
    invoices.map do |invoice|
      invoice.customer
    end
  end
end

# And if we started with a merchant we could find the
# customers who’ve purchased one or more items at their store:
