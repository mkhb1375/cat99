class PagesController < ApplicationController
    before_action :require_user!
    before_action :is_owner_2
  
    def approve_request
       yy =CatRentalRequest.find_by(id: params[:id]).cat_id
        
        CatRentalRequest.find_by(id: params[:id]).approve!
        redirect_to cat_url(yy)


    end

    def deny_request

        yy =CatRentalRequest.find_by(id: params[:id]).cat_id
        
        CatRentalRequest.find_by(id: params[:id]).deny!
        redirect_to cat_url(yy)

    end

    
  
  end