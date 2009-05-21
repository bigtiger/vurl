class Vurl < ActiveRecord::Base; has_many :clicks; end

namespace :click_counts do

  desc "Update vurl counter caches"
  task :update_cache => :environment do
    Vurl.all.each do |vurl|
      vurl.clicks_count = vurl.clicks.count
      vurl.save!
    end
  end
end
