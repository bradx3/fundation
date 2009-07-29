class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :family
  validates_presence_of :family

  has_many :funds
  accepts_nested_attributes_for(:funds, :allow_destroy => true,
                                :reject_if => proc { |attributes| attributes["name"].blank? })
  has_many :deposit_templates
  has_many :transactions

  def to_s
    login
  end

  def generate_random_password
    # from http://snippets.dzone.com/posts/show/491
    chars = ("a".."z").to_a + ("1".."9").to_a 
    newpass = Array.new(8, '').collect{chars[rand(chars.size)]}.join

    self.password = newpass
    self.password_confirmation = newpass
  end
end
