extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var SPEED = 50

func _on_ready():
	var anim = get_node("AnimatedSprite2D")
	anim.play("Idle")

func _physics_process(delta):
		
	velocity.y += gravity * delta
	var anim = get_node("AnimatedSprite2D")
	
	
	if anim.animation != "Death":
		if chase == true:
			anim.play("Jump")
			player = get_node("../../Node2D/Player")
			var direction : Vector2 = ( player.position - self.position ).normalized()
			if direction.x > 0:
				anim.flip_h = true
			else:
				anim.flip_h = false
				
			velocity.x = direction.x * SPEED
		else:
			anim.play("Idle")
			velocity.x = 0
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
	

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
		

func _on_death_body_entered(body):
	if body.name == "Player":
		death()



func death():
	chase = false
	Game.Gold += 5
	Utils.saveGame()
	var anim = get_node("AnimatedSprite2D")	
	anim.play("Death")
	await anim.animation_finished
	self.queue_free()


func _on_player_damage_body_entered(body):
	if body.name == "Player":
		Game.PlayerHP -= 3
		death()
