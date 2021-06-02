defmodule FormsWeb.DayComponent do
  use FormsWeb, :live_component

  def render(assigns) do
    ~L"""
    <li><strong><%= @day %></strong></li>
    """
    |> IO.inspect(label: inspect(__MODULE__))
  end
end
