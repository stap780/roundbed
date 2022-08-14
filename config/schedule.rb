# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# очистить cron -> crontab -r
# просмотр cron -> crontab -l
# сохранение и запуск cron в режиме девелопмент (писать в терминале) ->  whenever --set environment='production' --write-crontab или 
# RAILS_ENV=production whenever --write-crontab
# очистить cron - bundle exec whenever --clear-crontab
# сервер минус 3 часа (лето) и минус 4 (зима)

env :PATH, ENV['PATH']
env "GEM_HOME", ENV["GEM_HOME"]
set :output, "#{path}/log/cron.log"
set :chronic_options, :hours24 => true

every 1.day, :at => '13:50' do #
  runner "Laete.download"#, :environment => :production
end
every 1.day, :at => '14:00' do #
  runner "Laete.insales_to_csv"#, :environment => :production
end

every 1.day, :at => '14:10' do #
  runner "Evatek.download"#, :environment => :production
end
every 1.day, :at => '14:20' do #
  runner "Evatek.insales_to_csv"#, :environment => :production
end
every 1.day, :at => '14:30' do #
  runner "Alvitek.insales_to_csv"#, :environment => :production
end
every 1.day, :at => '14:40' do #
  runner "Cleo.download"#, :environment => :production
end
every 1.day, :at => '14:50' do #
  runner "Cleo.insales_to_csv"#, :environment => :production
end
every 1.day, :at => '15:00' do #
  runner "Marc.insales_to_csv"#, :environment => :production
end
every 1.day, :at => '15:10' do #
  runner "Best.download"#, :environment => :production
end
every 1.day, :at => '15:20' do #
  runner "Best.insales_to_csv"#, :environment => :production
end
every 1.day, :at => '15:25' do #
  runner "Infa.download"#, :environment => :production
end
every 1.day, :at => '15:30' do #
  runner "Infa.insales_to_csv"#, :environment => :production
end






