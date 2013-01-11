class IFCEDGE
  def length
    start_point=@edgeStart.to_obj.vertexGeometry.to_obj
    end_point=@edgeEnd.to_obj.vertexGeometry.to_obj
    Math.sqrt((start_point.x-end_point.x)**2+(start_point.y-end_point.y)**2+(start_point.z-end_point.z)**2)
  end
  
  def to_dae
    Dae.to_dae(self)
  end
  
  def to_dae_geometry(mesh_id="")	
    $edge_size = 0.1 if $edge_size == nil
	Dae.line_geometry(self,@edgeStart.to_obj.vertexGeometry.to_obj,@edgeEnd.to_obj.vertexGeometry.to_obj,$edge_size,$edge_size,$edge_size)
  end
  
  def to_dae_node(ifclocalplacemenet=nil)
	Dae.to_dae_node(self)  
  end 
  
  def to_xml( o=self)
	start_point=o.edgeStart.to_obj.vertexGeometry.to_obj
    end_point=o.edgeEnd.to_obj.vertexGeometry.to_obj
	res= "<IfcEdge id=\"ID" + o.line_id.to_s  + "\" "
	res += " edgeStart=\"" + start_point.x.to_s + " " + start_point.y.to_s + " " + start_point.z.to_s  + "\" "
	res += " edgeEnd=\"" + end_point.x.to_s + " " + end_point.y.to_s + " " + end_point.z.to_s  + "\" "
	res += " length=\"" + o.length.to_s  + "\" />"
	res
  end  
end