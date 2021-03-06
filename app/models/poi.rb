# frozen_string_literal: true

class POI < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :photos, as: :photoable
  has_and_belongs_to_many :zones

  scope :recommended, -> { where(recommended: true) }

  after_save :enqueue_update_shape_job

  private

  def enqueue_update_shape_job
    POIUpdateShapeJob.perform_later(id)
  end
end
