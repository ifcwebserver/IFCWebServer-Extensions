class IFCSTYLEDITEM
  def initialize1(args=[])		
    $depend_on={} if $depend_on == nil
    $depend_on[@item.to_s] ="" if $depend_on[@item.to_s]== nil
    $depend_on[@item.to_s] += "#" + @line_id.to_s #+ "," + @styles.to_s.sub("(","").sub(")","")
	$styles={} if $styles == nil
	$styles[@item.to_s]= "#" + @line_id.to_s
  end
end