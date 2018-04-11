class RoomsController < ApplicationController

  def index
    @rooms = Room.where(:public => true).order("created_at DESC")
    @new_room = Room.new
  end

  def create
    config_opentok
    session = @opentok.create_session

    puts session.session_id

    @new_room = Room.new(room_params)
    @new_room.sessionId = session.session_id
    @new_room.public = true

    respond_to do |format|
      if @new_room.save
        format.html { redirect_to("/rooms/"+@new_room.id.to_s) }
      else
        format.html { render :controller => ‘rooms’,
        :action => "index" }
      end
    end
  end

  def show
    @room = Room.find(params[:id])

    config_opentok

    @tok_token = @opentok.generate_token @room.sessionId
  end

  private

  def config_opentok
    if @opentok.nil?
      @opentok = OpenTok::OpenTok.new '46097522', '0a8cc0005202c262e3b91fb76adeccf19fc451c7'
    end
  end

  def room_params
    params.require(:room).permit(:name, :sessionId)
  end

end
