class AddUserIdToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :user_id, :integer
  end
end
