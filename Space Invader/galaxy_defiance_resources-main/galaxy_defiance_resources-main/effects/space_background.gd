extends ParallaxBackground

@onready var space_layer: ParallaxLayer = %SpaceLayer
@onready var far_stars_layer: ParallaxLayer = %FarStarsLayer
@onready var close_srtars_layer: ParallaxLayer = %CloseSrtarsLayer



func _process(delta: float) -> void:
	close_srtars_layer.motion_offset.y += 20 * delta
	far_stars_layer.motion_offset.y += 10 * delta
	space_layer.motion_offset.y += 5 * delta
