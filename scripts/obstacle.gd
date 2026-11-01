class_name Obstacle
extends Area2D

@export var speed := 320.0
const METEOR := preload("res://assets/art/meteor.svg")
const SPIKE_ORB := preload("res://assets/art/spike_orb.svg")

func configure_shape(use_spikes: bool) -> void:
	$Sprite.texture = SPIKE_ORB if use_spikes else METEOR
	$Sprite.rotation = randf_range(-0.5, 0.5)

func _process(delta: float) -> void:
	position.y += speed * delta
	$Sprite.rotation += delta * 1.3
	if position.y > 620.0:
		queue_free()
