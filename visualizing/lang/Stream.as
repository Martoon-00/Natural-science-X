class lang.Stream {
	private var values:Array
	
	function Stream(values:Array){ this.values = values }
	
	static function of(): Stream { return new Stream(arguments) }
	
	static function ofObj(obj: Object): Stream {
		var a = new Array()
		lang.Objects.iterate(obj, function(name, value){ a.push(value) })
		return new Stream(a)
	}
	
	function forEach(action:Function): Stream { // for each value invoke f(this = value)
		for (var i = 0; i < values.length; i++)
			action.call(values[i])
		return this
	}
	
	function forEachArg(action:Function): Stream {
		for (var i = 0; i < values.length; i++)
			action.call(null, values[i])
		return this
	}
	
	function collect(initValue, appender:Function){ // equals to call appender(this = appender(this = initValue, value1), value2...)
		forEach(function(){ initValue = appender.call(initValue, this) })
		return initValue
	}
	
	function filter(predicate:Function):Stream { // remains only values: predicate(this = value) == true
		return new Stream(collect(
			new Array(), 
			function(value){
				if (predicate.call(value)) 
					this.push(value)
				return this 
			}
		))
	}
	
	function map(mapper:Function):Stream { // apples mapper to each value
		var newValues = new Array()
		forEach(function(){ newValues.push(mapper.call(null, this)) })
		return new Stream(newValues)
	}
	
	function min() {
		return collect(Number.POSITIVE_INFINITY, function(v: Number){ return Math.min(this, v) })
	}
	function max() {
		return collect(Number.NEGATIVE_INFINITY, function(v: Number){ return Math.max(this, v) })
	}
	
	function toArray():Array {
		return values.copy(new Array());
	}
	
	function count(): Number {
		return values.length
	}
	
	function zipWith(other: Stream, f: Function): Stream {
		var r: Array = new Array()
		for (var i = 0; i < values.length; i++) {
			r[i] = f(values[i], other.values[i])
		}
		return new Stream(r)
	}
	
	static function generate(num:Number, generator):Stream { 
		return new Stream(new Array(num)).map(generator.funcWrap())
	}
	
	static function iterate(seed, next: Function, num: Number): Stream {
		var a = new Array()
		a.push(seed)
		for (var i = 1; i < num; i++) a.push(next(a[i - 1]))
		return new Stream(a)
	}
	
	static function atRange(range: lang.Range, step: Number): Stream {
		return iterate(range.a, function(k){ return k + step }, Math.floor(range.length() / step) + 1)
	}
	
	static function CALL(f: Function) {
		return f()
	}
}