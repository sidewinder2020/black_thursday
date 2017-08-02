module SaInvoiceAnalysis
  def average_invoices_per_merchant_standard_deviation
    find_standard_deviation(@se.average_invoices_per_merchant)
  end

  def average_invoices_per_merchant
    find_avrg_of_array(@se.average_invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    top_merchant_object_array = []
    top_merchants_array = get_top_merchants_array_by_invoice
    top_merchants_array.each do |merchant_id|
      top_merchant_object_array << @se.get_merchant_by_id(merchant_id)
    end
    top_merchant_object_array
  end

  def get_top_merchants_array_by_invoice
    top_merchants_array = []
    top_merchants_hash = @se.get_count_by_merchant_id
    mean = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation * 2
    top_merchants_hash.each do |key,value|
      if value > standard_deviation + mean
        top_merchants_array << key
      end
    end
    top_merchants_array
  end

  def get_bottom_merchants_array_by_invoice_count
    bottom_merchants_array = []
    bottom_merchants_hash = @se.get_count_by_merchant_id
    mean = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation * 2
    bottom_merchants_hash.each do |key,value|
      if value < mean - standard_deviation
        bottom_merchants_array << key
      end
    end
    bottom_merchants_array
  end

  def bottom_merchants_by_invoice_count
    bottom_merchant_object_array = []
    bottom_merchants_array = get_bottom_merchants_array_by_invoice_count
    bottom_merchants_array.each do |merchant_id|
      bottom_merchant_object_array << @se.get_merchant_by_id(merchant_id)
    end
    bottom_merchant_object_array
  end

  def get_top_days_by_invoice_count
    top_days_of_the_week_array = []
    top_days_of_the_week_hash = @se.get_number_of_invoices_by_day_of_the_week
    mean = average_invoices_per_day
    standard_deviation =
    average_invoices_per_day_of_the_week_standard_deviation
    top_days_of_the_week_hash.each do |key,value|
      if value > standard_deviation + mean
        top_days_of_the_week_array << key
      end
    end
    top_days_of_the_week_array
  end

  def top_days_by_invoice_count
    get_top_days_by_invoice_count.map do |weekday|
      Date::DAYNAMES[weekday]
    end
  end

  def average_invoices_per_day
    find_avrg_of_array(@se.get_number_of_invoices_by_day)
  end

  def average_invoices_per_day_of_the_week_standard_deviation
    find_standard_deviation(@se.get_number_of_invoices_by_day)
  end

  def invoice_status(status)
    ((@se.number_of_invoices_by_status[status].to_f /
    @se.all_invoices_count) * 100).round(2)
  end

  def best_invoice_by_revenue
    invoice = valid_invoices_array.max_by do |invoice|
      invoice.total
    end
    invoice
  end

  def best_invoice_by_quantity
    invoice = valid_invoices_array.max_by do |invoice|
      invoice.quantity_of_items
    end
    invoice
  end
end
