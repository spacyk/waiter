defmodule WaiterWeb.RequestLiveTest do
  use WaiterWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Waiter.Dashboard

  @create_attrs %{body: "some body", table: "some table"}
  @update_attrs %{body: "some updated body", table: "some updated table"}
  @invalid_attrs %{body: nil, table: nil}

  defp fixture(:request) do
    {:ok, request} = Dashboard.create_request(@create_attrs)
    request
  end

  defp create_request(_) do
    request = fixture(:request)
    %{request: request}
  end

  describe "Index" do
    setup [:create_request]

    test "lists all requests", %{conn: conn, request: request} do
      {:ok, _index_live, html} = live(conn, Routes.request_index_path(conn, :index))

      assert html =~ "Listing Requests"
      assert html =~ request.body
    end

    test "saves new request", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.request_index_path(conn, :index))

      assert index_live |> element("a", "New Request") |> render_click() =~
        "New Request"

      assert_patch(index_live, Routes.request_index_path(conn, :new))

      assert index_live
             |> form("#request-form", request: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#request-form", request: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.request_index_path(conn, :index))

      assert html =~ "Request created successfully"
      assert html =~ "some body"
    end

    test "updates request in listing", %{conn: conn, request: request} do
      {:ok, index_live, _html} = live(conn, Routes.request_index_path(conn, :index))

      assert index_live |> element("#request-#{request.id} a", "Edit") |> render_click() =~
        "Edit Request"

      assert_patch(index_live, Routes.request_index_path(conn, :edit, request))

      assert index_live
             |> form("#request-form", request: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#request-form", request: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.request_index_path(conn, :index))

      assert html =~ "Request updated successfully"
      assert html =~ "some updated body"
    end

    test "deletes request in listing", %{conn: conn, request: request} do
      {:ok, index_live, _html} = live(conn, Routes.request_index_path(conn, :index))

      assert index_live |> element("#request-#{request.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#request-#{request.id}")
    end
  end

  describe "Show" do
    setup [:create_request]

    test "displays request", %{conn: conn, request: request} do
      {:ok, _show_live, html} = live(conn, Routes.request_show_path(conn, :show, request))

      assert html =~ "Show Request"
      assert html =~ request.body
    end

    test "updates request within modal", %{conn: conn, request: request} do
      {:ok, show_live, _html} = live(conn, Routes.request_show_path(conn, :show, request))

      assert show_live |> element("a", "Edit") |> render_click() =~
        "Edit Request"

      assert_patch(show_live, Routes.request_show_path(conn, :edit, request))

      assert show_live
             |> form("#request-form", request: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#request-form", request: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.request_show_path(conn, :show, request))

      assert html =~ "Request updated successfully"
      assert html =~ "some updated body"
    end
  end
end
