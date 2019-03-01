class Invoice < ApplicationRecord
  belongs_to :payment, optional: true
end
