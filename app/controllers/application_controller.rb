class ApplicationController < Sinatra::Base
  
  enable :sessions
  register Sinatra::ActiveRecordExtension

  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    if logged_in?
      redirect '/notes'
    else
      erb :'/index'
    end
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
