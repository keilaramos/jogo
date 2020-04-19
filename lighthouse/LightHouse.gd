extends Area2D

signal gameover

var life = 100

func _process(_delta):
	$LifeBar.value = life
	$BigLight.texture_scale = 0.1 + (1.5 * life/100)
	$SmallLight.texture_scale = 0.1 + (0.9 * life/100)
	if life <= 0:
		emit_signal("gameover")
		queue_free()
	elif life < 30:
		$Sprite.frame = 2
	elif life < 60:
		$Sprite.frame = 1
	else:
		$Sprite.frame = 0


func _on_area_entered(area):
	if area.has_method("hurt"):
		area.hurt()
	life -= 9
	$LifeBar/AnimationPlayer.play("badflicker")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "badflicker":
		$LifeBar/AnimationPlayer.play("flicker")


func _on_BulletBooster_area_entered(area: Area2D):
	area.scale *= 3
	area.velocity *= 2
	area.invincible = true
	$BulletBooster/Flame.play()
	$LifeBar/AnimationPlayer.play("badflicker")
	life -= 2
