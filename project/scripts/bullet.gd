extends CharacterBody2D
var bullet_speed = 72
func _ready():
	velocity *= bullet_speed

	

func _physics_process(delta):
	move_and_slide()

func parry(rotation: float):
	velocity = Vector2.LEFT.rotated(rotation) * bullet_speed * -1.5
	$Area2D.collision_mask = 3
	$Sprite2D.self_modulate = Color("#0099db")

func _on_area_2d_body_entered(body):
	if body == self:
		return
	if body.is_in_group("enemy") or body.is_in_group("player"):
		body.hit()
		queue_free()
