require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :welcome
  end

  get "/signup" do
    erb :'/users/signup'
  end

  post "/signup" do
    if User.find_by(:email => params["email"])
      puts "Sorry, there is already an account using this email address"
      redirect "/login"
    else
      user = User.create(params)

      if user.save
        session[:user_id] = user.id
        redirect "/"
      else
        puts "Sorry. All fields must be filled out."
        redirect "/signup"
      end

    end
  #  @user = User.new(name: params["name"], email: params["email"], password: params["password"])
   # @user.save
   #@user = User.new(params)
   # @user.save
    #session[:user_id] = @user.id
    #puts params
    #redirect '/users/home'
    #session[:name] = params[:name]
  end

  get "/login" do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(:email => params["email"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id
      redirect "/home"
    end
    redirect "/login"
  end

  get '/gigs' do
    erb :'gigs/gigs'
  end

  get '/home' do
    @user = User.find(session[:user_id])
    erb :'users/home'
  end

  get '/logout' do
    session.clear
    redirect "/"
  end

end
