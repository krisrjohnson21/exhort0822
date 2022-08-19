defmodule NameBadge do
  def print(id, name, department) do
    if is_nil(id) and is_nil(department) do
      "#{name} - OWNER"
    else
      if is_nil(id) do
        "#{name} - #{String.upcase(department)}"
      else
        if is_nil(department) do
          "[#{id}] - #{name} - OWNER"
        else
          "[#{id}] - #{name} - #{String.upcase(department)}"
        end
      end
    end
  end
end
