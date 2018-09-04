class IFCSCHEDULETIMECONTROL
    def detail
        res= {}
        res["ActualStart"] = self.actualStart	if self.actualStart != "$"
        res["EarlyStart"] =  self.earlyStart.to_obj.date_time if self.earlyStart != "$"
        res["LateStart"] = self.lateStart.to_obj.date_time if self.lateStart != "$"
        res["ScheduleStart"]  = self.scheduleStart.to_obj.date_time if self.scheduleStart != "$"
        res["ActualFinish"] = sef.actualFinish.to_obj.date_time if self.actualFinish != "$"
        res["EarlyFinish"] = self.earlyFinish.to_obj.date_time if self.earlyFinish != "$"
        res["LateFinish"] =self.lateFinish.to_obj.date_time if self.lateFinish != "$"
        res["ScheduleFinish"] =self.scheduleFinish.to_obj.date_time if self.scheduleFinish != "$"
        res["ScheduleDuration"] =self.scheduleDuration if self.scheduleDuration != "$"
        res["ActualDuration"] =self.actualDuration if self.actualDuration != "$"
        res["RemainingTime"] =self.remainingTime if self.remainingTime != "$"
        res["FreeFloat"] =self.freeFloat if self.freeFloat != "$"
        res["TotalFloat"] =self.totalFloat if self.totalFloat != "$"
        res["IsCritical"] =self.isCritical if self.isCritical != "$"
        res["StatusTime"] = self.statusTime if self.statusTime != "$"
        res["StartFloat"] = self.startFloat.to_s if self.startFloat != "$"
        res["FinishFloat"] =self.finishFloat.to_s if self.finishFloat != "$"
        res["Completion"] =self.completion.to_s if self.completion != "$"
        res
    end
end