class Benutzer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :trainings, dependent: :destroy
  validates :role, presence: true, inclusion: { in: %w[coach student] }
  def coach?
    role == 'coach'
  end
  def student?
    role == 'student'
  end
end