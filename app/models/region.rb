# frozen_string_literal: true

class Region < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :zones
end
