class IFCTOPOLOGYREPRESENTATION  
  def to_dae(objectPlacement=nil,*args)
		@items_list = @items.delete("(").delete(")").gsub("#","")
		@items_list.toIfcObject.each { |k,o|			
		if o.respond_to?('to_dae')
			Dae.to_dae(o,objectPlacement)			
		else
			$log["<br>#{ __LINE__ } Line:#{ __LINE__}"]= "IFCTOPOLOGYREPRESENTATION:to_dae  "  + " class:" +  o.class.to_s + " to_dae is not yet supported"					
		end
		}
	end
	
  def to_dae_geometry(mesh_id="")	
    end
  
  def to_dae_node(ifclocalplacemenet=nil)
	Dae.to_dae_node(self)  
  end 
	
end

