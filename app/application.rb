require 'rho/rhoapplication'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    # Super must be called *after* settings @tabs!
    @tabs = nil
    @@tabbar = nil
# 
#     @@toolbar = [
#          {:action => :home},
#          {:action => :sync},
#          {:action => :options}
#       ]
    super

    # Uncomment to set sync notification callback to /app/Settings/sync_notify.
    # SyncEngine::set_objectnotify_url("/app/Settings/sync_notify")
    # SyncEngine.set_notification(-1, "/app/Settings/sync_notify", '')

	$is_device_setup = false
  end

end
