extends CanvasLayer

# store our goes to path
var path = ""

func fade_to(scn_to):
	self.path = scn_to
	$AnimationPlayer.play("fade")

# Middleware
func change_scene():
	if path != null :
		get_tree().change_scene(path)