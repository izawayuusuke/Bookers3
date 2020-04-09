class DailyMailer < ApplicationMailer
  def send_regularly
    # @user = user
    @url = "http://localhost:3000/users/#{@user.id}"
    mail(subject: "Hello, World", bcc: User.pluck(:email))
  end
end
