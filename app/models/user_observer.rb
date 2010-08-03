require 'xmpp_client.rb'
class UserObserver < ActiveRecord::Observer
  
  def after_create(user)
    puts " ******************* Inside User.after_create method ****************************"  
    user.register_jabber
    
  end
end
