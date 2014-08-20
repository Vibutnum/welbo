# encoding: utf-8
module LoginHelper

  
 
  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
  	@current_user = user
  end

  def current_user
    
    @current_user ||= User.find(session[:id])
  end

  def current_user?(user)
    user.id == session[:id]
  end

 

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath if request.get?
  end
end
