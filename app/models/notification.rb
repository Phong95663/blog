class Notification < ApplicationRecord
  belongs_to :notified_by, class_name: "User"
  belongs_to :user
  belongs_to :post, optional: true

  scope :num_not_check, ->{where(checked: false).count}

end
