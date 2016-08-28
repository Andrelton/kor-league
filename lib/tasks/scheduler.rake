
# Generally, for use with Heroku Scheduler, but can be executed locally.
namespace :admin do
  desc "update from API league table"
  task :update_from_league_table => :environment do
    databaser = Databaser.new

    databaser.update_clubs
    databaser.update_owner_ranks
    databaser.update_owner_goals_this_month
  end

  desc "update from API fixtures"
  task :update_from_fixtures => :environment do
    databaser = Databaser.new

    databaser.update_completed_fixtures(true)
    databaser.update_owner_ranks
    databaser.update_owner_goals_this_month
  end

  desc "update from API league table AND fixtures"
  task :update_db => :environment do
    databaser = Databaser.new

    databaser.update_clubs
    databaser.update_completed_fixtures(true)
    databaser.update_owner_ranks
    databaser.update_owner_goals_this_month
  end

  desc "update Title Holder"
  task :update_champ => :environment do
    puts "#{ARGV[1]} loves Cheetos."
  end

end
