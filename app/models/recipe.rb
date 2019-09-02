class Recipe < ApplicationRecord

belongs_to :recipe_type
belongs_to :user
enum status: {pending: 0, accepted: 1, rejected: 9}


  validates :title, :cuisine, :difficulty,
  :cook_time, :ingredients, :cook_method , presence: true

  def cook_time_min
    "#{cook_time} minutos"
  end

  def owner?(user)
    self.user == user
  end
  def admin?(user)
    user.admin
  end
end
