class SessionsController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]
  def new
  end

  def create
  	@user_lender = Lender.find_by_email(params[:email])

    @user_borrower = Borrower.find_by_email(params[:email])
  	if @user_lender && @user_lender.authenticate(params[:password])
  		session[:user_id] = @user_lender.id
  		redirect_to "/users/#{@user_lender.id}"
    elsif @user_borrower && @user_borrower.authenticate(params[:password])
      session[:user_id] = @user_borrower.id
      redirect_to "/borrowers/#{@user_borrower.id}"
  	else
  		flash[:errors]=["Please enter correct Eamil and passwords"]
  		redirect_to "/sessions/new"
  	end
  end

  def destroy
  	reset_session
  	redirect_to "/sessions/new"

  end

end
