import lang.*

class net.Request {
	private var url: String
	private var parse: Function = function(s){ return s }
	
	function Request(url: String) {
		this.url = url
	}
	
	function send(f: Function, params) {  
		var _this = this
		var request = Optional.of(params).orElse({}).copy(new LoadVars())
		var result = new LoadVars()
		result.decode = function(data){ f(_this.parse(data)) }
		
		return request.sendAndLoad(url, result, "GET")
	}

	function setParser(f: Function): Request {
		parse = f
		return this
	}
	
}
