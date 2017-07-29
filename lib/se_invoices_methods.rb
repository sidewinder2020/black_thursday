module SeInvoicesMethods
    def all_invoices_count
      @invoices.all.count
    end

    def average_invoices_per_merchant
      @invoices.average_invoices_per_merchant
    end

    def get_all_invoices_by_merchant_id(id)
      @invoices.get_all_invoices_by_merchant_id(id)
    end

    def get_count_by_merchant_id
      @invoices.get_count_by_merchant_id
    end

    def get_number_of_invoices_by_day
      @invoices.get_number_of_invoices_by_day
    end

    def get_number_of_invoices_by_day_of_the_week
      @invoices.get_invoice_count_by_day_of_week
    end

    def number_of_invoices_by_status
      @invoices.number_of_invoices_by_status
    end
end
