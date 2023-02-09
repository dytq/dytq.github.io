extends Control

var test_page = load("res://scenes/Test.tscn")

var current_scn = null

func _ready():
	pass

func return_to_menu():
	$ViewportContainer.set_undisplay(Vector2(OS.window_size.x,0))
	

func remove_viewport_scene():
	if(current_scn != null):
		$GridContainer/GridContainer2/ViewportContainer/Viewport.remove_child(current_scn)
		current_scn.queue_free()

func _on_Button_pressed():
	var my_page = test_page.instance()
	my_page.connect("return_to_menu", self, "return_to_menu")
	$ViewportContainer/Viewport.add_child(my_page)
	$ViewportContainer.set_display(Vector2(0,0),Vector2(OS.window_size.x,0))

func _process(delta):
	if(OS.window_size.x < 600):
		$ScrollContainer/GridContainer/GridContainer.columns = 1
	else:
		$ScrollContainer/GridContainer/GridContainer.columns = 2

