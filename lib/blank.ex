defmodule ProtocolExample do

  defmodule User do
    defstruct name: "john", age: 27
  end

  @fallback_to_any true
  defprotocol Blank do
    @doc "Returns true if data is empty"
    def blank?(data)
  end

  defimpl Blank, for: Integer do
    def blank?(_), do: false
  end

  defimpl Blank, for: List do
    def blank?([]), do: true
    def blank?(_), do: false
  end

  defimpl Blank, for: Atom do
    def blank?(false), do: true
    def blank?(nil), do: true
    def blank?(_), do: false
  end

  defimpl Blank, for: User do
    def blank?(_), do: false
  end



end
