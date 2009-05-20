#-- vim:sw=2:et
#++
#
# :title: fmylife.com quote retrieval
#
# Author:: David Gadling <dave@toasterwaffles.com>
#
# Copyright:: (C) 2009, David Gadling
#
# License:: public domain
#

require 'rexml/document'

class FMLPlugin < Plugin

  include REXML
  def help(plugin, topic="")
    [
      _("fml => print a random quote from fmylife.com"),
      _("fml id => print that quote from fmylife.com"),
    ].join(", ")
  end

  def fml(m, params)
    if params.key? :id
      id = params[:id]
    else
      id = "random"
    end

    url = "http://api.betacie.com/view/%{id}/nocomment?key=readonly&language=en" % {:id => id}
    xml = @bot.httputil.get(url)

    unless xml
      m.reply "XML parse failed. FML."
      return
    end
    doc = Document.new xml
    unless doc
      m.reply "XML parse failed. FML."
      return
    end
    root = doc.elements['root'].elements['items'][0]
    text = root.elements['text'].text
    id = root.attributes['id']
    agree = root.elements['agree'].text
    deserved = root.elements['deserved'].text
    reply = "%{text} %{bold}%{id}%{bold} %{green}%{agree} %{red}%{deserved}" % {
      :text => text, :id => id, :agree => agree, :deserved => deserved, 
      :bold => Bold, :green => Irc.color(:green), :red => Irc.color(:red)
    }
    m.reply reply
  end
end

plugin = FMLPlugin.new

plugin.map "fml [:id]", :defaults => {:id => 'random'}
