defmodule Nesty do
    @moduledoc """
      Convenient helpers when dealing with nested keywords and maps.
    """

    @type key :: Keyword.key | Map.key
    @type default :: any
    @type value :: Keyword.value | Map.value

    @doc """
      Get the value deeply nested at the specified key path.

      If a key does not exist, a default value will be returned (`nil` if
      one is not provided).

      Example
      -------
        iex> Nesty.get([a: [b: %{ c: 55 }]], [:a, :b, :c])
        55

        iex> Nesty.get([a: [b: %{ c: 55 }]], [:a, :d])
        nil

        iex> Nesty.get([a: [b: %{ c: 55 }]], [:a, { :d, 1000 }, :c])
        1000
    """
    @spec get(any, [key | { key, default }, ...]) :: value | default
    def get(data, [{ _, default }|_]) when not is_map(data) and not is_list(data), do: default
    def get(data, [_|_]) when not is_map(data) and not is_list(data), do: nil
    def get(data, [{ key, default }]) do
        case data[key] do
            nil -> default
            data -> data
        end
    end
    def get(data, [key]), do: data[key]
    def get(data, [{ key, default }|keys]) do
        case data[key] do
            nil -> default
            data -> get(data, keys)
        end
    end
    def get(data, [key|keys]) do
        case data[key] do
            nil -> nil
            data -> get(data, keys)
        end
    end
end
