defmodule WaiterWeb.RestaurantLive.Index do
  use WaiterWeb, :live_view

  alias Waiter.Dashboard
  alias Waiter.Dashboard.Request

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Dashboard.subscribe()
    {:ok, assign(socket, :requests, fetch_requests()), temporary_assigns: [requests: []]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Request")
    |> assign(:request, Dashboard.get_request!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Request")
    |> assign(:request, %Request{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Requests")
    |> assign(:request, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    request = Dashboard.get_request!(id)
    {:ok, _} = Dashboard.delete_request(request)

    {:noreply, assign(socket, :requests, fetch_requests())}
  end


  @impl true
  def handle_info({:request_created, request}, socket) do
    {:noreply, update(socket, :requests, fn requests -> [request | requests] end)}
  end

  def handle_info({:request_updated, request}, socket) do
    {:noreply, update(socket, :requests, fn requests -> [request | requests] end)}
  end

  def handle_info({:request_deleted, request}, socket) do
    {:noreply, update(socket, :requests, fn [request | requests] -> [requests] end)}
  end

  defp fetch_requests do
    Dashboard.list_requests()
  end
end
