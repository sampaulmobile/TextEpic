class Textor
    require 'twilio-ruby' 

    @queue = :textor


    def self.perform(message_id)

        m = Message.find(message_id)
        if !m
            puts "Invalid message id #{message_id}"
            Rails.logger.error "Invalid message id #{message_id}"
            return
        end

        from = m.number_from
        to = m.number_to
        msg = m.message
        url = m.media_url != "" ? m.media_url : nil
        callback = m.callback != "" ? m.callback : nil

        # put your own credentials here 
        account_sid = 'AC91821a5406b73eeed1cd8fea85b67dc9' 
        auth_token = '6082f0ac0a58cf0c820a115a01238758' 

        # set up a client to talk to the Twilio REST API 
        client = Twilio::REST::Client.new account_sid, auth_token 

        opts = {
            :from => from,
            :to => to,
            :body => msg,
        }

        #TODO - check media url and status_callback (url)

        opts[:media_url] = url if url
        opts[:status_callback] = callback if callback

        Rails.logger.info "Sending message id #{message_id}"
        puts "sending message with opts: #{opts.inspect}"

        res = client.account.messages.create(opts)

        if !res
            m.increment!(:fail_count)
            Rails.logger.error "Error sending message id #{message_id}"
            puts "Error sending message id #{message_id}"
        end
    end

end
