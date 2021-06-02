defmodule FormsWeb.ForLiveStatelessComponents do
  use FormsWeb, :live_view

  alias FormsWeb.DayComponent

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
    {:ok, assign(socket, :week, @week)}
  end

  def render(assigns) do
    ~L"""
    <h1>Stateless components</h1>

    <button phx-click="change_one">Change one</button>
    <button phx-click="cycle">Cycle</button>
    <button phx-click="reset">Reset</button>

    <ol>
      <%= for day <- @week do %>
        <%= live_component @socket, DayComponent, day: day %>
      <% end %>
    </ol>
    """
    |> IO.inspect(label: inspect(__MODULE__))
  end

  def handle_event("change_one", _params, socket) do
    index = Enum.random(0..(length(socket.assigns.week) - 1))
    week = List.update_at(socket.assigns.week, index, &random_change/1)
    {:noreply, assign(socket, :week, week)}
  end

  def handle_event("cycle", _params, socket) do
    [first | rest] = socket.assigns.week
    week = rest ++ [first]
    {:noreply, assign(socket, :week, week)}
  end

  def handle_event("reset", _params, socket) do
    {:noreply, assign(socket, :week, @week)}
  end

  @changes [&String.downcase/1, &String.capitalize/1, &String.upcase/1]

  defp random_change(day) do
    change = Enum.random(@changes)

    day
    |> change.()
    |> case do
      ^day -> random_change(day)
      changed_day -> changed_day
    end
  end
end
