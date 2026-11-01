class_name MusicPlayer
extends AudioStreamPlayer

# A tiny procedural chiptune loop: it avoids an external audio dependency while
# still giving the project its own music asset and a reusable audio component.
const NOTES := [261.63, 329.63, 392.0, 523.25, 392.0, 329.63, 293.66, 349.23]
var playback: AudioStreamGeneratorPlayback
var phase := 0.0
var note_clock := 0.0
var note_index := 0

func _ready() -> void:
	var stream := AudioStreamGenerator.new()
	stream.mix_rate = 22050.0
	stream.buffer_length = 0.4
	stream_paused = false
	self.stream = stream
	volume_db = -20.0
	play()
	playback = get_stream_playback()

func _process(delta: float) -> void:
	if playback == null:
		return
	note_clock += delta
	if note_clock > 0.24:
		note_clock = 0.0
		note_index = (note_index + 1) % NOTES.size()
	var frames := playback.get_frames_available()
	for i in frames:
		var sample := sin(phase) * 0.15
		phase = fmod(phase + TAU * NOTES[note_index] / 22050.0, TAU)
		playback.push_frame(Vector2(sample, sample))
