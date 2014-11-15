defmodule ProcessTest do
  use ExUnit.Case

  test "test kv" do
    send :kv, {:get, :hello, self()}
    receive do
      x -> assert x == nil
    end

    send :kv, {:put, :hello, 2}
    send :kv, {:get, :hello, self()}
    receive do
      x -> assert x == 2
    end
  end
end
