class SendPayment
 
  attr_accessor :course, :user, :numseats, :purchase, :card, :seats
  
  def initialize(purchase)
    @purchase = purchase
  end

  def run
    #card = { name: 'Mr Card Tenderson', number: '4030000010001234', expiry_month: '07', expiry_year: '22', cvd: '123'}

    #binding.pry

    #these should provide the proper values
    if @purchase.course.provider_id == @purchase.user.provider_id
      #should get discounted rate
      merchant_id = @purchase.course.provider.provider_accounts.where(discount_type: 'discounted').first.merchant_id
      api_key = @purchase.course.provider.provider_accounts.where(discount_type: 'discounted').first.api_key
    else
      #should be charged regular amount
      merchant_id = @purchase.course.provider.provider_accounts.where(discount_type: 'regular').first.merchant_id
      api_key = @purchase.course.provider.provider_accounts.where(discount_type: 'regular').first.api_key
    end

    Beanstream.merchant_id = merchant_id
    Beanstream.payments_api_key = api_key

    result = Beanstream.PaymentsAPI.make_payment( {
      order_number: Beanstream::PaymentsAPI.generateRandomOrderId('test'),
      amount: purchase.price,
      payment_method: Beanstream::PaymentMethods::CARD,
      card: {
        name: purchase.card_name,
        number: purchase.credit_card_number,
        expiry_month: purchase.expiry_month,
        expiry_year: purchase.expiry_year,
        cvd: purchase.cvd,
        complete: true
      }
    })
    puts "Success, TransactionID: #{result['id']}"

    @purchase.update(
      status: :succeeded, 
      response_id: result['id'],
      full_response: result.to_s)

  rescue Exception => e
    @purchase.update(
      status: :failed,
      full_response: e.message
    )
    puts e.message
    puts e.backtrace.inspect
  end

end
