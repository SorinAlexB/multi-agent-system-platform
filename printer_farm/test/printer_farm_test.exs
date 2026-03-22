defmodule PrinterFarmTest do
  use ExUnit.Case
  doctest PrinterFarm

  test "greets the world" do
    assert PrinterFarm.hello() == :world
  end
end
