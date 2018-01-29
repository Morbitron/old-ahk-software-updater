MergeStr(vars){
	final_string := ""
	for key, current_string in vars
	{
		final_string .= current_string
	}
		return final_string
}

IsValueInArray(value_var, array_var, is_recursive=""){
	value_is_in_array := 0
	
	if(value_var == null)
		return value_is_in_array
	
	if(!IsObject(value_var))
		value_var := Array(value_var)
	
	for incoming_array_key, incoming_array_value in value_var
	{
		for array_key, array_value in array_var
		{
			/*
			if(RegExMatch(array_value, incoming_array_value))
			{
				value_is_in_array := 1
			}
			else if(IsObject(array_value) && is_recursive == 1)
			{
				if(IsValueInArray(incoming_array_value, array_value, 1) == 1 || array_key == incoming_array_value)
					value_is_in_array := 1
			}
			*/
			if(IsObject(array_value))
			{
				if(is_recursive)
					value_is_in_array := IsValueInArray(incoming_array_value, array_value, is_recursive)
			}
			Else if(StrLen(array_value) > 0)
			{
				if(RegExMatch(array_value, incoming_array_value))
					value_is_in_array := 1
			}
			Else if(array_value == incoming_array_value)
			{
				value_is_in_array := 1
			}
			
			
		}
	}
	return value_is_in_array
}

IsValueNotInArray(value_var, array_var, is_recursive=""){
	return IsValueInArray(value_var, array_var, is_recursive) == 0
}

AddArrayAt(add_array_var, out_array_var, values_must_be_unique="", is_recursive=""){
	result_array_var := Array()
	
	if(values_must_be_unique == "")
		values_must_be_unique := false
		
	if(is_recursive == "")
		is_recursive := false
	
	
	if(!IsObject(add_array_var))
		add_array_var := Array(add_array_var)
	
	
	;if(values_must_be_unique && is_recursive)
	
	for array_key, array_value in add_array_var
	{
		if(IsObject(array_value))
		{
			if(out_array_var[array_key] == null)
				out_array_var[array_key] := array_value
			Else
			{
				if(values_must_be_unique)
				{
					if(IsValueNotInArray(array_value, out_array_var, is_recursive))
						out_array_var[array_key] := AddArrayAt(array_value, out_array_var[array_key], values_must_be_unique, is_recursive)
				}
				Else
					out_array_var[array_key] := AddArrayAt(array_value, out_array_var[array_key], values_must_be_unique, is_recursive)
			}
		}
		Else
		{
			if(values_must_be_unique)
			{
				if(IsValueNotInArray(array_value, out_array_var, is_recursive))
					out_array_var.push(array_value)
			}
			Else
			{
				out_array_var.push(array_value)
			}
		}
	}
	return out_array_var
}

;if(IsValueNotInArray(out_array_var, array_value, is_recursive) == true)



;To Object
RegExArrayMatchOnce(Haystack, NeedleRegEx , UnquotedOutputVar="", StartingPosition=1){
	regexIsMatching := false
	
	for array_key, array_value in NeedleRegEx
		if(RegExMatch(Haystack, array_value , UnquotedOutputVar, StartingPosition))
			regexIsMatching := true
	
	return regexIsMatching
}


RegExArrayMatchNone(Haystack, NeedleRegEx , UnquotedOutputVar="", StartingPosition=1){
	if(RegExArrayMatchOnce(Haystack, NeedleRegEx , UnquotedOutputVar, StartingPosition))
		regexIsMatching := false
	Else
		regexIsMatching := true
	
	return regexIsMatching
}


RegExArrayMatchAll(Haystack, NeedleRegEx , UnquotedOutputVar="", StartingPosition=1){
	regexIsMatching := true
	
	for array_key, array_value in NeedleRegEx
		if(RegExMatch(Haystack, array_value , UnquotedOutputVar, StartingPosition) == false)
			regexIsMatching := false
	
	return regexIsMatching
}



;Create GUID
CreateGUID(){
	TypeLib := ComObjCreate("Scriptlet.TypeLib")
	return TypeLib.Guid
}



URLToVar(url){
	hObject:=ComObjCreate("WinHttp.WinHttpRequest.5.1") ;Create the Object
	hObject.Open("GET",URL) ;Open communication
	hObject.Send() ;Send the "get" request
	text_output := hObject.ResponseText ;Set the "text" variable to the response
	ObjRelease(hObject)
	return text_output
}
