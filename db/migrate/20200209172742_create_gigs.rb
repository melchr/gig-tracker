class CreateGigs < ActiveRecord::Migration
  def change
    create_table :gigs do |t|
      t.string :bands
      t.string :location
      t.date :date
      t.string :time
    end
  end
end
