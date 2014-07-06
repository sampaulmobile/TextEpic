class MessagesController < ApplicationController


    def chillin
    end

    def textepic
        from = params[:from] || "+16466812777"
        to = params[:to] || "5103811581"

        if !from || !to
            puts "No valid from/to"
            Rails.logger.error "No valid from/to"
            return
        end

        msg = params[:msg] || "LEFT OUT THE MESSAGE BRO"
        url = params[:url] || ""
        callback = params[:callback] || ""

        m = Message.new(number_from: from,
                        number_to: to,
                        message: msg,
                        media_url: url,
                        callback: callback)

        if m.save
            Resque.enqueue(Textor, m.id)
            Rails.logger.info "Enqueued message number #{m.id}"
            redirect_to root_url, flash: { success: "Message send succesfully" }
        else
            Rails.logger.error "Error saving message #{m.errors}"
            redirect_to root_url, flash: { error: "Error sending message" }
        end
    end

end
