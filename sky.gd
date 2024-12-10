extends MeshInstance3D

# Assuming this script is attached to the node containing the shader
@onready var animated_sprite = $AnimatedSprite3D
@onready var material = $YourMesh.material_override as ShaderMaterial

func _process(delta):
	# Set the shader texture uniform to the current frame texture
	if animated_sprite.texture:
		material.set_shader_param("sky_texture", animated_sprite.texture)
