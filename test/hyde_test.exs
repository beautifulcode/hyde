require Exredis

defmodule HydeTest do
  use ExUnit.Case
  doctest Hyde

  setup do
    {:ok, client} = Exredis.start_link
    {:ok, client: client}
  end

  test "that calling Hyde.is_active?(:feature_name) defaults to false", %{client: client} do
    assert Hyde.active?(client, :feature_name) == false
  end
end
