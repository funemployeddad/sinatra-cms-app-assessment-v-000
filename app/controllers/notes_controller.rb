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
      else
        current_user.notes.create(title: params[:title], content: params[:content])
        redirect '/notes'
      end
    else
      redirect '/login'
    end
   end

   get '/notes/:slug/edit' do
     if logged_in?
       @user = current_user
       @note = @user.notes.find_by_slug(params[:slug])
       erb :'/notes/edit'
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

  patch '/notes/:slug' do
    @note = Note.find_by_slug(params[:slug])
    @user = current_user
    if !params[:content].empty? && !params[:title].empty?
      if @note.user_id == @user.id
        @note.update(:title => params[:title], :content => params[:content])
        @user.save
      end
    end
      redirect '/notes'
  end

  delete '/notes/:slug/delete' do
    @user = current_user
    if logged_in?
      if @user.notes.find_by_slug(params[:slug])
        @note = @user.notes.find_by_slug(params[:slug])
      end
      if @note.user_id == @user.id
        @note.delete
        @user.save
      end
    end
    redirect '/notes'
  end

end
