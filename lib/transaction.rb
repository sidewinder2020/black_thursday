require 'pry'
require 'time'

class Transaction
attr_reader :id,
            :invoice_id,
            :credit_card_number,
            :credit_card_expiration_date,
            :result,
            :created_at,
            :updated_at

  def initialize(transaction_hash, tr)
    @id = transaction_hash[:id]
    @invoice_id = transaction_hash[:invoice_id]
    @credit_card_number = transaction_hash[:credit_card_number]
    @credit_card_expiration_date = cc_expir_handler(transaction_hash[:credit_card_expiration_date])
    @result = transaction_hash[:result]
    @created_at = Time.parse(transaction_hash[:created_at])
    @updated_at = Time.parse(transaction_hash[:updated_at])
    @tr = tr
  end

  def cc_expir_handler(expiration_date)
    '0%o' % expiration_date
  end

  def invoice
    @tr.find_invoice_by_id(@invoice_id)
  end

end

#
# transaction = se.transactions.find_by_id(40)
# transaction.invoice # => invoice
