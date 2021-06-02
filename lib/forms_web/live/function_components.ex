defmodule FormsWeb.FunctionComponents do
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
    {:ok, assign(socket, day1: Enum.random(@week), day2: Enum.random(@week))}
  end

  def render(assigns) do
    ~L"""
    <h1>Function components</h1>

    <button phx-click="day_1">Day 1</button>
    <button phx-click="day_2">Day 2</button>
    <button phx-click="no_change">No change</button>
    <button phx-click="unrelated_change">Unrelated change</button>

    <%= render_day_assigns(@day1) %>
    <%= render_day_variable(@day2) %>
    """
  end

  defp render_day_assigns(day) do
    assigns = %{day: day}

    ~L"""
    <p><strong><%= @day %></strong></p>
    """
    |> IO.inspect(label: :render_day_assigns)
  end

  defp render_day_variable(day) do
    assigns = %{}

    ~L"""
    <p><strong><%= day %></strong></p>
    """
    |> IO.inspect(label: :render_day_variable)
  end

  def handle_event("day_1", _params, socket) do
    {:noreply, assign(socket, :day1, Enum.random(@week))}
  end

  def handle_event("day_2", _params, socket) do
    {:noreply, assign(socket, :day2, Enum.random(@week))}
  end

  def handle_event("no_change", _params, socket) do
    IO.inspect("no_change")
    {:noreply, socket}
  end

  def handle_event("unrelated_change", _params, socket) do
    {:noreply, assign(socket, :random, :erlang.system_time())}
  end
end
