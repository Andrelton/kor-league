# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# AVATARS
# https://s10.postimg.io/6d5s00l89/brad.jpg
# https://s3.postimg.io/wrq5pieoj/dean.jpg
# https://s9.postimg.org/f60pqxmun/eric.jpg


# Owner.create(name: "Brad", avatar: "https://s10.postimg.io/6d5s00l89/brad.jpg")
# Owner.create(name: "Dean", avatar: "https://s3.postimg.io/wrq5pieoj/dean.jpg")
# Owner.create(name: "Rik")
# Owner.create(name: "Eric", avatar: "https://s9.postimg.org/f60pqxmun/eric.jpg")
# Owner.create(name: "Nick")
# Owner.create(name: "Jarred")
# Owner.create(name: "John K.")
# Owner.create(name: "Mark")
# Owner.create(name: "John Z.")
# Owner.create(name: "Matt")
# Owner.create(name: "Luke")

# databaser = Databaser.new

# databaser.seed_pretty_club_names
# databaser.seed_clubs
# databaser.assign_clubs_to_owners
# databaser.seed_fixtures

# man_city = Club.find_by(fd_id: 65)
# man_city.crest_url = "https://upload.wikimedia.org/wikipedia/en/e/eb/Manchester_City_FC_badge.svg"
# man_city.save

# Fixture.delete_all
# Databaser.new.seed_fixtures

# club_1 = Club.find_by(fd_id: 110)
# club_1.crest_url = "https://upload.wikimedia.org/wikipedia/en/e/e4/SS_Lazio.svg"
# club_1.save

# club_2 = Club.find_by(fd_id: 6)
# club_2.crest_url = "https://upload.wikimedia.org/wikipedia/commons/6/6d/FC_Schalke_04_Logo.svg"
# club_2.save

fixture1 = Fixture.where(home_club_id: 94).where(away_club_id: 559).first
fixture1.completed = true
fixture1.home_club_goals = 0
fixture1.away_club_goals = 0
fixture1.save

fixture2 = Fixture.where(home_club_id: 471).where(away_club_id: 585).first
fixture2.home_club_goals = 0
fixture2.away_club_goals = 3
fixture2.save

club = Club.where(fd_id: 471).first
club.points = 3
club.goals_this_month = 2
club.save



