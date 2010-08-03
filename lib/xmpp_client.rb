require 'xmpp4r'
require 'xmpp4r/roster'
include Jabber

class XmppClient
 
  NOTIFIER = '4_abcabc_879'
 
  def initialize
    @roster = nil
    @client = nil
  end
  
  def client(jid, domain=XMPPDOMAIN)
   bare_jid = jid + "@" + domain 
 puts " ******************* Inside xmpp_client.client method  ****************************"  
   @client = Jabber::Client.new(JID.new(bare_jid))
   @client.connect
  end

  def register(password = '123456')
   puts " ******************* Inside xmpp_client.register method #{password}****************************"  
   @client.register(password)
  end
  
  def login(password)
    puts " ******************* Inside xmpp_client.login method  #{password}****************************"  
   @client.auth(password)
  end

  def close
    @client.close
  end
  
  def subscribe_to(to_jid)
     puts " ******************* Inside xmpp_client.subscribe_to #{to_jid}  ****************************"  
    to_complete_jid = "#{to_jid}@#{XMPPDOMAIN}"   
    pres = Presence.new.set_type(:subscribe).set_to(to_complete_jid)
    @client.send(pres)
  end
  
  def accept_subscription(from, domain = XMPPDOMAIN)    
     puts " ******************* Inside xmpp_client.accept_subscription ****************************"  
    @roster = Roster::Helper.new(@client)
    puts" ************ Roster Obtained *************" + @roster.inspect
    full_jid = "#{from}@#{XMPPDOMAIN}"
    puts" ************ ACCEPT SUBSCRIPTION FROM  ************* " + full_jid.to_s
    @roster.accept_subscription(full_jid)
  end 

 
  
  def set_presence
    puts " ******************* Inside xmpp_client.set_presence method ****************************"  
    presence = Presence.new.set_type(:available)
    @client.send(presence)
  end
  
  def subscription_callback
    @roster = Roster::Helper.new(@client)
    @roster.add_subscription_request_callback do |item, pres|
      @roster.accept_subscription(pres.from)
      puts " **** Accepted subscription from #{pres.from} ***************** "
    end
  end
  
  
  def self.register(bare_jid, password, domain=XMPPDOMAIN)
   puts " ************* XmppClient.register ******************** " + XMPPDOMAIN.to_s
   Jabber::debug = true
   xmpp_client =  XmppClient.new
   xmpp_client.client(bare_jid, XMPPDOMAIN)
   xmpp_client.register(password)
   xmpp_client.close
  end

  def self.login(bare_jid, password, domain=XMPPDOMAIN)
    puts " ************* XmppClient.login ******************** " 
    Jabber::debug = true
    xmpp_client = XmppClient.new
    xmpp_client.client(bare_jid)
    xmpp_client.login(password)
    xmpp_client.set_presence
    #xmpp_client.subscription_callback
    xmpp_client
  end
   

  def send_message(to_jid, message, domain=XMPPDOMAIN)
    to_jabber_id = to_jid + "@" + domain
    msg = Message::new(to_jid, message)
    msg.type = :chat
    @client.send(msg)
  end

end
