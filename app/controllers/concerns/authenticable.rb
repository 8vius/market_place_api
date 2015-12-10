module Authenticable
  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
      status: :unauthorized unless current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(auth_token: authorization_header)
  end

  private

  def authorization_header
    request.headers['Authorization']
  end
end
