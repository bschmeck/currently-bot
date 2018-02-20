defmodule Currently.Slack.API do
  def user_info(user_id) do
    Slack.Web.Users.info(user_id, %{token: token()})
  end

  def initiate_dm(user_id) do
    Slack.Web.Im.open(user_id, %{token: token()})
  end

  defp token, do: System.get_env("CURRENTLY_TOKEN")
end
