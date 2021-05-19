defmodule FormsWeb.PageNested do
  use FormsWeb, :live_view

  @impl Phoenix.LiveView
  def mount(params, session, socket) do
    IO.inspect(params, label: :nested_params)
    IO.inspect(session, label: :nested_session)
    {:ok, assign(socket, id: socket.id, query: "", results: %{})}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~L"""
    <div x-data="{ open: false }">
      <button @click="open = !open" x-text="(open) ? 'Hide form' : 'Show form'"></button>

      <section class="phx-hero" x-show="open">
        <form phx-change="suggest" phx-submit="search">
          <input type="text" name="q" value="<%= @query %>" placeholder="Live dependency search" list="results" autocomplete="off"/>
          <datalist id="<%= "#{@id}_nested_results" %>">
            <%= for {app, _vsn} <- @results do %>
              <option value="<%= app %>"><%= app %></option>
            <% end %>
          </datalist>
        </form>
      </section>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("suggest", %{"q" => query}, socket) do
    IO.inspect(query, label: :nested_query)
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
