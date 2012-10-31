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
	
	def svg(scale=1)
		#scale=100 if @xDim.to_f < 1 or @yDim.to_f < 1		
		res = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\""
		res += " width=\"" +  (1.1*scale*@xDim.to_f).to_s + "\" height=\"" + (1.1*scale*@yDim.to_f).to_s + "\" >"
		res += "<rect width=\"" + (scale*@xDim.to_f).to_s + "\" height=\"" + (scale*@yDim.to_f).to_s + "\" style=\"fill:gray;stroke-width:0.01;stroke:rgb(255,0,0)\"/>\n</svg>"
		res += "<font size=\"1\">"
		res += "</br>scale=" + scale.to_f.to_s if scale != 1
		res += "</br>xDim=" + @xDim.to_f.to_s + "</br>yDim=" + @yDim.to_f.to_s + "</font>"	
		return res
	end	
end