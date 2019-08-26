class Recipe < ApplicationRecord

belongs_to :recipe_type
belongs_to :user
has_one_attached :profile

  validates :title, :cuisine, :difficulty, :profile,
  :cook_time, :ingredients, :cook_method , presence: true

  def cook_time_min
    "#{cook_time} minutos"
  end

  def owner?(user)
    self.user == user
  end
end
