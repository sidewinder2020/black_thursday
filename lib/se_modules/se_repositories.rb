module SeRepositories
  def customer_repository(csv_hash)
    if csv_hash[:customers]
      CustomerRepository.new(csv_hash[:customers], self)
    end
  end

  def invoice_item_repository(csv_hash)
    if csv_hash[:invoice_items]
      InvoiceItemRepository.new(csv_hash[:invoice_items], self)
    end
  end

  def item_repository(csv_hash)
    if csv_hash[:items]
      ItemRepository.new(csv_hash[:items], self)
    end
  end

  def merchant_repository(csv_hash)
    if csv_hash[:merchants]
      MerchantRepository.new(csv_hash[:merchants], self)
    end
  end

  def invoice_repository(csv_hash)
    if csv_hash[:invoices]
      InvoiceRepository.new(csv_hash[:invoices], self)
    end
  end

  def transaction_repository(csv_hash)
    if csv_hash[:transactions]
      TransactionRepository.new(csv_hash[:transactions], self)
    end
  end

end
