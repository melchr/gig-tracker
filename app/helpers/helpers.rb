
class Helpers

    def self.is_logged_in?(session)
      if session[:user_id] != nil
        true
      else
        false
      end
    end
  
    def self.current_user(session)
      if self.is_logged_in?(session)
        @user = User.find_by_id(session[:user_id])
      end
    end
  
  end