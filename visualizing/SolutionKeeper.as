import lang.*
import net.*
import globals.*

class SolutionKeeper {
	private static var CHECK_DELAY: Number = 100
	private var BLOCK_SIZE: Number
	
	private var request: Request
	private var params: Object
	
	private var closed: Boolean = false
	var onUpdate: Listener
	
	private var data: Array
	private var methods: Array
	
	function SolutionKeeper(request: Request, methods: Array, params: Object){
		var _this = this
		if (params == undefined)
			throw new Error("Passed undefined parameters in SolutionKeeper constructor")
		this.request = request.setParser(function(){ return _this.parseData.apply(_this, arguments) })
		this.params = params.copy({ methods: methods })
		
		this.methods = methods
		data = new Array()
		BLOCK_SIZE = int(200 / methods.length / (0.1 / params.dx))
		
		onUpdate = new Listener()
		
		check()
	}
	
	function check(): Void { 
		var _this = this
		
		var p = params.copy({ 
			from: data.length, 
			num: BLOCK_SIZE 
		})
		request.send(function(){ _this.fillData.apply(_this, arguments) }, p)
		
		if (!closed) 
			_global.setTimeout(function(){ _this.check() }, CHECK_DELAY)
	}
	
	private function fillData(received: Object): Void { 
		if (closed) return
		
		var blockIndex:Number = received.from
		var receivedData: Array = received.data
		var dataSize = data.length
		for (var i = 0; i < BLOCK_SIZE; i++) { 
			if (data.length <= i + blockIndex) { 
				data[i + blockIndex] = new Stream(receivedData)
					.map(function(methodData){ return methodData[i] })
					.toArray()
			}
		}
		
		if (data.length > dataSize){
			onUpdate.invoke(data.length)
		}
	}
	
	private function parseData(s: String) {   // converts to data array [method_no][index in block][x]
		var lines = s.split("\n")
		var data = new Array()
		var index = 0;
		for (var i = 0; i < methods.length; i++) {
			var method = new Array()
			data.push(method)
			for (var j = 0; j < BLOCK_SIZE; j++) {
				method.push(new Stream(lines[index++].split(" "))
					.map(function(sv){ return Number(sv) })
					.toArray()  
				)
			}
		}
		var from = Number(lines[index])
		return { data: data, from: from }
	}
	
	function available(): Number { return data.length }
	function get(index: Number) { return data[index] }
	
	function close(): Void {
		closed = true
	}
	
	
}