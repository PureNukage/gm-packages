function keys() {
	mouseLeftPress = mouse_check_button_pressed(mb_left)
	mouseLeftRelease = mouse_check_button_released(mb_left)
	mouseLeft = mouse_check_button(mb_left)

	mouseRightPress = mouse_check_button_pressed(mb_right)
	mouseRightRelease = mouse_check_button_released(mb_right)
	mouseRight = mouse_check_button(mb_right)

	keyUp = keyboard_check(ord("W"))
	keyLeft = keyboard_check(ord("A"))
	keyDown = keyboard_check(ord("S"))
	keyRight = keyboard_check(ord("D"))

	debugToggle = keyboard_check_pressed(vk_control)	
}

keys()