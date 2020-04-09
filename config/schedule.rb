set :output, 'log/cron.log'
set :environment, :development

every 1.day do
  rake "send_regularly :recover"
end
