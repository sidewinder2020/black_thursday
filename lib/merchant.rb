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
    @mr.find_all_items_by_merchant_id(id)
  end

end
