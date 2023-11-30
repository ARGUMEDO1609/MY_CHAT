class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: %i[ show edit update destroy ]

  def index
    @chats = Chat.all
  end

  def show
  end

  def new
    @chat = Chat.new
  end

  def edit
  end

  def create
    @chat = Chat.new(chat_params)

   respond_to do |format|
    if @chat.save 
    format.turbo_stream { render turbo_stream: turbo_stream.append('chats', partial: 'shared/chat', locals: {chat: @chat})}
    else 
      format.turbo_stream { render turbo_stream: turbo_stream.replace('chat_form', partial:'chats/form', locals: {chat: @chat})}
    end
   end 
  end

  def update
    respond_to do |format|
      if @chat.update chat_params
      format.turbo_stream { render turbo_stream: turbo_stream.replace("chat_#{@chat.id}", partial: 'shared/chat', locals: {chat: @chat})}
      else 
        format.html { render :edit }
      end
     end
  end

  def destroy
  end

  private
    def set_chat
      @chat = Chat.find(params[:id])
    end

    def chat_params
      params.require(:chat).permit(:name)
    end
end
