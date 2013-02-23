class Server
	def self.Compare(m1,m2)
		#doc:<div class='documentaion'>Compare two IFC models m1,m2 and show the reulst as HTML table</div>
		load $ifc_path + "/cache/" + $username +"/"  + m1 +".rb"
		hash1=$list_of_objects
		load $ifc_path + "/cache/" + $username + "/" + m2 +".rb"
		hash2=$list_of_objects
		hash1.diff(hash2).html_table.sub("<table>","<table><tr><th>IFC Class name</th><th>[Model1,Model2]</th></tr>")
	end

	def self.ModelsCount
		#doc:<div class='documentaion'>Return the number of IFC models owned by the current user on the server</div>
		Dir.entries($ifc_file_dir_path + "/" + $username ).size - 2
	end
	
	def self.ModelsList
		#doc:<div class='documentaion'>Return an array of all IFC models owned be the current user on the server</div>
		#Dir.entries( $ifc_file_dir_path + $username ).join(",").split(",")- [".",".."]
		Dir[$ifc_file_dir_path + $username + "/*.ifc"].entries.join(",").gsub($ifc_file_dir_path + $username + "/","").split(",")- [".",".."]
	end
	
	def self.classes_list(m1)
	if File.exist?($ifc_path + "/cache/" + $username +"/"  + m1 +".rb")
	load $ifc_path + "/cache/" + $username +"/"  + m1 +".rb"
	$list_of_objects
	else
		{}
	end
	end
	
	def version
	"1.0"
	end

	def self.runConverter(path="runconverter")
	  FakeFS.deactivate! if FakeFS != nil
      File.new(path,  "w").close      
	end
end