class AddReferralsCountToUser < ActiveRecord::Migration
  def change
  	add_column :users, :referrals_count, :integer, :default => 0, :null => false
  	User.find_each { |user| User.reset_counters(user.id, :referrals) }
  end
end
