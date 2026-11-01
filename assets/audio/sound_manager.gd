class_name SoundManager
extends Node

# Lightweight synthesized effects so the project remains self-contained.
func flap() -> void:
	play_tone(740.0, 0.075, 0.10, 960.0)

func crash() -> void:
	play_tone(180.0, 0.28, 0.23, 58.0)

func game_over() -> void:
	play_tone(330.0, 0.42, 0.16, 110.0)

func play_tone(start_hz: float, duration: float, volume: float, end_hz: float) -> void:
	var player := AudioStreamPlayer.new()
	var stream := AudioStreamGenerator.new()
	stream.mix_rate = 22050.0
	stream.buffer_length = duration + 0.08
	player.stream = stream
	player.volume_db = -7.0
	add_child(player)
	player.play()
	var output: AudioStreamGeneratorPlayback = player.get_stream_playback()
	var frames := int(stream.mix_rate * duration)
	var phase := 0.0
	for frame in frames:
		var t := float(frame) / frames
		var frequency := lerpf(start_hz, end_hz, t)
		phase += TAU * frequency / stream.mix_rate
		var envelope := sin(t * PI)
		var value := sin(phase) * volume * envelope
		output.push_frame(Vector2(value, value))
	get_tree().create_timer(duration + 0.15).timeout.connect(player.queue_free)
