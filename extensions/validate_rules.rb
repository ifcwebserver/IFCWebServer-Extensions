## Low level rules validations
## The rules will be loaded if the global variable $rules_validation is set to be true
require 'date'
$div="<div style='background-color:rgb(255, 230, 230);padding: 16px ;width:75%' >"
class IFCACTORROLE
	def validate_rules
		#WR1 : (Role <> IfcRoleEnum.USERDEFINED) OR ((Role = IfcRoleEnum.USERDEFINED) AND  EXISTS(SELF.UserDefinedRole));
		if (@role != ".USERDEFINED." or (@role == ".USERDEFINED." and (@userDefinedRole != '$' and @userDefinedRole != '' ))) == false then
			puts $div
			puts self.class.to_s + "<br>"
			puts "The Rule:<br>WR1 : (Role <> IfcRoleEnum.USERDEFINED) OR ((Role = IfcRoleEnum.USERDEFINED) AND  EXISTS(SELF.UserDefinedRole));"
			puts "is broken\n"
			puts $hash["#" +@line_id.to_s]	
			puts "</div>"			
		end	
	end
end

class IFCADDRESS
#	WR1 : (NOT(EXISTS(Purpose))) OR
#            ((Purpose <> IfcAddressTypeEnum.USERDEFINED) OR
#            ((Purpose = IfcAddressTypeEnum.USERDEFINED) AND
#              EXISTS(SELF.UserDefinedPurpose)));
	def validate_rules
		if (@purpose!= "$" and @purpose!= "''") or (
			@purpose != ".USERDEFINED." or 
			(( @purpose == ".USERDEFINED." and (@userDefinedPurpose != "$" or @userDefinedPurpose != "''"))))
			puts $div
			puts self.class.to_s + "<br>"
			puts "The Rule:<br>
			 WR1 : (NOT(EXISTS(Purpose))) OR
            ((Purpose <> IfcAddressTypeEnum.USERDEFINED) OR
            ((Purpose = IfcAddressTypeEnum.USERDEFINED) AND
            EXISTS(SELF.UserDefinedPurpose)));<br>
		    is broken</br>"
			puts $hash["#" +@line_id.to_s]	
			puts "</div>"			
		end	
	end
end

class IFCPOSTALADDRESS
#	WR1 : EXISTS (InternalLocation) OR 
#            EXISTS (AddressLines) OR
#            EXISTS (PostalBox) OR
#            EXISTS (PostalCode) OR
#            EXISTS (Town) OR 
#            EXISTS (Region) OR  
#            EXISTS (Country);
	def validate_rules
		if (@internalLocation != "$" or @internalLocation != "''" 
			or  @addressLines != "$" or @addressLines != "''" 
			or @postalBox != "$" or @postalBox != "''"
			or  @postalCode != "$" or @postalCode != "''" 
			or  @town != "$" or @town != "''" 
			or  @region != "$" or @region != "''" 
			or  @country != "$" or @country != "''" )		
		else
		puts $div
		puts self.class.to_s + "<br>"
		puts "The Rule:<br>
		WR1 : EXISTS (InternalLocation) OR 
            EXISTS (AddressLines) OR
            EXISTS (PostalBox) OR
            EXISTS (PostalCode) OR
            EXISTS (Town) OR 
            EXISTS (Region) OR  
            EXISTS (Country);<br>
		is broken</br>"
		puts $hash["#" +@line_id.to_s]	
		puts "</div>"
		end		
	end
end

class IFCTELECOMADDRESS
#	WR1 : EXISTS (TelephoneNumbers) OR
#            EXISTS (PagerNumber) OR
#            EXISTS (FacsimileNumbers) OR 
#            EXISTS (ElectronicMailAddresses) OR 
#            EXISTS (WWWHomePageURL);
	def validate_rules
		if (@telephoneNumbers != "$" or @telephoneNumbers != "''" 
			or  @pagerNumber != "$" or @pagerNumber != "''" 
			or @facsimileNumbers != "$" or @facsimileNumbers != "''"
			or  @electronicMailAddresses != "$" or @electronicMailAddresses != "''" 
			or  @wWWHomePageURL != "$" or @wWWHomePageURL != "''" )
		else
		puts $div
		puts self.class.to_s + "<br>"
		puts "The Rule:<br>
		WR1 : EXISTS (TelephoneNumbers) OR
            EXISTS (PagerNumber) OR
            EXISTS (FacsimileNumbers) OR 
            EXISTS (ElectronicMailAddresses) OR 
            EXISTS (WWWHomePageURL);<br>
		is broken</br>"
		puts $hash["#" +@line_id.to_s]	
		puts "</div>"
		end
	end
end

class IFCAPPLIEDVALUE
#	WR1 : EXISTS (AppliedValue) OR 
#            EXISTS (ValueOfComponents);
	def validate_rules
		if (@appliedValue != "$" or @appliedValue != "''" 
			or  @valueOfComponents != "$" or @valueOfComponents != "''" )
		else
		puts $div
		puts self.class.to_s + "<br>"
		puts "The Rule:<br>
		WR1 : EXISTS (AppliedValue) OR 
        EXISTS (ValueOfComponents);<br>
		is broken</br>"
		puts $hash["#" +@line_id.to_s]	
		puts "</div>"
		end
	end
end

class IFCENVIRONMENTALIMPACTVALUE
#	WR1 : (Category <> IfcEnvironmentalImpactCategoryEnum.USERDEFINED) OR
#            ((Category = IfcEnvironmentalImpactCategoryEnum.USERDEFINED) AND EXISTS(SELF\IfcEnvironmentalImpactValue.UserDefinedCategory));
	def validate_rules
		if ( )
		else
		puts $div
		puts self.class.to_s + "<br>"
		puts "The Rule:<br>
		<br>
		is broken</br>"
		puts $hash["#" +@line_id.to_s]	
		puts "</div>"
		end
	end
end

class IFCCALENDARDATE
	def validate_rules		
	    begin			
			Date.new(@yearComponent, @monthComponent, @dayComponent)
		rescue 
			$log["#" +@line_id.to_s ]=  "<div style='background-color:rgb(255, 230, 230);padding: 16px ;width:50%' >" + self.class.to_s + "<br>The Rule:<br>WR21 : IfcValidCalendarDate (SELF);\nis broken\n" + $hash["#" +@line_id.to_s] +"</div>"
		end	
	end	
end
#IfcRelation classes
class IFCRELNESTS
	def validate_rules
		#NoSelfReference WR1 : SIZEOF(QUERY(Temp <* SELF\IfcRelDecomposes.RelatedObjects | NOT(TYPEOF(SELF\IfcRelDecomposes.RelatingObject) = TYPEOF(Temp)))) = 0;
		if @relatedObjects.to_s.include?(@relatingObject.to_s) and @relatedObjects != nil			
			puts 
			puts $div
			puts self.class.to_s + "<br>"
			puts "The Rule:<b>NoSelfReference</b><br> WR1 : SIZEOF(QUERY(Temp <* SELF\IfcRelDecomposes.RelatedObjects | NOT(TYPEOF(SELF\IfcRelDecomposes.RelatingObject) = TYPEOF(Temp)))) = 0;"
			puts "</br>is broken</br>"
			puts $hash["#" +@line_id.to_s]	
			puts "</br>The object:<b>" + @relatingObject.to_s + "</b> can not be nested to itself"
			puts "</div>"
		end
	end
end

class IFCPERSON	
	def validate_rules
		#	WR1 : EXISTS(FamilyName) OR   EXISTS(GivenName);		
		if (@familyName== "$" or @familyName== "''")  and (@givenName== "$" or @givenName== "''")
			puts $div
			puts self.class.to_s + "<br>"
			puts "The Rule:<br>WR1 : EXISTS(FamilyName) OR   EXISTS(GivenName);"
			puts "is broken</br>"
			puts $hash["#" +@line_id.to_s]	
			puts "</div>"			
		end	
	end
end

class IFCZONE
	def validate_rules
		#IFC2x3
		#WR1 : 	SIZEOF (QUERY (temp <* SELF\IfcGroup.IsGroupedBy.RelatedObjects | NOT(('IFCPRODUCTEXTENSION.IFCZONE' IN TYPEOF(temp)) OR ('IFCPRODUCTEXTENSION.IFCSPACE' IN TYPEOF(temp))) )) = 0;
		#IFC2x4
		#WR1 : 	(SIZEOF(SELF\IfcGroup.IsGroupedBy) = 0) OR (SIZEOF (QUERY (temp <* SELF\IfcGroup.IsGroupedBy[1].RelatedObjects | NOT(('IFC2X4_ALPHA.IFCZONE' IN TYPEOF(temp)) OR ('IFC2X4_ALPHA.IFCSPACE' IN TYPEOF(temp)) OR ('IFC2X4_ALPHA.IFCSPATIALZONE' IN TYPEOF(temp)) ))) = 0);
		# A Zone is grouped by the objectified relationship IfcRelAssignsToGroup. Only objects of type IfcSpace or IfcZone are allowed as RelatedObjects.
		if @isGroupedBy != nil 
			isGroupedByObj=$ifcObjects[@isGroupedBy].relatedObjects.split("#").each { |relObj_ID|
			if $ifcObjects[relObj_ID].class.to_s == "IFCSPACE" or $ifcObjects[relObj_ID].class.to_s == "IFCZONE" then
			else
				puts $div
				puts self.class.to_s + "<br>"
				puts "The Rule:<br>WR1 : A Zone is grouped by the objectified relationship IfcRelAssignsToGroup. Only objects of type IfcSpace or IfcZone are allowed as RelatedObjects."
				puts "</br>is broken</br>"
				puts $hash["#" +@line_id.to_s]	
				puts "#" + relObj_ID.to_s + " class =" + $ifcObjects[relObj_ID].class.to_s
				puts "</div>"
			end;
			}					
		end	
	end
end