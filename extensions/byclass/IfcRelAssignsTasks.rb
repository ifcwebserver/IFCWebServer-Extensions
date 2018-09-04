class IFCRELASSIGNSTASKS
    def saveTimeForTask     
		   $timeForTask={} if $timeForTask == nil
           self.relatedObjects.toIfcObject.each { |o,id|
           $timeForTask[o] = self.timeForTask.to_obj.detail
          }
       
    end
end 
