defmodule ListFilter do
  def call(list) do
    countOddNumbers(list)
  end

  def parse_list_element(element) do
    cond do
      is_integer(element) -> {element}
      is_binary(element) and String.match?(element, ~r/[0-9]/) -> elem(Integer.parse(element), 0)
      is_binary(element) -> {:error}
    end
  end

  defp filter_element({:error}), do: false
  defp filter_element({x}), do: is_integer(x) and Integer.mod(x, 2) != 0

  defp filter_element({x, _}), do: is_integer(x) and Integer.mod(x, 2) != 0

  defp filter_element(x), do: is_integer(x) and Integer.mod(x, 2) != 0

  defp countOddNumbers(list) do
    list
    |> Enum.map(fn x -> parse_list_element(x) end)
    |> Enum.filter(fn x -> filter_element(x) end)
    |> Enum.count()
  end
end
