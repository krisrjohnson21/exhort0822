defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price), :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn item -> is_nil(item.price) end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      updated_name = String.replace(item.name, old_word, new_word)
      %{item | name: updated_name}
    end)
  end

  def increase_quantity(item, count) do
    new_counts = Map.new(item.quantity_by_size, fn {size, quantity} -> {size, quantity + count} end)
    %{item | quantity_by_size: new_counts}
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_, quantity}, accumulator -> accumulator + quantity end)
  end
end
