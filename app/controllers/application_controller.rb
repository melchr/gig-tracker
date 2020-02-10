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

  get '/home' do
    @user = User.find(session[:user_id])
    erb :'users/home'
  end

  get '/gigs' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @gigs = Gig.all
      #if @user != nil
      #  @gigs = Gig.where(:user_id => @user.id)
      erb :'gigs/index'
    else
      redirect "/login"
    end
  end

  post '/gigs' do
    user = Helpers.current_user(session)

    gig = user.gigs.create(params)
    if gig.save
      puts "Gig has been saved."
    else
      puts "Please try again."
    end

    redirect "/gigs"
  end

get '/gigs/new' do
  if Helpers.is_logged_in?(session)
    erb :'gigs/new'
  else
    redirect "/login"
  end
end

get '/gigs/:id' do
  if Helpers.is_logged_in?(session)
    @user = Helpers.current_user(session)
    @gig = Gig.find_by_id(params["id"])
    if @gig.id == @gig.user_id
      erb :'gigs/show'
    else
      redirect "/login"
    end
  else
    redirect "/login"
  end
end

get '/gigs/:id/edit' do
  if Helpers.is_logged_in?(session)
    @user = Helpers.current_user(session)
    @gig = Gig.find_by_id(params[:id]) #["id"]
    if @user.id == @gig.user_id
      erb :'gigs/edit'
    else
      redirect "/login"
    end
  else
    redirect "/login"
  end
end

patch '/gigs/:id' do
  @user = Helpers.current_user(session)
  @gig = Gig.find_by_id(params["id"])

  if @user.id == @gig.user_id
    @gig.update(params["gig"])
    redirect "/gigs/#{@gig.id}"
  else
    redirect "/login"
  end
end

delete '/gigs/:id' do
  @user = Helpers.current_user(session)
  @gig = Gig.find_by_id(params["id"])

  if @user.id == @gig.user_id
    @gig.destroy
    redirect "/gigs"
  else
    redirect "/login"
  end
end

  get '/logout' do
    session.clear
    redirect "/"
  end

end
