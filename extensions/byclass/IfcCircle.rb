class IFCCIRCLE 
	def area
		(Math::PI*@radius.to_f*@radius.to_f*$ifcUnit["Length"]*$ifcUnit["Length"]).to_f.round_to(3)
    end
    
	def perimeter
		(2*Math::PI*@radius.to_f*$ifcUnit["Length"]).to_s
    end
	
	def xyz_array
		@position.toIfcObject
		obj_pos= $ifcObjects[@position.delete("#").to_i]
		if obj_pos.class.to_s == "IFCAXIS2PLACEMENT3D"
			x,y,z=obj_pos.xyz
		else
			x,y=obj_pos.xy
			z = "z"
		end
		res=[]	
		n=16
		(n).times { |i|
		res << (@radius.to_f*(Math.cos((Math::PI/180)*((360/n)*i))) + x).to_s + " "
		res << (@radius.to_f*(Math.sin((Math::PI/180)*((360/n)*i))) + y).to_s + " "
		res <<  z.to_s + " "
		}		
		return  res		
	end
	
	def to_svg
		SVG.to_svg(self)
	end
	
	def svg(scale=1)
		#scale=100 if @radius.to_f < 1
		res = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\""
		res += " width=\"" +  (2.1*scale*@radius.to_f).to_s + "\" height=\"" + (2.1*scale*@radius.to_f).to_s + "\" >"
		#res += "<g transform=\" scale(" + scale.to_s + "," + scale.to_s + ")\">"
		res += "<circle cx=\"" +  (scale*@radius.to_f).to_s + "\" cy=\"" + (scale*@radius.to_f).to_s + "\" r=\"" + (scale*@radius.to_f).to_s + "\""
		res += " style=\"fill:gray;stroke:black;\" /></svg>"
		res += "<font size=\"1\">"
		res += "</br>scale=" + scale.to_f.to_s  if scale != 1
		res += "</br>R=" + @radius.to_f.to_s + "</font>"	
		return res
	end
end