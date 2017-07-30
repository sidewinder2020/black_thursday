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
require './test/invoice_item_test'
require './test/invoice_item_repository_test'
require './test/transaction_test'
require './test/transaction_repository_test'
require './test/customer_test'
require './test/customer_repository_test'
