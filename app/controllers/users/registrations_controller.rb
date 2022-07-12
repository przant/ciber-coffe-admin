# frozen_string_literal: true

module Users
  #= Users::RegistrationsController
  #
  # Overrides default devise Registrations
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: %i[create]
    before_action :configure_account_update_params, only: %i[edit update]

    private

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(
        :sign_up,
        keys: %i[name last_name nickname]
      )
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(
        :account_update,
        keys: %i[name last_name nickname]
      )
    end
  end
end