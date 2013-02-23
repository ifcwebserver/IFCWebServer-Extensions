class IFCAXIS2PLACEMENT2D
  def xy
    @location.toIfcObject
    obj= $ifcObjects[@location.delete("#").to_i]
    if @refDirection.include?("#")
      @refDirection.toIfcObject
      obj_dir=$ifcObjects[@refDirection.delete("#").to_i]
      if obj_dir.dir1 == 1 and obj_dir.dir2 == 0
        return obj.x , obj.y
      else
        #TODO
        #puts "<br> x,y values maybe not correct, the RefDirection is not taken in account yet for IFCAXIS2PLACEMENT2D, line:"  + __LINE__.to_s
        return obj.x , obj.y
      end  
    else      
      return obj.x , obj.y      
    end
  end
  
  def matrix
    if @refDirection.to_obj == nil
      [1,0,0,0,0,1,0,0,0,0,1,0,@x,@y,@z,1]
    else
      nv=@refDirection.to_obj.get_normal
     [nv[0],nv[1],0,0,nv[1],nv[0],0,0,0,0,1,0,@x,@y,0,1]
    end
  end
  
  def matrix2d
    if @refDirection.to_obj == nil and @axis.to_obj == nil
      [1,0,0,1,@x,@y]
    else
      nv=@refDirection.to_obj.get_normal
      [nv[0],nv[1], nv[1],nv[0],@x,@y]       
    end
  end
end