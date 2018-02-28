class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/notes'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup/error'
    end

    if !User.find_by(:username => params[:username])
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/login'
    else
      redirect '/signup/error'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/notes'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    if @user && @user.authenticate(params[:password])
      redirect '/notes'
    else
      redirect '/login'
    end
  end

  get '/signup/error' do
    erb :'/users/signup_error'
  end




end
