# Hyde

![Mr. Hyde](http://images.cdn.filmclub.org/film__2790-dr-jekyll-and-mr-hyde--detail.jpg "Mr Hyde")

Feature Toggles for Elixir

Basic Redis backed module to make flipping features on/off for individuals or named groups a snap

*WARNING* - Alpha software: likely to change APIs significantly as it is under active development

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add hyde to your list of dependencies in `mix.exs`:

        def deps do
          [{:hyde, "~> 0.0.1"}]
        end

  2. Ensure hyde is started before your application:

        def application do
          [applications: [:hyde]]
        end


## Usage

Hyde is a convenience wrapper around ExRedis that exposes basic toggling
capabilities by checking if a feature is `active?` using:

  - a global feature name
  - custom unique (user) id
  - the name of a group.

Hyde.active? will return `{:ok, true}` or `false`


### Global
    
    {:ok, client} = Exredis.start_link

    if Hyde.active?(client, :my_feature) do
      # Do Feature Code
    end

    case Hyde.active?(client, :my_feature) do
      {:ok, true} -> 
        # Do Feature Code
      false ->
        # Do Nada
    end

    # Turn on a feature for all
    client |> Hyde.activate(:my_feature)

    # Query a feature for all
    client |> Hyde.active?(:my_feature) 
    #true

    client |> Hyde.inactive?(:my_feature) 
    #false


### ID Based

    {:ok, user} = YourApp.User()
    {:ok, client} = Exredis.start_link

    if Hyde.active?(client, :my_feature, user.id) do
      # Do Feature Code
    end

    # Turn on a feature for single user
    client |> Hyde.activate(:my_feature, user.id)

    # Query a feature for single user
    client |> Hyde.active?(:my_feature, user.id) 
    #true

    client |> Hyde.inactive?(:my_feature, user.id) 
    #false

### Named Group Based

    {:ok, user} = YourApp.User()
    {:ok, client} = Exredis.start_link

    if Hyde.active?(client, :my_feature, :admins) do
      # Do Feature Code
    end

    # Turn on a feature for single user
    client |> Hyde.activate(:my_feature, :admins)

    # Query a feature for single user
    client |> Hyde.active?(:my_feature, :admins) 
    #true

    client |> Hyde.inactive?(:my_feature, :admins) 
    #false


## TODO

  - Move Redis client creation to initialization/lazy 
    vs passing it in all the time
