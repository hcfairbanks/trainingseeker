class RefundPayment
  
  def run
    #should have user data from login
    #purchase database entry should have all the necessary info

    #stub and fix later
    merchant_id = '300204029'
    api_key = 'BC60BC8F6A29496Ba8f2FC04A45Ea386'
    @purchase = Purchase.where(id: 1)

    Beanstream.merchant_id = merchant_id
    Beanstream.payments_api_key = api_key

    transaction_id = @purchase.first.response_id
    amount = @purchase.first.price

    refund_result = Beanstream.PaymentsAPI.return_payment(transaction_id, amount)

    puts "Success: result=#{refund_result.inspect}"

    @purchase.update(
      status: 5,
      refund_response: refund_result.to_s)

  rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
  end

end
