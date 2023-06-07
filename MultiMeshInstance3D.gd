@tool
extends MultiMeshInstance3D


func Draw3dMat(mat, surfaceLimit, radius = 0.05):

	var width = mat.size()
	var height = mat[0].size()
	var depth = mat[0][0].size() 

	# Create the multimesh.
	multimesh = MultiMesh.new()

	var meshi = SphereMesh.new()
	meshi.radius = radius
	meshi.height = radius*2
	multimesh.mesh = meshi

	multimesh.mesh.set_material(StandardMaterial3D.new())
	multimesh.mesh.material.vertex_color_use_as_albedo = true
	multimesh.mesh.material.albedo_color = Color(1,1,1)
	multimesh.use_colors = true

	# Set the format first.
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	# Then resize (otherwise, changing the format is not allowed).
	multimesh.instance_count = width*height*depth
	# Maybe not all of them should be visible at first.
	multimesh.visible_instance_count = width*height*depth
	for x in range(width):
		for y in range(height):
			for z in range(depth):
				var index = (z * width * height) + (y * width) + x
				var val = int(mat[x][y][z].w < surfaceLimit)
				multimesh.set_instance_transform(index, Transform3D(Basis(), Vector3(0,0,0)).translated(Vector3(mat[x][y][z].x, mat[x][y][z].y, mat[x][y][z].z)))
				multimesh.set_instance_color(index, Color(val*255, 0, 0))


func draw_multi_mesh():
	var mat = get_parent().mat
	var surfaceLimit = get_parent().surfaceLimit
	Draw3dMat(mat,surfaceLimit, 0.05)
