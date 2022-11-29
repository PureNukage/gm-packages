if (volumeMusicDimTime > -1) {
	if time.seconds_switch {
		volumeMusicDimTime--
		if volumeMusicDimTime <= 0 {
			audio_sound_gain(musicIndex, volumeMusic, 0)
			volumeMusicDimTime = -1
		}
	}
}