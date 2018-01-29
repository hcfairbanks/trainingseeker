class ExampleMailer < ApplicationMailer
  default from: "hcfairbanks@gmail.com"

 def sample_email(user)
   #@user = current_user
   #mail(to: @user.email, subject: 'Sample Email')
   @user_2 = UserSession.find
   @user = "hcfairbanks@gmail.com"
     puts "*" * 20
   mail(to: @user, subject: 'Sample Email')
     puts "*" * 20
 end

end
