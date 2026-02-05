extends Area2D

@onready var Killtimer: Timer = $Killtimer

func _on_body_entered(body):
	print("goonber")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	Killtimer.start()



func _on_timer_timeout():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
