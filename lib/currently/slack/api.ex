defmodule Currently.Slack.API do
  @token Application.get_env(:currently, Currently.Slack.API)[:token]

  def user_list do
    Slack.Web.Users.list(%{token: @token})
  end

  def user_info(user_id) do
    Slack.Web.Users.info(user_id, %{token: @token})
  end

  def initiate_dm(user_id) do
    Slack.Web.Im.open(user_id, %{token: @token})
  end

  def channel_info(channel_id) do
    Slack.Web.Channels.info(channel_id, %{token: @token})
  end
end
