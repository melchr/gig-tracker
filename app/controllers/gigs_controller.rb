class GigController < ApplicationController
    get '/gigs' do
        if logged_in?
          @user = current_user
          @gigs = Gig.all
          erb :'/gigs/index'
        else
          redirect to '/signup'
        end
    end
    
    get '/gigs/new' do
        if logged_in?
          @gigs = Gig.all
          erb :'/gigs/new'
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
          redirect "/gigs/#{gig.id}"
        else
          redirect '/gigs/new'
        end
    end
    
    get '/gigs/:id' do
        if logged_in?
          @gig = Gig.find_by_id(params[:id])
        if current_user.id == @gig.user_id
          erb :"/gigs/show"
        else
          redirect '/login'
        end
    end
    end
    
    get '/gigs/:id/edit' do
        @gig = Gig.find_by_id(params[:id])
        if logged_in? && @gig.user_id == current_user.id
            erb :'/gigs/edit'
        else
          redirect to "/gigs/#{gig.id}"
          end
        end

        patch '/gigs/:id' do
            @gig = Gig.find_by_id(params[:id])
            #@gig.bands = params[:bands]
            #@gig.location = params[:location]
            #@gig.date = params[:date]
            #@gig.time = params[:time]
            #@gig.save
            #@gig.update(:bands => params[:bands], :location => params[:location], :date => params[:date], :time => params[:time])
            @gig.update(params[:gig])
            erb :'/users/home'
        end
    
    delete '/gigs/:id' do
        @gig = Gig.find_by_id(params[:id])
        @gig.delete
        redirect to '/gigs'
    end
end