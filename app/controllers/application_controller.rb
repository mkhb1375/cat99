class ApplicationController < ActionController::Base
    helper_method :current_user  
    helper_method :owner?
    private
    def  current_user

        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])

    end

    def login_user!(user)

        session[:session_token] = user.reset_session_token!

    end

    def logout_user! 

        current_user.reset_session_token!
            session[:session_token] = nil

    end

    def require_no_user!
        
        redirect_to cats_url if current_user


    end

    def require_user!
        
        redirect_to new_session_url if current_user ==nil

    end

    def is_owner? 
       return false if current_user.nil?
        redirect_back(fallback_location: root_path) if current_user.cats.where("id = ?",params[:id]).count == 0
    end 

    def is_owner_2
        return false if current_user.nil?
        redirect_back(fallback_location: root_path) if current_user.cats.where("id = ?",session[:cat_id]).count == 0

    end

  def owner?
    return 0 if current_user.nil?
    current_user.cats.where("id = ?",params[:id]).count 

  end

end
