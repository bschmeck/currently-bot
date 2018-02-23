defmodule Currently.Slack.TestAPI do
  def user_info("FAKE_USER") do
    %{"error" => "user_not_found", "ok" => false,
      "response_metadata" => %{"warnings" => ["superfluous_charset"]},
      "warning" => "superfluous_charset"}
  end

  def user_info("REAL_USER") do
    %{"ok" => true, "response_metadata" => %{"warnings" => ["superfluous_charset"]},
      "user" => %{"color" => "9f69e7", "deleted" => false, "id" => "REAL_USER",
                 "is_admin" => true, "is_app_user" => false, "is_bot" => false,
                 "is_owner" => true, "is_primary_owner" => true, "is_restricted" => false,
                 "is_ultra_restricted" => false, "name" => "jquser",
                 "profile" => %{"avatar_hash" => "gd09cec8ccd4", "display_name" => "",
                               "display_name_normalized" => "", "email" => "user@example.com",
                               "image_192" => "https://secure.gravatar.com/avatar/d09fffffffffffffffffffffffffffff.jpg?s=192&d=https%3A%2F%2Fa.slack-edge.com%2F7fa9%2Fimg%2Favatars%2Fava_0020-192.png",
                               "image_24" => "https://secure.gravatar.com/avatar/d09fffffffffffffffffffffffffffff.jpg?s=24&d=https%3A%2F%2Fa.slack-edge.com%2F66f9%2Fimg%2Favatars%2Fava_0020-24.png",
                               "image_32" => "https://secure.gravatar.com/avatar/d09fffffffffffffffffffffffffffff.jpg?s=32&d=https%3A%2F%2Fa.slack-edge.com%2F0180%2Fimg%2Favatars%2Fava_0020-32.png",
                               "image_48" => "https://secure.gravatar.com/avatar/d09fffffffffffffffffffffffffffff.jpg?s=48&d=https%3A%2F%2Fa.slack-edge.com%2F66f9%2Fimg%2Favatars%2Fava_0020-48.png",
                               "image_512" => "https://secure.gravatar.com/avatar/d09fffffffffffffffffffffffffffff.jpg?s=512&d=https%3A%2F%2Fa.slack-edge.com%2F7fa9%2Fimg%2Favatars%2Fava_0020-512.png",
                               "image_72" => "https://secure.gravatar.com/avatar/d09fffffffffffffffffffffffffffff.jpg?s=72&d=https%3A%2F%2Fa.slack-edge.com%2F66f9%2Fimg%2Favatars%2Fava_0020-72.png",
                               "phone" => "", "real_name" => "jquser",
                               "real_name_normalized" => "jquser", "skype" => "", "status_emoji" => "",
                               "status_text" => "", "team" => "TEAM_ID", "title" => ""},
                 "real_name" => "jquser", "team_id" => "TEAM_ID",
                 "tz" => "America/Chicago", "tz_label" => "Central Standard Time",
                 "tz_offset" => -21600, "updated" => 1504362447},
      "warning" => "superfluous_charset"}
  end

  def initiate_dm(_user_id), do: %{"channel" => %{"id" => 0}}

  def channel_info("CHANNEL_ID") do
    %{"channel" => %{"created" => 1448288930, "creator" => "REAL_USER",
                    "id" => "CHANNEL_ID", "is_archived" => false, "is_channel" => true,
                    "is_general" => false, "is_member" => false, "is_mpim" => false,
                    "is_org_shared" => false, "is_private" => false, "is_shared" => false,
                    "members" => ["REAL_USER", "USER_ID1"], "name" => "random",
                    "name_normalized" => "random", "previous_names" => [],
                    "purpose" => %{"creator" => "", "last_set" => 0, "value" => ""},
                    "topic" => %{"creator" => "", "last_set" => 0, "value" => ""},
                    "unlinked" => 0}, "ok" => true,
      "response_metadata" => %{"warnings" => ["superfluous_charset"]},
      "warning" => "superfluous_charset"}
  end
end
