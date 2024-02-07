extends Node2D

var Cherry = preload("res://Collectables/Cherry.tscn")

func _on_timer_timeout():
	var cherryTemp = Cherry.instantiate()
	var rng = RandomNumberGenerator.new()	
	var rand = rng.randi_range(0,900)
	cherryTemp.position = Vector2(rand,16)
	add_child(cherryTemp)
