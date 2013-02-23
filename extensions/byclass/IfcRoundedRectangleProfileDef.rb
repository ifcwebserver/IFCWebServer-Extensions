class IFCROUNDEDRECTANGLEPROFILEDEF
  def area
    rr=@roundingRadius.to_f
    ((Math::PI*rr*rr+(@xDim-2*rr)*@yDim+(@yDim-2*rr)*2*rr)*$ifcUnit["Length"]*$ifcUnit["Length"]).to_f.round_to(3)
  end

  def perimeter
    ((Math::PI*@roundingRadius.to_f + 2*(@xDim.to_f - 2*@roundingRadius.to_f) + 2*(@yDim.to_f - 2*@roundingRadius.to_f))*$ifcUnit["Length"]).to_s
  end
end