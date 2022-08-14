defmodule BirdCount do
  def today([head | _tail]) do
    head
  end

  def today([]), do: nil

  def increment_day_count([head | tail]) do
    [head + 1 | tail]
  end

  def increment_day_count([]), do: [1]

  def has_day_without_birds?([head | tail]) do
    head == 0 or has_day_without_birds?(tail)
  end

  def has_day_without_birds?([]), do: false

  def total([head | tail]) do
    head + total(tail)
  end

  def total([]), do: 0

  def busy_days([head | tail]) when head >= 5 do
    1 + busy_days(tail)
  end

  def busy_days([_head | tail]) do
    busy_days(tail)
  end

  def busy_days([]), do: 0
end
