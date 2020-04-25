defmodule WaiterWeb.RequestLive.RequestComponent do
  use WaiterWeb, :live_component

  def render(assigns) do
    ~L"""

            <div id="request-<%= @request.id %>" class="container text-center" style="border:1.5px solid #cecece; padding: 15px 20px; margin: 25px;">
              <div class="row">
                <div class="col-md-8">
                    <h2><%= @request.table %></h2>
                    <p><%= @request.body %></p>
                </div>
                <div class="col-md-4">
                  <span>
                  <%= live_patch to: Routes.request_index_path(@socket, :edit, @request) do %>
                    <h2><span class="badge badge-secondary">Edit</span></h2>
                  <% end %>
                </div>

              </div>
            </div>

    """
  end

end
