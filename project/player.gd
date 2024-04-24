extends CharacterBody2D

var speed = 64
@onready var hinge = $hinge
@onready var parry_area = $hinge/parry_area

func _physics_process(delta):
	velocity = Input.get_vector("left", "right", "up", "down") * speed
	move_and_slide()
		
	hinge.rotation = get_local_mouse_position().angle()
	
	if Input.is_action_just_pressed("parry"):
		for i in parry_area.get_overlapping_bodies():
			if i.is_in_group("bullet"):
				i.parry(hinge.rotation)

func hit():
	get_tree().call_deferred("reload_current_scene")
