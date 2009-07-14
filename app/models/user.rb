class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :family
  validates_presence_of :family

  has_many :funds
  has_many :deposit_templates
  has_many :transactions

  def to_s
    login
  end
end
