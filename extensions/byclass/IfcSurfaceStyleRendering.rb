class IFCSURFACESTYLERENDERING
  def surfaceColour_html
    @surfaceColour.to_obj.to_html_div if @surfaceColour.to_obj != nil and @surfaceColour.to_obj.respond_to?('to_html_div')
  end
  
  def effect
      "\n<effect id=\"EFFECTNAME\">
      <profile_COMMON>
        <technique sid=\"common\">
          <phong>
            <emission>
              <color sid=\"emission\">0 0 0 1</color>
            </emission>
            <ambient>
              <color sid=\"ambient\">0 0 0 1</color>
            </ambient>
            <diffuse>
              <color sid=\"diffuse\">DIFF 1</color>
            </diffuse>
            <specular>
              <color sid=\"specular\">0 0 0.55555 1</color>
            </specular>
            <shininess>
              <float sid=\"shininess\">50</float>
            </shininess>
            <transparency>
              <float sid=\"transparency\">TRANS</float>
            </transparency>
            <index_of_refraction>
              <float sid=\"index_of_refraction\">1</float>
            </index_of_refraction>
          </phong>
        </technique>
        <extra>
          <technique profile=\"GOOGLEEARTH\">
            <double_sided>1</double_sided>
          </technique>
        </extra>
      </profile_COMMON>
      <extra><technique profile=\"MAX3D\"><double_sided>1</double_sided></technique></extra>
    </effect>".sub("EFFECTNAME","effect-" + @line_id.to_s).sub("TRANS",@transparency.to_f.to_s).sub("DIFF",@surfaceColour.to_obj.to_RGB.gsub(","," "))
  end
  
  def material
    "\n<material id=\"MATNAME\" name=\"MATID\">
      <instance_effect url=\"#effect-LINEID\"/>
    </material>".gsub("LINEID",@line_id.to_s)
  end
end