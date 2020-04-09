namespace :send_regularly do
  desc "Send regularly everyday"
  task recover: :environment do
    DailyMailer.send_regularly.deliver_now
  end
end
