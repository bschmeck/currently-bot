defmodule SlackStubClient do

end

defmodule Currently.UsersTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = Currently.Users.start_link
    {:ok, pid: pid}
  end

  test "looks up user information", %{pid: pid} do
    assert Currently.Users.info(pid, "foobar") == 0
  end
end
