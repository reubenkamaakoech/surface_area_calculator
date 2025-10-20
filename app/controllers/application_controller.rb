class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

   before_action :update_last_seen_at

  def update_last_seen_at
  return unless current_user

  if current_user.last_seen_at.nil? || current_user.last_seen_at < 1.minute.ago
    current_user.update_column(:last_seen_at, Time.current)
    broadcast_online_users
  end
end

def broadcast_online_users
  turbo_stream = ApplicationController.render(
    partial: "users/online_list",
    locals: { online_users: User.online }
  )
  ActionCable.server.broadcast("online_users_channel", { html: turbo_stream })
end
end
