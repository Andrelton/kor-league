
# Generally, for use with Heroku Scheduler, but can be executed locally.
namespace :admin do
  desc "update clubs, owner points rank, and fixtures"
  task :update_db => :environment do
    databaser = Databaser.new

    # These can be accomplished in eric_console
    # databaser.update_clubs
    # databaser.update_owner_ranks
    # databaser.update_owner_goals_this_month

    databaser.update_fixtures
  end
end
