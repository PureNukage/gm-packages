creator = ""
version = ""

var Layer = "Instances"
instance_create_layer(0,0,Layer,camera)
instance_create_layer(0,0,Layer,input)
instance_create_layer(0,0,Layer,debug)
instance_create_layer(0,0,Layer,time)
instance_create_layer(0,0,Layer,sound)

if room == RoomAppIntro {
	room_goto_next()
}