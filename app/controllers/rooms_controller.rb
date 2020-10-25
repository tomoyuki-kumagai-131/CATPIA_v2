class RoomsController < ApplicationController
  before_action :logged_in_user

  #def index
    #@rooms = current_user.rooms.includes(:messages).order("messages.created_at desc")
  #end

  def create
    @room = Room.create
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @messages = @room.messages.includes(:user)#.order("created_at asc")
      @message = Message.new
      @entries = @room.entries.includes(:user)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  #private
    #def join_room_params
      #params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
    #end
end
