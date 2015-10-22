import lang.*
import coordinates.*
import diag.*
import util.*

class diag.ProfileDrawer extends MovieClip {
	private var diagram: Diagram
	
	private var width: Number
	private var height: Number
	
	private var step: ChangeWatcher 
	
	private var xs: Array
	private var ys: Array
	
	private var lastMousePos: Coord
	
	public var close: Function
	
	function ProfileDrawer(){ 
		var _this = this
		width = _width
		height = _height
	
		var bounds = getBounds(this)
		_width = bounds.xMax - bounds.xMin
		_height = bounds.yMax - bounds.yMin
	
		var bg = createEmptyMovieClip("bg", 10)
		new Drawer(bg)
			.beginFill(0xFF00FF, 0)
			.rectangle(0, width, 0, -height)
	
		diagram._width = width
		diagram._height = height
		
		bg.onUnload = new MouseListener().register({
			onHold: function(){  
				_this.change() 
				_this.lastMousePos = new Coord(_this._xmouse, _this._ymouse)
			}											
		})
		
		step = new ChangeWatcher()
		step.onChange = function(){ _this.recount.apply(_this, arguments) }
		xs = new Array(0, 1)
		ys = new Array(0, 0)
		draw()
		
		close = new MouseListener().register({
			onPress: function(){ 
				_this.step.get() 
				_this.lastMousePos = new Coord(_this._xmouse, _this._ymouse)
			}	 
		})
		
	}
	
	function recount(newVal, oldVal) {  
		try {
			var xs_ = this.xs
			var ys_ = this.ys
			var xs = Range.UNIT.fill(newVal)
			var ys = new Array()
			
			for (var i = xs_.length; i > 0; i--) {
				xs_.push(xs_[xs_.length - 1] + oldVal)
				ys_.push(ys_[ys_.length - 1])
			}
			
			for (var i = 0, j = 0; i < xs.length; i++) { 
				while (xs[i] > xs_[j + 1]) j++
				ys[i] = (ys_[j + 1] * (xs[i] - xs_[j]) + ys_[j] * (xs_[j + 1] - xs[i])) / (xs_[j + 1] - xs_[j])
			}
			this.xs = xs
			this.ys = ys
			
			draw()
		} catch (e: Error) {
			new Logger("stage").info(e.message)
		}
	}
	
	function setStep(f: Function) {
		step.getter = f
	}
	
	function change() { 
		function lim(k: Number){ return isNaN(k) || Math.abs(k) == Number.POSITIVE_INFINITY ? 1 : k }
		
		var mouse = new Coord(_xmouse, _ymouse)
		var d = step.get() * width
		var last = lastMousePos
		new Range(last.x, mouse.x).map(function(k){ return Math.round(k / d) * d }).iterate(function(x: Number){    
			var y = (mouse.y - last.y) * lim((x - last.x) / (mouse.x - last.x)) + last.y
			if (x < 0 || x > width || -y < 0 || -y > height)
				return;
				
			var index = x / d
			ys[index] = -y / height
		}.withThis(this), d)
		draw()
	}
	
	function draw() {
		diagram
			.clear()
			.draw(
				function(dr){ dr.lineStyle(3, 0x0000FF) },
				new Stream(xs).zipWith(new Stream(ys), function(x, y){ return new Coord(x, y) }).toArray()
			)
	}
	
	function set(xs: Array, ys: Array): Void {
		this.xs = xs
		this.ys = ys
		draw()
	}
	
	function get(): Object {
		step.get()
		return { xs: xs.copy(new Array()), ys: ys.copy(new Array()) }
	}
	
}