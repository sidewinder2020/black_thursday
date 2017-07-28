require './lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class MerchantTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :merchants => "./data/merchants.csv",
    :items     => "./data/items.csv"
    })
    @merchant = Merchant.new({:id => 12334105, :name => 'Shopin1901'}, @se)
  end

  def test_it_exists
  assert_instance_of Merchant, @merchant
  end

  def test_can_retrieve_name
    assert_equal 'Shopin1901', @merchant.name
  end

  def test_it_can_retrieve_id
    assert_equal 12334105, @merchant.id
  end

  def test_it_can_find_items_by_merchant_id
    assert_instance_of Item, @merchant.items[0]
  end

end
