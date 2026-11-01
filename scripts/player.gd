class_name Player
extends Area2D

signal hit
signal flap
const SPEED := 520.0
var flap_clock := 0.0

func move(direction: float, delta: float) -> void:
	position.x = clampf(position.x + direction * SPEED * delta, 42.0, 918.0)
	flap_clock += delta
	if flap_clock >= 0.36:
		flap_clock = 0.0
		flap.emit()

func _on_area_entered(_area: Area2D) -> void:
	hit.emit()
