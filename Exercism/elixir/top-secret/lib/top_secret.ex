defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({op, _meta, arguments} = ast, acc) when op in [:def, :defp] do
    {name, arguments} = get_name(arguments)

    message = name |> to_string() |> String.slice(0, length(arguments))

    {ast, [message | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp get_name([{:when, _meta, arguments} | _]), do: get_name(arguments)

  defp get_name([{name, _meta, arguments} | _]) when is_list(arguments), do: {name, arguments}

  defp get_name([{name, _meta, arguments} | _]) when is_atom(arguments), do: {name, []}


  def decode_secret_message(string) do
    {_ast, message} = Macro.prewalk(to_ast(string), [], &decode_secret_message_part/2)

    message |> Enum.reverse() |> Enum.join()
  end
end
