class AddReferralsCountToUser < ActiveRecord::Migration
  def change
  	add_column :users, :referrals_count, :integer
  	User.find_each { |user| User.reset_counters(user.id, :referrals) }
  end
end
