# frozen_string_literal: true

class ReminderMailer < ApplicationMailer
  before_action do
    @user_name = params[:user_name]
    @user_email = params[:user_email]
    @carrier_name = params[:carrier_name]
    @location = params[:location]
    @due_date = params[:due_date]
  end

  def overdue_email
    mail(to: @user_email, subject: 'Baby Carrier Overdue For Return')
  end

  def due_today_email
    mail(to: @user_email, subject: 'Baby Carrier Due For Return')
  end

  def week_advance_notice_email
    mail(to: @user_email, subject: 'Baby Carrier Due For Return in One Week')
  end

  def successful_checkout_email
    mail(to: @user_email, subject: "You've Successfully Checked Out #{@carrier_name}")
  end
end
