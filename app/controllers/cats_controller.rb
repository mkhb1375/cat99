class CatsController < ApplicationController
    before_action :require_user!, only: %i(new create edit update)
    before_action :is_owner? , only: %i(edit update)
    def index
        @cats = Cat.all
        render :index

    end

   
    def show

       
        session[:cat_id] = params[:id]

        @temp_id=[]
        @temp_dates=[]
        ff = CatRentalRequest.where(cat_id:params[:id]).where('status=?',"PENDING").order(:start_date)
        ff.each do |ele|
            @requester = User.find_by(id:ele.user_id).user_name.to_s
            @temp_id << ele.id
            @temp_dates << [ele.start_date,ele.end_date]
        end   
       cc= CatRentalRequest.find_by_sql ["SELECT  start_date , end_date ,status
         FROM  cat_rental_requests WHERE cat_id = ? AND status != ?
         ORDER BY start_date"  , params[:id],"PENDING"]
       temp =[]
        cc.to_s.split("#<CatRentalRequest id: nil, ").each do|ele|
        if ele.length >5
            ele.chomp!(%(>, ))
            ele.chomp!(%("))
            ele.chomp!(%(>]))
            ele.chomp!(%("))
            ele+=%(")
           
          
            
            temp  << ele

        end
        @requests = temp
        end
        
       @cat = Cat.find_by(id: params[:id]) 
       render :show

    end

    def new
        
        @cat=Cat.new
        render :new

    
    end

    def create

            @cat = Cat.new(cats_params)
            @cat.user_id = current_user.id
            if @cat.save
                flash[:notice] = 'Cat Added successfuly !'
                redirect_to cats_url(@cat)

            else
                flash.now[:errors] = [@cat.errors.full_messages]
                render :new

            end

    end

    def edit

        @cat = Cat.find_by(id: params[:id])
        render :edit

    end

    def update
        @cat = Cat.find_by(id: params[:id])
      
        if @cat.update(cats_params)

            flash[:notice] = 'Cat Updated successfuly !'
            redirect_to cat_url(@cat)
        else
            flash.now[:errors] = [@cat.errors.full_messages]
            render :edit

        end


    end


    private

    def cats_params

        params.require(:cats).permit(:name,:sex,:color,:birth_date,:description)

    end
end