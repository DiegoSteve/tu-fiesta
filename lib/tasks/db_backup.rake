# lib/tasks/db_backup.rake

namespace :db do
    desc 'Realiza un respaldo de la base de datos'
    task :backup => :environment do
      system("pg_dump -h localhost -d tufiesta_development > #{Rails.root}/db/backup.sql")
    end
  end
  