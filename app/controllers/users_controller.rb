class UsersController < ApplicationController

    before_action :require_no_user!

    def new 

        render :new

    end

    def create

        
       if user_params[:second_password] != user_params[:password]
        flash.now[:errors] = ['Passwords dosen\'t match']
        render :new
        return
       end
      

        user = User.new(password:user_params[:password],user_name:user_params[:user_name])
                if user.save
                    flash[:notice] = ['Account created successfully !']
                    # render json: flash.now[:errors]
                    session[:session_token] = user.session_token
                    redirect_to cats_url
                    

                    else
                        flash[:notice] = user.errors.full_messages
                     
                        redirect_to new_user_url

                end

        

    end


    private

    def user_params

        params.require(:user).permit(:password , :user_name,:second_password)

    end

    

end