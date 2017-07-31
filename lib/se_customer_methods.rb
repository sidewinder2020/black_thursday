module SeCustomerMethods
  def find_customer_by_id(customer_id)
    @customers.find_by_id(customer_id)
  end
end
