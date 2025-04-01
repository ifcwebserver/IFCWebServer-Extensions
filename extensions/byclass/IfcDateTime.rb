class IFCDATEANDTIME
    def date_time
        dateComponent= self.dateComponent.to_obj
        timeComponent = self.timeComponent.to_obj
		dateComponent.monthComponent = '0' + dateComponent.monthComponent.to_s if dateComponent.monthComponent.to_s.size == 1
		dateComponent.dayComponent = '0' + dateComponent.dayComponent.to_s if dateComponent.dayComponent.to_s.size == 1
		timeComponent.minuteComponent = '0' + timeComponent.minuteComponent.to_s if timeComponent.minuteComponent.to_s.size == 1
		timeComponent.hourComponent = '0' + timeComponent.hourComponent.to_s if timeComponent.hourComponent.to_s.size == 1		
        "#{dateComponent.yearComponent}-#{dateComponent.monthComponent}-#{dateComponent.dayComponent} #{timeComponent.hourComponent}:#{timeComponent.minuteComponent}"
    end

    def attach_to_obj(obj)
	#doc:<div class='documentaion' > This method links the name of the material object to the associated objects through the relation IfcRelAssociatesMaterial as a new attribute .</br> The new attribute to be used in reports or filters called:<ul><li><i>ext_material_name</i></li></ul></div>
		obj.instance_variable_set("@ext_date_time", date_time  )
    end
end