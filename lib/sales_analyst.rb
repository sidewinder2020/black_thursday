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
    merchant_id = find_customer_by_id(customer_id).top_merchant_for_customer
    @se.get_merchant_by_id(merchant_id)
  end

  # def one_time_buyers
  #   @se.all_customers.select do |customer|
  #     customer.invoices.count == 1
  #   end
  # end
  #
  # def one_time_buyers_invoices
  #   one_time_buyers.map do |customer|
  #     customer.invoices
  #   end.flatten
  # end
  #
  # def one_time_buyers_items_items
  #   item_id_array = []
  #   one_time_buyers_invoices.each do |invoice|
  #     invoice.items.each do |item|
  #       item_id_array << item.id
  #     end
  #   end
  #   item_id_array
  # end
  #
  # def one_time_buyers_item
  #   binding.pry
  #   items_count = one_time_buyers_items_items
  #   counts = Hash.new(0)
  #   items_count.each do |item|
  #     counts[item] += 1
  #   end
  #   counts
  # end

  def items_bought_in_year(customer_id, year)
    customer = @se.find_customer_by_id(customer_id)
    invoices = customer.find_customer_invoices_by_year(year)
    item_array = []
      invoices.each do |invoice|
        invoice.items.each do |item|
          item_array << item
        end
      end
      item_array
  end

end
