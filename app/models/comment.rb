# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :description, presence: true, length: { maximum: 500 }
end
