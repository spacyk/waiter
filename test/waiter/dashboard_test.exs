defmodule Waiter.DashboardTest do
  use Waiter.DataCase

  alias Waiter.Dashboard

  describe "requests" do
    alias Waiter.Dashboard.Request

    @valid_attrs %{body: "some body", table: "some table"}
    @update_attrs %{body: "some updated body", table: "some updated table"}
    @invalid_attrs %{body: nil, table: nil}

    def request_fixture(attrs \\ %{}) do
      {:ok, request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dashboard.create_request()

      request
    end

    test "list_requests/0 returns all requests" do
      request = request_fixture()
      assert Dashboard.list_requests() == [request]
    end

    test "get_request!/1 returns the request with given id" do
      request = request_fixture()
      assert Dashboard.get_request!(request.id) == request
    end

    test "create_request/1 with valid data creates a request" do
      assert {:ok, %Request{} = request} = Dashboard.create_request(@valid_attrs)
      assert request.body == "some body"
      assert request.table == "some table"
    end

    test "create_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_request(@invalid_attrs)
    end

    test "update_request/2 with valid data updates the request" do
      request = request_fixture()
      assert {:ok, %Request{} = request} = Dashboard.update_request(request, @update_attrs)
      assert request.body == "some updated body"
      assert request.table == "some updated table"
    end

    test "update_request/2 with invalid data returns error changeset" do
      request = request_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_request(request, @invalid_attrs)
      assert request == Dashboard.get_request!(request.id)
    end

    test "delete_request/1 deletes the request" do
      request = request_fixture()
      assert {:ok, %Request{}} = Dashboard.delete_request(request)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_request!(request.id) end
    end

    test "change_request/1 returns a request changeset" do
      request = request_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_request(request)
    end
  end
end
