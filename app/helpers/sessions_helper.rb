module SessionsHelper
  def sign_in user
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def current_user= user
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user? user
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    #is nil after a redirect anyway
    self.current_user = nil
  end

  def signed_in_user(new_return_point = request.url)
      # raise signed_in?.inspect
      unless signed_in?
        set_return_point(new_return_point)
        redirect_to signin_path, notice: "Please sign in."
      end
  end
end
