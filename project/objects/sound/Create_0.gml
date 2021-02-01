volumeSound = 1
volumeMusic = 1

function playSoundEffect(index) {
	audio_play_sound(index, 0, false)
	audio_sound_gain(index, volumeSound, 0)
	debug.log("Playing sound: " + string_upper(string(audio_get_name(index))))
}