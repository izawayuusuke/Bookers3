env :PATH, ENV['PATH']
set :output, 'log/cron.log'
set :environment, :development

every 1.day, at: "7:00 am" do
  runner "DailyMailer.send_regularly"
end
