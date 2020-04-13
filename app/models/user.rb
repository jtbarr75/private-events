class User < ApplicationRecord
  before_save :downcase_email

  has_many :created_events, foreign_key: :creator_id, class_name: "Event"
  has_many :event_attendings, foreign_key: :attendee_id
  has_many :attended_events, through: :event_attendings, source: :attended_event

  validates :name, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  def upcoming_events
    self.attended_events.upcoming
  end

  def previous_events
    self.attended_events.past
  end

private

    #converts the email to all lower case
    def downcase_email
      email.downcase!
    end
end
