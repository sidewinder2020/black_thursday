require './lib/merchant_repository'
require './lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class MerchantRepositoryTest < Minitest::Test
# REFACTOR TO USE DUMMY DATA

  def setup
    @se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
    @mr = MerchantRepository.new("./data/merchants.csv", @se)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_merchants_all
    assert_equal 475, @mr.all.count
  end

  def test_all_returns_all_merchants_in_the_correct_format
    assert_instance_of Merchant, @mr.merchants[0]
    assert_equal 'Shopin1901', @mr.merchants[0].name
    assert_equal 12334105, @mr.merchants[0].id
    assert_equal 475, @mr.merchants.count
  end

  def test_find_by_id_returns_specified_merchant_instance
    merchant = @mr.find_by_id(12334105)
    nil_merchant = @mr.find_by_id(1231412543534543)
    
    assert_equal 'Shopin1901', merchant.name
    assert_nil nil_merchant
  end

  def test_find_by_name_returns_specified_merchant_instance
    merchant = @mr.find_by_name('Shopin1901')
    nil_merchant = @mr.find_by_name('Sals hammocks')
    merchant_upcase = @mr.find_by_name('SHOPIN1901')

    assert_equal 12334105, merchant.id
    assert_equal 12334105, merchant_upcase.id
    assert_nil nil_merchant
  end

  def test_find_all_by_name_returns_an_array_with_one_or_more_matches
    merchant = @mr.find_all_by_name('little')
    nil_merchant = @mr.find_all_by_name('Sals hammocks')
    merchant_upcase = @mr.find_all_by_name('LITTLE')

    assert_equal 4, merchant.count
    assert_equal 4, merchant_upcase.count
    assert_equal 0, nil_merchant.count
    assert_equal 'littledorisdesigns', merchant[0].name
    assert_equal 'littledorisdesigns', merchant_upcase[0].name
  end

  def test_create_array_of_merchant_ids
    assert_equal 475, @mr.all_ids.count
    assert_instance_of Fixnum, @mr.all_ids[27]
  end

  def test_get_total_inventory
    assert_equal 475, @mr.get_total_inventory.count
    assert_instance_of Fixnum, @mr.get_total_inventory[5]
  end

  def test_merchant_items_count
    assert_equal 3, @mr.merchant_items_count(12334105)
    assert_equal 25, @mr.merchant_items_count(12334123)
    assert_equal 0, @mr.merchant_items_count(12334110)
  end

  def test_return_merchants_by_item_count_greater_than
    assert_equal 15, @mr.return_merchants_by_item_count_greater_than(10).count
    assert_equal 9, @mr.return_merchants_by_item_count_greater_than(12).count
  end
end
