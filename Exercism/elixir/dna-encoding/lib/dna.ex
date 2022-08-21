defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode([head | tail]), do: encode(tail, <<encode_nucleotide(head)::4>>)

  defp encode([], accumulator), do: accumulator

  defp encode([head | tail], accumulator) do
    encoded_head = <<encode_nucleotide(head)::4>>
    encode(tail, <<accumulator::bitstring, encoded_head::bitstring>>)
  end

  def decode(<<head::4, tail::bitstring>>), do: decode(tail, [decode_nucleotide(head)])

  defp decode(<<>>, accumulator), do: accumulator

  defp decode(<<head::4, tail::bitstring>>, accumulator) do
    decode(tail, accumulator ++ [decode_nucleotide(head)])
  end
end
