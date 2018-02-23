defmodule Currently.Users do
  use GenServer
  alias Currently.Users.Impl

  # Should we:
  # 1. On boot, hit users.list endpoint to fetch all users
  # 2. Store all user ids and bot ids in separate hashes
  # 3. When asked for user info, initiate a dm if we don't have a channel?
  # Client

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def info(user_id) do
    GenServer.call(__MODULE__, {:info, user_id})
  end

  # Server

  def init(_state) do
    users = Impl.all_users
    {:ok, store_users(users)}
  end

  def handle_call({:info, user_id}, _from, state) do
    user = state |> Impl.lookup(user_id)
    state = state |> Impl.store(user_id, user)

    {:reply, {:ok, user}, state}
  end

  defp store_users(users), do: store_users(users, %{})
  defp store_users([], state), do: state
  defp store_users([{user_id, user} | rest], state), do: store_users(rest, Impl.store(state, user_id, user))
end
