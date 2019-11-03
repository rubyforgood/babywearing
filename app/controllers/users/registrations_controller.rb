# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :first_name, :last_name, :street_address,
                                 :street_address_second, :city, :state,
                                 :postal_code, :phone_number)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :current_password, :first_name, :last_name,
                                 :street_address, :street_address_second,
                                 :city, :state, :postal_code, :phone_number)
  end
end
