class IFCPRODUCTDEFINITIONSHAPE
  def initialize1(args=[])		
    $depend_on={} if $depend_on == nil
    @representations.sub("(","").sub(")","").split(",").each { |id|
      $depend_on[id] ="" if $depend_on[id]== nil
      $depend_on[id] += "#" + @line_id.to_s
    }
  end 
  
  def to_dae(objectPlacement=nil,*args)
     #Dae.attribute_to_dae(@representations,objectPlacement)
    Dae.to_dae(self,objectPlacement)		
  end

  def to_dae_geometry(mesh_id="")
    Dae.to_dae_geometry(@representations,mesh_id)		
  end	

  def to_dae_node(local=nil)
    @representations.to_s.toIfcObject.each { |k,v|
    Dae.to_dae_node(v,local,"",v.class.to_s + "_" + v.line_id.to_s)
    }
  end	

  def volume
    volume= 0
    @representations.to_s.toIfcObject.each { |k,v|
      volume = v.volume.to_f if v.respond_to?('volume')  
    }
    volume	
  end	
end