defmodule FormsWeb.FunctionComponentsAssigns do
  use FormsWeb, :live_view

  @week [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ]

  def mount(_params, _session, socket) do
    {:ok, assign(socket, day: Enum.random(@week), static: "Static")}
  end

  def render(assigns) do
    ~L"""
    <h1>Function components assigns</h1>

    <button phx-click="no_change">No change</button>
    <button phx-click="random">Random</button>
    <button phx-click="unrelated_change">Unrelated change</button>

    <%= render_day_assigns(assigns) %>
    <%= render_static(assigns) %>
    """
    |> IO.inspect(label: inspect(__MODULE__))
  end

  defp render_day_assigns(assigns) do
    ~L"""
    <p><strong><%= @day %></strong></p>
    """
    |> IO.inspect(label: :render_day_assigns)
  end

  defp render_static(assigns) do
    ~L"""
    <p><strong><%= @static %></strong></p>
    """
    |> IO.inspect(label: :render_static)
  end

  def handle_event("no_change", _params, socket) do
    IO.inspect("no_change")
    {:noreply, socket}
  end

  def handle_event("random", _params, socket) do
    {:noreply, assign(socket, :day, Enum.random(@week))}
  end

  def handle_event("unrelated_change", _params, socket) do
    {:noreply, assign(socket, :random, :erlang.system_time())}
  end
end
