extends CharacterBody2D

var speed = 48


var min_distance = pow(64,2)
var max_distance = pow(128,2)

@onready var player = get_parent().get_node("player")
@onready var timer = $Timer

@export var bullet: PackedScene

enum MODE {SEARCHING, ACTIVE, INACTIVE}
var mode = MODE.SEARCHING

func _physics_process(delta):
	match mode:
		MODE.SEARCHING:
			var player_position = player.global_position
			var distance_squared_to_player = global_position.distance_squared_to(player_position)
			velocity = direction(player_position) * speed
			move_and_slide()
			if distance_squared_to_player < min_distance:
				mode = MODE.ACTIVE
				timer.start()
		MODE.ACTIVE:
			var player_position = player.global_position
			var distance_squared_to_player = global_position.distance_squared_to(player_position)

			if distance_squared_to_player > max_distance:
				velocity = direction(player_position) * speed

			elif distance_squared_to_player < min_distance:
				velocity = direction(player_position) * speed * -1
			else:
				velocity = Vector2()
			move_and_slide()
		MODE.INACTIVE:
			pass


func _on_timer_timeout():
	var bullet_inst = bullet.instantiate()
	bullet_inst.velocity = direction(player.global_position)
	bullet_inst.global_position = global_position
	get_parent().add_child(bullet_inst)

func direction(target: Vector2):
	return global_position.direction_to(target)

func hit():
	queue_free()
