class UserChat < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  after_commit on: :create do 
    broadcast_append_to(
      'users_chats_channel',
      partial: 'shared/chat',
      locals: { chat: Chat.find(chat_id) },
      target: "user_#{user_id}_chats"
    )
  end
end
