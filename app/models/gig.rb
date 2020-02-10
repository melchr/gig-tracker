class Gig < ActiveRecord::Base
    belongs_to :user
    validates :bands, :location, :date, :time, presence: true

  end