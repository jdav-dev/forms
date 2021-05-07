defmodule FormsWeb.PageLive do
  use FormsWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{})}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~L"""
    <h2>Root</h2>
    <div x-data="{ open: false }">
      <button @click="open = !open" x-text="(open) ? 'Hide form' : 'Show form'"></button>

      <section class="phx-hero" x-show="open">
        <form phx-change="suggest" phx-submit="search">
          <input type="text" name="q" value="<%= @query %>" placeholder="Live dependency search" list="results" autocomplete="off"/>
          <datalist id="root_results">
            <%= for {app, _vsn} <- @results do %>
              <option value="<%= app %>"><%= app %></option>
            <% end %>
          </datalist>
        </form>
      </section>
    </div>

    <h2>Component</h2>
    <%= live_component @socket, FormsWeb.PageComponent, id: "page_component" %>

    <h2>Nested</h2>
    <%= live_render @socket, FormsWeb.PageNested, id: "page_nested" %>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("suggest", %{"q" => query}, socket) do
    IO.inspect(query, label: :root)
    {:noreply, assign(socket, results: search(query), query: query)}
  end

  defp search(query) do
    if not FormsWeb.Endpoint.config(:code_reloader) do
      raise "action disabled when not in development"
    end

    for {app, desc, vsn} <- Application.started_applications(),
        app = to_string(app),
        String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
        into: %{},
        do: {app, vsn}
  end
end
