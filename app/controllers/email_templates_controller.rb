# frozen_string_literal: true

class EmailTemplatesController < ApplicationController
  def index
    authorize @email_templates = EmailTemplate.order(active: :desc)
  end

  def show
    @email_template = authorize EmailTemplate.find(params[:id])
  end

  def new
    @email_template = authorize EmailTemplate.new
  end

  def edit
    @email_template = authorize EmailTemplate.find(params[:id])
  end

  def create
    @email_template = authorize EmailTemplate.new(email_template_params)

    if @email_template.save
      redirect_to email_templates_path, notice: 'Email template was successfully created.'
    else
      render :new
    end
  end

  def update
    @email_template = authorize EmailTemplate.find(params[:id])
    if @email_template.update(email_template_params)
      redirect_to email_templates_path, notice: 'Email template was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @email_template = authorize EmailTemplate.find(params[:id])
    msg = @email_template.destroy ? 'Email template was successfully destroyed' : 'Unable to destroy email template'

    redirect_to email_templates_url, alert: msg
  end

  private

  def email_template_params
    params.require(:email_template).permit(:type, :name, :subject, :body, :when_sent, :when_days, :active)
  end
end
