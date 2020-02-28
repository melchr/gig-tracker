class User < ActiveRecord::Base
    has_secure_password
    has_many :gigs
    validates :name, :email, :password_digest, presence: true 
  
  end