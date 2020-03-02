class GigController < ApplicationController 
  get '/gigs' do 
    if logged_in? 
      @user = current_user 
      @gigs = Gig.all 
        erb :'/gigs/index' 
    else
      redirect to '/login' 
    end
  end
  
  get '/gigs/new' do 
    if logged_in? 
      erb :'/gigs/new' 
    else
      redirect to '/login' 
    end
  end
  
  post '/gigs' do 
    @gig = Gig.new(params)
    @gig.user = current_user
      if @gig.save 
        redirect to "/gigs/#{ @gig.id }" 
      else
        redirect '/gigs/new' 
      end
  end

  get '/gigs/:id' do 
    if logged_in?
      @gig = Gig.find_by_id(params[:id]) 
        erb :"/gigs/show"
    else
      redirect '/login'
    end
  end
  
  get '/gigs/:id/edit' do 
    @gig = Gig.find_by_id(params[:id]) 
      if logged_in? && @gig.user_id == current_user.id 
        erb :'/gigs/edit'
      else
        redirect to "/login" 
      end
  end

  patch '/gigs/:id' do
    @gig = Gig.find_by_id(params[:id])
    @gig.update(params[:gig])
      redirect to '/home'
  end
  
  delete '/gigs/:id' do
    @gig = Gig.find_by_id(params[:id])
    @gig.delete
      redirect to '/gigs' 
  end
end