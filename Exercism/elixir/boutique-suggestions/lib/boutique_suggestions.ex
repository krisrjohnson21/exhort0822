defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    max_price = Keyword.get(options, :maximum_price, 100)

    for top <- tops, bottom <- bottoms,
      top.base_color !== bottom.base_color,
      max_price > (top.price + bottom.price) do
        {top, bottom}
    end
  end
end
