module Authenticable

  # devise method override
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end
end