class LandingPagesController < ApplicationController
    
    def default
        render :default, layout: "default_layout"
    end

end
