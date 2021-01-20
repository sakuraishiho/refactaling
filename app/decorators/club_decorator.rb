module ClubDecorator
  def total_result_on_current_year
    matches, won, lost, draw = total_result_on(Date.current.year)
    "#{matches}戦#{won}勝#{draw}分#{lost}敗"
  end
end
