class NotesController < ApplicationController

  get '/notes' do
    @user = current_user
    @notes = @user.notes

    if logged_in?
      erb :'/notes/view'
    end
  end

  get '/notes/new' do
    erb :'/notes/new'
  end

  post '/notes' do
    if params[:content] == "" || params[:title] = ""
      redirect '/notes/new'
    else
      @user = current_user
      @note = Note.create(:title => params[:title], :content => params[:content])
      @note.user_id = @user.id
      redirect '/notes'
    end
  end

end
