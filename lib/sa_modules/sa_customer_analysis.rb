module SaCustomerAnalysis
  def find_customer_by_id(customer_id)
    @se.find_customer_by_id(customer_id)
  end

  def top_merchant_for_customer(customer_id)
    merchant_id = find_customer_by_id(customer_id).top_merchant_for_customer
    @se.get_merchant_by_id(merchant_id)
  end

  def top_buyers(number = 20)
    all_customers = @se.all_customers
    all_customers.max_by(number) do |customer|
      customer.get_total_spent
    end
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

  def highest_volume_items(customer_id)
    get_highest_count_item_ids(customer_id).map do |item_id|
      @se.find_item_by_item_id(item_id)
    end
  end

  def get_all_customer_item_ids(customer_id)
    item_id_hash = {}
    customer = @se.find_customer_by_id(customer_id)
      customer.invoices.each do |invoice|
        item_id_hash.merge!(invoice.quantity_by_item_id)
      end
      item_id_hash
  end

  def get_highest_count_item_ids(customer_id)
    crappy_array = []
    item_id_hash = get_all_customer_item_ids(customer_id)
    max = item_id_hash.values.max
      item_id_hash.each do |key, value|
        if value == max
           crappy_array << key
        end
      end
      crappy_array
  end

  def customers_with_unpaid_invoices
    all_customers = @se.all_customers
    all_customers.find_all do |customer|
      customer.unpaid_invoices?
    end
  end

  def top_ten_customers_by_outstanding_invoices
    customers_with_unpaid_invoices.max_by(10) do |customer|
      customer.total_of_unpaid_invoices
    end
  end

  def ten_most_wanted
    the_hit_hash = Hash.new
    top_ten_customers_by_outstanding_invoices.each do |customer|
      the_hit_hash[customer.name] = customer.total_of_unpaid_invoices
    end
    the_hit_hash
  end
  
  def valid_invoices_array
    invoice_array = []
    @se.all_invoices.each do |invoice|
      if invoice.is_paid_in_full?
        invoice_array << invoice
      end
    end
    invoice_array
  end

end
