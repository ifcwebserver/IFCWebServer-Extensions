require "fileutils"
class Report
attr_accessor :hash,:ifcObjects
  def initialize(hash={}, ifcObjects={})
    @hash=hash
    @ifcObjects=ifcObjects
  end
  
  def to_html
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

class CacheReport < Report
  def to_html  
    puts "<table><tr><th>Class</th><th>#</th><th>HTML</th><th>XML</th></tr>"
    $list_of_objects.each { |k,v|
    next if k == 'IFC'
    puts "<tr><td>" + k + "</td><td>" + v.to_s + "</td><td>" 
      if not File.exist?("#$cache_folder/#$username/" + $ifc_file_name + "/" + k + ".html")  
        puts "<a href='ifc.rb?output_format=to_html&ifc_file=" + $ifc_file_name + "&q=" + k.upcase + "'>cache it now</a>" 
      else
        puts "yes"
      end  
    puts "</td><td>"  
      if not File.exist?("#$cache_folder/#$username/" + $ifc_file_name + "/" + k + ".xml")  
        puts "<a href='ifc.rb?output_format=to_xml&ifc_file=" + $ifc_file_name + "&q=" + k.upcase + "'>cache it now</a>" 
      else
        puts "yes"
      end
    puts "</td></tr>"
    }
    puts "</table>"
  end
end

class QueryHistory < Report
  def to_html
    HTML.h2 "My Queries"
    missing_files=[]
    Dir["/var/www/virtual/ali1976/html/temp/all/*.ifc"].each {|file| 
      if file.include?($username + "_")
         if File.exist?(file.sub(".ifc",".png"))
            file = file.sub("/var/www/virtual/ali1976/html/","")
	    puts "Download:<b><a href='/" + file + "'>" + file.sub("temp/all/","") + "</a></b><br />Online Viewer: click on the image<br/>"
            puts "<a href='sgl/?url=../" + file.sub(".ifc","") + "'> <img src='" + file.sub(".ifc",".png") + "'></a><hr>"
         else
            puts "Download:<b><a href='/temp/all/" + file.sub("/var/www/virtual/ali1976/html/temp/all/","") + "'>" + file.sub("/var/www/virtual/ali1976/html/temp/all/","")  + "</a></b><br />"
            puts "<img src='images/spinner.gif'>The real-time render for IFC files is not active on the server for moment</br><hr>"
            missing_files << file 
         end
      end
    }
    if missing_files.size > 0
      to = "ali.syria.germany@gmail.com"
      subject = "IFCWebServer: please run the redner process"
      content = "You have to run the render process now<br>:" + missing_files.join("\n")
      `mail -s "#{subject}" #{to}<<EOM
       #{content} 
       EOM`
    end
  end
end

class ModelTree < Report
	def to_html
	puts <<EOF
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" />
		<script src="http://code.jquery.com/jquery-1.8.3.js"></script>
		<script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>
		<link rel='stylesheet' href='http://tamerayd.in/works/jquery-sapling/jquery.sapling.css'>
		<script type='text/javascript' src='http://tamerayd.in/works/jquery-sapling/jquery.sapling.min.js'></script>
		<script type="text/javascript">
		$(document).ready(function() {
		$('#model_tree').sapling();
		});
</script>
EOF
	model_tree
	end
	
	def model_tree
	res=""
		res += "<ul id='model_tree'>"
		res += "<li>" 
		res += IFCPROJECT.where("all","o.name").join.gsub("'","")
		res += "<ul><li>"
		 res += IFCSITE.where("all","o.name").join.gsub("'","")
			res += "<ul>"
			IFCBUILDING.where("all","o").each { |b|
			   res += "<li>" + b.name.gsub("'","")
				 res += "<ul>" 
					  IFCBUILDINGSTOREY.where("all","o").each { |bs|
						  res += "<li>" + bs.name.gsub("'","")
						  res += "<ul>"
						  IFCRELCONTAINEDINSPATIALSTRUCTURE.where("o.relatingStructure=='#" + bs.line_id.to_s + "'","o").each { |bs|	
						  cls={}
						  bs.relatedElements.toIfcObject.each{|k,v| 
						  cls[v.class] ||= []
						  cls[v.class] << v.name.gsub("'","")
						  }
						  cls.each { |element_class,elements|
						  img =""
						  img="<img src='img/" + element_class.to_s + ".PNG' />" if File.exist?("img/" + element_class.to_s + ".PNG")
						  res += "<li>" + img + $ifcClassesNames[element_class.to_s].sub("Ifc","") + "(" + elements.size.to_s + ")<ul><li>" + elements.join("<li>") + "</ul></li>"
						  }
						  }
						  res += "</ul>"
					  }#end_buildingstorey
				 res += "</ul>" 
			   res += "</li>" 
			 }#end_building
			res += "</ul>"#end_site
		res += "</li>" 
		res += "</ul>"
		res += "</ul>"
		res
	end
end

class Doors < Report
require File.dirname(__FILE__) + '/Server.rb'
  def to_html(filter="all")
	  number_of_doors=0
	  HTML.h1 "Doors"
	  HTML.tableHeader "BIM model","GUID","Preview","overallWidth","overallHeight","Name"
	  $doors={}
	  Server.ModelsList.each { |m|
	  Server.classes_list(m)
	  if $list_of_objects["IfcDoor"] != nil		 
		number_of_doors += $list_of_objects["IfcDoor"]
		$hash={}
		$ifcObjects={}
		$points={}
		$guid={}
		$saved_as_ifc={}
		$depend_on={}
		ifc_file= $ifc_file_dir_path + $username + "/" +  m
		read_ifc_file(ifc_file) if $hash.size == 0
		IFCDOOR.where(filter,"o").each { |o|
		HTML.arr_to_row [m,o.globalId,o.preview,o.overallWidth,o.overallHeight,o.name] if $doors[[o.overallHeight,o.overallWidth]] == nil
		$doors[[o.overallHeight,o.overallWidth]]=true
		}
	  end	  		
	  }
	  puts "</table>"
	  puts number_of_doors.to_s
  end
end

class FurnishingElement < Report
require File.dirname(__FILE__) + '/Server.rb'
  def to_html
	  number_of_doors=0
	  HTML.h1 "FurnishingElement"
	  HTML.tableHeader "BIM model","GUID","Preview","objectType","Name"
	  $doors={}
	  Server.ModelsList.each { |m|
	  $ifc_file_name = m
	  Server.classes_list(m)
	  if $list_of_objects["IfcFurnishingElement"] != nil		 
		number_of_doors += $list_of_objects["IfcFurnishingElement"]
		$hash={}
		$ifcObjects={}
		$points={}
		$guid={}
		$saved_as_ifc={}
		$depend_on={}
		ifc_file= $ifc_file_dir_path + $username + "/" +  m
		read_ifc_file(ifc_file) if $hash.size == 0
		IFCFURNISHINGELEMENT.where("all","o").each { |o|
		HTML.arr_to_row [m,o.globalId,o.preview,o.objectType,o.name] if $doors[o.objectType] == nil
		$doors[o.objectType]=true
		}
	  end	  		
	  }
	  puts "</table>"
	  puts number_of_doors.to_s
  end
end

def bims_list_full  
  puts "<table class='sortable'  width='95%'>
<thead>
	<tr>
		<th>ID</th>
		<th>Preview</th>
		<th>Model</th>
		<th>Schema</th>
		<th>TimeStamp</th>
		<th>Size</th>
		<th>Author</th>
		<th>Orginization</th>
		<th>PreprocessorVersion</th>
		<th>OrginatingSystem</th>
		<th>Description</th>
	</tr>
	</thead>
<tbody>"
  Server.ModelsList.sort.each_with_index { |model,id|
    fsize = (((File.size($ifc_file_dir_path + $username + "/" + model).to_f/(1024*1024))*10**3).round.to_f / 10**3).to_s         
      $file_header= []
      full_line =""
      File.open($ifc_file_dir_path + $username + "/" + model).each_line{ |line|
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
      $header_obj= FileHeader.new($file_header)
		
      puts "<tr>"
      puts "<th>#{id+1}</th>"
      if File.exist?("#$ifc_path/cache/" + $username + "/" + model + "/" +  model + ".png" )
        img_url= "cache/" + $username + "/" + model + "/"+  model + ".png"
      else
        img_url= "http://cdn.ifcwebserver.org/cache/" + $username + "/" + model + "/"+  model + ".png"
      end

      if File.exist?("#$ifc_path/dae/" + $username + "/" + model.sub(".ifc",".dae") )
        puts "<td ><a href='index.rb?ifc_file=" + model + "'><img src='" + img_url + "' alt=\"" + model.to_s.strip + "\"  width='100'></a></td>"
      elsif File.exist?("#$ifc_path/cache/" + $username + "/" + model + "/" +  model + ".png" )
        puts "<td><a href='index.rb?ifc_file=" + model + "'><img src='" + img_url + "' alt=\"" + model.to_s.strip + "\"  width='100'></a></td>"
      else
        puts "<td><a href='index.rb?ifc_file=" + model + "'><img src=\"/img/no_preview.png\" alt=\"no preview\"  width='100'></a>" + "</td>"
      end	  
      puts "<td>" + model.to_s.strip.sub(".ifc","")
      puts "</br><a href='ifc.rb?ifc_file=" + model + "&q=objects_list'>Objects list</a></br><a href='ifc.rb?ifc_file=" + model + "&q=tree'>Objects Tree</a>"
      puts "</td>"
      puts "<td>" 
      puts $header_obj.schema_identifieres.split("_").join("</br>").to_s if $header_obj.schema_identifieres != nil
      puts "</td>"
      puts "<td>" + $header_obj.time_stamp.split("T").join("<br>").to_s
      begin
        puts "</br>(" + (DateTime.now - DateTime.strptime($header_obj.time_stamp.to_s, "%Y-%m-%dT%H:%M:%S")).to_i.to_s + " days)"
      rescue
      end
      puts "</td>"
      puts "<td>" + fsize + "</td>"
      #puts "<td>#{ $header_obj.name}</td>"
      puts "<td>#{$header_obj.author}</td>"  
      puts "<td>#{$header_obj.orginization}</td>"
      puts "<td>#{$header_obj.preprocessor_version}</td>"
      puts "<td>#{$header_obj.orginating_system}</td>"
      puts "<td>" + $header_obj.description.gsub("[","").gsub("]","").gsub("Option","<hr>") + "</td>"
     # puts "<td>#{$header_obj.authorization}</td>"
     # puts "<td>#{$header_obj.implementation_level}</td>"
      puts "</tr>"
  } 
  puts "</tbody></table>"
end

def bims_list  

#  puts "<h3>Projects</h3>"
#    Server.ProjectsList.each { |project|
#    HTML.h4  project
#    puts Server.ModelsList(project).sort.join("<br>")
#    puts "<hr>"
#   }
  puts "<table class='sortable' width='95%'><thead>
  <tr>
  <th>ID</th>
  <th>Preview</th>
  <th>Model</th>
  <th>Size (MB)</th>
  </tr>
</thead>
<tbody>"
  Server.ModelsList.sort.each_with_index { |model,id|
    fsize = (((File.size($ifc_file_dir_path + $username + "/" + model).to_f/(1024*1024))*10**3).round.to_f / 10**3).to_s         
      puts "<tr>"
      puts "<th>#{id+1}</th>"
      if File.exist?("#$ifc_path/cache/" + $username + "/" + model + "/" +  model + ".png" )
        img_url= "cache/" + $username + "/" + model + "/"+  model + ".png"
      else
        img_url= "cache/" + $username + "/" + model + "/"+  model + ".png"
      end

      if File.exist?("#$ifc_path/dae/" + $username + "/" + model.sub(".ifc",".dae") )
        puts "<td ><a href='index.rb?ifc_file=" + model + "'><img src='" + img_url + "' alt=\"" + model.to_s.strip + "\"  width='180'></a>"		
      elsif File.exist?("#$ifc_path/cache/" + $username + "/" + model + "/" +  model + ".png" )
        puts "<td><a href='index.rb?ifc_file=" + model + "'><img src='" + img_url + "' alt=\"" + model.to_s.strip + "\"  width='180'></a>"
      else
        puts "<td><a href='index.rb?ifc_file=" + model + "'><img src=\"/img/no_preview.png\" alt=\"no preview\"  width='180'></a>"
      end	
      #if $username != "user1" orConsole.session.admin == true
      if Console.session.admin == true
       puts "<a href='delete_model.rb?f=" + model + "'>Delete<a>"
       puts " | <a href='/bim-annotator/db/db_.php?sqlite=&username=&db=/var/www/html/cache/#{$username}/#{model}/#{model.sub(".ifc","")}_Pset.sqlite'>DB</a>"
      end
      puts "</td>"  
      puts "<td>" + model.to_s.strip.sub(".ifc","")
      puts "</br><a href='ifc.rb?ifc_file=" + model + "&q=objects_list'>Objects list</a></br><a href='ifc.rb?ifc_file=" + model + "&q=tree'>Objects Tree</a>"
      puts "</td>"
      puts "<td>" + fsize + "</td>"
      puts "</tr>"
  } 
  puts "</tbody></table>"
end