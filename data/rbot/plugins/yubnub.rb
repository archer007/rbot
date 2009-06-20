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
	#y_string = ""
	
	#params.each do |p|
	#	y_string = y_string + p + " "
	#end+ params[:yarg] + 
	
	m.reply("http://yubnub.org/parser/parse?command=" + params[*rest])
	
  end

  def help(plugin, topic="")
	
  end

end

plugin = YubNubPlugin.new
plugin.map 'y :yarg *rest', :action=>'run_yubnub_command'
