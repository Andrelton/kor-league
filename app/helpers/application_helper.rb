module ApplicationHelper
  def ordinal_ranking(rank)
    ordinals = %w[ST ND RD]
    ordinal_rank = rank.to_s + (ordinals[rank - 1] || "TH")
    return ordinal_rank
  end
end
