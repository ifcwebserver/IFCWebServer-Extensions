class IFCVERTEXPOINT
  def to_dae
    Dae.to_dae(self)
  end
  
  def to_dae_geometry(mesh_id="")
	$vertex_size = 0.4 if $vertex_size == nil
	Dae.box_geometry(self,$vertex_size,$vertex_size,$vertex_size,self.vertexGeometry.to_obj.line_id)  
  end
  
  def to_dae_node(ifclocalplacemenet=nil)
	Dae.to_dae_node(self)  
  end
end