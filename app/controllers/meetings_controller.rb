class MeetingsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_meeting, only: %i[ show edit update destroy ]

  # GET /meetings or /meetings.json
  def index
    @meetings = Meeting.where(first_user_id: Current.user.id).or(Meeting.where(second_user_id: Current.user.id))
  end

  def searchDate
    @meeting = Meeting.new
    @meeting_second_user = nil
    @start_time = params[:start_time]
    @first_user = params[:first_user]

    # An variable to store all the user_id of user available during @start_time
    @possible_matches = Slot.where(start_time: @start_time).where.not(user_id: @first_user)
    # @possible_matches = Slot.where(start_time: @start_time).or(Slot.where.not(user_id: @first_user))

    if @possible_matches.present?

      # An array to store user info from User table correlating to User_id in the @possible match
      @matches = Array.new

      # Check if the logged-in user already has a meeting at this time
      # An array containing all the meeting of the logged-in user
      @all_meetings = Meeting.where(first_user_id: Current.user.id).or(Meeting.where(second_user_id: Current.user.id))

      @errors_array = Array.new

      @possible_matches.each do |match|
        @all_meetings.each do |meet|
          if match.start_time == @start_time
            @errors_array.push("You already have a meeting at this time")
            if (match.user_id == meet.first_user_id) || (match.user_id == meet.second_user_id)
              @errors_array.push("You already have a meeting at this time with this person")

            end

          end
        end
      end

      if @errors_array.nil?
      else
        if @errors_array[1] == "You already have a meeting at this time"
          @errors_array.each do |err|
            flash[:notice] = err
          end
          redirect_to slots_path
        end
      end

      @all_meetings.each do |meets|
        if meets.starts_at == @start_time
          @redirect_error = "You already have a meeting at this time."
        end
      end
      @possible_matches.each do |slot_match|
        @matches << User.select(:id, :first_name, :last_name, :details).find_by(id: slot_match.user_id)
      end
    else

      redirect_to slots_path, notice: "Sorry, No match available for this time"
      # format.html { render :new, status: :unprocessable_entity }

    end

  end

  # GET /meetings/1 or /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
    @slot_id = params[:time_slot]
    time_slot = Slot.find(@slot_id)
    @meeting_starts_at = time_slot.start_time
    @meeting_ends_at = (@meeting_starts_at.to_datetime + 1.hours).to_s
    @meeting_first_user = time_slot.user_id
    @meeting_first_user_name = User.find(@meeting_first_user).first_name
  end

  # # GET /meetings/1/edit
  # def edit
  # end

  # POST /meetings or /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to meeting_url(@meeting), notice: "Meeting was successfully created." }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to meeting_url(@meeting), notice: "Meeting was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to meetings_url, notice: "Meeting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:starts_at, :ends_at, :first_user_id, :second_user_id)
    end


end
