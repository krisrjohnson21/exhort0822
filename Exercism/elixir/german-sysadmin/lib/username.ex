defmodule Username do
  def sanitize([]), do: []

  def sanitize([char | tail]) do
    letter = case char do
      char when char >= ?a and char <= ?z -> [char]
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      ?_ -> [char]
      _ -> ''
    end

    letter ++ sanitize(tail)
  end
end
