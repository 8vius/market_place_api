class Api::V1::SessionsController < ApplicationController
  respond_to :json

  def create
    email = params[:session][:email]
    password = params[:session][:password]

    @user = email.present? && User.find_by(email: email)

    if @user.valid_password?(password)
      sign_in @user, store: false
      @user.generate_authentication_token!
      @user.save
      render :show, status: :ok
    else
      render(
        json: { errors: "Invalid email or password" },
        status: :unprocessable_entity
      )
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    head :no_content
  end
end
