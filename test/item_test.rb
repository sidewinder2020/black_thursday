require './lib/item'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    @ir = ItemRepository.new("./data/items.csv", @se)
    @item = Item.new({
                    :id          => 263395237,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => 50000,
                    :merchant_id => 12334189,
                    :created_at  => "2016-01-11 11:44:00 UTC",
                    :updated_at  => "2006-08-26 06:56:21 UTC"
                  }, @ir)
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_an_id
    assert_equal 263395237, @item.id
  end

  def test_it_has_a_name
    assert_equal "Pencil", @item.name
  end

  def test_it_has_a_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_has_a_unit_price
    assert_instance_of BigDecimal, @item.unit_price
  end

  def test_it_has_a_merchant_id
    assert_equal 12334189, @item.merchant_id
  end

  def test_it_has_a_created_at_date
    assert_equal Time.parse('2016-01-11 11:44:00 UTC'), @item.created_at
  end

  def test_it_has_an_updated_date
    assert_equal Time.parse('2006-08-26 06:56:21 UTC'), @item.updated_at
  end

  def test_it_can_convert_unit_price_to_dollars
    assert_equal 500.00, @item.unit_price_to_dollars
  end

  def test_it_can_find_merchant_by_item_id
    assert_instance_of Merchant, @item.merchant
  end

end
