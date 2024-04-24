extends Node2D

@onready var camera = $Camera2D
@onready var player = $player
@onready var timer = $Timer
@export var enemy: PackedScene

var positions = [Vector2(-8,-8),Vector2(240,-8),Vector2(488,-8),Vector2(-8,328),Vector2(240,328),Vector2(488,328)]

func _process(delta):
	camera.global_position = player.global_position



func _on_timer_timeout():
	var enemy_inst = enemy.instantiate()
	enemy_inst.global_position = positions.pick_random()
	add_child(enemy_inst)
	timer.wait_time = max(timer.wait_time - 0.1, 3)
