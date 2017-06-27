class History < ActiveRecord::Base
	belongs_to :lender
	belongs_to :borrower

	has_many :lenders_history, through: :historys, source: :lender
	has_many :borrower_history, through: :historys, source: :borrower

	validates :amount, presence: true
end
