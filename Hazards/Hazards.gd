extends Area2D

func _process(delta):
	manage_collision()

func manage_collision():
	var collider = get_overlapping_bodies()
	for object in collider:
		if object.name == "Player":
			get_tree().call_group("gamestate", "hurt")

func _on_SpikeTop_body_entered(body):
	print(body);
	get_tree().call_group("gamestate", "hurt")
