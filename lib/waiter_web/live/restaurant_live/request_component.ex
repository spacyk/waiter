defmodule WaiterWeb.RestaurantLive.RequestComponent do
  use WaiterWeb, :live_component

  def render(assigns) do
    ~L"""
    <%= link to: "#", phx_click: "delete", phx_value_id: @request.id, data: [confirm: "Do you want to process this order?"] do %>
        <div id="request-<%= @request.id %>" class="text-center" style="border:1.5px solid #cecece; padding: 15px 20px; margin: 25px;">
          <div class="text-center">
            <h2><%= @request.table %></h2>
            <p><%= @request.body %></p>
          </div>
        </div>
    <% end %>

    """
  end

end
