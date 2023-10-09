extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null
var player_inattack_zone = true
var health = 100

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	
	
	deal_with_damage()
	if player_chase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) <0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true


func _on_area_2d_body_exited(body):
	player = null
	player_chase = false
	$AnimatedSprite2D.play("idle")
	

func enemy():
	pass


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true
		player_chase = false


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		player_chase = true
		
func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		health = health -20
		print("slime health = ", health)
		if health <= 0	:
			self.queue_free()
