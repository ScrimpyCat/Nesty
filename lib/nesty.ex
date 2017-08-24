defmodule Nesty do
    def get(data, keys, default \\ nil)
    def get(data, [_|_], [default|_]) when not is_map(data) and not is_list(data), do: default
    def get(data, [_|_], default) when not is_map(data) and not is_list(data), do: default
    def get(data, [key], [default|_]) do
        case data[key] do
            nil -> default
            data -> data
        end
    end
    def get(data, [key], default) do
        case data[key] do
            nil -> default
            data -> data
        end
    end
    def get(data, [key|keys], [default|defaults]) do
        case data[key] do
            nil -> default
            data -> get(data, keys, defaults)
        end
    end
    def get(data, [key|keys], default) do
        case data[key] do
            nil -> default
            data -> get(data, keys, default)
        end
    end
end
