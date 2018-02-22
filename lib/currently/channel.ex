defmodule Currently.Channel do
  @slack_api Application.get_env(:currently, :slack_api)

  def victim(channel_id) do
    channel_id
    |> @slack_api.channel_info
    |> users_in
    |> Enum.random
  end

  defp users_in(%{"channel" => %{"members" => members}}), do: members
end
