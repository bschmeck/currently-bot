defmodule Currently.ChannelTest do
  use ExUnit.Case, async: true

  test "it returns user ids of a channel's members" do
    victim = Currently.Channel.victim("CHANNEL_ID")
    # Channel members are hardcoded in the Test API client
    channel_members = ["REAL_USER", "USER_ID1"]

    assert Enum.member?(channel_members, victim), "Unexpected victim #{victim}"
  end
end
