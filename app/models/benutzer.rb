class Benutzer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :trainings, dependent: :destroy
  has_many :uebungs, dependent: :destroy
  has_many :activity_logs, dependent: :destroy

  validates :role, presence: true, inclusion: { in: %w[coach student admin] }

  def coach?
    role == 'coach'
  end
  def student?
    role == 'student'
  end
  def admin?
    role == 'admin'
  end
  def log_activity(action, details)
    activity_logs.create(action: action, details: details)
  end
end
