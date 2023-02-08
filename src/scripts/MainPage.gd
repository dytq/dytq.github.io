extends Control

var example_page = load("res://scenes/Page.tscn")

var current_scn = null

func _ready():
	pass

func _on_Button_pressed():
	if(current_scn != null):
		remove_viewport_scene()
	current_scn = example_page.instance()
	current_scn.connect("return_to_menu",self,"return_to_menu")
	$ViewportContainer/Viewport.add_child(current_scn)
	$Camera2D.target_position = Vector2(1920, $Camera2D.position.y)

func return_to_menu():
	$Camera2D.target_position.x = 0

func remove_viewport_scene():
	$ViewportContainer/Viewport.remove_child(current_scn)
	current_scn.queue_free()
