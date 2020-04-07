class ThanksMailer < ApplicationMailer
  def send_mail(user)
    @user = user
    @url = "http://localhost:3000/users/#{@user.id}"
    mail(subject: "COMPLETE join your address", to: @user.email)
  end
end
