#-- vim:sw=2:et
#++
#
# :title: joe.to-specific commands
#
# Author:: Archer <dslguy14@yahoo.com>
#
# Copyright:: (C) 2009, Archer
#
# License:: GPL
#

require 'rexml/document'
require 'rubygems'
require 'hpricot'
require 'open-uri'
 
class J2Plugin < Plugin

  include REXML
  def help(plugin, topic="")
    [
      _("j2 => Prints this help menu"),
      _("j2 newposts => gets new posts from forums.joe.to"),
    ].join(", ")
  end

  # ugh. this needs to be completely re-done so that I can refer to sibling elements and 
  # get author names as well as the unread links. Can I specify a rango of elements to extract from??
	def j2(m, params)
	 doc = Hpricot(open("http://forums.joe.to/search.php?search_id=newposts"))
	 topics = doc.search("//a[@class='topictitle']")
	
	topics.each do |topic|
		m.reply topic.inner_html
	end
 end
end

plugin = J2Plugin.new

plugin.map "j2"
	#:action => 'newtopics'
#plugin.map "j2 nt",
#  :action => 'newtopics'
