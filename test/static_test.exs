defmodule StaticTest do
  use ExUnit.Case
  doctest Static

  test "greets the world" do
    assert Static.hello() == :world
  end
end
