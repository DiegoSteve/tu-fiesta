class Event < ApplicationRecord
    belongs_to :user 
    has_many :guests, dependent: :destroy
end
