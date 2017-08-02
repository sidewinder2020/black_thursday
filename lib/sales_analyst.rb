require_relative 'sales_engine'
require_relative './sa_modules/sa_merchant_analysis'
require_relative './sa_modules/sa_invoice_analysis'
require_relative './sa_modules/sa_item_analysis'
require_relative './sa_modules/sa_customer_analysis'
require_relative './sa_modules/sa_math'
require 'bigdecimal'
require 'date'
require 'pry'

class SalesAnalyst
  include SaMerchantAnalysis
  include SaInvoiceAnalysis
  include SaItemAnalysis
  include SaCustomerAnalysis
  include SaMath

  def initialize(sales_engine)
    @se = sales_engine
  end

end
