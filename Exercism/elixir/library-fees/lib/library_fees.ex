defmodule LibraryFees do
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  def before_noon?(datetime), do: datetime.hour < 12

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      Date.add(checkout_datetime, 28)
    else
      Date.add(checkout_datetime, 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    comparison = Date.compare(planned_return_date, actual_return_datetime)
    if comparison == :lt do
      Date.diff(actual_return_datetime, planned_return_date)
    else
      0
    end
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout
    |> datetime_from_string()
    |> return_date()
    |> days_late(datetime_from_string(return))
    |> then(fn days_late ->
      case monday?(datetime_from_string(return)) do
        false -> days_late * rate
        true -> days_late * (rate * 0.5) |> Float.floor()
      end
    end)
  end
end
