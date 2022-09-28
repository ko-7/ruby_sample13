class Collaboration < ApplicationRecord

  belongs_to :applicant_user, class_name: "User"
  belongs_to :target_user, class_name: "User"

  validates :applicant_user_id, presence: true
  validates :target_user_id, presence: true

end
