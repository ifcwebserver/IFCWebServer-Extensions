class IFCDIMENSIONALEXPONENTS
	def unitExponent
		res = ""
		res += "(Length)^" + @lengthExponent.to_s   									if @lengthExponent.to_s.to_f != 0
		res += "(Mass)^" + @massExponent.to_s 											if @massExponent.to_s.to_f	!= 0
		res += "(Time)^" + @timeExponent.to_s 	   										if @timeExponent.to_s.to_f	 != 0
		res += "(ElectricCurrent)^" +  @electricCurrentExponent.to_s					if @electricCurrentExponent.to_s.to_f	!= 0
		res += "(ThermodynamicTemperature)^" + @thermodynamicTemperatureExponent.to_s   if @thermodynamicTemperatureExponent.to_s.to_f != 0
		res += "(AmountOfSubstance)^"  + @amountOfSubstanceExponent.to_s	 			if @amountOfSubstanceExponent.to_s.to_f	!= 0
		res += "(LuminousIntensity)^" +  @luminousIntensityExponent.to_s  				if @luminousIntensityExponent.to_s.to_f	!= 0.0
		return res
	end
end