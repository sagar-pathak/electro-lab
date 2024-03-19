class ApplicationController < ActionController::Base

    def after_sign_in_path_for(resource)
        if current_user.admin 
            categories_url
        else
            stored_location_for(resource) || homePage_url
        end
    end

    before_action :configure_permitted_parameters, if:  :devise_controller?

    protected
    def configure_permitted_parameters

        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :description])

    end

    def after_sign_out_path_for(resource_or_scope)
        landingPage_url
    end

end
