class ActivityLog < ApplicationRecord
  belongs_to :benutzer
  validates :action, presence: true
  validates :details, presence: true
end
