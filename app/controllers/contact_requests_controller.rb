class ContactRequestsController < ApplicationController
  before_action :set_owner_card, only: %i[create]
  before_action :set_contact_request, only: %i[show update destroy]

  # GET /contact_requests
  def index
    @contact_requests = ContactRequest.all

    render json: @contact_requests
  end

  # GET /contact_requests/1
  def show
    render json: @contact_request
  end

  # POST /contact_requests
  def create
    @contact_request = @owner_card.sent_contact_requests.new(contact_request_params)

    authorize @contact_request

    if @contact_request.save
      render json: @contact_request, status: :created
    else
      render json: @contact_request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contact_requests/1
  def update
    if @contact_request.update(contact_request_params)
      render json: @contact_request
    else
      render json: @contact_request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contact_requests/1
  def destroy
    @contact_request.destroy
  end

  private

  def set_owner_card
    @owner_card = policy_scope(MyCard).find(params[:owner_card_id])
  end

  def set_contact_request
    @contact_request = ContactRequest.find(params[:id])
  end

  def contact_request_params
    params.permit(:message, :friend_card_id)
  end
end
