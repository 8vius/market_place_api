module Authenticable
  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
      status: :unauthorized unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find_by(auth_token: authorization_header)
  end

  def user_signed_in?
    current_user.present?
  end

  private

  def authorization_header
    request.headers['Authorization']
  end
end
