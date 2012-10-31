class IFCGRIDAXIS
	def to_dae
		@axisCurve.toIfcObject 
		$ifcObjects[@axisCurve.delete("#").to_i].to_dae
	end
	
	def to_svg
		@axisCurve.toIfcObject 
		$ifcObjects[@axisCurve.delete("#").to_i].to_svg
	end
end