import lang.*
import util.*
import coordinates.*

class diag.Diagram extends MovieClip {
	private var size: Coord
	private var scale: Coord
	
	var xAxisName: String = "x"
	var yAxisName: String = "y"
	
	var field: MovieClip
	
	function Diagram(){
		//var releaseDraw = InitStub.laterCall(this, "draw")
		//this.watch("field", new Functions().UNWATCH_ONCE_DEFINED(releaseDraw))
		
		init()
	}
	
	function init() {
		size = new Coord(_width, _height)
		var bounds = getBounds(this)
		_width = bounds.xMax - bounds.xMin
		_height = bounds.yMax - bounds.yMin
		scale = size.minus(new Coord(1, 1).times(5)).times(1 / 1)
		
		drawAxes()
		field = createEmptyMovieClip("field", 100)
	}
	
	function drawAxes() {
		var xAxis = createEmptyMovieClip("xAxis", 20)
		var yAxis = createEmptyMovieClip("yAxis", 21)
		
		// grid
		var gridParts = 5
		var gridAlpha = 30
		xAxis.lineStyle(1, 0x00FF00, gridAlpha)
		for (var i = 1; i < gridParts; i++) { 
			new Drawer(xAxis)
				.transform(Transform.MOVE(scale.x * i / gridParts, 0))
				.moveTo(Coord.ZERO)
				.lineTo(0, -size.y * 0.95)
		}
		
		yAxis.lineStyle(1, 0x00FF00, gridAlpha)
		for (var i = 1; i < gridParts; i++) { 
			new Drawer(yAxis)
				.transform(Transform.MOVE(0, -scale.y * i / gridParts))
				.moveTo(Coord.ZERO)
				.lineTo(size.x * 0.95, 0)
		}
		
		// axis
		var axisMargin = 10
		function drawArrow(dr: Drawer) {
			var arrowLength = 10
			dr
				.moveTo(Coord.ZERO)
				.lineTo(new Coord(-arrowLength, 0).rotate(45))
				.moveTo(Coord.ZERO)
				.lineTo(new Coord(-arrowLength, 0).rotate(-45))
		}
	
		new Drawer(xAxis)
			.lineStyle(3, 0)
			.moveTo(Coord.ZERO)
			.lineTo(size.x + axisMargin, 0)
			.transform(Transform.MOVE(size.x + axisMargin, 0))
			.apply(drawArrow)
			
		new Drawer(yAxis)
			.lineStyle(3, 0)
			.transform(Transform.ROTATE(90))
			.moveTo(Coord.ZERO)
			.lineTo(size.y + axisMargin, 0)
			.modify(Transform.MOVE(size.y + axisMargin, 0))
			.apply(drawArrow)
		
		// axis text
		var axisNameFormat = new TextFormat()
		//axisNameFormat.bold = true
		axisNameFormat.size = 14
		function tuneAxisText(txt: TextField) {
			txt.autoSize = true
			txt.setNewTextFormat(axisNameFormat)
		}
			
		var xText = xAxis.createTextField("axisName", 10, size.x + 5, 0, 20, 20)
		tuneAxisText(xText)
		xText.text = xAxisName
		
		var yText = yAxis.createTextField("axisName", 10, 10, -size.y - 15, 20, 20)
		tuneAxisText(yText)
		yText.text = yAxisName	

	}
	
	function clear(): Diagram {
		field.clear()
		return this;
	}
	
	function draw(liner: Function, points: Array): Diagram { 
		var dr = new Drawer(field)
			.lineStyle(1, 0)
			.apply(liner)
			.transform(Transform.SCALE(scale.x, -scale.y))
			
		new Stream(points).forEachArg(function(point){ 
			dr.lineTo(point)
		})
		
		return this;
	}

}