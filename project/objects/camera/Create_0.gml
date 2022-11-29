focus = -1
focuses = ds_list_create()

function _createFocus(_unit = -1, _x = -1, _y = -1, _duration = -1, _movespeed = 1) constructor {
	unit = _unit
	x = _x
	y = _y
	duration = _duration
	movespeed = _movespeed
}

function createFocus(_unit = -1, _x = -1, _y = -1, _duration = -1, _movespeed = 1) {
	var Focus = new _createFocus(_unit, _x, _y, _duration, _movespeed)
	ds_list_add(focuses, Focus)
}
	
function createOriginalFocus(_movespeed = 1) {
	if (typeof(focus) == "struct") var Focus = focus
	else {
		var Focus = new _createFocus(-1, x, y, -1, _movespeed)
	}
	ds_list_add(focuses, Focus)
}

function cameraSetup() {

		width = 640
		height = 360
		zoom_level = 1
		
		var fullscreen = false
		//var windowWidth = window_get_width()
		var windowHeight = window_get_height()
		//var displayWidth = display_get_width()
		var displayHeight = display_get_height()
		if window_get_width() == display_get_width() and (abs(windowHeight - displayHeight) < 100) {
			fullscreen = true
		}

		#region Views

			view_enabled = true
			view_visible[0] = true

			view_set_visible(0,true)

			view_set_wport(0,width)
			view_set_hport(0,height)

		#endregion
		#region Resize and Center Game Window

			window_set_rectangle((display_get_width()-view_wport[0])*0.5,(display_get_height()-view_hport[0])*0.5,view_wport[0],view_hport[0])
	
			surface_resize(application_surface,view_wport[0],view_hport[0])
	
			display_set_gui_size(width,height)


		#endregion
		#region Camera Create

			lens = camera_create()

			var viewmat = matrix_build_lookat(width,height,-10,width,height,0,0,1,0)
			var projmat = matrix_build_projection_ortho(width,height,1.0,32000.0)

			camera_set_view_mat(lens,viewmat)
			camera_set_proj_mat(lens,projmat)
	
			camera_set_view_pos(lens,x,y)
			camera_set_view_size(lens,width,height)
	
			camera_set_view_speed(lens,200,200)
			camera_set_view_border(lens,width,height)
	
			camera_set_view_target(lens,id)

			view_camera[0] = lens

		#endregion
	
		//if !fullscreen scale_canvas(1920,1080)

		default_zoom_width = camera_get_view_width(lens)
		default_zoom_height = camera_get_view_height(lens)

}
	
function cameraFix() {
	#region Views

		view_enabled = true
		view_visible[0] = true

		view_set_visible(0,true)

		view_set_wport(0,width)
		view_set_hport(0,height)

	#endregion
	#region Camera Create

		lens = camera_create()

		var viewmat = matrix_build_lookat(width,height,-10,width,height,0,0,1,0)
		var projmat = matrix_build_projection_ortho(width,height,1.0,32000.0)

		camera_set_view_mat(lens,viewmat)
		camera_set_proj_mat(lens,projmat)
	
		camera_set_view_pos(lens,x,y)
		camera_set_view_size(lens,width,height)
	
		camera_set_view_speed(lens,200,200)
		camera_set_view_border(lens,width,height)
	
		camera_set_view_target(lens,id)

		view_camera[0] = lens

	#endregion
}
	
function cameraLogic() {
	
	if (debug.on) {
		zoom_level = clamp((zoom_level + (mouse_wheel_down()-mouse_wheel_up())*0.1),0.25,1.0)
	}
	
	//	We have a camera focus!
	if (typeof(focus) == "struct") {
		if (focus.unit > -1 and instance_exists(focus.unit)) {
			focus.x = focus.unit.x
			focus.y = focus.unit.y
		}
		x = lerp(x, focus.x, focus.movespeed)
		y = lerp(y, focus.y, focus.movespeed)
		
		if (focus.duration > -1) {
			if time.seconds_switch focus.duration--
			
			if (focus.duration) <= 0 {
				focus = -1
			}
		}
	}
	//	Let's check if we have any camera focuses queued up
	else {
		if !ds_list_empty(focuses) {
			debug.log("we have a new camera focus!")
			focus = focuses[| 0]
			ds_list_delete(focuses, 0)
		}
	}

	camera_set_view_pos(lens,
			clamp( camera_get_view_x(lens), 0, room_width - camera_get_view_width(lens) ),
			clamp( camera_get_view_y(lens), 0, room_height - camera_get_view_height(lens) ));

	var view_w = camera_get_view_width(lens)
	var view_h = camera_get_view_height(lens)

	var rate = 0.2

	var new_w = round(lerp(view_w, zoom_level *  default_zoom_width, rate))
	var new_h = round(lerp(view_h, zoom_level * default_zoom_height, rate))
			
	if new_w & 1 {
		new_w++	
	}
	if new_h & 1 {
		new_h++	
	}

	camera_set_view_size(lens, new_w, new_h)
 
	//	Realignment
	var shift_x = camera_get_view_x(lens) - (new_w - view_w) * 0.5
	var shift_y = camera_get_view_y(lens) - (new_h - view_h) * 0.5

	camera_set_view_pos(lens,round(shift_x), round(shift_y))

	////	Clamp app x,y within room
	var edgeX = camera_get_view_width(lens)/2
	var edgeY = camera_get_view_height(lens)/2
	x = clamp(x,0+edgeX,room_width-edgeX)
	y = clamp(y,0+edgeY,room_height-edgeY)	
}
	
cameraSetup()