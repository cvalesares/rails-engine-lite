class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_all_by_name(search_params)
    where("name ILIKE ?", "%#{search_params}%")
  end
end
