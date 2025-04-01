class IFCPROJECT
 def report
 res = "<table><tr><td>Name</td><td>#{@name}</td></tr>"
 res += "<tr><td>Long Name </td><td>#{@longName} </td></tr>"
 res += "<tr><td>Description</td><td>#{@description}</td></tr>"
 res += "<tr><td>Phase </td><td>#{@phase}</td></tr>"
 res += "</table>"
 res
 end
end