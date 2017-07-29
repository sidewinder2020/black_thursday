require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

require './test/item_repository_test'
require './test/item_test'
require './test/merchant_repository_test'
require './test/merchant_test'
require './test/salesengine_test'
require './test/sales_analyst_test'
require './test/invoice_test'
require './test/invoice_repository_test'
