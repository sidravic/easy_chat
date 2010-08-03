require 'xmpp_client.rb'
class User < ActiveRecord::Base
  acts_as_authentic
  
  NOTIFIER = '4_abcabc_879'
  JABBER_PASSWORD = '123456' 
  
  def register_jabber
    puts " ************* In User.register_jabber ******************** " + XMPPDOMAIN.to_s
    bare_jid = generate_id
    self.jabber_id =  bare_jid
    XmppClient.register(bare_jid, JABBER_PASSWORD, "siddharth-ravichandrans-macbook-pro.local")    
    save   
    subscribe_notifier
  end
  
  def subscribe_notifier
    puts " ************* In User.subscribe_notifier ******************** " + XMPPDOMAIN.to_s
    jabber_id = self.jabber_id
    xmpp_client = XmppClient.login(jabber_id, JABBER_PASSWORD)
    notifier = XmppClient.login(NOTIFIER, JABBER_PASSWORD)
    xmpp_client.subscribe_to(NOTIFIER)
    notifier.subscribe_to(jabber_id)
    notifier.accept_subscription(jabber_id)
    xmpp_client.accept_subscription(NOTIFIER)
    notifier.close
    xmpp_client.close    
  end  
  
  private
  
  def generate_id
    bare_jid = "#{self.id}_abcabc_#{rand(1000)}"    
  end
end
