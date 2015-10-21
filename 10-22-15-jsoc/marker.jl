using GLVisualize, GeometryTypes, GLAbstraction, Reactive, FileIO, Colors
w,r = glscreen()
const s = Vec2f0(45)
const N = 128
# 2D particles
particle_data2D(i, N) = Point2f0[rand(Point2f0, -2f0:eps(Float32):2f0) for x=1:N]
const p2ddata = foldp(+, Point2f0[rand(Point2f0, 0f0:eps(Float32):1000f0) for x=1:N],
	const_lift(particle_data2D, bounce(1f0:1f0:50f0), N))
particle_robj = visualize(p2ddata, scale=s, color=Texture(map(RGBA{U8}, colormap("blues", N))))
gpu_o = particle_robj[:positions]

const offset = Vec3f0(s[1]*5f0, s[1]*5f0, 0)

view(particle_robj)
view(visualize(
	gpu_o, scale=s, color=RGBA{Float32}(.1f0, .1f0, 0.6f0, 0.7f0),
	style=Cint(OUTLINED), shape=Cint(ROUNDED_RECTANGLE), 
	model=translationmatrix(rand(Vec3f0).*offset)))
view(visualize(
	gpu_o, scale=s, color=RGBA{Float32}(.9f0, .2f0, 0.3f0, 0.9f0), 
	style=Cint(FILLED), shape=Cint(CIRCLE), model=translationmatrix(rand(Vec3f0).*offset)))
view(visualize(gpu_o, scale=s, style=Cint(FILLED)|Cint(FILLED), shape=Cint(RECTANGLE), model=translationmatrix(rand(Vec3f0).*offset)))
view(visualize(gpu_o, scale=s, style=Cint(FILLED)|Cint(OUTLINED)|Cint(GLOWING), shape=Cint(ROUNDED_RECTANGLE), model=translationmatrix(rand(Vec3f0).*offset)))
view(visualize(
	gpu_o, scale=s, glow_color=RGBA{Float32}(.9f0, .3f0, 0.9f0, 0.9f0),
	style=Cint(OUTLINED)|Cint(GLOWING), shape=Cint(TRIANGLE), model=translationmatrix(rand(Vec3f0).*offset)))
gif = load("doge.png").data
view(visualize(
	gpu_o, 
	style=Cint(FILLED)|Cint(FILLED)|Cint(TEXTURE_FILL), 
	shape=Cint(ROUNDED_RECTANGLE),
	texture_fill=Texture(gif), scale=s,
	model=translationmatrix(rand(Vec3f0).*offset)
))
r()