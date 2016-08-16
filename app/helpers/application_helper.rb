module ApplicationHelper
  def ordinal_ranking(rank)
    ordinals = %w[ST ND RD]
    ordinal_rank = rank.to_s + (ordinals[rank - 1] || "TH")
    return ordinal_rank
  end

  def goals_month
    today = DateTime.now
    today += 1.month if today < DateTime.parse("2016-09-01")
    return today.strftime('%^b')
  end
end
