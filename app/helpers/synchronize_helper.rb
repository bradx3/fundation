module SynchronizeHelper

  def sync_desc
    [ "Your #{ $SITE_NAME } balance is ",
      currency(@transaction.dollars.abs),
      wd ? "ahead of" : "behind",
      "your real account." ].join(" ")
  end
  
  def withdrawing?
    @transaction.is_a?(Withdrawal)
  end
  alias_method :wd, :withdrawing?
  
  def depositing?
    !wd
  end

  def sync_verb
    wd ? "withdraw" : "deposit"
  end

  def sync_dir
    wd ? "from" : "into"
  end
end
