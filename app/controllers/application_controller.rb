# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  
  # Raises an exception if the CSRF token doesn't match.
  protect_from_forgery with: :exception
  
  # Catches any authorization errors thrown by Pundit and handles them.
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Catches any "record not found" errors and handles them.
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def user_not_authorized(exception)
    # Accepts an exception parameter, which allows us to get more information about the authorization failure.
    policy_name = exception.policy.class.to_s.underscore
    
    # Translates the error message using the Pundit I18n (internationalization) translations.
    flash[:alert] = t("#{policy_name}.#{exception.query}", scope: "pundit", default: "You are not authorized to perform this action.")
    redirect_back(fallback_location: root_path)
  end

  # Handle cases where a requested record doesn't exist.
  def record_not_found
    flash[:alert] = "The requested resource could not be found."
    redirect_to(request.referrer || root_path)
  end
end
