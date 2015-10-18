import net.*

class net.UrlKeeper {
	private var root
	
	function UrlKeeper(rootUrl) {
		root = rootUrl
	}
	
	function request(path: String, parse: Function): Request { 
		var _this = this
		return new Request(function(){ return _this.root.defunc() + path })
			.setParser(parse)
	}
	
	function toString(): String { return root }
	
}