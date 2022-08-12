defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    elem(volume_pair, 1)
  end

  def to_milliliter({unit, volume}) do
    case {unit, volume} do
      {:milliliter, volume} -> {:milliliter, volume}
      {:cup, volume} -> {:milliliter, volume * 240}
      {:fluid_ounce, volume} -> {:milliliter, volume * 30}
      {:teaspoon, volume} -> {:milliliter, volume * 5}
      {:tablespoon, volume} -> {:milliliter, volume * 15}
    end
  end

  def from_milliliter(volume_pair, unit) do
    volume = get_volume(volume_pair)
    case unit do
      :milliliter -> {:milliliter, volume}
      :cup -> {:cup, volume / 240}
      :fluid_ounce -> {:fluid_ounce, volume / 30}
      :teaspoon -> {:teaspoon, volume / 5}
      :tablespoon -> {:tablespoon, volume / 15}
    end
  end

  def convert({unit, volume}, to_unit) do
    to_milliliter({unit, volume}) |> from_milliliter(to_unit)
  end
end
