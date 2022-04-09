class MessagesController < ApplicationController
  before_action :set_meeting, only: [:create, :destroy]

  def create
    @message = @meeting.messages.new(message_params)
    if @message.save
      redirect_to @meeting, notice: 'Message Sent'
    else
      redirect_to @meeting, notice: 'Failed to send message'
    end
  end

  private
  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end

  def message_params
    params.require(:message).permit(:sender, :content)
  end
end
