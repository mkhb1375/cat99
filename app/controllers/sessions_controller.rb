class SessionsController < ApplicationController


    before_action :require_no_user! , only: %i(create new)

   def  new
    flash[:notice] =''
        render :new
    

   end

   def create 

        user = User.find_by_credentials(
            params[:user][:user_name],
            params[:user][:password]
        )

        if user == nil 
            flash.now[:errors] = ['Wrong credentials ! ']
            
            render :new

        else
            flash[:notice] = 'Loged in successfully !'
            login_user!(user)
            redirect_to cats_url

        end

   end


   def destroy

        

            logout_user!
            redirect_to new_session_url

       

   end



end