extends Camera2D

@export var random_strength: float = 40.0
@export var shake_fade: float = 5.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0
var original_offset := Vector2.ZERO

func apply_shake():
	shake_strength = random_strength
	
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_offset = offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shake_fade*delta)
		offset = original_offset + randomOffset()
	else:
		offset = original_offset

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))
	
