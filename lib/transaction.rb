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
    @credit_card_expiration_date = cc_expir_handler(transaction_hash)
    @result = transaction_hash[:result]
    @created_at = Time.parse(transaction_hash[:created_at])
    @updated_at = Time.parse(transaction_hash[:updated_at])
    @tr = tr
  end

  def cc_expir_handler(transaction_hash)
    if transaction_hash[:credit_card_expiration_date].to_s.length == 3
      transaction_hash[:credit_card_expiration_date].to_s.prepend("0")
    else
    transaction_hash[:credit_card_expiration_date].to_s
    end
  end

  def invoice
    @tr.find_invoice_by_id(@invoice_id)
  end

end

#
# transaction = se.transactions.find_by_id(40)
# transaction.invoice # => invoice
