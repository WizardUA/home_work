class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  private

    def after_sign_in_path_for(resource)
      profile_person_path(current_user)
    end

    def after_sign_out_path_for(resource_or_scope)
      request.referrer
    end

    def render_404
      render file: "public/404.html", status: 404
    end
    
    def render_403
      render file: "public/403.html", status: 403
    end

    def check_if_admin
      render_403 unless current_user.admin
    end

end
