require 'xmpp4r'
require 'xmpp4r/roster'
include Jabber

class XmppClient

  def client(bare_jid, domain='sid-laptop')
   jabber_id = bare_jid + "@" + domain 
   @client = Jabber::Client.new(JID.new(jabber_id))
   @client.connect
  end

  def register(password)
   @client.register(password)
  end

  def login(password)
   @client.auth(password)
  end

  def close
    @client.close
  end

  def self.register(bare_jid, password, domain='sid-laptop')
   xmpp_client =  XmppClient.new
   xmpp_client.client(bare_jid)
   xmpp_client.register(password)
   xmpp_client.close
  end

  def self.login(bare_jid, password, domain='sid-laptop')
    xmpp_client = XmppClient.new
    xmpp_client.client(bare_jid)
    xmpp_client.login(password)
    xmpp_client.set_presence
    xmpp_client.activate_callbacks
  end

  def activate_callbacks
    message_callback
    presence_callback
    subscription_callback
  end


  def set_presence(status='available')
    presence = Presence.new.set_type(status.to_sym)
    @client.send(presence)
  end

  def message_callback
    @client.add_message_callback do |message|
      return [message.body, message.from]
    end
  end

  def presence_callback
    @client.add_presence_callback do |old_presence, new_presence|
        return [old_presence, new_presence]
    end
  end

  def subscription_callback
    @roster = Roster::Helper.new(@client) 
    @roster.add_subscription_callback do |item, presence|
      @roster.accept_subscription(presence.from)  # accepts subscription by default
    end
  end

  def send_message(to_jid, message, domain='sid-laptop')
    to_jabber_id = to_jid + "@" + domain
    msg = Message::new(to_jid, message)
    msg.type = :chat
    @client.send(msg)
  end

end
