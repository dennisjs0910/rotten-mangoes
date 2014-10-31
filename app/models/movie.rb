# require "pry"
class Movie < ActiveRecord::Base
  has_many :reviews

  mount_uploader :image, ImageUploader

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date, presence: true

  
  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size > 0
  end

  def self.search(search, duration)
    case duration.to_i
    when 90
      runtime = "runtime_in_minutes < 90"
    when 90120
      runtime = "runtime_in_minutes > 90 AND runtime_in_minutes < 120"
    when 120
      runtime = "runtime_in_minutes > 120"
    else
      runtime = ""
    end

    if search
      where("title LIKE :search
       OR director LIKE :search ", 
       {:search => "%#{search}%"}).where(runtime)
    else
      all
    end
  end

  protected

end
