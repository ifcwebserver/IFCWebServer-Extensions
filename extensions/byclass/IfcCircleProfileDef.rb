class IFCCIRCLEPROFILEDEF
	def area
		(Math::PI*@radius.to_f*@radius.to_f*$ifcUnit["Length"]*$ifcUnit["Length"]).to_f.round_to(3)
	end
	def perimeter
		(2*Math::PI*@radius.to_f*$ifcUnit["Length"]).to_s
	end
	def xyz_array
		@position.toIfcObject
		obj_pos= $ifcObjects[@position.delete("#").to_i]
		x,y=obj_pos.xy
		res=[]	
		n=16
		(n).times { |i|
		res << (@radius.to_f*(Math.cos(((Math::PI)/180)*((360/n)*i))) + x).to_s + " "
		res << (@radius.to_f*(Math.sin(((Math::PI)/180)*((360/n)*i))) + y).to_s + " "
		res << "z "
		}		
		return  res		
	end
	
	def xy_array
		@position.toIfcObject
		obj_pos= $ifcObjects[@position.delete("#").to_i]
		x,y=obj_pos.xy
		res=[]	
		n=16
		(n).times { |i|
		res << (@radius.to_f*(Math.cos(((Math::PI)/180)*((360/n)*i))) + x).to_s + " "
		res << (@radius.to_f*(Math.sin(((Math::PI)/180)*((360/n)*i))) + y).to_s + " "		
		}		
		return  res		
	end
	
	def to_svg
		SVG.to_svg(self)
	end
	
	def svg(scale=1,transformation="")
	    style = "  style=\"fill:gray;stroke:black;\" "
	    style=$svg_style if $svg_style != nil
        if transformation== ""
			transformation= " transform=\" scale(" + scale.to_s + "," + scale.to_s + ")\""
		end	
		res = "<g " + transformation + " >"
		res += "<circle cx=\"" +  (scale*@radius.to_f).to_s + "\" cy=\"" + (scale*@radius.to_f).to_s + "\" r=\"" + (scale*@radius.to_f).to_s + "\""
		res += " " + style + " /></g>"	
		return res
	end	
end