class IFCCARTESIANPOINTLIST
  def size
    @coordList.gsub(" ","").split("),").size
  end
  
  def coordArray
    @coordList.gsub(" ","").gsub("(","").sub("))","").split("),")
  end
end