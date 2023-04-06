defmodule EchoUdpTest do
  use ExUnit.Case
  doctest EchoUdp

  test "greets the world" do
    assert EchoUdp.hello() == :world
  end
end
