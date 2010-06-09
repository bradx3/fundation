module SynchronizeHelper

  def sync_desc
    [ "Your #{ $SITE_NAME } balance is ",
      currency(@transaction.dollars.abs),
      wd ? "ahead of" : "behind",
      "your real account." ].join(" ")
  end
  
  def wd
    @transaction.is_a?(Withdrawal)
  end

  def sync_verb
    wd ? "withdraw" : "deposit"
  end
end
