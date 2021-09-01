namespace :user do
  desc "Randomly assign user to spots"
  task check_in: :environment do
    spots = Spot.where(category: "spot")
    derek = User.find_by(username: "Derek")
    derek.spot = nil
    derek.save
    User.where.not(username: "Derek") do |user|
      user.spot = spots.sample
      user.save
    end
  end
end
