class CatRentalRequestsController < ApplicationController
    before_action :require_user!



def new


    @cat_id = params[:cat_id]


    # pending = CatRentalRequest.find_by_sql ["SELECT  id FROM cat_rental_requests 
    #     WHERE status = ? AND cat_id = ? ","PENDING" , @cat_id]

   
    # if pending.count == 0

    #    any = false

    # else

    #    any = true

    # end

    # @pending_error = "Another request is pending for this cat !" if any



@cats = Cat.all
render :new

end

 

    




def create
  
    
#    pending = CatRentalRequest.find_by_sql ["SELECT  id FROM cat_rental_requests 
#         WHERE status = ? AND cat_id = ? ","PENDING" , params["cat_rental_request"]["cat_id"]]
   
#      if pending.count == 0

#         any = false

#      else

#         any = true

#      end

#      if any
        
#         redirect_to new_cat_cat_rental_request_url
#         return 
#      end

    rental_request = CatRentalRequest.new(cat_rental_request_params)
    rental_request.user_id = current_user.id    
    
    

    if rental_request.save
        flash[:notice] = "Request Added successfully !"

        redirect_to cat_url(params["cat_rental_request"]["cat_id"])

    else
        flash[:notice] = [rental_request.errors.full_messages]
        redirect_to new_cat_cat_rental_request_url

    end


end


private

def cat_rental_request_params

    params.require(:cat_rental_request).permit(:cat_id , :start_date , :end_date , :status)

end

end