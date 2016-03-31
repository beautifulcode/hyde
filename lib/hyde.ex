defmodule Hyde do
  import Kernel

  @moduledoc """
  Basic (Redis Backed) Feature Toggling

  Activate/Deactivate based on feature name & optionally an identifying integer to compare against.

  Requires an initialized ExRedis client to be passed into the function calls
  """

  @doc """
  ## Parameters

  - `client` client to connect to redis
  - `feature` Atom that addresses the feature
  - `user_id` Optional: Integer that represents the identity of a user

  ## Examples

      iex> {:ok, client} = Exredis.start_link
      iex> client |> Hyde.activate(:my_feature)
      true

  """
  def activate(client, feature, user_id \\ 0) do
    client |> Exredis.query(["SADD", feature, user_id]) |> return_as_boolean
  end

  @doc """
  ## Parameters

  - `client` client to connect to redis
  - `feature` Atom that represents the name of the feature
  - `user_id` Optional: Integer that represents the identity of a user

  ## Examples

      iex> {:ok, client} = Exredis.start_link
      iex> client |> Hyde.deactivate(:my_feature)
      true

  """
  def deactivate(client, feature, user_id \\ 0) do
    client |> Exredis.query(["SREM", feature, user_id]) |> return_as_boolean
  end

  @doc """

  ## Parameters

  - `client` client to connect to redis
  - `feature` Atom that represents the name of the feature
  - `user_id` Optional: Integer that represents the identity of a user

  ## Examples

      iex> {:ok, client} = Exredis.start_link; 
      iex> client |> Hyde.activate(:my_active_feature)
      iex> client |> Hyde.active?(:my_active_feature)
      true

  """
  def active?(client, feature, user_id \\ 0) do
    client |> Exredis.query(["SISMEMBER", feature, user_id]) |> return_as_boolean
  end

  @doc """

  ## Parameters
  - `client` client to connect to redis
  - `feature` Atom that represents the name of the feature
  - `user_id` Optional: Integer that represents the identity of a user

  ## Examples

      iex> {:ok, client} = Exredis.start_link; 
      iex> client |> Hyde.inactive?(:my_inactive_feature)
      true

  """
  def inactive?(client, feature, user_id \\ 0) do
    client |> Exredis.query(["SISMEMBER", feature, user_id]) |> return_as_boolean |> Kernel.!
  end

  @doc false
  def return_as_boolean(result) do
    if result == "1", do: true, else: false
  end
end
