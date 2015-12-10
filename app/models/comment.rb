class Comment < ActiveRecord::Base
	belongs_to :calf
	validates :body, presence: true
    validates :rating, presence: true
    validates_inclusion_of :rating, :in => 1..5
end
