class IFCSURFACESTYLERENDERING
  def surfaceColour_html
    @surfaceColour.to_obj.to_html_div if @surfaceColour.to_obj != nil and @surfaceColour.to_obj.respond_to?('to_html_div')
  end
end