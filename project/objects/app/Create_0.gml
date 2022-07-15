creator = ""
version = ""

var Layer = "Instances"
instance_create_layer(0,0,Layer,input)
instance_create_layer(0,0,Layer,debug)
instance_create_layer(0,0,Layer,time)
instance_create_layer(0,0,Layer,sound)

function scale_canvas(new_width, new_height) {
	window_set_size(new_width, new_height)
	
	//if center {
	//	centerWindow = true
	//}
	
	//surface_resize(application_surface,new_width,new_height)
}
	
function cameraSetup() {
	#region Camera

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

			camera = camera_create()

			var viewmat = matrix_build_lookat(width,height,-10,width,height,0,0,1,0)
			var projmat = matrix_build_projection_ortho(width,height,1.0,32000.0)

			camera_set_view_mat(camera,viewmat)
			camera_set_proj_mat(camera,projmat)
	
			camera_set_view_pos(camera,x,y)
			camera_set_view_size(camera,width,height)
	
			camera_set_view_speed(camera,200,200)
			camera_set_view_border(camera,width,height)
	
			camera_set_view_target(camera,id)

			view_camera[0] = camera

		#endregion
	
		//if !fullscreen scale_canvas(1920,1080)

		default_zoom_width = camera_get_view_width(camera)
		default_zoom_height = camera_get_view_height(camera)

	#endregion	
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

		camera = camera_create()

		var viewmat = matrix_build_lookat(width,height,-10,width,height,0,0,1,0)
		var projmat = matrix_build_projection_ortho(width,height,1.0,32000.0)

		camera_set_view_mat(camera,viewmat)
		camera_set_proj_mat(camera,projmat)
	
		camera_set_view_pos(camera,x,y)
		camera_set_view_size(camera,width,height)
	
		camera_set_view_speed(camera,200,200)
		camera_set_view_border(camera,width,height)
	
		camera_set_view_target(camera,id)

		view_camera[0] = camera

	#endregion
}

function cameraLogic() {
	//zoom_level = clamp((zoom_level + (mouse_wheel_down()-mouse_wheel_up())*0.1),0.25,1.0)

	camera_set_view_pos(camera,
			clamp( camera_get_view_x(camera), 0, room_width - camera_get_view_width(camera) ),
			clamp( camera_get_view_y(camera), 0, room_height - camera_get_view_height(camera) ));

	var view_w = camera_get_view_width(camera)
	var view_h = camera_get_view_height(camera)

	var rate = 0.2

	var new_w = round(lerp(view_w, zoom_level *  default_zoom_width, rate))
	var new_h = round(lerp(view_h, zoom_level * default_zoom_height, rate))
			
	if new_w & 1 {
		new_w++	
	}
	if new_h & 1 {
		new_h++	
	}

	camera_set_view_size(camera, new_w, new_h)

	//	Realignment
	var shift_x = camera_get_view_x(camera) - (new_w - view_w) * 0.5
	var shift_y = camera_get_view_y(camera) - (new_h - view_h) * 0.5

	camera_set_view_pos(camera,shift_x, shift_y)


	////	Clamp app x,y within room
	var edgeX = camera_get_view_width(camera)/2
	var edgeY = camera_get_view_height(camera)/2
	x = clamp(x,0+edgeX,room_width-edgeX)
	y = clamp(y,0+edgeY,room_height-edgeY)	
}
	
cameraSetup()