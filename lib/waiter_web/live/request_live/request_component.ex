defmodule WaiterWeb.RequestLive.RequestComponent do
  use WaiterWeb, :live_component

  def render(assigns) do
    ~L"""

            <div id="request-<%= @request.id %>" class="container text-center" style="border:1.5px solid #cecece; padding: 15px 20px; margin: 25px;">
              <div class="card">
                <h2><%= @request.table %></h2>
                <p><%= @request.body %></p>
                <span><%= live_patch "Edit", to: Routes.request_index_path(@socket, :edit, @request) %></span>
                <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @request.id, data: [confirm: "Are you sure?"] %></span>
              </div>
            </div>

    """
  end

end
