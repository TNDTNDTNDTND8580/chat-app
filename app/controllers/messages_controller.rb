class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
  end
  
  def create
    @room = Room.find(params[:room_id])
    # binding.pry
    @message = @room.messages.new(message_params)
    @message.save
    redirect_to room_messages_path(@room)
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
