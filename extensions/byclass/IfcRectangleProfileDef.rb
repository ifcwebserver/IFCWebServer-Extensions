class IFCRECTANGLEPROFILEDEF
	def area
		(@xDim.to_f * @yDim.to_f*$ifcUnit["Length"]*$ifcUnit["Length"]).to_f.round_to(3)
	end
	
	def xyz_array
		@position.toIfcObject
		obj_pos= $ifcObjects[@position.delete("#").to_i]
		x,y=obj_pos.xy
		res=[]	
		res << (0 + x).to_s + " "
		res << (0 + y).to_s + " " 
		res << "z "
		res << (@xDim.to_f + x).to_s + " "
		res << (0 + y).to_s + " " 
		res << "z "
		res << (@xDim.to_f + x).to_s + " "
		res << (@yDim.to_f + y).to_s + " " 
		res << "z "
		res << (0 + x).to_s + " "
		res << (@yDim.to_f + y).to_s + " " 
		res << "z "
		return  res		
	end
	
	def perimeter
		(2*(@xDim.to_f + @yDim.to_f)*$ifcUnit["Length"]).to_s
	end
	
	def	to_svg
		SVG.to_svg(self)		
	end
	
	def svg(scale=1,transformation="")	
	  style = " style=\"fill:gray;stroke-width:0.01;stroke:rgb(255,0,0)\" "
	  style=$svg_style if $svg_style != nil
	  if transformation == ""
	    transformation= " transform=\" scale(" + scale.to_s + "," + scale.to_s + ")\""
	  end
	  res = "<g " + transformation + " >"				  
	  res += "<rect width=\"" + (@xDim.to_f).to_s + "\" height=\"" + (@yDim.to_f).to_s + "\" " + style + " /></g>"				
	  return res
	end	
end