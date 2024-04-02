# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# config/schedule.rb

every 1.day, at: '2:00 am' do
    rake "db:backup"  # Utiliza un comando personalizado en lugar de pg_dump directamente
end
  
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
