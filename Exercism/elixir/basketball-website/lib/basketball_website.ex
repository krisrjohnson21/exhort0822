defmodule BasketballWebsite do
  def extract_from_path(data, [path_head | []]), do: data[path_head]

  def extract_from_path(data, [path_head | path_tail]) do
    extract_from_path(data[path_head], path_tail)
  end

  def extract_from_path(data, path) do
    extract_from_path(data, String.split(path, "."))
  end

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
