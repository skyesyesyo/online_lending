class HistorysController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]
	def create
		@history = History.new history_params
		
		@borrower = Borrower.find(params[:historys][:borrower_id])
		@lender = Lender.find(params[:historys][:lender_id])

		# Check if borrower raised enough money
		if @borrower.raised.to_i + @history.amount > @borrower.money
			flash[:errors] = ["Borrower will reach more than need."]
			redirect_to :back
		# check if lender has enough money
		elsif @lender.money < @history.amount
			flash[:errors] = ["You don't have enough money to lend"]
			redirect_to :back

		elsif @history.save
			#borrower_raise = borrower raised + history amount
			@borrower.raised = @borrower.raised.to_i + @history.amount
			@lender.money = @lender.money - @history.amount

			# update borrower raised
			@borrower.update(raised: @borrower.raised)

			# update lender money
			@lender.update(money: @lender.money)

			redirect_to :back
		else
	  		flash[:errors] = @user.errors.full_messages
	  		redirect_to :back
	  	end
	end

	private
		def history_params
			params.require(:historys).permit(:amount, :borrower_id, :lender_id)
		end

end
