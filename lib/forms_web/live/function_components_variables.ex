defmodule FormsWeb.FunctionComponentsVariables do
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
    <h1>Function components variables</h1>

    <button phx-click="random">Random</button>

    <% day = String.upcase(@day) %>
    <%= render_day(%{day: day}) %>

    <% static = String.downcase(@static) %>
    <%= render_static(%{static: static}) %>
    """
    |> IO.inspect(label: inspect(__MODULE__))
  end

  defp render_day(assigns) do
    ~L"""
    <p><strong><%= @day %></strong></p>
    """
    |> IO.inspect(label: :render_day)
  end

  defp render_static(assigns) do
    ~L"""
    <p><strong><%= @static %></strong></p>
    """
    |> IO.inspect(label: :render_static)
  end

  def handle_event("random", _params, socket) do
    {:noreply, assign(socket, :day, Enum.random(@week))}
  end
end
