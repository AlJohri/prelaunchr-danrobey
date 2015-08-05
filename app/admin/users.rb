ActiveAdmin.register User do

  index do
    column :id
    column :email
    column :referral_code
    column :referrer_id
    column :referrals_count
    column :created_at
    column :updated_at
    default_actions
  end

  csv do
    column :id
    column :email
    column :referral_code
    column :referrer_id
    column :referrals_count
    column :created_at
    column :updated_at
  end

end
