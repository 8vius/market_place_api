module Authenticable
  def current_user
    @current_user ||= User.find_by(auth_token: authorization_header)
  end

  private

  def authorization_header
    request.headers['Authorization']
  end
end
