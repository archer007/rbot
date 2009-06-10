#-- vim:sw=2:et
#++
#
# :title: YubNub plugin for rbot
#
# Author:: Archer <dslguy14@yahoo.com>
# License:: GPL v2
#
# Simple rbot plugin to make
# YubNub queries

class YubNubPlugin < Plugin
  
  def run_yubnub_command(m, params)
	m.reply("http://yubnub.org/parser/parse?command=" + params[:yarg])
  end

  def help(plugin, topic="")
    case topic
    when 'tf2'
      return _("tf2 <server> => return map name and number of players on the given server")
    when 'servers'
      return _("servers => same as saying !tf2 <server1> !tf2 <server2>...")
    when 'players'
      return _("players <server> => returns a list of players on server")
    end
    return _("tf2 topics: tf2, servers, players")
  end

end

plugin = YubNubPlugin.new
plugin.map 'y :yarg', :action=>'run_yubnub_command'
