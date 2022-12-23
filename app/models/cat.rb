require 'action_view'
class Cat < ApplicationRecord
   include ActionView::Helpers::DateHelper

CAT_COLORS = %w(black white orange brown).freeze

validates :birth_date, :color, :name, :sex,  presence:true
validates :color , inclusion:CAT_COLORS
validates :sex , inclusion: %w(M F)
validates :user_id , presence:true
validates :owner , presence:true

validate :birth_in_future

def age
    time_ago_in_words(birth_date)
end

has_many(
    :rental_requests ,
    class_name: 'CatRentalRequest'
)



belongs_to :owner ,
class_name: 'User' ,
foreign_key: :user_id





private 


def birth_in_future
if self.birth_date !=nil
    if self.birth_date > Date.today

        errors["BirthDay"] << "can\'t be in future"
        
    end
end
end



end