require 'pry'
require 'beanstream'

MERCHANT_ID = '300204029'
API_KEY = 'BC60BC8F6A29496Ba8f2FC04A45Ea386'

MERCHANT_ID_ALT = '300204033'
API_KEY_ALT = '3243229A42934Eb2bcdb79f72E09A45b'

CREDIT_CARD_APPROVED = '4030000010001234'
CREDIT_CARD_DECLINED = '4003050500040005'
CVD_NUMBER = '123'

#binding.pry

begin

    puts 'initializing'
    Beanstream.merchant_id = MERCHANT_ID
    Beanstream.payments_api_key = API_KEY

    puts 'making the call to api'
    result = Beanstream.PaymentsAPI.make_payment( {
        :order_number => Beanstream::PaymentsAPI.generateRandomOrderId("test"),
        :amount => 100,
        :payment_method => Beanstream::PaymentMethods::CARD,
        :card => {
            :name => 'Mr. Card Tenderson',
            :number => CREDIT_CARD_APPROVED,
            :expiry_month => '07',
            :expiry_year => '22',
            :cvd => CVD_NUMBER,
            :complete => true
            }
    })
    puts "Success, TransactionID: #{result['id']}"

   # binding.pry

rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
end
