extends Control

# example page
var test_page = load("res://scenes/Test.tscn")

# my pages
var ia_page = load("res://Pages/IA.tscn")
var secu_page = load("res://Pages/Securite.tscn")
var dev_page = load("res://Pages/JeuEtDev.tscn")
var reseau_page = load("res://Pages/ReseauEtSystem.tscn")

var current_scn = null

func _ready():
	pass

func return_to_menu():
	$ViewportContainer.set_undisplay(Vector2(OS.window_size.x,0))
	

func remove_viewport_scene():
	if(current_scn != null):
		$GridContainer/GridContainer2/ViewportContainer/Viewport.remove_child(current_scn)
		current_scn.queue_free()

func _process(delta):
	if(OS.window_size.x < 600):
		$ScrollContainer/GridContainer/Body.columns = 1
	else:
		$ScrollContainer/GridContainer/Body.columns = 2

# URL
func _on_ButtonCodinGame_pressed():
	pass # Replace with function body.

func _on_Buttonrootme_pressed():
	pass # Replace with function body.

func _on_Buttongithub_pressed():
	pass # Replace with function body.

func _on_Buttontryhackme_pressed():
	pass # Replace with function body.
	
# Pages 
func _on_Button_pressed():
	var ia = ia_page.instance()
	ia.connect("return_to_menu", self, "return_to_menu")
	$ViewportContainer/Viewport.add_child(ia)
	$ViewportContainer.set_display(Vector2(0,0),Vector2(OS.window_size.x,0))

func _on_ButtonSecurite_pressed():
	var secu = secu_page.instance()
	secu.connect("return_to_menu", self, "return_to_menu")
	$ViewportContainer/Viewport.add_child(secu)
	$ViewportContainer.set_display(Vector2(0,0),Vector2(OS.window_size.x,0))

func _on_ButtonReseauSysteme_pressed():
	var reseau = reseau_page.instance()
	reseau.connect("return_to_menu", self, "return_to_menu")
	$ViewportContainer/Viewport.add_child(reseau)
	$ViewportContainer.set_display(Vector2(0,0),Vector2(OS.window_size.x,0))

func _on_ButtonJeuetDev_pressed():
	var dev = dev_page.instance()
	dev.connect("return_to_menu", self, "return_to_menu")
	$ViewportContainer/Viewport.add_child(dev)
	$ViewportContainer.set_display(Vector2(0,0),Vector2(OS.window_size.x,0))
