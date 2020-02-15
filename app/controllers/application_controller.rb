require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "mels_session"
  end

  get '/' do
    erb :welcome
  end


  get '/logout' do
    session.clear
    redirect to '/'
  end

  #helpers
  helpers do

  def logged_in?
    !!current_user
  end

  def current_user
    @user ||= User.find_by_id(session[:user_id])
  end

  def is_authorized?(id)
    current_user.id == id.to_i
  end

 # def not_logged_in
  #  if !logged_in?
 #     "You must be logged in to view that page."
 #     redirect '/'
 #   end
 # end

end

end
