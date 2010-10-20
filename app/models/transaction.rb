class Transaction < ActiveRecord::Base
  SYNCHRONIZE = "Synchronize"

  has_many :fund_transactions, :dependent => :destroy
  accepts_nested_attributes_for :fund_transactions

  belongs_to :user
  validates_presence_of :user
  before_save :remove_unused_fund_transactions
  
  include DollarMethods

  # Returns the given transactions with any fund_transactions not
  # in fund_ids removed (but unsaved). 
  def self.trim_filtered_funds(transactions, fund_ids)
    if fund_ids and fund_ids.any?
      # trim out filtered fund transactions
      transactions.each do |t|
        t.fund_transactions.delete_if { |ft| !fund_ids.include?(ft.fund_id.to_s) }
      end
    end

    return transactions
  end

  def synchronize?
    description == SYNCHRONIZE
  end

  def allocated_dollars
    cents = fund_transactions.inject(0) { |total, da| total += da.amount_in_cents.to_f }    
    return cents.to_f / 100.00
  end

  def init_all_deposit_funds
    funds = user.family.funds
    fts = self.fund_transactions
    set_funds = fts.map { |d| d.fund }

    (funds - set_funds).each do |f|
      fts.build(:percentage => 0, :fund => f)
    end
  end
  
  protected

  include ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def allocations_add_to_total
    diff = allocated_dollars.abs.round(2) - dollars.abs.round(2)

    if diff != 0
      error = "#{ currency(diff.abs) } still has to be allocated."
      self.errors.add(:base, error)
    end
  end

  def remove_unused_fund_transactions
    unused = fund_transactions.select { |ft| ft.amount_in_cents.nil? or ft.amount_in_cents == 0 }
    fund_transactions.delete(unused)
  end
end
