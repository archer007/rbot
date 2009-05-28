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
      _("j2 newtopics => gets new posts/topics from forums.joe.to"),
    ].join(", ")
  end

	def baconator(m, params)
		m.act('stuffs ' + m.sourcenick + '\'s mouth full of bacon')
	end
  
  # ugh. this needs to be completely re-done so that I can refer to sibling elements and 
  # get author names as well as the unread links. Can I specify a range of elements to extract from??
	def newtopics(m, params)
	 doc = Hpricot(open("http://forums.joe.to/search.php?search_id=newposts"))
	 topics = doc.search("//a[@class='topictitle']")
	
	newtopics = Array.new(30)
	
	iterator = 0
	topics.each do |topic|
		#m.reply topic.inner_html
		newtopics[iterator] = topic.inner_html
		iterator = iterator + 1
	end
	
	for i in 0..params[:number_of_topics] - 1
		m.reply newtopics[i]
	end
 end
end

plugin = J2Plugin.new

plugin.map 'j2 newtopics [number_of_topics]', :action=>'newtopics', :private => false, :defaults => { :number_of_topics => 5 }
plugin.map 'baconator'
	#:action => 'newtopics'
#plugin.map "j2 nt",
#  :action => 'newtopics'
