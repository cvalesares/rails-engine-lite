class Merchant < ApplicationRecord
  has_many :items

  def self.find_by_name(search_params)
    where("name ILIKE ?", "%#{search_params}%").first
  end

  def self.find_all_by_name(search_params)
    where("name ILIKE ?", "%#{search_params}%")
  end
end
