class math.Maths {
	static function floor(v: Number, granule: Number) {
		if (granule == undefined) granule = 1
		return Math.floor(v / granule) * granule
	}
	
	static function ceil(v: Number, granule: Number) {
		if (granule == undefined) granule = 1
		return Math.ceil(v / granule) * granule
	}
}