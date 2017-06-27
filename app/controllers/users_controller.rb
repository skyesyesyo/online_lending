class UsersController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]
	before_action :require_correct_user, only: [:edit, :show, :update, :destroy]
	layout "two"
  def index
  end

  def create
  	@user =Lender.new user_params
  	if @user.save
  		redirect_to "/sessions/new"
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to :back
  	end
  end

  def show
    @user = Lender.find(params[:id])
    @borrowers = Borrower.all
  end

  def edit
  end

  def update
    # @user = Lender.find(params[:id])
    # @borrower = Borrower.find(params[:id])
    # if @borrower.update(params[:raised])
    #   redirect_to "/users/#{@user.id}"
    # else
    #   flash[:errors] = @borrower.errors.full_messages
    #   redirect_to "/users/#{@user.id}"
    # end



  end

  def destroy

  end

  private
  	def require_correct_user
  		if current_user != Lender.find(params[:id])
  			redirect_to "/users/#{session[:user_id]}"
  		end
  	end

  	def user_params
  		params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
  	end

      def lending_params
        params.require(:borrower).permit(:first_name, :last_name, :email, :password, :money, :purpose, :description, :raised)
      end
end
