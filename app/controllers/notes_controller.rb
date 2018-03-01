class NotesController < ApplicationController

  get '/notes' do
    @user = current_user
    @notes = @user.notes
    if logged_in?
      erb :'/notes/index'
    end
  end

  get '/notes/new' do
    erb :'/notes/new'
  end

  post '/notes' do
    if logged_in?
      if params[:content].empty? || params[:title].empty?
        redirect '/notes/new'
        binding.pry
      else
        @user = current_user
        @note = Note.create(:title => params[:title], :content => params[:content])
        @note.user_id = @user.id
        @user.notes << @note
        @user.save
        redirect '/notes'
      end
    else
      redirect '/login'
    end
   end

  get '/notes/:slug' do
    if logged_in?
      @user = current_user
      @note = Note.find_by_slug(params[:slug])
      erb :'/notes/view'
    else
      redirect '/login'
    end
  end


end
