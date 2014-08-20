class ApplicationController < ActionController::Base
  protect_from_forgery
  include LoginHelper
  before_filter :verification
  

  def verification
  	if session[:id].blank?
  		redirect_to new_login_path
  	end
  	
  end
end
