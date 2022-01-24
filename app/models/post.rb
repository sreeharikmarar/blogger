# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10 }
  validates :user, presence: true
end
