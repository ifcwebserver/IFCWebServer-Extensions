class Report
attr_accessor :hash ,:ifcObjects
	def initialize(hash, ifcObjects)
		@hash=hash
		@ifcObjects=ifcObjects					
	end	
end


class ProjectInfo < Report	
	def to_html
		puts "</br></br>Report time:" + Time.now.to_s
		puts "<h1>Project information</h1>"
		puts "<b>Number of Stories: </b>" + IFCBUILDINGSTOREY.count.to_s
		puts "</br><b>Number of Slabs: </b>" + IFCSLAB.count.to_s
		puts "</br><b>Number of StandardWalls: </b>" + IFCWALLSTANDARDCASE.count.to_s
		puts "</br><b>Number of Doors: </b>" + IFCDOOR.count.to_s
		puts "</br><b>Number of Windows: </b>" + IFCWINDOW.count.to_s		
		$output_format="to_html"		
		IFCBUILDINGSTOREY.list("name|description|elevation")
		IFCSLAB.list("globalId|name|Net Volume:@ext_netVolume|description|")
		IFCDOOR.list("Identification:globalId|Name:fix_it(name)|Construction type:@ext_Type_ConstructionType|Operation Type:@ext_Type_OperationType |Classification-UniFormat|isExterior|Fire Rarting|Door Width:overallWidth|Door Height:overallHeight|Door Frame Depth:@ext_liningDepth|Door Frame Thickness:@ext_liningThickness|Door Leaf Thickness:@ext_panelDepth|Door Permiter:(overallHeight*2+overallWidth)|Door Gross Area:area|")
		IFCWALL.list("globalId|name|Net Volume:@ext_netVolume|description|")		
	end
end

class Quantitiy_Take_off < Report
	def to_html
		puts "<h1>Item|Quantity|Unit</h1>"
	end
	#Quantities by location#
end

class CacheReport < Report
	def to_html	
	puts "<table><tr><th>Class</th><th>#</th><th>HTML</th><th>XML</th></tr>"
	$list_of_objects.each { |k,v|
	next if k == 'IFC'
	puts "<tr><td>" + k + "</td><td>" + v.to_s + "</td><td>" 
		if not File.exist?("cache/#$username/" + $ifc_file_name + "/" + k + ".html")	
			puts "<a href='ifc.rb?output_format=to_html&ifc_file=" + $ifc_file_name + "&q=" + k.upcase + "'>cache it now</a>" 
		else
			puts "yes"
		end	
	puts "</td><td>"	
		if not File.exist?("cache/#$username/" + $ifc_file_name + "/" + k + ".xml")	
			puts "<a href='ifc.rb?output_format=to_xml&ifc_file=" + $ifc_file_name + "&q=" + k.upcase + "'>cache it now</a>" 
		else
			puts "yes"
		end
	puts "</td></tr>"
	}
	puts "</table>"
	end
end

def bims_list	
	puts "<table class='sortable'><thead>
	<tr>	
	<th>ID</th>
	<th>Preview</th>
	<th>File name</th>
	<th>Schema</th>
	<th>Time_stamp</th>		
	<th>Size(MB)</th>	
	<th>Author</th>	
	<th>Orginization</th>
	<th>Preprocessor_version</th>
	<th>Orginating_system</th>
	<th>Description	</th>			
	</tr></thead><tbody>"	
	id = 0
	Dir.foreach($ifc_file_dir_path + $username ) do |entry|
		fsize = (((File.size($ifc_file_dir_path + $username + "/" + entry).to_f/(1024*1024))*10**3).round.to_f / 10**3).to_s   			
		if entry.upcase.include?('.IFC')
			$file_header= []	
			#ifcFileContent = File.open($ifc_file_dir_path + $username + "/" + entry,"r")
			full_line =""	
			File.open($ifc_file_dir_path + $username + "/" + entry).each_line{ |line|
			#ifcFileContent.each do |line|
				if line.chomp[-1,1] != ";"
					full_line = full_line + line.chomp
					next
				end		
				full_line =   full_line + line
				file_schema =full_line.sub("FILE_SCHEMA","").gsub("(","").gsub(")","").gsub("'","").sub(";","").strip.upcase  if full_line.include?("FILE_SCHEMA")		
				$file_header << full_line if full_line.upcase.include?("FILE_DESCRIPTION") or full_line.upcase.include?("FILE_NAME") or full_line.upcase.include?("FILE_SCHEMA") 					
				full_line =""	
				break  if line.strip.include?("DATA")
			}	
			$header_obj= FileHeader.new($file_header) #.to_html	
			id += 1	
			puts "<tr>"
			puts "<th>" + id.to_s + "</th>"
			if File.exist?("D:/web_server/www/dae/" + $username + "/" + entry.sub(".ifc",".dae") )			
				#puts "<td ><a href='sgl/index.php?url="  + $username + "/" + entry.sub(".ifc","") + "'>View</br><img src=\"http://dl.dropbox.com/u/9691311/IfcWebServer_test_case/cache/" + $username + "/" + entry + ".png\" alt=\"" + entry.to_s.strip + "\"  width='150'></a></td>"
				puts "<td ><a href='sgl/index.php?url=" + $username + "/" + entry.sub(".ifc","") + "'>View</br><img src=\"cache/" + $username + "/" + entry + ".png\" alt=\"" + entry.to_s.strip + "\"  width='150'></a></td>"
			else			
				#puts "<td><img src=\"http://dl.dropbox.com/u/9691311/IfcWebServer_test_case/cache/" + $username + "/" + entry + ".png\" alt=\"" + entry.to_s.strip + "\"  width='150'></td>"
				puts "<td><img src=\"cache/" + $username + "/" + entry + ".png\" alt=\"" + entry.to_s.strip + "\"  width='150'></td>"
			end
			puts "<td>" + entry.to_s.strip.sub(".ifc","") 
			puts "</br><a href='ifc.rb?ifc_file=" + entry + "&q=objects_list'>Objects list</a></br><a href='ifc.rb?ifc_file=" + entry + "&q=tree'>Objects Tree</a>"
			puts "</td>"
			puts "<td>" + $header_obj.schema_identifieres.split("_").join("</br>").to_s + "</td>"
			puts "<td>" + $header_obj.time_stamp.split("T").join("<br>").to_s 
			begin
				puts "</br>(" + (DateTime.now - DateTime.strptime($header_obj.time_stamp.to_s, "%Y-%m-%dT%H:%M:%S")).to_i.to_s + " days)"
			rescue				
			end		
			puts "</td>"			
			puts "<td>" + fsize + "</td>"
			#puts "<td>" + $header_obj.name.to_s + "</td>"
			puts "<td>" + $header_obj.author.to_s + "</td>"	
			puts "<td>" + $header_obj.orginization.to_s + "</td>"
			puts "<td>" + $header_obj.preprocessor_version.to_s + "</td>"
			puts "<td>" + $header_obj.orginating_system + "</td>"
			puts "<td>" + $header_obj.description + "</td>"
		#	puts "<td>" + $header_obj.authorization + "</td>"
		#	puts "<td>" + $header_obj.implementation_level + "</td>"
			puts "</tr>"
		end	
	end	
	puts "</tbody></table>"
	puts "*<a href=\"doc/sources.html\" target=\"_blank\">BIMs sources</a><br>"
	puts "*<a href=\"statistic.rb\" >Statistics</a><br>"
end

def exchange_information_for_energy_simulation
print <<EOF
<table>
<tr>
<th>Type of Info</th>
<th>Information needed</th>
<th>Required</th>
<th>Optional</th>
<th>Data Type</th>
<th>Unit</th>
</tr>
<tr>
<td>
<form action="ajax.rb?query=new_exchange_info">
<input type=button value="add new Exchange Info">
</form>
</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
</table>
EOF
	File.open("html_templates/add_new_exchang.html").each_line do |l|
		puts l
	end		
end

