class Merchant
  attr_reader :merchant_info

  def initialize(merchant_info, sales_engine)
    @se            = sales_engine
    @merchant_info = merchant_info
  end

  def name
    merchant_info[:name]
  end

  def id
    merchant_info[:id]
  end

  def items
    @se.items.find_all_by_merchant_id(id)
  end

end
