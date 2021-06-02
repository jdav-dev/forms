defmodule FormsWeb.Router do
  use FormsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FormsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FormsWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/live", PageLive
    get "/no-nested", PageController, :no_nested
    live "/for-no-variable", ForLiveNoVariable
    live "/for-functions", ForLiveFunctions
    live "/for-stateful-components", ForLiveStatefulComponents
    live "/for-stateful-components-with-variable", ForLiveStatefulComponentsWithVariable
    live "/for-stateless-components", ForLiveStatelessComponents
    live "/for-variable", ForLiveVariable
  end

  # Other scopes may use custom stacks.
  # scope "/api", FormsWeb do
  #   pipe_through :api
  # end
end
