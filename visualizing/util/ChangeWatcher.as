class util.ChangeWatcher {
	var getter: Function
	private var last: Function
	var onChange: Function
	
	function get() {
		var v = getter()
		if (v != last) {
			onChange(v, last)
			last = v
		}
		return v
	}
	
}