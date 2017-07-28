require 'bigdecimal'
require 'time'

class Item
  attr_reader :item_info,
              :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item_info, ir)
    @ir                = ir
    @item_info         = item_info
    @id                = item_info[:id]
    @name              = item_info[:name]
    @description       = item_info[:description]
    @unit_price = BigDecimal.new(item_info[:unit_price].to_s.insert(-3, "."))
    @merchant_id       = item_info[:merchant_id]
    @created_at        = Time.parse(item_info[:created_at])
    @updated_at        = Time.parse(item_info[:updated_at])
  end

  def unit_price_to_dollars
    (item_info[:unit_price] / 100).to_f
  end

  def merchant
    @ir.return_merchant_by_item_id(@id)
  end

end
