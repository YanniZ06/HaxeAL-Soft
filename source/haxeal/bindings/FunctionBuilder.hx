package haxeal.bindings;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.Tools;
#if !macro
using StringTools;
#end

@:noDoc
class FunctionBuilder {
    public static macro function buildFunctions():Array<Field> {
        var fields:Array<Field> = Context.getBuildFields();
		var newFields:Array<Field> = [];

		var initFunContent:String = '';
        
        for(field in fields) {
            var ignoreField:Bool = true;
            var alFuncName:String = '';

            for (data in field.meta) {
				if (data.name != 'lpFunc')
					continue;

				ignoreField = false; // Hooray, our field has the lpFunc annotation
                alFuncName = data.params[0].getValue();
			}

			if (ignoreField) {
				newFields.push(field); // Make sure our field is still passed
				continue;
			}
			
			var argNames:Array<String> = [];
			var retType:ComplexType;
			var originalFun:Function = null;
			switch(field.kind) {
				case FFun(f):
					for(arg in f.args) argNames.push(arg.name); // Get original function parameter names

					retType = f.ret; // Get original function return type
					originalFun = f;
				default:
			}

			var returnKey:String = '';
			switch(retType) {
				case TPath(p): if(p.name != 'Void') returnKey = 'return '; // If the function isnt of type void, return the al call value
				default:
			}

			final functionCodeContentExec:String = '${returnKey}$alFuncName(${argNames.join(', ')});';

			// Get functionCode metadata expr with our code executor string
			final baseExpr = macro
				@:functionCode($v{functionCodeContentExec})
				function placeholder() {};
			
			var functionCodeMeta:MetadataEntry = null;
			switch(baseExpr.expr) {
				case EMeta(s, e): functionCodeMeta = s; // Get our metadata so we can pass it to the new field later
				default:
			}

			// Finally, replace our old function
			final funcField:Field = {
				name: field.name,
				kind: FFun(originalFun),
				pos: Context.currentPos(),
				access: [AStatic, APublic],
				meta: [functionCodeMeta] // Import our metadata, this does the important c++ shit!
			};
			newFields.push(funcField);

			// Push this to the init functionCode
			final longPointerName = 'LP${alFuncName.toUpperCase()}';
			initFunContent += ' 	$alFuncName = ($longPointerName) alGetProcAddress("$alFuncName");\n'; 
        }

		// Set up our initializer function data
		final metaExpr = macro 
			@:functionCode($v{initFunContent})
			function placeholder() {};

		var initFunctionCodeMeta:MetadataEntry = null;
		switch(metaExpr.expr) {
			case EMeta(s, e): initFunctionCodeMeta = s; // Get our metadata so we can pass it to the new field later
			default:
			}

		final emptyFuncMacro = macro function empty() {};
		var emptyFunc:Function;
		switch(emptyFuncMacro.expr) {
			case EFunction(kind, f): emptyFunc = f;
			default:
		}

		var type = Context.getLocalClass().get().name;
		if(type == 'ALSOFT') type = 'SOFT';

		// Initializer Function Declaration
		var initField:Field = {
			name: 'init$type',
			kind: FFun(emptyFunc),
			pos: Context.currentPos(),
			access: [AStatic, APublic],
			meta: [initFunctionCodeMeta]
		};
		newFields.push(initField);

        return newFields;
    }
}