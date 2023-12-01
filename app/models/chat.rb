class Chat < ApplicationRecord
    validates :name,presence: true
    has_many :user_chats
    has_many :users, through: :user_chats
end
