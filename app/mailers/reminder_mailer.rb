# frozen_string_literal: true

class ReminderMailer < ApplicationMailer
  def overdue_email(user, carrier_name, current_location, due_date)
    @user = user
    @carrier_name = carrier_name
    @current_location = current_location
    @due_date = due_date
    mail(to: @user.email, subject: 'Baby Carrier Overdue For Return')
  end

  def due_today_email(user, carrier_name, current_location)
    @user = user
    @carrier_name = carrier_name
    @current_location = current_location
    mail(to: @user.email, subject: 'Carrier Return Is Now Due')
  end

  def week_advance_notice_email(user, carrier_name, current_location, due_date)
    @user = user
    @carrier_name = carrier_name
    @current_location = current_location
    @due_date = due_date
    mail(to: @user.email, subject: 'Baby Carrier Due For Return')
  end

  def successful_checkout_email(user, carrier, due_date)
    @user = user
    @carrier_name = carrier.name
    @category = carrier.category.name
    @color = carrier.color
    @item_id = carrier.item_id
    @due_date = due_date
    mail(to: @user.email, subject: "You've Successfully Checked Out #{@carrier_name}")
  end
end
