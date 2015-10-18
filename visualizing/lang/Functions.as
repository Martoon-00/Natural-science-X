import lang.*

class lang.Functions {
	private static var _lol = new FuncInvoker(init)
	private static function init() { 
		var proto = arguments.callee.__proto__
		
		proto.defunc = function() { return this.apply(this, arguments) }
		
		proto.override = function(obj: Object, prop: String) {
			var old = obj[prop]
			var _this = this
			obj[prop] = function() {
				return _this.apply(this, new Array(old).concat(arguments))
			}
		}
		
		_global.ASSetPropFlags(proto, null, 0x7)
		
		_global.traceAll = function(){ trace(arguments.join("  ")) }
	}
	
	
	static var WATCH_ARRAY = function(prop, oldVal, newVal) {
		oldVal.push(newVal)
		return oldVal
	}
	
	static var UNWATCH_ONCE_DEFINED = function(f) {
		return function(prop, oldVal, newVal) { 
			if (newVal != undefined) {
				this.unwatch(prop)
				this[prop] = newVal
				f(newVal)
			}
			return newVal
		}
	}

	static function makeMultiListener(obj: Object, prop: String, listener: Function): Function {
		if (obj[prop] instanceof Array) return;
		var oldVal = obj[prop]
		var array = new Array()

		obj[prop] = function(){ for (var i = 0; i < array.length; i++) array[i].apply(this, arguments) }
		obj.watch(prop, function(prop, oldVal, newVal){ array.push(newVal); return oldVal })
		
		obj[prop] = oldVal
		if (listener != undefined) obj[prop] = listener
		
		return obj[prop]
	}
	
	static function makeExecOnce(f: Function) {
		var executed = false
		return function() {
			if (!executed) {
				executed = true
				return f.apply(this, arguments)
			}
			return null
		}
	}
	
}