class PublicController < ApplicationController
    def home
      @services = Service.by_locale(I18n.locale.to_s)
      @testimonials = Testimonial.by_locale(I18n.locale.to_s)
    end
    
    def about; end
    
    def services
      @services = Service.by_locale(I18n.locale.to_s)
    end
    
    def testimonials
      @testimonials = Testimonial.by_locale(I18n.locale.to_s)
    end
    
    def contact; end
end
