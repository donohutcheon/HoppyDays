extends Node2D

var taken = false

func _on_Area2D_body_entered(body):
	if !taken:
		taken = true
		$AudioStreamPlayer2D.play()
		$AnimationPlayer.play("collected")
		get_tree().call_group("gamestate", "coin_up")

func collect():
	queue_free()