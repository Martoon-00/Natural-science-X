import lang.*
import util.*
import coordinates.*
import math.*
import colors.*

class diag.Diagram extends MovieClip {
	private var size: Coord
	private var fieldSize: Coord
	
	var xAxisName: String = "x"
	var yAxisName: String = "y"
	
	var xScale: LinearFunc
	var yScale: LinearFunc
	var yAutoScale: Boolean = true
	
	var gridParts: Number = 10
	
	var field: MovieClip
	
	var xAxis: MovieClip
	var yAxis: MovieClip
	
	var toDraw: Array
	
	function Diagram(){
		xScale = LinearFunc.ID
		yScale = LinearFunc.ID
		
		init()
	}
	
	function init() {
		size = new Coord(_width, _height)
		var bounds = getBounds(this)
		_width = bounds.xMax - bounds.xMin
		_height = bounds.yMax - bounds.yMin
		fieldSize = size.minus(new Coord(1, 1).times(5)).times(1 / 1)
		
		drawAxes()
		field = createEmptyMovieClip("field", 100)
		toDraw = new Array()
	}
	
	function fillingGridCoords(scale: LinearFunc) {
		var lf = scale.inverse()
		var a1 = lf.apply(0)
		var a2 = lf.apply(1)
		
		var coef = 0.03
		var order = Math.log(coef * (a2 - a1)) / Math.LN10
		var d = Math.exp(Maths.ceil(Math.log(coef * (a2 - a1)), Math.LN10))
		var r = new Range(Maths.ceil(lf.apply(0), d), Maths.floor(lf.apply(1), d) - 1e-3)
		
		var a = new Array()
		r.iterate(function(v: Number){ a.push(v) }, d)
		return {order: order, keypoints: a}
	}
	
	function drawAxes() {
		var _this = this
		xAxis = createEmptyMovieClip("xAxis", 20)
		yAxis = createEmptyMovieClip("yAxis", 21)
		
		// grid
		var gridAlpha = 30
		xAxis.lineStyle(1, 0x00FF00, gridAlpha)
		for (var i = 1; i < gridParts; i++) { 
			new Drawer(xAxis)
				.transform(Transform.MOVE(fieldSize.x * i / gridParts, 0))
				.moveTo(Coord.ZERO)
				.lineTo(0, -size.y * 0.98)
		}
		
		var yGridParam = fillingGridCoords(yScale)
		yAxis.lineStyle(1, 0x00FF00, gridAlpha)
		yGridParam.keypoints.forEach(function(i, y){  
			new Drawer(yAxis)
				.transform(Transform.MOVE(0, -yScale.apply(y) * fieldSize.y))
				.moveTo(Coord.ZERO)
				.lineTo(size.x * 0.98, 0)
		}.withThis(this))
		
		// bg
		var colors = new ColorSmoothChoice([0x00FF00, 0x00FFFF, 0x0000FF, 0xA000FF, 0xFF0000, 0xFFFF00])
		var color = colors.get(LinearFunc.normalizer([-1, 10]).apply(yGridParam.order))
		new Drawer(yAxis)
			// .lineStyle()
			//.beginFill(color, 5)
			//.rectangle(0, fieldSize.x, 0, -fieldSize.y)
		
		
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
		axisNameFormat.size = 14
		function tuneAxisText(txt: TextField) {
			txt.autoSize = true
			txt.setNewTextFormat(axisNameFormat)
			txt.selectable = false
		}
			
		var xText = xAxis.createTextField("axisName", 10, size.x + 10, -25, 20, 20)
		tuneAxisText(xText)
		xText.text = xAxisName
		
		var yText = yAxis.createTextField("axisName", 10, 10, -size.y - 15, 20, 20)
		tuneAxisText(yText)
		yText.text = yAxisName	
		
		// axis coords text
		var cutDouble = function(k){
			var s = String(k).slice(0, 4)
			if (s.charAt(s.length - 1) == ".") s = s.slice(0, -1)
			return s
		}
		var tuneCoordText = function(txt: TextField, align) {
			txt.autoSize = align
			txt.selectable = false
		}
		
		var yCoordText1 = yAxis.createTextField("axisCoord1", 100, -25, -fieldSize.y - 10, 20, 20)
		tuneCoordText(yCoordText1, "right")
		yCoordText1.text = cutDouble(yScale.inverse().apply(1))

		var yCoordText2 = yAxis.createTextField("axisCoord2", 101, -25, 0 - 10, 20, 20)
		tuneCoordText(yCoordText2, "right")
		yCoordText2.text = cutDouble(yScale.inverse().apply(0))

		
		var xCoordText1 = xAxis.createTextField("axisCoord1", 100, fieldSize.x, 5, 0, 20)
		tuneCoordText(xCoordText1, "center")
		xCoordText1.text = cutDouble(xScale.inverse().apply(1))
		
		var xCoordText2 = xAxis.createTextField("axisCoord2", 101, 0, 5, 0, 20)
		tuneCoordText(xCoordText2, "center")
		xCoordText2.text = cutDouble(xScale.inverse().apply(0))

	}
	
	function clear(): Diagram {
		field.clear()
		toDraw = new Array()
		return this;
	}
	
	function draw(liner: Function, points: Array): Diagram { 
		toDraw.push({ liner: liner, points: points })
		return this;
	}
	
	function commit(): Diagram {
		if (toDraw.length == 0) return;
		var _this = this
		
		var allPoints = new Array()
		for (var i = 0; i < toDraw.length; i++) allPoints = allPoints.concat(toDraw[i].points)
		checkResize(allPoints)
		
		for (var i = 0; i < toDraw.length; i++) {
			var liner = toDraw[i].liner
			var points = toDraw[i].points
			
			var dr = new Drawer(field)
				.lineStyle(1, 0)
				.apply(liner)
				.transform(Transform.SCALE(fieldSize.x, -fieldSize.y))
			
			new Stream(points)
				.map(function(c: Coord){ return new Coord(c.x, _this.yScale.apply(c.y)) })
				.forEachArg(function(point){ 
					dr.lineTo(point)
				})
		}
		return this
	}
	
	
	function checkResize(points): Void { 
		if (!yAutoScale) return;
		
		var lf = math.LinearFunc.normalizer(new Stream(points.concat(new Coord(0, 0), new Coord(0, 1)))
			.map(Stream.GETTER("y"))
			.toArray())
		
		if (lf.equals(yScale)) return;
	
		yScale = lf
		drawAxes()
	}

}