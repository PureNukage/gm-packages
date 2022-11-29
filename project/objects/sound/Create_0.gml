volumeSound = 1
volumeMusic = 1

musicIndex = -1
volumeMusicDimTime = -1

function playSoundEffect(index) {
	audio_play_sound(index, 0, false)
	audio_sound_gain(index, volumeSound, 0)
	debug.log("Playing sound: " + string_upper(string(audio_get_name(index))))
}

function playMusic(index, loops) {
	if musicIndex != index {
		if musicIndex > -1 and audio_is_playing(musicIndex) {
			audio_stop_sound(musicIndex)
			musicIndex = -1
		}
		musicIndex = index
		audio_play_sound(index, 0, loops)
		audio_sound_gain(index, volumeMusic, 0)
		debug.log("Playing music: " + string_upper(string(audio_get_name(index))))
	}
}

function stopMusic() {
	if musicIndex > -1 {
		audio_stop_sound(musicIndex)
		musicIndex = -1
	}
}

function volumeChangeMusic(index, new_volume, change_in_seconds = 0, duration_of_volume_change = -1) {
	if audio_is_playing(index) {
		audio_sound_gain(index, volumeMusic * new_volume, change_in_seconds * 1000)
	}
	volumeMusicDimTime = duration_of_volume_change
}