class SharedLocation < ApplicationRecord
  belongs_to :shared_by, class_name: 'User', foreign_key: :shared_by_id
  belongs_to :shared_with, class_name: 'User', foreign_key: :shared_with_id, optional: true
  belongs_to :location
end
