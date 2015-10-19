import lang.*

class net.Request {
	private var url
	private var parse: Function = function(s){ return s }
	
	function Request(url) {
		this.url = url
	}
	
	function send(f: Function, params) {   
		var _this = this
		var request = Optional.of(params).orElse({}).copy(new LoadVars())
		var result = new LoadVars()
		result.decode = function(data){ f(_this.parse(data)) }
		
		return request.sendAndLoad(url.defunc(), result, "GET")
	}

	function setParser(f: Function): Request {
		parse = f
		return this
	}
	
}
