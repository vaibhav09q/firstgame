extends Node2D

const OBSTACLE_SCENE := preload("res://scenes/Obstacle.tscn")
@onready var player: Player = $Player
@onready var spawner: Timer = $ObstacleSpawner
@onready var score_label: Label = $HUD/Score
@onready var best_label: Label = $HUD/Best
@onready var game_over_panel: PanelContainer = $HUD/GameOver
@onready var sounds: SoundManager = $Sounds

var score := 0.0
var best := 0
var playing := true
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	best = load_best()
	best_label.text = "BEST  %d" % best
	player.hit.connect(end_game)
	player.flap.connect(sounds.flap)
	game_over_panel.hide()

func _process(delta: float) -> void:
	if not playing:
		if Input.is_action_just_pressed("restart"):
			get_tree().reload_current_scene()
		return
	player.move(Input.get_axis("move_left", "move_right"), delta)
	score += delta
	score_label.text = "SCORE  %d" % int(score)
	spawner.wait_time = maxf(0.32, 0.78 - score * 0.008)

func _on_obstacle_spawner_timeout() -> void:
	if not playing:
		return
	var obstacle: Obstacle = OBSTACLE_SCENE.instantiate()
	obstacle.position = Vector2(rng.randf_range(38.0, 922.0), -45.0)
	obstacle.speed = rng.randf_range(260.0, 395.0) + minf(score * 5.0, 170.0)
	obstacle.configure_shape(rng.randf() > 0.5)
	$Obstacles.add_child(obstacle)

func end_game() -> void:
	if not playing:
		return
	playing = false
	spawner.stop()
	sounds.crash()
	sounds.game_over()
	var final_score := int(score)
	if final_score > best:
		best = final_score
		var file := FileAccess.open("user://best_score.save", FileAccess.WRITE)
		file.store_string(str(best))
	game_over_panel.get_node("Margin/VBox/Result").text = "YOU FLEW FOR %d SECONDS" % final_score
	game_over_panel.show()

func load_best() -> int:
	if not FileAccess.file_exists("user://best_score.save"):
		return 0
	return int(FileAccess.open("user://best_score.save", FileAccess.READ).get_as_text())
