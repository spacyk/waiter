defmodule WaiterWeb.Router do
  use WaiterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WaiterWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    # Custom
    plug WaiterWeb.Plugs.Locale, "en"
    plug WaiterWeb.Plugs.Session, ""

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WaiterWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/test/:messenger", PageController, :show


    live "/requests", RequestLive.Index, :index
    live "/requests/new", RequestLive.Index, :new
    live "/requests/:id/edit", RequestLive.Index, :edit
    live "/requests/:id", RequestLive.Show, :show
    live "/requests/:id/show/edit", RequestLive.Show, :edit

    live "/restaurant", RestaurantLive.Index, :index


    # live "/", PageLive, :index # No need for this

  end

  # Other scopes may use custom stacks.
  # scope "/api", WaiterWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: WaiterWeb.Telemetry
    end
  end
end
