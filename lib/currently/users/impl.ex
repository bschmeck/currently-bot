defmodule Currently.Users.Impl do
  @slack_api Application.get_env(:currently, :slack_api)

  def all_users do
    @slack_api.user_list
    |> Map.get("members")
    |> Enum.map(fn %{"id" => user_id, "name" => handle, "is_bot" => is_bot} -> {user_id, %{handle: handle, is_bot: is_bot}} end)
  end

  def lookup(users, user_id) do
    if Map.has_key?(users, user_id) do
      Map.get(users, user_id)
    else
      fetch_new_user(user_id)
    end
  end

  def bot_ids(users) do
    users
    |> Enum.filter(fn {_user_id, user_info} -> user_info[:is_bot] end)
    |> Enum.map(fn {user_id, _user_info} -> user_id end)
  end

  def store(users, user_id, user) do
    Map.put(users, user_id, user)
  end

  defp fetch_new_user(user_id) do
    with {:ok, handle} <- user_id |> user_info |> handle_for,
         {:ok, channel} <- user_id |> initiate_dm |> channel_for
    do
      %{handle: handle, channel: channel}
    else
      {:error, :user_not_found} -> %{handle: :not_found, channel: nil}
    end
  end

  defp user_info(user_id), do: @slack_api.user_info(user_id)
  defp handle_for(%{"user" => %{"name" => handle}}), do: {:ok, handle}
  defp handle_for(%{"error" => "user_not_found"}), do: {:error, :user_not_found}

  defp initiate_dm(user_id), do: @slack_api.initiate_dm(user_id)
  defp channel_for(%{"channel" => %{"id" => id}}), do: {:ok, id}
end
