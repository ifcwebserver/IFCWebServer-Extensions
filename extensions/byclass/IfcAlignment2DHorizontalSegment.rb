class IFCALIGNMENT2DHORIZONTALSEGMENT
  def to_svg
	res= ""
	self.curveGeometry.toIfcObject.each { |id,o|
	if o.class == IFCLINESEGMENT2D
	elsif o.class == IFCCIRCULARARCSEGMENT2D
	  startPoint = o.startPoint.to_obj	
	  endAngle= o.segmentLength.to_f * 360 / ( 2*3.141592653* o.radius.to_f)
	  start = polarToCartesian(startPoint.x.to_f, startPoint.y.to_f, o.radius.to_f, endAngle)
	  endpoint =   polarToCartesian(startPoint.x.to_f, startPoint.y.to_f, o.radius.to_f, 0)
      res += " M #{startPoint.x} #{startPoint.y}, A #{o.radius}, #{o.radius} 0 #{o.startDirection} 0 #{endpoint[0]}, #{endpoint[1]}"
	end
	}
	res
	end
	
  def polarToCartesian(centerX, centerY, radius, angleInDegrees)
	angleInRadians = (angleInDegrees-90) * 3.141592653 / 180.0
	[centerX + (radius * Math.cos(angleInRadians)),centerY + (radius * Math.sin(angleInRadians))]
  end
end