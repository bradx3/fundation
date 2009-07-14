class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :family
  validates_presence_of :family

  def to_s
    login
  end
end
