class MyCardsController < ApplicationController
  before_action :set_my_card, only: %i[show update destroy]

  # GET /my_cards
  def index
    @my_cards = policy_scope(MyCard)

    render json: @my_cards, include: '*.*.*'
  end

  # GET /my_cards/1
  def show
    authorize @my_card

    render json: @my_card, include: '*.*.*', show_details: true
  end

  # POST /my_cards
  def create
    @my_card = policy_scope(MyCard).new(my_card_params)
    authorize @my_card

    if @my_card.save
      render json: @my_card, status: :created, show_details: true
    else
      render json: @my_card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /my_cards/1
  def update
    authorize @my_card

    if @my_card.update(my_card_params)
      render json: @my_card, show_details: true
    else
      render json: @my_card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /my_cards/1
  def destroy
    authorize @my_card

    if @my_card.destroy
      head 204
    else
      render json: @my_card.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_my_card
    @my_card = current_user.my_cards.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def my_card_params
    params.permit(
      :role,
      :title,
      :gender,
      :public,
      :category,
      :fullname,
      :birthday,
      :description,
      :name_prefix,
      :organization,
      :auto_accept_request,
      emails_attributes: %i[id category value _destroy],
      phones_attributes: %i[id category value _destroy],
      addresses_attributes: %i[id category value _destroy],
      website_urls_attributes: %i[id category value _destroy],
      social_urls_attributes: %i[id category value _destroy],
      hash_tags_attributes: %i[id value _destroy],
      photos_attributes: %i[id image _destroy]
    )
  end
end
