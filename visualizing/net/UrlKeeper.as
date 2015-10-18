import net.*

class net.UrlKeeper {
	private var root: String
	
	function UrlKeeper(rootUrl: String) {
		root = rootUrl
	}
	
	function request(path: String, parse: Function): Request {
		return new Request(root + path)
			.setParser(parse)
	}
	
	function toString(): String { return root }
	
}