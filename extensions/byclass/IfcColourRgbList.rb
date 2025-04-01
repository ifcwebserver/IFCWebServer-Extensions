class IFCCOLOURRGBLIST    	
  def to_html_div 
    arr=[]
    res=""
    @colourList.gsub("(","").gsub(")","").split(",").each { |v|
       arr << sprintf("%02x", v.to_f*255).upcase 
    }
    threes = (0..2).cycle
    arr=  arr.slice_when { threes.next == 2 }.to_a
    arr.each { |a|
    res += "<div class='color_rgb' style=\"background-color:" +  "#" + a.join + "\">&nbsp;" + a.join + "</div>"  
    }
    return res
   end
end
       

