class CatRentalRequest < ApplicationRecord
validates :cat_id  , :start_date , :end_date , :status , presence:true 
validates :status , inclusion: %w(APPROVED DENIED PENDING)
validates :requester , presence:true
validate :does_not_overlap_approved_request
validate :start_end
validate :past

belongs_to(
    :cat,
    class_name: 'Cat',
    dependent: :destroy
)

def overlapping_pending_requests

    CatRentalRequest.find_by_sql ["SELECT cat_rental_requests.* 
       FROM cat_rental_requests 
       WHERE  (start_date >= ? AND start_date<=?)
       OR (end_date >= ? AND end_date<=?)
       OR (start_date < ? AND end_date>?)
       GROUP BY (id)
       HAVING (status = ? )
       AND cat_id = ? ",self.start_date,self.end_date,self.start_date,self.end_date,self.start_date,self.end_date,"PENDING",self.cat_id]
      
      
    
end

def overlapping_approved_requests

     CatRentalRequest.find_by_sql ["SELECT cat_rental_requests.* 
        FROM cat_rental_requests 
        WHERE  (start_date >= ? AND start_date<=?)
        OR (end_date >= ? AND end_date<=?)
        OR (start_date < ? AND end_date>?)
        GROUP BY (id)
        HAVING (status = ? )
        AND cat_id = ? ",self.start_date,self.end_date,self.start_date,self.end_date,self.start_date,self.end_date,"APPROVED",self.cat_id]
       
       
     
end

def approve!


    transaction do
     self.overlapping_pending_requests.each do |ele|


           

           CatRentalRequest.find_by(id:ele.id).update(status:"DENIED")
           
            
       
     end
     self.update(status:"APPROVED")
    end

end

def deny! 

    self.update(status:"DENIED")

end

belongs_to :requester , 
class_name: 'User'  , 
foreign_key: :user_id



private


def does_not_overlap_approved_request

    if overlapping_approved_requests.empty? ==false

        errors["request duration"] << 'can\'t overlap whit other requests'
        
    end

end

def start_end

    if self.start_date >= self.end_date

        errors["date"] << 'can\'t have start date after end date'
    end

end

def past 

    if self.start_date < Date.today

        errors["date"] << 'can\'t have start date before today'
    end

end


end