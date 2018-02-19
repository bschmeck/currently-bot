defmodule Currently.Users do
  use GenServer

  # Client

  def start_link do
    GenServer.start_link(__MODULE__, %{}, [])
  end

  def info(pid, user_id) do
    GenServer.call(pid, {:info, user_id})
  end

  # Server

  def handle_call({:info, user_id}, _from, state) do
    # User in state?
    # Yes: Pull from state and return
    # No: Fetch user info
    # User exists?
    # Yes: Initiate DM, update state and return
    # No: Return error

    state = if unknown_user?(state, user_id) do
      state |> add_new_user(user_id)
    else
      state
    end

    user = state |> lookup_user(user_id)

    {:reply, {:ok, user}, state}
  end

  defp add_new_user(state, user_id) do
    user = with {:ok, handle} <- user_id |> fetch_user |> handle_for,
                {:ok, channel} <- user_id |> initiate_dm |> channel_for
      do
      %{handle: handle, channel: channel}
      else
        {:error, :user_not_found} -> %{handle: :not_found, channel: nil}
    end

    state = state |> Map.put(user_id, user)
  end

  defp unknown_user?(state, user_id), do: !Map.has_key?(state, user_id)

  defp lookup_user(state, user_id), do: Map.get(state, user_id)

  defp fetch_user(user_id), do: Slack.Web.Users.info(user_id, %{token: token()})
  defp initiate_dm(user_id), do: Slack.Web.Im.open(user_id, %{token: token()})
  defp handle_for(%{"user" => %{"name" => handle}}), do: {:ok, handle}
  defp handle_for(%{"error" => "user_not_found"}), do: {:error, :user_not_found}
  defp channel_for(%{"channel" => %{"id" => id}}), do: {:ok, id}

  defp token, do: System.get_env("CURRENTLY_TOKEN")
end
