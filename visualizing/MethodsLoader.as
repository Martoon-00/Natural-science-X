import lang.*

class MethodsLoader {
	static function load(onLoad: Function) {
		_global._rootUrl.request("methods", function(s){ return s.split("\n") })
			.send(function(methods){ _global._methods = methods; onLoad() })
	}
}