defmodule Currently.Users.ImplTest do
  use ExUnit.Case, async: true

  describe "when looking up a known user" do
    test "it returns info for a known user" do
      user_id = "FOOBAR"
      user = %{handle: "blah", channel: 12}
      users = %{user_id => user}
      assert Currently.Users.Impl.lookup(users, user_id) == user
    end
  end

  describe "when looking up an unknown user" do
    test "it returns an unfound user when the user id doesn't exist" do
      user_id = "FAKE_USER"
      users = %{}
      assert Currently.Users.Impl.lookup(users, user_id) == %{channel: nil, handle: :not_found}
    end

    test "it returns info retrieved from the API" do
      user_id = "REAL_USER"
      users = %{}
      assert %{handle: "jquser"} = Currently.Users.Impl.lookup(users, user_id)
    end
  end

  describe "returning bot ids" do
    test "it returns bot ids" do
      users = %{"USER_ID" => %{is_bot: false}, "BOT_ID" => %{is_bot: true}}
      assert Currently.Users.Impl.bot_ids(users) == ["BOT_ID"]
    end
  end
end
