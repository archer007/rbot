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
require 'rss/1.0'
require 'rss/2.0'
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
	
	if 1 == 1
		m.reply "DEBUG: Start of j2 function"
		m.reply "DEBUG: Number of topics requested is: " + params[:num_of_topics]
	end
	
	source = "http://forums.joe.to/rss.php" # url or local file
	content = "" # raw content of rss feed will be loaded here
	open(source) do |s| content = s.read end
	rss = RSS::Parser.parse(content, false)
	
	if 1 == 1
		m.reply "DEBUG: Assigned variable rss"
	end
	
	if 1 == 1
		m.reply "DEBUG: Testing to see if rss was assigned correctly."
		m.reply "DEBUG: Title of Item 6 is: " + rss.channel.items[5].title
		m.reply "DEBUG: Entering loop..."
	end
	
	itr = 0
	for i in (0..params[:num_of_topics])
		m.reply rss.channel.items[itr].title
		itr += 1	
	end
	
	
	
	#itr = 0
	#(0..params[:num_of_topics]).each do |i|
        #	m.reply "DEBUG: Loop engaged."
        #	m.reply rss.channel.items[itr].title
        #	itr += 1
        #end
    
	    
	#m.reply rss.channel.items[5].title
	
	#rss.channel.items.each do |item|
	#	m.reply "DEBUG: " + item.title.index
	#	m.reply item.title
		#break if item.title.index >= params[:num_of_topics]
	#end
	
	m.reply "DEBUG: End of j2 function"
 end
end

plugin = J2Plugin.new

#plugin.map "j2"
	#:action => 'newtopics'
plugin.map "j2 [:num_of_topics]", :defaults => {:num_of_topics => 3}
#  :action => 'newtopics'
