class ApiKeysController < ApplicationController
  # protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  include ApiKeyAuthenticatable
  # Require token authentication for index
  prepend_before_filter :authenticate_with_api_key!, only: [:index, :user_details, :time_slots, :meetings, :meeting]
  # Optional token authentication for logout
  prepend_before_filter :authenticate_with_api_key, only: [:destroy]

  def index
    # render json: current_bearer.api_keys
    user = User.find_by(id: current_bearer.api_keys.first.bearer_id)
    if user
      respond_to do |format|
        format.json { render :json => { :user => user, :api_keys => current_bearer.api_keys}}
      end
    else
      render json: {error: 'User not found'}, status: 404
    end
    # d0f5b2cc7ce41503ee219bcaa044a369
  end

  def create
    authenticate_with_http_basic do |email, password|
      user = User.find_by email: email

      if user&.authenticate(password)
        api_key = user.api_keys.create! token: SecureRandom.hex

        render json: api_key, status: :created and return
      end
      render status: :unauthorized
    end
  end

  def destroy
    current_api_key&.destroy
  end

  def user_details
    user = User.find_by(id: current_bearer.api_keys.first.bearer_id)
    show_info_key = params[:show_only]
    if user
      if show_info_key == "id" || show_info_key == "email" || show_info_key == "first_name" || show_info_key == "last_name" || show_info_key == "details" || show_info_key == "created_at" || show_info_key == "updated_at"
        render json: user[show_info_key.to_sym]
      else
        render json: user
      end
    else
      render json: {error: 'User not found'}, status: 404
    end
  end

  def time_slots
    user = User.find_by(id: current_bearer.api_keys.first.bearer_id)
    slots = Slot.where(user_id: user[:id])

    # if slots.nil?
    #   render json: {error: 'No time slots not found'}, status: 404
    # else
    #   if params.has_key?("id")
    #     slots.each do |slot|
    #       if slot[:id] == params[:id]
    #         render json: slot
    #         break
    #       else
    #         render json: {error: "You don't have any time slot with id"}, status: 404
    #       end
    #     end
    #   else
    #     render json: slots
    #   end
    # end

    if slots.nil?
      render json: {error: 'No time slots not found'}, status: 404
    else
      # check if there is an id paramenter passed
      if params.has_key?("id")
        slot = Slot.find_by(id: params[:id], user_id: user[:id])
        if slot.nil?
          render json: {error: "You don't have any time slots with this id"}, status: 404
        else
          render json: slot
        end
      else
        render json: slots
      end
    end

  end

  def meetings
    user = User.find_by(id: current_bearer.api_keys.first.bearer_id)
    meetings = Meeting.where(first_user_id: user[:id]).or(Meeting.where(second_user_id: user[:id]))
    if meetings
      render json: meetings
    else
      render json: {error: 'No Meetings not found'}, status: 404
    end
  end

  def meeting
    user = User.find_by(id: current_bearer.api_keys.first.bearer_id)
    meeting = Meeting.find_by(id: params[:id])

    if meeting.nil?
      render json: {error: "No meetings found"}, status: 404
    else
      if meeting[:first_user_id] == user[:id] || meeting[:second_user_id] == user[:id]
        render json: meeting, include: :messages
      else
        render json: {error: "You don't have any meetings with this id"}, status: 404
      end
    end
  end

end
