class util.Algorithms {
	
	static function binarySearch(f: Function, l: Number, r: Number, s: Number) {
		var asc = f(l) < f(r)
		for (var i = 0; i < 50; i++) {
			var m = (l + r) / 2
			if ((f(m) < s) == asc) l = m
			else r = m
		}
		return l
	}
}