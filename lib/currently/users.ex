defmodule Currently.Users do
  use GenServer
  alias Currently.Users.Impl

  # Client

  def start_link do
    GenServer.start_link(__MODULE__, %{}, [])
  end

  def info(pid, user_id) do
    GenServer.call(pid, {:info, user_id})
  end

  # Server

  def handle_call({:info, user_id}, _from, state) do
    user = state |> Impl.lookup(user_id)
    state = state |> Impl.store(user_id, user)

    {:reply, {:ok, user}, state}
  end
end
