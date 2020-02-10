class GigController < ApplicationController
    get '/gigs' do
        if logged_in?
          @gigs = Gig.all
          erb :'/gigs/index'
        else
          redirect to '/signup'
        end
    end
    
    get '/gigs/new' do
        if logged_in?
          @gigs = Gig.all
          erb :'gigs/new'
        else
          redirect to '/login'
        end
    end
    
    post '/gigs' do
       # user = current_user
       # gig = user.gigs.create(params)
       gig = Gig.new(params)
       gig.user = current_user
        if gig.save
          puts "saved"
        else
          redirect '/gigs'
        end
    end
    
    get '/gigs/:id' do
        if logged_in?
          @gig = Gig.find_by_id(params[:id])
        if current_user.id == @gig.user_id
          erb :"gigs/show"
        else
          redirect '/login'
        end
    end
    end
    
    get '/gigs/:id/edit' do
        if logged_in?
            @gig = Gig.find_by_id(params[:id])
          if current_user.id == @gig.user_id
            erb :"gigs/edit"
        else
          redirect to '/login'
          end
        end
        end
end