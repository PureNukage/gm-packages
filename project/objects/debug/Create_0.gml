on = false

function log(String) {
	
	var Time = "[" + string(time.stream) + "] "
	
	//	This accounts for if a script is calling debug.log
	if (other == undefined) or (other.object_index == undefined) {
		var Object = "SCRIPT"
	}
	else {
		var Object = string_upper(object_get_name(other.object_index))
	}
	
	var fullMessage = Time + Object + " " + string(String)
	
	show_debug_message(fullMessage)
}