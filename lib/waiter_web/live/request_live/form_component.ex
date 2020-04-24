defmodule WaiterWeb.RequestLive.FormComponent do
  use WaiterWeb, :live_component

  alias Waiter.Dashboard

  @impl true
  def update(%{request: request} = assigns, socket) do
    changeset = Dashboard.change_request(request)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"request" => request_params}, socket) do
    changeset =
      socket.assigns.request
      |> Dashboard.change_request(request_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"request" => request_params}, socket) do
    save_request(socket, socket.assigns.action, request_params)
  end

  defp save_request(socket, :edit, request_params) do
    case Dashboard.update_request(socket.assigns.request, request_params) do
      {:ok, _request} ->
        {:noreply,
         socket
         |> put_flash(:info, "Request updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_request(socket, :new, request_params) do
    case Dashboard.create_request(request_params) do
      {:ok, _request} ->
        {:noreply,
         socket
         |> put_flash(:info, "Request created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
