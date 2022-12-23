class User < ApplicationRecord
    validates :user_name , presence:true , uniqueness:true
    validates :password_digest, presence:{error:"Password can\'t be empty "}
    validates :session_token , presence:true , uniqueness:true
    validates :password , length:{minimum:6 , allow_nill:true}
   
    
    after_initialize :ensure_session_token

    attr_reader :password

    def self.generate_session_token

        SecureRandom::urlsafe_base64(16)

    end

    def self.find_by_credentials(user_name,password)

        user = User.find_by(user_name:user_name)
        return user if  user && BCrypt::Password.new(user.password_digest).is_password?(password)
        nil

    end

    def reset_session_token!

        temp = User.generate_session_token
        self.update_attribute(:session_token, temp)
        temp 

    end

    def password=(password)

        @password = password
        self.password_digest = BCrypt::Password.create(password)

    end

        has_many :cats ,
        class_name: 'Cat' , 
        foreign_key: :user_id

        has_many :requests , 
        class_name: 'CatRentalReqeust' , 
        foreign_key: :user_id



    private

    

    def ensure_session_token

        self.session_token ||= User.generate_session_token

    end

end
