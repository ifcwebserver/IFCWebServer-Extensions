class IFCOWNERHISTORY
  def creationDate
    Time.at(@creationDate.to_i)
  end
end