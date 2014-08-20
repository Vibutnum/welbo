# encoding: utf-8
class LoginController < ApplicationController
  skip_before_filter :verification
	def new
		
	end
	def create
		puts params[:name], params[:password]
	  user = User.where(:name => params[:login][:name], :password => params[:login][:password]).first 
		if user.present?
			session[:id] = user.id
			redirect_to root_url
		else
			flash[:warning] = I18n.t = '你输入的账户与密码不匹配'
			redirect_to new_login_path
		end
	end

	def destroy
		session[:id] = nil
		redirect_to new_login_path
	end
end
