require Exredis

defmodule HydeTest do
  use ExUnit.Case
  doctest Hyde

  setup do
    {:ok, client} = Exredis.start_link

    client |> Hyde.activate(:active_feature_name)
    client |> Hyde.deactivate(:inactive_feature_name)

    user = %{id: 1}

    {:ok, client: client, user: user}
  end

  test "Hyde.is_active?(:feature_name) defaults to false", %{client: client} do
    refute Hyde.active?(client, :random_feature_name)
  end

  test "Hyde.activate(:feature_name) sets the flag to true", %{client: client} do
    client |> Hyde.activate(:new_active_feature_name)

    assert Exredis.query(client, ["SISMEMBER", :new_active_feature_name])
  end

  test "Hyde.deactivate(:feature_name) sets the flag to false", %{client: client} do
    client |> Hyde.deactivate(:new_inactive_feature_name)

    assert Exredis.query(client, ["SISMEMBER", :new_inactive_feature_name, 0]) == "0"
  end

  test "Hyde.active?(:feature_name) on an active feature returns true", %{client: client} do
    assert Hyde.active?(client, :active_feature_name)
  end

  test "Hyde.active?(:feature_name) on an inactive feature returns false", %{client: client} do
    refute Hyde.active?(client, :inactive_feature_name)
  end

  test "Hyde.inactive?(:feature_name) on an inactive feature returns true", %{client: client} do
    assert Hyde.inactive?(client, :inactive_feature_name)
  end

  test "Hyde.inactive?(:feature_name) on an active feature returns false", %{client: client} do
    refute Hyde.inactive?(client, :active_feature_name)
  end


end
