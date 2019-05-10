class Extra < ApplicationRecord
  has_many :project_extra_lines, dependent: :destroy
  has_many :projects, through: :project_extra_lines


end
