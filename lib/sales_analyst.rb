require_relative 'sales_engine'
require_relative 'sa_merchant_analysis'
require_relative 'sa_invoice_analysis'
require_relative 'sa_item_analysis'
require 'bigdecimal'
require 'date'
require 'pry'

class SalesAnalyst
  include SaMerchantAnalysis
  include SaInvoiceAnalysis
  include SaItemAnalysis

  def initialize(sales_engine)
    @se = sales_engine
  end

  def find_avrg_of_array(array)
    (array.reduce(:+) / array.length.to_f).round(2)
  end

  def find_standard_deviation(array)
    deviant_array = []
    mean = find_avrg_of_array(array)
    array.each do |number|
      deviant_array << (mean - number)**2
    end
    deviant_number =
    (deviant_array.reduce(:+)) / ((deviant_array.length - 1).to_f)
    (Math.sqrt(deviant_number)).round(2)
  end

  def top_buyers(number = 20)
    all_customers = @se.all_customers
    all_customers.max_by(number) do |customer|
      customer.get_total_spent
    end
  end

  def find_customer_by_id(customer_id)
    @se.find_customer_by_id(customer_id)
  end

  def top_merchant_for_customer(customer_id)
    find_customer_by_id(customer_id).top_merchant_for_customer
  end
end
