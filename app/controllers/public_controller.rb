class PublicController < ApplicationController
    def home; end
    def about; end
    def services; @services = Service.all; end
    def testimonials; @testimonials = Testimonial.all; end
    def contact; end
end