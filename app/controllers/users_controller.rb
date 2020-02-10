class UsersController < ApplicationController
    get '/login' do
        if logged_in?
          redirect "/gigs"
        else
        erb :'users/login'
        end
      end
    
      post '/login' do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to "/gigs"
        else
          "Incorrect login."
          redirect to "/login"
        end
      end
    
      get '/signup' do
        if logged_in?
          redirect "/gigs"
        else
        erb :'users/signup'
        end
      end
    
      post '/signup' do
        if params.values.any?{|v| v.nil? || v.length == 0}
          redirect to "/signup"
        elsif User.find_by(name: params[:name])
          "Username already taken."
          redirect to "/signup"
        elsif User.find_by(email: params[:email])
          "Email already taken."
          redirect to "/signup"
        else
          user = User.create(name: params[:name], password: params[:password], email: params[:email])
          session[:user_id] = user.id
          redirect to "/login"
          end
      end
    
      get '/home' do
        erb :'users/home'
      end
end