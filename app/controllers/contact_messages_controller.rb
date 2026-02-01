class ContactMessagesController < ApplicationController
  invisible_captcha only: [:create], honeypot: :subtitle
  
  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(contact_message_params)
    
    respond_to do |format|
      if @contact_message.valid?
        begin
          # Send admin notification
          ContactMailer.send_message(@contact_message).deliver_now!
          
          # Save to database
          @contact_message.save!
          
          # Send confirmation to user with current locale
          ContactMailer.contact_confirmation(@contact_message, I18n.locale).deliver_later
          
          format.turbo_stream do
            flash.now[:notice] = t('contact.success')
            render turbo_stream: [
              turbo_stream.update("flash", partial: "shared/flash"),
              turbo_stream.update("contact_form", partial: "contact_messages/success")
            ]
          end
          format.html { redirect_to root_path, notice: t('contact.success') }
        rescue => e
          Rails.logger.error "Failed to send contact message: #{e.message}"
          Rails.logger.error e.backtrace.join("\n")
          
          format.turbo_stream do
            flash.now[:alert] = "There was an error sending your message: #{e.message}"
            render turbo_stream: turbo_stream.update("flash", partial: "shared/flash")
          end
          format.html { render :new, status: :unprocessable_entity }
        end
      else
        format.turbo_stream do
          flash.now[:alert] = @contact_message.errors.full_messages.join(', ')
          render turbo_stream: turbo_stream.update("flash", partial: "shared/flash")
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :subject, :message)
  end
end
