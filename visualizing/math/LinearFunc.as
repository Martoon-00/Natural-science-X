import lang.*

class math.LinearFunc {
	static var ID: LinearFunc = new LinearFunc(1, 0)
	
	var k: Number
	var b: Number
	
	function LinearFunc(k: Number, b: Number) {
		this.k = k
		this.b = b
	}
	
	function apply(v: Number): Number { 
		return k * v + b 
	}
	
	function applyToRange(r: Range): Range {
		return r.times(k).plus(b)
	}
	
	function inverse(): LinearFunc { return new LinearFunc(1 / k, -b / k) }
	
	function times(v: Number): LinearFunc { return new LinearFunc(v * k, b)	}
	function plus(v: Number): LinearFunc { return new LinearFunc(k, b + v)	}
	
	static function normalizer(a: Array): LinearFunc { 
		if (a.length == 0) a = a.concat(1)
		if (a.length == 1) a = a.concat(a[0])
			
		var s = new Stream(a)
		var min = s.min()
		var max = s.max()
		if (min == max) 
			return new LinearFunc(1 / min, 0)
		else 
			return new LinearFunc(max - min, min).inverse()
	}
	
	function equals(other: LinearFunc): Boolean { return k == other.k && b == other.b }
	
	function toString(): String { return Strings.format("[LinearFunc %.3f %.3f]", k, b) }
	
}