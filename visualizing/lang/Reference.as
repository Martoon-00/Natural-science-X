class lang.Reference {
	private var obj: Object
	private var prop: String
	
	function Reference(obj: Object, prop: String) {
		this.obj = obj
		this.prop = prop
	}
	
	function get(): Object {
		return obj[prop]
	}
	
	function set(value: Object): Void {
		obj[prop] = value
	}
}