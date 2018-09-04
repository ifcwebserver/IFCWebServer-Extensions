xx = <<-eos
class API
def getObjectByLineID(id)
#doc:<div class='documentaion' >Return an IFC object by its STEP ID </div>
end

def IFC_CLASS_NAME.nonInverseAttributes
#doc:<div class='documentaion' >Return a list of IFC class basic attributes<br>
#doc:<b> IFCCOLUMN.nonInverseAttributes</b>: -->>><br>"|globalId |ownerHistory |name |description |objectType |objectPlacement |representation |tag"</div>
end

def IFCObject.to_xml (obj)
#doc:<div class='documentaion' >Serialize any IFC object as XML 
#doc:<br><u> Example:</u><b> "#61185".to_obj.to_xml</b> -->>><br>
#doc:&lt;IFCCOLUMN&gt;
#doc:&lt;line_id&gt;61185&lt;/line_id&gt;
#doc:&lt;globalId&gt;'0APvzagRfDa8S2CxmCLJFH'&lt;/globalId&gt;
#doc:&lt;ownerHistory&gt;#13&lt;/ownerHistory&gt;
#doc:&lt;name&gt;'St\S\|tze-001'&lt;/name&gt;
#doc:&lt;description&gt;''&lt;/description&gt;
#doc:&lt;objectType&gt;$&lt;/objectType&gt;
#doc:&lt;objectPlacement&gt;#61239&lt;/objectPlacement&gt;
#doc:&lt;representation&gt;#61228&lt;/representation&gt;
#doc:&lt;tag&gt;$&lt;/tag&gt;
#doc:&lt;/IFCCOLUMN&gt;
#doc:</div>
end

def IFCObject.to_csv(obj)
#doc:<div class='documentaion' >Serialize any IFC object as Comma-Separated Values (CSV) </div>	
end

def IFCObject.to_html (obj)
#doc:<div class='documentaion' >Serialize any IFC object as row in HTML table</div>	
end

def IFC_CLASS_NAME.list(cols="")
#doc:<div class='documentaion' >Return a list of all IFC class instances, the parameter 'cols' can be used to define a set of custom data fields to be reported </div>
end

def IFCObject.as_link
#doc:<div class='documentaion' >Return HTML hyperlink to any IFC object instance </div>
end

def IFC_CLASS_NAME.where (cond,output)
#doc:<div class='documentaion' >Return a hash of user defined output applied on IFCCLASS object's instances which meet the 'cond' expression, 'all' or true can be used to retrive all instances, 'cond' can be any valid Ruby expression applied on each object instance, the 'o' is used as place holder for object instances <br><b>IFCWINDOW.where("all","o.area > 2.00")</b> </div>
end
end
eos