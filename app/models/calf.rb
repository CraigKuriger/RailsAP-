class Calf < ActiveRecord::Base
	belongs_to :cow
	has_many :comments, dependent: :destroy

	def average_comment
		ratings = comments.map {|comment| comment.rating}
		ratings.reduce(:+) / ratings.length
	end

	def latest_comment
		comments.order(:created_at).last.body
	end
end
