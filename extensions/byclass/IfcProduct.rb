class IFCPRODUCT
attr_accessor :material
  def initialize1(args=[])		
    $depend_on={} if $depend_on == nil
	if @representation.to_s != "" and @representation.to_s != "$"      
	  $depend_on[@representation.to_s] ="" if $depend_on[@representation.to_s]== nil
	  $depend_on[@representation.to_s] += "#" + @line_id.to_s if not $depend_on[@representation.to_s].include?("#" + @line_id.to_s)	  
	end	
  end 
  
  def referencedBy
  	# :SET OF IfcRelAssignsToProduct FOR RelatingProduct; 
		res=[]
		IFCRELASSIGNSTOPRODUCT.where("(o.relatingProduct + ',').gsub(' ','').sub(')',',').include?'#" + @line_id.to_s + ",'","o.relatedObjects").to_a.join.toIfcObject.each { |k,v|
		res << v
		}
		res
  end
	def area
		@representation.toIfcObject
		o=$ifcObjects[@representation.delete("#").to_i]
		if o != nil and o.respond_to?("area")
			o.area.to_f
		else
			puts  __LINE__.to_s + "IFCPRODUCT.area:o is null" if $debug
		end
	end
	
	def to_dae(placement=nil,*args)	
		Dae.attribute_to_dae(@representation,@objectPlacement,self.class.to_s,@line_id.to_s)			
	end
	
	def volume
		@representation.toIfcObject
		o=$ifcObjects[@representation.delete("#").to_i]
		if o != nil and o.respond_to?("volume")
			o.volume.to_f
		else
			puts  __LINE__.to_s + "IFCPRODUCT.volume:o is null" if $debug
		end
	end
	
	def area_side
		o=$ifcObjects[@representation.delete("#").to_i]
		if o != nil and o.respond_to?("area_side")
			o.area_side.to_f
		else
			puts  __LINE__.to_s "IFCPRODUCT.area_side:o is null" if $debug
		end	
	end	
	
	def location
		if @objectPlacement.include?("#")		
			obj=$ifcObjects[@objectPlacement.delete("#").to_i]
			obj =@objectPlacement.to_s.toIfcObject
			if obj != nil
				obj.location if obj.respond_to?("location")
			else
				puts "objectPlacement=nil" +  @objectPlacement + " line:" +  __LINE__.to_s if $debug
			end
		end	
	end
end