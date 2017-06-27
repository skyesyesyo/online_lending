class BorrowersController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]
	before_action :require_current_borrower, only: [:edit, :show, :updates, :destroy]
  layout "two"

  def index
  end

  def create
  	@user = Borrower.new user_params
  	if @user.save
  		redirect_to "/sessions/new"
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to :back

  	end
  end

  def show
    @user = Borrower.find(params[:id])
    # @lenders = Borrower.find(params[:id]).historys

    @transactions = History.includes(:lender).where(borrower_id: session[:user_id])
  end


  def edit
  end

  private
  	def require_current_borrower
  		if current_borrower != Borrower.find(params[:id])
  			redirect_to "/borrowers/#{session[:user_id]}"
  		end
  	end

  	def user_params
  		params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money, :purpose, :description)

  	end
end
