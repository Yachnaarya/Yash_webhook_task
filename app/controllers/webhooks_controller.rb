class WebhooksController < ApplicationController
  before_action :set_webhook, only: %i[ show destroy ]
  skip_before_action :verify_authenticity_token, only: [:create]
  def index
    @webhooks = Webhook.all
  end

  def show
  end

  def create
    @webhook = Webhook.new(webhook_params)
    @webhook.source = params[:source]
    @webhook.data = params
    # @webhook.data = params.except(:controller, :action)
      if @webhook.save
        WebhookJob.perform_later(@webhook)
        render json: { status: :ok }, status: :ok
      else
        render json: { errors: :unprocessable_entity }, status: :unprocessable_entity
      end
  end

  def update
    respond_to do |format|
      if @webhook.update(webhook_params)
        format.html { redirect_to webhook_url(@webhook), notice: "Webhook was successfully updated." }
        format.json { render :show, status: :ok, location: @webhook }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @webhook.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @webhook.destroy

    respond_to do |format|
      format.html { redirect_to webhooks_url, notice: "Webhook was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_webhook
      @webhook = Webhook.find(params[:id])
    end

    def webhook_params
      params.permit(:source, :message, :event)
    end
end
