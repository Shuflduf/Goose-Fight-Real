extends PlayerComponent

const WALK_SPEED: float = 250.0
const RUN_SPEED: float = 500.0
const RUN_WINDOW: float = 0.2

var running: bool = false
var run_timer: float = 0.0
var last_run_dir: int = 0

func _physics_process(delta: float) -> void:
    var input_dir: float = Input.get_axis(&"left", &"right")
    var current_dir: int = int(input_dir)

    if current_dir == 0:
        if last_run_dir != 0:
            run_timer += delta
    else:
        if current_dir != last_run_dir:
            running = false
            last_run_dir = current_dir
            run_timer = 0.0
        elif run_timer > 0.0:
            running = true
            run_timer = 0.0

    if run_timer > RUN_WINDOW:
        run_timer = 0.0
        last_run_dir = 0
        running = false

    if running and input_dir:
        p.velocity.x = input_dir * RUN_SPEED
    else:
        p.velocity.x = lerp(p.velocity.x, input_dir * WALK_SPEED, delta * 30.0)
