defmodule ProtocolTest do
  use ExUnit.Case

  alias ProtocolExample.Blank
  alias ProtocolExample.User

  test "test blankness" do
    assert Blank.blank?(nil)
    assert false == Blank.blank?(%User{})
  end

end
