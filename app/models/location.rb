class Location < ActiveRecord::Base
    has_many :users, through: :plants
    has_many :plants
end
