class ReadingStatus < ApplicationRecord
  enum status: [:reading, :read]

  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
end
