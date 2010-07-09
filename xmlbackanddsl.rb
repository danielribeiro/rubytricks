#!/usr/bin/env ruby
require 'nokogiri'
require 'pp'

data = <<-eof
<?xml version="1.0" encoding="UTF-8"?>
<!--
================================================================================
/**
 * Main XUL file. It start MAB.
 * It can be loaded directly from a URL, with the browser File -> Open or when
 * installed from the Tools menu.
 *
 * @filename mab.xul
 * @$LastChangedDate: 2004-05-07 16:58:00 +0200 (Fri, 07 May 2004) $
 * @author Fabio Serra <faser@faser.net>
 * @copyright Fabio Serra (The Initial Developer of the Original Code)
 * @license Mozilla Public License Version 1.1
*/
================================================================================
-->

<?xml-stylesheet href="chrome://global/skin/" type="text/css"?>
<?xml-stylesheet href="../skin/mab.css" type="text/css"?>
<?xul-overlay href="overlay/main_menubar.xul"?>
<?xul-overlay href="overlay/icon_toolbar.xul"?>
<?xul-overlay href="overlay/search_toolbar.xul"?>
<?xul-overlay href="overlay/result_tree.xul"?>
<?xul-overlay href="overlay/detail_box.xul"?>
<?xul-overlay href="overlay/price_box.xul"?>
<?xul-overlay href="overlay/status_statusbar.xul"?>
<!DOCTYPE window [

	<!ENTITY catalog.label "Catalog">
	<!ENTITY next.label "Next">
	<!ENTITY next.tooltip "Get Next Records">

	<!ENTITY clear.label "Clear">

	<!ENTITY imageLarge.tooltip "Click to see the larger image">
	<!ENTITY review.label "Reviews">
	<!ENTITY info.label "Product Info">
]
>

<window id="amazWindow"
	title=""
	xmlns="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"
	width="800"
	height="600"
	onload="main()"
	type="mab:main"
	persist="screenX screenY width height sizemode">

<!-- Include Javascript -->
<script src="js/ProductLine.js" type="application/x-javascript"/>
<script src="js/ProductLineController.js" type="application/x-javascript"/>
<script src="js/DisplayController.js" type="application/x-javascript"/>
<script src="js/SearchController.js" type="application/x-javascript"/>

<script src="js/SearchHistory.js" type="application/x-javascript"/>
<script src="js/ProgressBar.js" type="application/x-javascript"/>
<script src="js/QueryStringBuilder.js" type="application/x-javascript"/>
<script src="js/Connection.js" type="application/x-javascript"/>
<script src="js/FileManager.js" type="application/x-javascript"/>
<script src="js/AmazonParser.js" type="application/x-javascript"/>
<script src="js/XMDManager.js" type="application/x-javascript"/>
<script src="js/DocOpenManager.js" type="application/x-javascript"/>
<script src="js/config.js" type="application/x-javascript"/>
<script src="js/utils.js" type="application/x-javascript"/>
<script src="js/mab.js" type="application/x-javascript"/>

<!-- Broadcaster -->
<broadcaster id="isSearchRunning" disabled="true"/>
<!-- Some buttons that have to be disabled in remote MAB -->
<broadcaster id="isMabRemote" disabled="false"/>

<commandset id="mabCommand">
	<!-- Overlay main_menubar.xul -->
	<commandset id="menubarCommand" />

	<command id="newSearchCmd" oncommand="newSearch()"/>
	<command id="nextCmd" oncommand="nextRecord()"/>
	<command id="clearCmd" oncommand="clearAll()" />
	<command id="commentCmd" oncommand="getComment()"/>
	<command id="goAmazonCmd" oncommand="goAmazon()" />
	<command id="addCartCmd" oncommand="addCart()" />

	<command id="goGoogleCmd" oncommand="goGoogle()" />
	<command id="deleteCmd" oncommand="deleteRow()"/>
</commandset>

<!-- All Keyset must stay in the same file -->
<keyset>
	<key id="search-key"  keycode="VK_RETURN" command="newSearchCmd"/>
 	<key id="search-key"  keycode="VK_ENTER"  command="newSearchCmd"/>
	<key id="delete-key"  keycode="VK_DELETE"  command="deleteCmd"/>
	<!-- main_menubar.xul -->
	<key id="new-key" modifiers="accel" key="n" command="newCmd"/>

	<key id="close-key" modifiers="accel" key="w" command="closeCmd"/>
	<key id="save-key" modifiers="accel" key="s" command="saveCmd"/>

	<key id="review-key" modifiers="accel" key="r" command="commentCmd"/>
</keyset>



<!--
This invisible spacer is used to store preferences
In this way I can store preferences for remote and installed MAB version
-->
<spacer id="settings-spacer" hidden="true" search="lite" nrResult="20" persist="search nrResult"/>
<!-- UI Start -->
<toolbox>
	<!-- Overlay MenuBar -->

	<menubar id="main-menubar"/>
	<!-- Overlay Toolbar icon -->
	<toolbar id="icon-toolbar"/>
	<!-- Overlay Search toolbar -->
	<toolbar id="search-toolbar"/>
</toolbox>

<!-- Tree -->
<hbox flex="1" id="main-box">
	<vbox>
		<!-- Tree Overlay -->

		<tree id="result-tree"/>
		<!-- Details Overlay -->
		<hbox id="detail-box"/>
		<separator class="groove"/>
		<!-- Price Overlay  -->
		<hbox id="price-box" />
	</vbox>
	<splitter id="detail-comment" collapse="after" resizeafter="grow">
		<grippy />

	</splitter>
	<!-- Extra Info right panel -->
	<tabbox flex="1" id="extra-info-tab">
		<tabs id="comment-tab">
			<tab label="&info.label;"/>
			<tab label="&review.label;"/>
		</tabs>
		<tabpanels style="background-color: White;" flex="3">
			<tabpanel>

				<iframe id="allInfo-selected" src="html/allinfo.html" flex="3" />
			</tabpanel>
			<tabpanel>
				<iframe id="comment-selected" src="html/comment.html" flex="3"/>
			</tabpanel>
		</tabpanels>
	</tabbox>
</hbox>
	<!-- Status Bar Overlay -->

	<statusbar id="mab-status-bar" />
</window>

eof

class Hash
  class << self
    def from_xml(xml_io)
        result = Nokogiri::XML(xml_io)
        return { result.root.name.to_sym => xml_node_to_hash(result.root)}

    end

    def xml_node_to_hash(node)
      # If we are at the root of the document, start the hash
      if node.element?
        result_hash = {}
        if node.attributes != {}
          result_hash[:attributes] = {}
          node.attributes.keys.each do |key|
            result_hash[:attributes][node.attributes[key].name.to_sym] = prepare(node.attributes[key].value)
          end
        end
        if node.children.size > 0
          node.children.each do |child|
            result = xml_node_to_hash(child)

            if child.name == "text"
              unless child.next_sibling || child.previous_sibling
                return prepare(result)
              end
            elsif result_hash[child.name.to_sym]
              if result_hash[child.name.to_sym].is_a?(Object::Array)
                result_hash[child.name.to_sym] << prepare(result)
              else
                result_hash[child.name.to_sym] = [result_hash[child.name.to_sym]] << prepare(result)
              end
            else
              result_hash[child.name.to_sym] = prepare(result)
            end
          end

          return result_hash
        else
          return result_hash
        end
      else
        return prepare(node.content.to_s)
      end
    end

    def prepare(data)
      (data.class == String && data.to_i.to_s == data) ? data.to_i : data
    end
  end

  def to_struct(struct_name)
    Struct.new(struct_name,*keys).new(*values)
  end
end



#xml = Nokogiri::XML.parse(data)
pp Hash.from_xml(data)