class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/notes'
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    if !User.find_by(:username => params[:username])
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    end
      redirect '/login'
  end





  helpers do
     def logged_in?
       !!current_user
     end

     def current_user
       @current_user ||= User.find(session[:user_id]) if session[:user_id]
     end

     def logout!
       session.clear
     end
   end
end
