package haxeal.bindings;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.Tools;
using StringTools;

class EFXBuilder {
    public static macro function buildFunctions():Array<Field> {
        var fields:Array<Field> = Context.getBuildFields();
		var newFields:Array<Field> = [];
        
        for(field in fields) {
            var ignoreField:Bool = true;
            var alFuncName:String = '';

			newFields.push(field);
            for (data in field.meta) {
				if (data.name != 'efxFunc')
					continue;

				ignoreField = false; // Hooray, our field has the efxFunc annotation
                alFuncName = data.params[0].getValue();
			}

			if (ignoreField) continue;
			
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

			newFields.remove(field); // Remove old function field, now replace with a variable function
			
			// Setup our functionCode content
			final longPointerName = 'LP${alFuncName.toUpperCase()}';

			var returnKey:String = '';
			switch(retType) {
				case TPath(p): if(p.name != 'Void') returnKey = 'return '; // If the function isnt of type void, return the al call value
				default:
			}

			final functionCodeContent:String = 
			'$longPointerName $alFuncName = ($longPointerName) alGetProcAddress("$alFuncName");
			${returnKey}$alFuncName(${argNames.join(', ')});
			';

			// Get functionCode metadata expr
			final baseExpr = macro
				@:functionCode($v{functionCodeContent})
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
				meta: [functionCodeMeta] // Import our metadata, this does the important shit c++ shit!
			};
			newFields.push(funcField);
        }

        return newFields;
    }
}