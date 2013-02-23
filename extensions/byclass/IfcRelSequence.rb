class IFCRELSEQUENCE
  def count()
	@relatedProcess.to_s.split("#").size-1
  end
  
  def add(instance_id)
    @relatedProcess += "," + "#" + instance_id.to_s
  end
  
  def count_by_class
    classes={}
	@relatedProcess.toIfcObject.each { |k,o|
	classes[o.class.to_s] == nil ? classes[o.class.to_s] = 1 :classes[o.class.to_s] += 1}
	classes
  end 
end