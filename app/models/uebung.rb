class Uebung < ApplicationRecord
  belongs_to :benutzer
  validates :title, presence: true
  validates :description, presence: true
end
