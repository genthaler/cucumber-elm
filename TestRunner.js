
(function() {
'use strict';

function F2(fun)
{
  function wrapper(a) { return function(b) { return fun(a,b); }; }
  wrapper.arity = 2;
  wrapper.func = fun;
  return wrapper;
}

function F3(fun)
{
  function wrapper(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  }
  wrapper.arity = 3;
  wrapper.func = fun;
  return wrapper;
}

function F4(fun)
{
  function wrapper(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  }
  wrapper.arity = 4;
  wrapper.func = fun;
  return wrapper;
}

function F5(fun)
{
  function wrapper(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  }
  wrapper.arity = 5;
  wrapper.func = fun;
  return wrapper;
}

function F6(fun)
{
  function wrapper(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  }
  wrapper.arity = 6;
  wrapper.func = fun;
  return wrapper;
}

function F7(fun)
{
  function wrapper(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  }
  wrapper.arity = 7;
  wrapper.func = fun;
  return wrapper;
}

function F8(fun)
{
  function wrapper(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  }
  wrapper.arity = 8;
  wrapper.func = fun;
  return wrapper;
}

function F9(fun)
{
  function wrapper(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  }
  wrapper.arity = 9;
  wrapper.func = fun;
  return wrapper;
}

function A2(fun, a, b)
{
  return fun.arity === 2
    ? fun.func(a, b)
    : fun(a)(b);
}
function A3(fun, a, b, c)
{
  return fun.arity === 3
    ? fun.func(a, b, c)
    : fun(a)(b)(c);
}
function A4(fun, a, b, c, d)
{
  return fun.arity === 4
    ? fun.func(a, b, c, d)
    : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e)
{
  return fun.arity === 5
    ? fun.func(a, b, c, d, e)
    : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f)
{
  return fun.arity === 6
    ? fun.func(a, b, c, d, e, f)
    : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g)
{
  return fun.arity === 7
    ? fun.func(a, b, c, d, e, f, g)
    : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h)
{
  return fun.arity === 8
    ? fun.func(a, b, c, d, e, f, g, h)
    : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i)
{
  return fun.arity === 9
    ? fun.func(a, b, c, d, e, f, g, h, i)
    : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}

//import Native.Utils //

var _elm_lang$core$Native_Basics = function() {

function div(a, b)
{
	return (a / b) | 0;
}
function rem(a, b)
{
	return a % b;
}
function mod(a, b)
{
	if (b === 0)
	{
		throw new Error('Cannot perform mod 0. Division by zero error.');
	}
	var r = a % b;
	var m = a === 0 ? 0 : (b > 0 ? (a >= 0 ? r : r + b) : -mod(-a, -b));

	return m === b ? 0 : m;
}
function logBase(base, n)
{
	return Math.log(n) / Math.log(base);
}
function negate(n)
{
	return -n;
}
function abs(n)
{
	return n < 0 ? -n : n;
}

function min(a, b)
{
	return _elm_lang$core$Native_Utils.cmp(a, b) < 0 ? a : b;
}
function max(a, b)
{
	return _elm_lang$core$Native_Utils.cmp(a, b) > 0 ? a : b;
}
function clamp(lo, hi, n)
{
	return _elm_lang$core$Native_Utils.cmp(n, lo) < 0
		? lo
		: _elm_lang$core$Native_Utils.cmp(n, hi) > 0
			? hi
			: n;
}

var ord = ['LT', 'EQ', 'GT'];

function compare(x, y)
{
	return { ctor: ord[_elm_lang$core$Native_Utils.cmp(x, y) + 1] };
}

function xor(a, b)
{
	return a !== b;
}
function not(b)
{
	return !b;
}
function isInfinite(n)
{
	return n === Infinity || n === -Infinity;
}

function truncate(n)
{
	return n | 0;
}

function degrees(d)
{
	return d * Math.PI / 180;
}
function turns(t)
{
	return 2 * Math.PI * t;
}
function fromPolar(point)
{
	var r = point._0;
	var t = point._1;
	return _elm_lang$core$Native_Utils.Tuple2(r * Math.cos(t), r * Math.sin(t));
}
function toPolar(point)
{
	var x = point._0;
	var y = point._1;
	return _elm_lang$core$Native_Utils.Tuple2(Math.sqrt(x * x + y * y), Math.atan2(y, x));
}

return {
	div: F2(div),
	rem: F2(rem),
	mod: F2(mod),

	pi: Math.PI,
	e: Math.E,
	cos: Math.cos,
	sin: Math.sin,
	tan: Math.tan,
	acos: Math.acos,
	asin: Math.asin,
	atan: Math.atan,
	atan2: F2(Math.atan2),

	degrees: degrees,
	turns: turns,
	fromPolar: fromPolar,
	toPolar: toPolar,

	sqrt: Math.sqrt,
	logBase: F2(logBase),
	negate: negate,
	abs: abs,
	min: F2(min),
	max: F2(max),
	clamp: F3(clamp),
	compare: F2(compare),

	xor: F2(xor),
	not: not,

	truncate: truncate,
	ceiling: Math.ceil,
	floor: Math.floor,
	round: Math.round,
	toFloat: function(x) { return x; },
	isNaN: isNaN,
	isInfinite: isInfinite
};

}();
//import //

var _elm_lang$core$Native_Utils = function() {

// COMPARISONS

function eq(rootX, rootY)
{
	var stack = [{ x: rootX, y: rootY }];
	while (stack.length > 0)
	{
		var front = stack.pop();
		var x = front.x;
		var y = front.y;
		if (x === y)
		{
			continue;
		}
		if (typeof x === 'object')
		{
			var c = 0;
			for (var key in x)
			{
				++c;
				if (!(key in y))
				{
					return false;
				}
				if (key === 'ctor')
				{
					continue;
				}
				stack.push({ x: x[key], y: y[key] });
			}
			if ('ctor' in x)
			{
				stack.push({ x: x.ctor, y: y.ctor});
			}
			if (c !== Object.keys(y).length)
			{
				return false;
			}
		}
		else if (typeof x === 'function')
		{
			throw new Error('Equality error: general function equality is ' +
							'undecidable, and therefore, unsupported');
		}
		else
		{
			return false;
		}
	}
	return true;
}

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

var LT = -1, EQ = 0, GT = 1;

function cmp(x, y)
{
	var ord;
	if (typeof x !== 'object')
	{
		return x === y ? EQ : x < y ? LT : GT;
	}
	else if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b
			? EQ
			: a < b
				? LT
				: GT;
	}
	else if (x.ctor === '::' || x.ctor === '[]')
	{
		while (true)
		{
			if (x.ctor === '[]' && y.ctor === '[]')
			{
				return EQ;
			}
			if (x.ctor !== y.ctor)
			{
				return x.ctor === '[]' ? LT : GT;
			}
			ord = cmp(x._0, y._0);
			if (ord !== EQ)
			{
				return ord;
			}
			x = x._1;
			y = y._1;
		}
	}
	else if (x.ctor.slice(0, 6) === '_Tuple')
	{
		var n = x.ctor.slice(6) - 0;
		var err = 'cannot compare tuples with more than 6 elements.';
		if (n === 0) return EQ;
		if (n >= 1) { ord = cmp(x._0, y._0); if (ord !== EQ) return ord;
		if (n >= 2) { ord = cmp(x._1, y._1); if (ord !== EQ) return ord;
		if (n >= 3) { ord = cmp(x._2, y._2); if (ord !== EQ) return ord;
		if (n >= 4) { ord = cmp(x._3, y._3); if (ord !== EQ) return ord;
		if (n >= 5) { ord = cmp(x._4, y._4); if (ord !== EQ) return ord;
		if (n >= 6) { ord = cmp(x._5, y._5); if (ord !== EQ) return ord;
		if (n >= 7) throw new Error('Comparison error: ' + err); } } } } } }
		return EQ;
	}
	else
	{
		throw new Error('Comparison error: comparison is only defined on ints, ' +
						'floats, times, chars, strings, lists of comparable values, ' +
						'and tuples of comparable values.');
	}
}


// COMMON VALUES

var Tuple0 = {
	ctor: '_Tuple0'
};

function Tuple2(x, y)
{
	return {
		ctor: '_Tuple2',
		_0: x,
		_1: y
	};
}

function chr(c)
{
	return new String(c);
}


// GUID

var count = 0;
function guid(_)
{
	return count++;
}


// RECORDS

function update(oldRecord, updatedFields)
{
	var newRecord = {};
	for (var key in oldRecord)
	{
		var value = (key in updatedFields) ? updatedFields[key] : oldRecord[key];
		newRecord[key] = value;
	}
	return newRecord;
}


//// LIST STUFF ////

var Nil = { ctor: '[]' };

function Cons(hd, tl)
{
	return {
		ctor: '::',
		_0: hd,
		_1: tl
	};
}

function append(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (xs.ctor === '[]')
	{
		return ys;
	}
	var root = Cons(xs._0, Nil);
	var curr = root;
	xs = xs._1;
	while (xs.ctor !== '[]')
	{
		curr._1 = Cons(xs._0, Nil);
		xs = xs._1;
		curr = curr._1;
	}
	curr._1 = ys;
	return root;
}


// CRASHES

function crash(moduleName, region)
{
	return function(message) {
		throw new Error(
			'Ran into a `Debug.crash` in module `' + moduleName + '` ' + regionToString(region) + '\n'
			+ 'The message provided by the code author is:\n\n    '
			+ message
		);
	};
}

function crashCase(moduleName, region, value)
{
	return function(message) {
		throw new Error(
			'Ran into a `Debug.crash` in module `' + moduleName + '`\n\n'
			+ 'This was caused by the `case` expression ' + regionToString(region) + '.\n'
			+ 'One of the branches ended with a crash and the following value got through:\n\n    ' + toString(value) + '\n\n'
			+ 'The message provided by the code author is:\n\n    '
			+ message
		);
	};
}

function regionToString(region)
{
	if (region.start.line == region.end.line)
	{
		return 'on line ' + region.start.line;
	}
	return 'between lines ' + region.start.line + ' and ' + region.end.line;
}


// TO STRING

function toString(v)
{
	var type = typeof v;
	if (type === 'function')
	{
		var name = v.func ? v.func.name : v.name;
		return '<function' + (name === '' ? '' : ':') + name + '>';
	}

	if (type === 'boolean')
	{
		return v ? 'True' : 'False';
	}

	if (type === 'number')
	{
		return v + '';
	}

	if (v instanceof String)
	{
		return '\'' + addSlashes(v, true) + '\'';
	}

	if (type === 'string')
	{
		return '"' + addSlashes(v, false) + '"';
	}

	if (v === null)
	{
		return 'null';
	}

	if (type === 'object' && 'ctor' in v)
	{
		var ctorStarter = v.ctor.substring(0, 5);

		if (ctorStarter === '_Tupl')
		{
			var output = [];
			for (var k in v)
			{
				if (k === 'ctor') continue;
				output.push(toString(v[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (ctorStarter === '_Task')
		{
			return '<task>'
		}

		if (v.ctor === '_Array')
		{
			var list = _elm_lang$core$Array$toList(v);
			return 'Array.fromList ' + toString(list);
		}

		if (v.ctor === '<decoder>')
		{
			return '<decoder>';
		}

		if (v.ctor === '_Process')
		{
			return '<process:' + v.id + '>';
		}

		if (v.ctor === '::')
		{
			var output = '[' + toString(v._0);
			v = v._1;
			while (v.ctor === '::')
			{
				output += ',' + toString(v._0);
				v = v._1;
			}
			return output + ']';
		}

		if (v.ctor === '[]')
		{
			return '[]';
		}

		if (v.ctor === 'RBNode_elm_builtin' || v.ctor === 'RBEmpty_elm_builtin' || v.ctor === 'Set_elm_builtin')
		{
			var name, list;
			if (v.ctor === 'Set_elm_builtin')
			{
				name = 'Set';
				list = A2(
					_elm_lang$core$List$map,
					function(x) {return x._0; },
					_elm_lang$core$Dict$toList(v._0)
				);
			}
			else
			{
				name = 'Dict';
				list = _elm_lang$core$Dict$toList(v);
			}
			return name + '.fromList ' + toString(list);
		}

		var output = '';
		for (var i in v)
		{
			if (i === 'ctor') continue;
			var str = toString(v[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return v.ctor + output;
	}

	if (type === 'object')
	{
		var output = [];
		for (var k in v)
		{
			output.push(k + ' = ' + toString(v[k]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return '<internal structure>';
}

function addSlashes(str, isChar)
{
	var s = str.replace(/\\/g, '\\\\')
			  .replace(/\n/g, '\\n')
			  .replace(/\t/g, '\\t')
			  .replace(/\r/g, '\\r')
			  .replace(/\v/g, '\\v')
			  .replace(/\0/g, '\\0');
	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}


return {
	eq: eq,
	cmp: cmp,
	Tuple0: Tuple0,
	Tuple2: Tuple2,
	chr: chr,
	update: update,
	guid: guid,

	append: F2(append),

	crash: crash,
	crashCase: crashCase,

	toString: toString
};

}();
var _elm_lang$core$Basics$uncurry = F2(
	function (f, _p0) {
		var _p1 = _p0;
		return A2(f, _p1._0, _p1._1);
	});
var _elm_lang$core$Basics$curry = F3(
	function (f, a, b) {
		return f(
			{ctor: '_Tuple2', _0: a, _1: b});
	});
var _elm_lang$core$Basics$flip = F3(
	function (f, b, a) {
		return A2(f, a, b);
	});
var _elm_lang$core$Basics$snd = function (_p2) {
	var _p3 = _p2;
	return _p3._1;
};
var _elm_lang$core$Basics$fst = function (_p4) {
	var _p5 = _p4;
	return _p5._0;
};
var _elm_lang$core$Basics$always = F2(
	function (a, _p6) {
		return a;
	});
var _elm_lang$core$Basics$identity = function (x) {
	return x;
};
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['<|'] = F2(
	function (f, x) {
		return f(x);
	});
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['|>'] = F2(
	function (x, f) {
		return f(x);
	});
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['>>'] = F3(
	function (f, g, x) {
		return g(
			f(x));
	});
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['<<'] = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['++'] = _elm_lang$core$Native_Utils.append;
var _elm_lang$core$Basics$toString = _elm_lang$core$Native_Utils.toString;
var _elm_lang$core$Basics$isInfinite = _elm_lang$core$Native_Basics.isInfinite;
var _elm_lang$core$Basics$isNaN = _elm_lang$core$Native_Basics.isNaN;
var _elm_lang$core$Basics$toFloat = _elm_lang$core$Native_Basics.toFloat;
var _elm_lang$core$Basics$ceiling = _elm_lang$core$Native_Basics.ceiling;
var _elm_lang$core$Basics$floor = _elm_lang$core$Native_Basics.floor;
var _elm_lang$core$Basics$truncate = _elm_lang$core$Native_Basics.truncate;
var _elm_lang$core$Basics$round = _elm_lang$core$Native_Basics.round;
var _elm_lang$core$Basics$not = _elm_lang$core$Native_Basics.not;
var _elm_lang$core$Basics$xor = _elm_lang$core$Native_Basics.xor;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['||'] = _elm_lang$core$Native_Basics.or;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['&&'] = _elm_lang$core$Native_Basics.and;
var _elm_lang$core$Basics$max = _elm_lang$core$Native_Basics.max;
var _elm_lang$core$Basics$min = _elm_lang$core$Native_Basics.min;
var _elm_lang$core$Basics$compare = _elm_lang$core$Native_Basics.compare;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['>='] = _elm_lang$core$Native_Basics.ge;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['<='] = _elm_lang$core$Native_Basics.le;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['>'] = _elm_lang$core$Native_Basics.gt;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['<'] = _elm_lang$core$Native_Basics.lt;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['/='] = _elm_lang$core$Native_Basics.neq;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['=='] = _elm_lang$core$Native_Basics.eq;
var _elm_lang$core$Basics$e = _elm_lang$core$Native_Basics.e;
var _elm_lang$core$Basics$pi = _elm_lang$core$Native_Basics.pi;
var _elm_lang$core$Basics$clamp = _elm_lang$core$Native_Basics.clamp;
var _elm_lang$core$Basics$logBase = _elm_lang$core$Native_Basics.logBase;
var _elm_lang$core$Basics$abs = _elm_lang$core$Native_Basics.abs;
var _elm_lang$core$Basics$negate = _elm_lang$core$Native_Basics.negate;
var _elm_lang$core$Basics$sqrt = _elm_lang$core$Native_Basics.sqrt;
var _elm_lang$core$Basics$atan2 = _elm_lang$core$Native_Basics.atan2;
var _elm_lang$core$Basics$atan = _elm_lang$core$Native_Basics.atan;
var _elm_lang$core$Basics$asin = _elm_lang$core$Native_Basics.asin;
var _elm_lang$core$Basics$acos = _elm_lang$core$Native_Basics.acos;
var _elm_lang$core$Basics$tan = _elm_lang$core$Native_Basics.tan;
var _elm_lang$core$Basics$sin = _elm_lang$core$Native_Basics.sin;
var _elm_lang$core$Basics$cos = _elm_lang$core$Native_Basics.cos;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['^'] = _elm_lang$core$Native_Basics.exp;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['%'] = _elm_lang$core$Native_Basics.mod;
var _elm_lang$core$Basics$rem = _elm_lang$core$Native_Basics.rem;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['//'] = _elm_lang$core$Native_Basics.div;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['/'] = _elm_lang$core$Native_Basics.floatDiv;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['*'] = _elm_lang$core$Native_Basics.mul;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['-'] = _elm_lang$core$Native_Basics.sub;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['+'] = _elm_lang$core$Native_Basics.add;
var _elm_lang$core$Basics$toPolar = _elm_lang$core$Native_Basics.toPolar;
var _elm_lang$core$Basics$fromPolar = _elm_lang$core$Native_Basics.fromPolar;
var _elm_lang$core$Basics$turns = _elm_lang$core$Native_Basics.turns;
var _elm_lang$core$Basics$degrees = _elm_lang$core$Native_Basics.degrees;
var _elm_lang$core$Basics$radians = function (t) {
	return t;
};
var _elm_lang$core$Basics$GT = {ctor: 'GT'};
var _elm_lang$core$Basics$EQ = {ctor: 'EQ'};
var _elm_lang$core$Basics$LT = {ctor: 'LT'};
var _elm_lang$core$Basics$Never = function (a) {
	return {ctor: 'Never', _0: a};
};

//import Native.Utils //

var _elm_lang$core$Native_Debug = function() {

function log(tag, value)
{
	var msg = tag + ': ' + _elm_lang$core$Native_Utils.toString(value);
	var process = process || {};
	if (process.stdout)
	{
		process.stdout.write(msg);
	}
	else
	{
		console.log(msg);
	}
	return value;
}

function crash(message)
{
	throw new Error(message);
}

return {
	crash: crash,
	log: F2(log)
};

}();
var _elm_lang$core$Debug$crash = _elm_lang$core$Native_Debug.crash;
var _elm_lang$core$Debug$log = _elm_lang$core$Native_Debug.log;

var _elm_lang$core$Maybe$withDefault = F2(
	function ($default, maybe) {
		var _p0 = maybe;
		if (_p0.ctor === 'Just') {
			return _p0._0;
		} else {
			return $default;
		}
	});
var _elm_lang$core$Maybe$Nothing = {ctor: 'Nothing'};
var _elm_lang$core$Maybe$oneOf = function (maybes) {
	oneOf:
	while (true) {
		var _p1 = maybes;
		if (_p1.ctor === '[]') {
			return _elm_lang$core$Maybe$Nothing;
		} else {
			var _p3 = _p1._0;
			var _p2 = _p3;
			if (_p2.ctor === 'Nothing') {
				var _v3 = _p1._1;
				maybes = _v3;
				continue oneOf;
			} else {
				return _p3;
			}
		}
	}
};
var _elm_lang$core$Maybe$andThen = F2(
	function (maybeValue, callback) {
		var _p4 = maybeValue;
		if (_p4.ctor === 'Just') {
			return callback(_p4._0);
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_lang$core$Maybe$Just = function (a) {
	return {ctor: 'Just', _0: a};
};
var _elm_lang$core$Maybe$map = F2(
	function (f, maybe) {
		var _p5 = maybe;
		if (_p5.ctor === 'Just') {
			return _elm_lang$core$Maybe$Just(
				f(_p5._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_lang$core$Maybe$map2 = F3(
	function (func, ma, mb) {
		var _p6 = {ctor: '_Tuple2', _0: ma, _1: mb};
		if (((_p6.ctor === '_Tuple2') && (_p6._0.ctor === 'Just')) && (_p6._1.ctor === 'Just')) {
			return _elm_lang$core$Maybe$Just(
				A2(func, _p6._0._0, _p6._1._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_lang$core$Maybe$map3 = F4(
	function (func, ma, mb, mc) {
		var _p7 = {ctor: '_Tuple3', _0: ma, _1: mb, _2: mc};
		if ((((_p7.ctor === '_Tuple3') && (_p7._0.ctor === 'Just')) && (_p7._1.ctor === 'Just')) && (_p7._2.ctor === 'Just')) {
			return _elm_lang$core$Maybe$Just(
				A3(func, _p7._0._0, _p7._1._0, _p7._2._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_lang$core$Maybe$map4 = F5(
	function (func, ma, mb, mc, md) {
		var _p8 = {ctor: '_Tuple4', _0: ma, _1: mb, _2: mc, _3: md};
		if (((((_p8.ctor === '_Tuple4') && (_p8._0.ctor === 'Just')) && (_p8._1.ctor === 'Just')) && (_p8._2.ctor === 'Just')) && (_p8._3.ctor === 'Just')) {
			return _elm_lang$core$Maybe$Just(
				A4(func, _p8._0._0, _p8._1._0, _p8._2._0, _p8._3._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_lang$core$Maybe$map5 = F6(
	function (func, ma, mb, mc, md, me) {
		var _p9 = {ctor: '_Tuple5', _0: ma, _1: mb, _2: mc, _3: md, _4: me};
		if ((((((_p9.ctor === '_Tuple5') && (_p9._0.ctor === 'Just')) && (_p9._1.ctor === 'Just')) && (_p9._2.ctor === 'Just')) && (_p9._3.ctor === 'Just')) && (_p9._4.ctor === 'Just')) {
			return _elm_lang$core$Maybe$Just(
				A5(func, _p9._0._0, _p9._1._0, _p9._2._0, _p9._3._0, _p9._4._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});

//import Native.Utils //

var _elm_lang$core$Native_List = function() {

var Nil = { ctor: '[]' };

function Cons(hd, tl)
{
	return { ctor: '::', _0: hd, _1: tl };
}

function fromArray(arr)
{
	var out = Nil;
	for (var i = arr.length; i--; )
	{
		out = Cons(arr[i], out);
	}
	return out;
}

function toArray(xs)
{
	var out = [];
	while (xs.ctor !== '[]')
	{
		out.push(xs._0);
		xs = xs._1;
	}
	return out;
}


function range(lo, hi)
{
	var list = Nil;
	if (lo <= hi)
	{
		do
		{
			list = Cons(hi, list);
		}
		while (hi-- > lo);
	}
	return list;
}

function foldr(f, b, xs)
{
	var arr = toArray(xs);
	var acc = b;
	for (var i = arr.length; i--; )
	{
		acc = A2(f, arr[i], acc);
	}
	return acc;
}

function map2(f, xs, ys)
{
	var arr = [];
	while (xs.ctor !== '[]' && ys.ctor !== '[]')
	{
		arr.push(A2(f, xs._0, ys._0));
		xs = xs._1;
		ys = ys._1;
	}
	return fromArray(arr);
}

function map3(f, xs, ys, zs)
{
	var arr = [];
	while (xs.ctor !== '[]' && ys.ctor !== '[]' && zs.ctor !== '[]')
	{
		arr.push(A3(f, xs._0, ys._0, zs._0));
		xs = xs._1;
		ys = ys._1;
		zs = zs._1;
	}
	return fromArray(arr);
}

function map4(f, ws, xs, ys, zs)
{
	var arr = [];
	while (   ws.ctor !== '[]'
		   && xs.ctor !== '[]'
		   && ys.ctor !== '[]'
		   && zs.ctor !== '[]')
	{
		arr.push(A4(f, ws._0, xs._0, ys._0, zs._0));
		ws = ws._1;
		xs = xs._1;
		ys = ys._1;
		zs = zs._1;
	}
	return fromArray(arr);
}

function map5(f, vs, ws, xs, ys, zs)
{
	var arr = [];
	while (   vs.ctor !== '[]'
		   && ws.ctor !== '[]'
		   && xs.ctor !== '[]'
		   && ys.ctor !== '[]'
		   && zs.ctor !== '[]')
	{
		arr.push(A5(f, vs._0, ws._0, xs._0, ys._0, zs._0));
		vs = vs._1;
		ws = ws._1;
		xs = xs._1;
		ys = ys._1;
		zs = zs._1;
	}
	return fromArray(arr);
}

function sortBy(f, xs)
{
	return fromArray(toArray(xs).sort(function(a, b) {
		return _elm_lang$core$Native_Utils.cmp(f(a), f(b));
	}));
}

function sortWith(f, xs)
{
	return fromArray(toArray(xs).sort(function(a, b) {
		var ord = f(a)(b).ctor;
		return ord === 'EQ' ? 0 : ord === 'LT' ? -1 : 1;
	}));
}

return {
	Nil: Nil,
	Cons: Cons,
	cons: F2(Cons),
	toArray: toArray,
	fromArray: fromArray,
	range: range,

	foldr: F3(foldr),

	map2: F3(map2),
	map3: F4(map3),
	map4: F5(map4),
	map5: F6(map5),
	sortBy: F2(sortBy),
	sortWith: F2(sortWith)
};

}();
var _elm_lang$core$List$sortWith = _elm_lang$core$Native_List.sortWith;
var _elm_lang$core$List$sortBy = _elm_lang$core$Native_List.sortBy;
var _elm_lang$core$List$sort = function (xs) {
	return A2(_elm_lang$core$List$sortBy, _elm_lang$core$Basics$identity, xs);
};
var _elm_lang$core$List$drop = F2(
	function (n, list) {
		drop:
		while (true) {
			if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
				return list;
			} else {
				var _p0 = list;
				if (_p0.ctor === '[]') {
					return list;
				} else {
					var _v1 = n - 1,
						_v2 = _p0._1;
					n = _v1;
					list = _v2;
					continue drop;
				}
			}
		}
	});
var _elm_lang$core$List$map5 = _elm_lang$core$Native_List.map5;
var _elm_lang$core$List$map4 = _elm_lang$core$Native_List.map4;
var _elm_lang$core$List$map3 = _elm_lang$core$Native_List.map3;
var _elm_lang$core$List$map2 = _elm_lang$core$Native_List.map2;
var _elm_lang$core$List$any = F2(
	function (isOkay, list) {
		any:
		while (true) {
			var _p1 = list;
			if (_p1.ctor === '[]') {
				return false;
			} else {
				if (isOkay(_p1._0)) {
					return true;
				} else {
					var _v4 = isOkay,
						_v5 = _p1._1;
					isOkay = _v4;
					list = _v5;
					continue any;
				}
			}
		}
	});
var _elm_lang$core$List$all = F2(
	function (isOkay, list) {
		return _elm_lang$core$Basics$not(
			A2(
				_elm_lang$core$List$any,
				function (_p2) {
					return _elm_lang$core$Basics$not(
						isOkay(_p2));
				},
				list));
	});
var _elm_lang$core$List$foldr = _elm_lang$core$Native_List.foldr;
var _elm_lang$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			var _p3 = list;
			if (_p3.ctor === '[]') {
				return acc;
			} else {
				var _v7 = func,
					_v8 = A2(func, _p3._0, acc),
					_v9 = _p3._1;
				func = _v7;
				acc = _v8;
				list = _v9;
				continue foldl;
			}
		}
	});
var _elm_lang$core$List$length = function (xs) {
	return A3(
		_elm_lang$core$List$foldl,
		F2(
			function (_p4, i) {
				return i + 1;
			}),
		0,
		xs);
};
var _elm_lang$core$List$sum = function (numbers) {
	return A3(
		_elm_lang$core$List$foldl,
		F2(
			function (x, y) {
				return x + y;
			}),
		0,
		numbers);
};
var _elm_lang$core$List$product = function (numbers) {
	return A3(
		_elm_lang$core$List$foldl,
		F2(
			function (x, y) {
				return x * y;
			}),
		1,
		numbers);
};
var _elm_lang$core$List$maximum = function (list) {
	var _p5 = list;
	if (_p5.ctor === '::') {
		return _elm_lang$core$Maybe$Just(
			A3(_elm_lang$core$List$foldl, _elm_lang$core$Basics$max, _p5._0, _p5._1));
	} else {
		return _elm_lang$core$Maybe$Nothing;
	}
};
var _elm_lang$core$List$minimum = function (list) {
	var _p6 = list;
	if (_p6.ctor === '::') {
		return _elm_lang$core$Maybe$Just(
			A3(_elm_lang$core$List$foldl, _elm_lang$core$Basics$min, _p6._0, _p6._1));
	} else {
		return _elm_lang$core$Maybe$Nothing;
	}
};
var _elm_lang$core$List$indexedMap = F2(
	function (f, xs) {
		return A3(
			_elm_lang$core$List$map2,
			f,
			_elm_lang$core$Native_List.range(
				0,
				_elm_lang$core$List$length(xs) - 1),
			xs);
	});
var _elm_lang$core$List$member = F2(
	function (x, xs) {
		return A2(
			_elm_lang$core$List$any,
			function (a) {
				return _elm_lang$core$Native_Utils.eq(a, x);
			},
			xs);
	});
var _elm_lang$core$List$isEmpty = function (xs) {
	var _p7 = xs;
	if (_p7.ctor === '[]') {
		return true;
	} else {
		return false;
	}
};
var _elm_lang$core$List$tail = function (list) {
	var _p8 = list;
	if (_p8.ctor === '::') {
		return _elm_lang$core$Maybe$Just(_p8._1);
	} else {
		return _elm_lang$core$Maybe$Nothing;
	}
};
var _elm_lang$core$List$head = function (list) {
	var _p9 = list;
	if (_p9.ctor === '::') {
		return _elm_lang$core$Maybe$Just(_p9._0);
	} else {
		return _elm_lang$core$Maybe$Nothing;
	}
};
var _elm_lang$core$List_ops = _elm_lang$core$List_ops || {};
_elm_lang$core$List_ops['::'] = _elm_lang$core$Native_List.cons;
var _elm_lang$core$List$map = F2(
	function (f, xs) {
		return A3(
			_elm_lang$core$List$foldr,
			F2(
				function (x, acc) {
					return A2(
						_elm_lang$core$List_ops['::'],
						f(x),
						acc);
				}),
			_elm_lang$core$Native_List.fromArray(
				[]),
			xs);
	});
var _elm_lang$core$List$filter = F2(
	function (pred, xs) {
		var conditionalCons = F2(
			function (x, xs$) {
				return pred(x) ? A2(_elm_lang$core$List_ops['::'], x, xs$) : xs$;
			});
		return A3(
			_elm_lang$core$List$foldr,
			conditionalCons,
			_elm_lang$core$Native_List.fromArray(
				[]),
			xs);
	});
var _elm_lang$core$List$maybeCons = F3(
	function (f, mx, xs) {
		var _p10 = f(mx);
		if (_p10.ctor === 'Just') {
			return A2(_elm_lang$core$List_ops['::'], _p10._0, xs);
		} else {
			return xs;
		}
	});
var _elm_lang$core$List$filterMap = F2(
	function (f, xs) {
		return A3(
			_elm_lang$core$List$foldr,
			_elm_lang$core$List$maybeCons(f),
			_elm_lang$core$Native_List.fromArray(
				[]),
			xs);
	});
var _elm_lang$core$List$reverse = function (list) {
	return A3(
		_elm_lang$core$List$foldl,
		F2(
			function (x, y) {
				return A2(_elm_lang$core$List_ops['::'], x, y);
			}),
		_elm_lang$core$Native_List.fromArray(
			[]),
		list);
};
var _elm_lang$core$List$scanl = F3(
	function (f, b, xs) {
		var scan1 = F2(
			function (x, accAcc) {
				var _p11 = accAcc;
				if (_p11.ctor === '::') {
					return A2(
						_elm_lang$core$List_ops['::'],
						A2(f, x, _p11._0),
						accAcc);
				} else {
					return _elm_lang$core$Native_List.fromArray(
						[]);
				}
			});
		return _elm_lang$core$List$reverse(
			A3(
				_elm_lang$core$List$foldl,
				scan1,
				_elm_lang$core$Native_List.fromArray(
					[b]),
				xs));
	});
var _elm_lang$core$List$append = F2(
	function (xs, ys) {
		var _p12 = ys;
		if (_p12.ctor === '[]') {
			return xs;
		} else {
			return A3(
				_elm_lang$core$List$foldr,
				F2(
					function (x, y) {
						return A2(_elm_lang$core$List_ops['::'], x, y);
					}),
				ys,
				xs);
		}
	});
var _elm_lang$core$List$concat = function (lists) {
	return A3(
		_elm_lang$core$List$foldr,
		_elm_lang$core$List$append,
		_elm_lang$core$Native_List.fromArray(
			[]),
		lists);
};
var _elm_lang$core$List$concatMap = F2(
	function (f, list) {
		return _elm_lang$core$List$concat(
			A2(_elm_lang$core$List$map, f, list));
	});
var _elm_lang$core$List$partition = F2(
	function (pred, list) {
		var step = F2(
			function (x, _p13) {
				var _p14 = _p13;
				var _p16 = _p14._0;
				var _p15 = _p14._1;
				return pred(x) ? {
					ctor: '_Tuple2',
					_0: A2(_elm_lang$core$List_ops['::'], x, _p16),
					_1: _p15
				} : {
					ctor: '_Tuple2',
					_0: _p16,
					_1: A2(_elm_lang$core$List_ops['::'], x, _p15)
				};
			});
		return A3(
			_elm_lang$core$List$foldr,
			step,
			{
				ctor: '_Tuple2',
				_0: _elm_lang$core$Native_List.fromArray(
					[]),
				_1: _elm_lang$core$Native_List.fromArray(
					[])
			},
			list);
	});
var _elm_lang$core$List$unzip = function (pairs) {
	var step = F2(
		function (_p18, _p17) {
			var _p19 = _p18;
			var _p20 = _p17;
			return {
				ctor: '_Tuple2',
				_0: A2(_elm_lang$core$List_ops['::'], _p19._0, _p20._0),
				_1: A2(_elm_lang$core$List_ops['::'], _p19._1, _p20._1)
			};
		});
	return A3(
		_elm_lang$core$List$foldr,
		step,
		{
			ctor: '_Tuple2',
			_0: _elm_lang$core$Native_List.fromArray(
				[]),
			_1: _elm_lang$core$Native_List.fromArray(
				[])
		},
		pairs);
};
var _elm_lang$core$List$intersperse = F2(
	function (sep, xs) {
		var _p21 = xs;
		if (_p21.ctor === '[]') {
			return _elm_lang$core$Native_List.fromArray(
				[]);
		} else {
			var step = F2(
				function (x, rest) {
					return A2(
						_elm_lang$core$List_ops['::'],
						sep,
						A2(_elm_lang$core$List_ops['::'], x, rest));
				});
			var spersed = A3(
				_elm_lang$core$List$foldr,
				step,
				_elm_lang$core$Native_List.fromArray(
					[]),
				_p21._1);
			return A2(_elm_lang$core$List_ops['::'], _p21._0, spersed);
		}
	});
var _elm_lang$core$List$take = F2(
	function (n, list) {
		if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
			return _elm_lang$core$Native_List.fromArray(
				[]);
		} else {
			var _p22 = list;
			if (_p22.ctor === '[]') {
				return list;
			} else {
				return A2(
					_elm_lang$core$List_ops['::'],
					_p22._0,
					A2(_elm_lang$core$List$take, n - 1, _p22._1));
			}
		}
	});
var _elm_lang$core$List$repeatHelp = F3(
	function (result, n, value) {
		repeatHelp:
		while (true) {
			if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
				return result;
			} else {
				var _v23 = A2(_elm_lang$core$List_ops['::'], value, result),
					_v24 = n - 1,
					_v25 = value;
				result = _v23;
				n = _v24;
				value = _v25;
				continue repeatHelp;
			}
		}
	});
var _elm_lang$core$List$repeat = F2(
	function (n, value) {
		return A3(
			_elm_lang$core$List$repeatHelp,
			_elm_lang$core$Native_List.fromArray(
				[]),
			n,
			value);
	});

var _elm_lang$core$Result$toMaybe = function (result) {
	var _p0 = result;
	if (_p0.ctor === 'Ok') {
		return _elm_lang$core$Maybe$Just(_p0._0);
	} else {
		return _elm_lang$core$Maybe$Nothing;
	}
};
var _elm_lang$core$Result$withDefault = F2(
	function (def, result) {
		var _p1 = result;
		if (_p1.ctor === 'Ok') {
			return _p1._0;
		} else {
			return def;
		}
	});
var _elm_lang$core$Result$Err = function (a) {
	return {ctor: 'Err', _0: a};
};
var _elm_lang$core$Result$andThen = F2(
	function (result, callback) {
		var _p2 = result;
		if (_p2.ctor === 'Ok') {
			return callback(_p2._0);
		} else {
			return _elm_lang$core$Result$Err(_p2._0);
		}
	});
var _elm_lang$core$Result$Ok = function (a) {
	return {ctor: 'Ok', _0: a};
};
var _elm_lang$core$Result$map = F2(
	function (func, ra) {
		var _p3 = ra;
		if (_p3.ctor === 'Ok') {
			return _elm_lang$core$Result$Ok(
				func(_p3._0));
		} else {
			return _elm_lang$core$Result$Err(_p3._0);
		}
	});
var _elm_lang$core$Result$map2 = F3(
	function (func, ra, rb) {
		var _p4 = {ctor: '_Tuple2', _0: ra, _1: rb};
		if (_p4._0.ctor === 'Ok') {
			if (_p4._1.ctor === 'Ok') {
				return _elm_lang$core$Result$Ok(
					A2(func, _p4._0._0, _p4._1._0));
			} else {
				return _elm_lang$core$Result$Err(_p4._1._0);
			}
		} else {
			return _elm_lang$core$Result$Err(_p4._0._0);
		}
	});
var _elm_lang$core$Result$map3 = F4(
	function (func, ra, rb, rc) {
		var _p5 = {ctor: '_Tuple3', _0: ra, _1: rb, _2: rc};
		if (_p5._0.ctor === 'Ok') {
			if (_p5._1.ctor === 'Ok') {
				if (_p5._2.ctor === 'Ok') {
					return _elm_lang$core$Result$Ok(
						A3(func, _p5._0._0, _p5._1._0, _p5._2._0));
				} else {
					return _elm_lang$core$Result$Err(_p5._2._0);
				}
			} else {
				return _elm_lang$core$Result$Err(_p5._1._0);
			}
		} else {
			return _elm_lang$core$Result$Err(_p5._0._0);
		}
	});
var _elm_lang$core$Result$map4 = F5(
	function (func, ra, rb, rc, rd) {
		var _p6 = {ctor: '_Tuple4', _0: ra, _1: rb, _2: rc, _3: rd};
		if (_p6._0.ctor === 'Ok') {
			if (_p6._1.ctor === 'Ok') {
				if (_p6._2.ctor === 'Ok') {
					if (_p6._3.ctor === 'Ok') {
						return _elm_lang$core$Result$Ok(
							A4(func, _p6._0._0, _p6._1._0, _p6._2._0, _p6._3._0));
					} else {
						return _elm_lang$core$Result$Err(_p6._3._0);
					}
				} else {
					return _elm_lang$core$Result$Err(_p6._2._0);
				}
			} else {
				return _elm_lang$core$Result$Err(_p6._1._0);
			}
		} else {
			return _elm_lang$core$Result$Err(_p6._0._0);
		}
	});
var _elm_lang$core$Result$map5 = F6(
	function (func, ra, rb, rc, rd, re) {
		var _p7 = {ctor: '_Tuple5', _0: ra, _1: rb, _2: rc, _3: rd, _4: re};
		if (_p7._0.ctor === 'Ok') {
			if (_p7._1.ctor === 'Ok') {
				if (_p7._2.ctor === 'Ok') {
					if (_p7._3.ctor === 'Ok') {
						if (_p7._4.ctor === 'Ok') {
							return _elm_lang$core$Result$Ok(
								A5(func, _p7._0._0, _p7._1._0, _p7._2._0, _p7._3._0, _p7._4._0));
						} else {
							return _elm_lang$core$Result$Err(_p7._4._0);
						}
					} else {
						return _elm_lang$core$Result$Err(_p7._3._0);
					}
				} else {
					return _elm_lang$core$Result$Err(_p7._2._0);
				}
			} else {
				return _elm_lang$core$Result$Err(_p7._1._0);
			}
		} else {
			return _elm_lang$core$Result$Err(_p7._0._0);
		}
	});
var _elm_lang$core$Result$formatError = F2(
	function (f, result) {
		var _p8 = result;
		if (_p8.ctor === 'Ok') {
			return _elm_lang$core$Result$Ok(_p8._0);
		} else {
			return _elm_lang$core$Result$Err(
				f(_p8._0));
		}
	});
var _elm_lang$core$Result$fromMaybe = F2(
	function (err, maybe) {
		var _p9 = maybe;
		if (_p9.ctor === 'Just') {
			return _elm_lang$core$Result$Ok(_p9._0);
		} else {
			return _elm_lang$core$Result$Err(err);
		}
	});

//import //

var _elm_lang$core$Native_Platform = function() {


// PROGRAMS

function addPublicModule(object, name, main)
{
	var init = main ? makeEmbed(name, main) : mainIsUndefined(name);

	object['worker'] = function worker(flags)
	{
		return init(undefined, flags, false);
	}

	object['embed'] = function embed(domNode, flags)
	{
		return init(domNode, flags, true);
	}

	object['fullscreen'] = function fullscreen(flags)
	{
		return init(document.body, flags, true);
	};
}


// PROGRAM FAIL

function mainIsUndefined(name)
{
	return function(domNode)
	{
		var message = 'Cannot initialize module `' + name +
			'` because it has no `main` value!\nWhat should I show on screen?';
		domNode.innerHTML = errorHtml(message);
		throw new Error(message);
	};
}

function errorHtml(message)
{
	return '<div style="padding-left:1em;">'
		+ '<h2 style="font-weight:normal;"><b>Oops!</b> Something went wrong when starting your Elm program.</h2>'
		+ '<pre style="padding-left:1em;">' + message + '</pre>'
		+ '</div>';
}


// PROGRAM SUCCESS

function makeEmbed(moduleName, main)
{
	return function embed(rootDomNode, flags, withRenderer)
	{
		try
		{
			var program = mainToProgram(moduleName, main);
			if (!withRenderer)
			{
				program.renderer = dummyRenderer;
			}
			return makeEmbedHelp(moduleName, program, rootDomNode, flags);
		}
		catch (e)
		{
			rootDomNode.innerHTML = errorHtml(e.message);
			throw e;
		}
	};
}

function dummyRenderer()
{
	return { update: function() {} };
}


// MAIN TO PROGRAM

function mainToProgram(moduleName, wrappedMain)
{
	var main = wrappedMain.main;

	if (typeof main.init === 'undefined')
	{
		var emptyBag = batch(_elm_lang$core$Native_List.Nil);
		var noChange = _elm_lang$core$Native_Utils.Tuple2(
			_elm_lang$core$Native_Utils.Tuple0,
			emptyBag
		);

		return _elm_lang$virtual_dom$VirtualDom$programWithFlags({
			init: function() { return noChange; },
			view: function() { return main; },
			update: F2(function() { return noChange; }),
			subscriptions: function () { return emptyBag; }
		});
	}

	var flags = wrappedMain.flags;
	var init = flags
		? initWithFlags(moduleName, main.init, flags)
		: initWithoutFlags(moduleName, main.init);

	return _elm_lang$virtual_dom$VirtualDom$programWithFlags({
		init: init,
		view: main.view,
		update: main.update,
		subscriptions: main.subscriptions,
	});
}

function initWithoutFlags(moduleName, realInit)
{
	return function init(flags)
	{
		if (typeof flags !== 'undefined')
		{
			throw new Error(
				'You are giving module `' + moduleName + '` an argument in JavaScript.\n'
				+ 'This module does not take arguments though! You probably need to change the\n'
				+ 'initialization code to something like `Elm.' + moduleName + '.fullscreen()`'
			);
		}
		return realInit();
	};
}

function initWithFlags(moduleName, realInit, flagDecoder)
{
	return function init(flags)
	{
		var result = A2(_elm_lang$core$Native_Json.run, flagDecoder, flags);
		if (result.ctor === 'Err')
		{
			throw new Error(
				'You are trying to initialize module `' + moduleName + '` with an unexpected argument.\n'
				+ 'When trying to convert it to a usable Elm value, I run into this problem:\n\n'
				+ result._0
			);
		}
		return realInit(result._0);
	};
}


// SETUP RUNTIME SYSTEM

function makeEmbedHelp(moduleName, program, rootDomNode, flags)
{
	var init = program.init;
	var update = program.update;
	var subscriptions = program.subscriptions;
	var view = program.view;
	var makeRenderer = program.renderer;

	// ambient state
	var managers = {};
	var renderer;

	// init and update state in main process
	var initApp = _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
		var results = init(flags);
		var model = results._0;
		renderer = makeRenderer(rootDomNode, enqueue, view(model));
		var cmds = results._1;
		var subs = subscriptions(model);
		dispatchEffects(managers, cmds, subs);
		callback(_elm_lang$core$Native_Scheduler.succeed(model));
	});

	function onMessage(msg, model)
	{
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
			var results = A2(update, msg, model);
			model = results._0;
			renderer.update(view(model));
			var cmds = results._1;
			var subs = subscriptions(model);
			dispatchEffects(managers, cmds, subs);
			callback(_elm_lang$core$Native_Scheduler.succeed(model));
		});
	}

	var mainProcess = spawnLoop(initApp, onMessage);

	function enqueue(msg)
	{
		_elm_lang$core$Native_Scheduler.rawSend(mainProcess, msg);
	}

	var ports = setupEffects(managers, enqueue);

	return ports ? { ports: ports } : {};
}


// EFFECT MANAGERS

var effectManagers = {};

function setupEffects(managers, callback)
{
	var ports;

	// setup all necessary effect managers
	for (var key in effectManagers)
	{
		var manager = effectManagers[key];

		if (manager.isForeign)
		{
			ports = ports || {};
			ports[key] = manager.tag === 'cmd'
				? setupOutgoingPort(key)
				: setupIncomingPort(key, callback);
		}

		managers[key] = makeManager(manager, callback);
	}

	return ports;
}

function makeManager(info, callback)
{
	var router = {
		main: callback,
		self: undefined
	};

	var tag = info.tag;
	var onEffects = info.onEffects;
	var onSelfMsg = info.onSelfMsg;

	function onMessage(msg, state)
	{
		if (msg.ctor === 'self')
		{
			return A3(onSelfMsg, router, msg._0, state);
		}

		var fx = msg._0;
		switch (tag)
		{
			case 'cmd':
				return A3(onEffects, router, fx.cmds, state);

			case 'sub':
				return A3(onEffects, router, fx.subs, state);

			case 'fx':
				return A4(onEffects, router, fx.cmds, fx.subs, state);
		}
	}

	var process = spawnLoop(info.init, onMessage);
	router.self = process;
	return process;
}

function sendToApp(router, msg)
{
	return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
	{
		router.main(msg);
		callback(_elm_lang$core$Native_Scheduler.succeed(_elm_lang$core$Native_Utils.Tuple0));
	});
}

function sendToSelf(router, msg)
{
	return A2(_elm_lang$core$Native_Scheduler.send, router.self, {
		ctor: 'self',
		_0: msg
	});
}


// HELPER for STATEFUL LOOPS

function spawnLoop(init, onMessage)
{
	var andThen = _elm_lang$core$Native_Scheduler.andThen;

	function loop(state)
	{
		var handleMsg = _elm_lang$core$Native_Scheduler.receive(function(msg) {
			return onMessage(msg, state);
		});
		return A2(andThen, handleMsg, loop);
	}

	var task = A2(andThen, init, loop);

	return _elm_lang$core$Native_Scheduler.rawSpawn(task);
}


// BAGS

function leaf(home)
{
	return function(value)
	{
		return {
			type: 'leaf',
			home: home,
			value: value
		};
	};
}

function batch(list)
{
	return {
		type: 'node',
		branches: list
	};
}

function map(tagger, bag)
{
	return {
		type: 'map',
		tagger: tagger,
		tree: bag
	}
}


// PIPE BAGS INTO EFFECT MANAGERS

function dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	gatherEffects(true, cmdBag, effectsDict, null);
	gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		var fx = home in effectsDict
			? effectsDict[home]
			: {
				cmds: _elm_lang$core$Native_List.Nil,
				subs: _elm_lang$core$Native_List.Nil
			};

		_elm_lang$core$Native_Scheduler.rawSend(managers[home], { ctor: 'fx', _0: fx });
	}
}

function gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.type)
	{
		case 'leaf':
			var home = bag.home;
			var effect = toEffect(isCmd, home, taggers, bag.value);
			effectsDict[home] = insert(isCmd, effect, effectsDict[home]);
			return;

		case 'node':
			var list = bag.branches;
			while (list.ctor !== '[]')
			{
				gatherEffects(isCmd, list._0, effectsDict, taggers);
				list = list._1;
			}
			return;

		case 'map':
			gatherEffects(isCmd, bag.tree, effectsDict, {
				tagger: bag.tagger,
				rest: taggers
			});
			return;
	}
}

function toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		var temp = taggers;
		while (temp)
		{
			x = temp.tagger(x);
			temp = temp.rest;
		}
		return x;
	}

	var map = isCmd
		? effectManagers[home].cmdMap
		: effectManagers[home].subMap;

	return A2(map, applyTaggers, value)
}

function insert(isCmd, newEffect, effects)
{
	effects = effects || {
		cmds: _elm_lang$core$Native_List.Nil,
		subs: _elm_lang$core$Native_List.Nil
	};
	if (isCmd)
	{
		effects.cmds = _elm_lang$core$Native_List.Cons(newEffect, effects.cmds);
		return effects;
	}
	effects.subs = _elm_lang$core$Native_List.Cons(newEffect, effects.subs);
	return effects;
}


// PORTS

function checkPortName(name)
{
	if (name in effectManagers)
	{
		throw new Error('There can only be one port named `' + name + '`, but your program has multiple.');
	}
}


// OUTGOING PORTS

function outgoingPort(name, converter)
{
	checkPortName(name);
	effectManagers[name] = {
		tag: 'cmd',
		cmdMap: outgoingPortMap,
		converter: converter,
		isForeign: true
	};
	return leaf(name);
}

var outgoingPortMap = F2(function cmdMap(tagger, value) {
	return value;
});

function setupOutgoingPort(name)
{
	var subs = [];
	var converter = effectManagers[name].converter;

	// CREATE MANAGER

	var init = _elm_lang$core$Native_Scheduler.succeed(null);

	function onEffects(router, cmdList, state)
	{
		while (cmdList.ctor !== '[]')
		{
			var value = converter(cmdList._0);
			for (var i = 0; i < subs.length; i++)
			{
				subs[i](value);
			}
			cmdList = cmdList._1;
		}
		return init;
	}

	effectManagers[name].init = init;
	effectManagers[name].onEffects = F3(onEffects);

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}


// INCOMING PORTS

function incomingPort(name, converter)
{
	checkPortName(name);
	effectManagers[name] = {
		tag: 'sub',
		subMap: incomingPortMap,
		converter: converter,
		isForeign: true
	};
	return leaf(name);
}

var incomingPortMap = F2(function subMap(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});

function setupIncomingPort(name, callback)
{
	var subs = _elm_lang$core$Native_List.Nil;
	var converter = effectManagers[name].converter;

	// CREATE MANAGER

	var init = _elm_lang$core$Native_Scheduler.succeed(null);

	function onEffects(router, subList, state)
	{
		subs = subList;
		return init;
	}

	effectManagers[name].init = init;
	effectManagers[name].onEffects = F3(onEffects);

	// PUBLIC API

	function send(value)
	{
		var result = A2(_elm_lang$core$Json_Decode$decodeValue, converter, value);
		if (result.ctor === 'Err')
		{
			throw new Error('Trying to send an unexpected type of value through port `' + name + '`:\n' + result._0);
		}

		var value = result._0;
		var temp = subs;
		while (temp.ctor !== '[]')
		{
			callback(temp._0(value));
			temp = temp._1;
		}
	}

	return { send: send };
}

return {
	// routers
	sendToApp: F2(sendToApp),
	sendToSelf: F2(sendToSelf),

	// global setup
	mainToProgram: mainToProgram,
	effectManagers: effectManagers,
	outgoingPort: outgoingPort,
	incomingPort: incomingPort,
	addPublicModule: addPublicModule,

	// effect bags
	leaf: leaf,
	batch: batch,
	map: F2(map)
};

}();
//import Native.Utils //

var _elm_lang$core$Native_Scheduler = function() {

var MAX_STEPS = 10000;


// TASKS

function succeed(value)
{
	return {
		ctor: '_Task_succeed',
		value: value
	};
}

function fail(error)
{
	return {
		ctor: '_Task_fail',
		value: error
	};
}

function nativeBinding(callback)
{
	return {
		ctor: '_Task_nativeBinding',
		callback: callback,
		cancel: null
	};
}

function andThen(task, callback)
{
	return {
		ctor: '_Task_andThen',
		task: task,
		callback: callback
	};
}

function onError(task, callback)
{
	return {
		ctor: '_Task_onError',
		task: task,
		callback: callback
	};
}

function receive(callback)
{
	return {
		ctor: '_Task_receive',
		callback: callback
	};
}


// PROCESSES

function rawSpawn(task)
{
	var process = {
		ctor: '_Process',
		id: _elm_lang$core$Native_Utils.guid(),
		root: task,
		stack: null,
		mailbox: []
	};

	enqueue(process);

	return process;
}

function spawn(task)
{
	return nativeBinding(function(callback) {
		var process = rawSpawn(task);
		callback(succeed(process));
	});
}

function rawSend(process, msg)
{
	process.mailbox.push(msg);
	enqueue(process);
}

function send(process, msg)
{
	return nativeBinding(function(callback) {
		rawSend(process, msg);
		callback(succeed(_elm_lang$core$Native_Utils.Tuple0));
	});
}

function kill(process)
{
	return nativeBinding(function(callback) {
		var root = process.root;
		if (root.ctor === '_Task_nativeBinding' && root.cancel)
		{
			root.cancel();
		}

		process.root = null;

		callback(succeed(_elm_lang$core$Native_Utils.Tuple0));
	});
}

function sleep(time)
{
	return nativeBinding(function(callback) {
		var id = setTimeout(function() {
			callback(succeed(_elm_lang$core$Native_Utils.Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}


// STEP PROCESSES

function step(numSteps, process)
{
	while (numSteps < MAX_STEPS)
	{
		var ctor = process.root.ctor;

		if (ctor === '_Task_succeed')
		{
			while (process.stack && process.stack.ctor === '_Task_onError')
			{
				process.stack = process.stack.rest;
			}
			if (process.stack === null)
			{
				break;
			}
			process.root = process.stack.callback(process.root.value);
			process.stack = process.stack.rest;
			++numSteps;
			continue;
		}

		if (ctor === '_Task_fail')
		{
			while (process.stack && process.stack.ctor === '_Task_andThen')
			{
				process.stack = process.stack.rest;
			}
			if (process.stack === null)
			{
				break;
			}
			process.root = process.stack.callback(process.root.value);
			process.stack = process.stack.rest;
			++numSteps;
			continue;
		}

		if (ctor === '_Task_andThen')
		{
			process.stack = {
				ctor: '_Task_andThen',
				callback: process.root.callback,
				rest: process.stack
			};
			process.root = process.root.task;
			++numSteps;
			continue;
		}

		if (ctor === '_Task_onError')
		{
			process.stack = {
				ctor: '_Task_onError',
				callback: process.root.callback,
				rest: process.stack
			};
			process.root = process.root.task;
			++numSteps;
			continue;
		}

		if (ctor === '_Task_nativeBinding')
		{
			process.root.cancel = process.root.callback(function(newRoot) {
				process.root = newRoot;
				enqueue(process);
			});

			break;
		}

		if (ctor === '_Task_receive')
		{
			var mailbox = process.mailbox;
			if (mailbox.length === 0)
			{
				break;
			}

			process.root = process.root.callback(mailbox.shift());
			++numSteps;
			continue;
		}

		throw new Error(ctor);
	}

	if (numSteps < MAX_STEPS)
	{
		return numSteps + 1;
	}
	enqueue(process);

	return numSteps;
}


// WORK QUEUE

var working = false;
var workQueue = [];

function enqueue(process)
{
	workQueue.push(process);

	if (!working)
	{
		setTimeout(work, 0);
		working = true;
	}
}

function work()
{
	var numSteps = 0;
	var process;
	while (numSteps < MAX_STEPS && (process = workQueue.shift()))
	{
		numSteps = step(numSteps, process);
	}
	if (!process)
	{
		working = false;
		return;
	}
	setTimeout(work, 0);
}


return {
	succeed: succeed,
	fail: fail,
	nativeBinding: nativeBinding,
	andThen: F2(andThen),
	onError: F2(onError),
	receive: receive,

	spawn: spawn,
	kill: kill,
	sleep: sleep,
	send: F2(send),

	rawSpawn: rawSpawn,
	rawSend: rawSend
};

}();
var _elm_lang$core$Platform$hack = _elm_lang$core$Native_Scheduler.succeed;
var _elm_lang$core$Platform$sendToSelf = _elm_lang$core$Native_Platform.sendToSelf;
var _elm_lang$core$Platform$sendToApp = _elm_lang$core$Native_Platform.sendToApp;
var _elm_lang$core$Platform$Program = {ctor: 'Program'};
var _elm_lang$core$Platform$Task = {ctor: 'Task'};
var _elm_lang$core$Platform$ProcessId = {ctor: 'ProcessId'};
var _elm_lang$core$Platform$Router = {ctor: 'Router'};

var _elm_lang$core$Platform_Cmd$batch = _elm_lang$core$Native_Platform.batch;
var _elm_lang$core$Platform_Cmd$none = _elm_lang$core$Platform_Cmd$batch(
	_elm_lang$core$Native_List.fromArray(
		[]));
var _elm_lang$core$Platform_Cmd_ops = _elm_lang$core$Platform_Cmd_ops || {};
_elm_lang$core$Platform_Cmd_ops['!'] = F2(
	function (model, commands) {
		return {
			ctor: '_Tuple2',
			_0: model,
			_1: _elm_lang$core$Platform_Cmd$batch(commands)
		};
	});
var _elm_lang$core$Platform_Cmd$map = _elm_lang$core$Native_Platform.map;
var _elm_lang$core$Platform_Cmd$Cmd = {ctor: 'Cmd'};

var _elm_lang$core$Platform_Sub$batch = _elm_lang$core$Native_Platform.batch;
var _elm_lang$core$Platform_Sub$none = _elm_lang$core$Platform_Sub$batch(
	_elm_lang$core$Native_List.fromArray(
		[]));
var _elm_lang$core$Platform_Sub$map = _elm_lang$core$Native_Platform.map;
var _elm_lang$core$Platform_Sub$Sub = {ctor: 'Sub'};

//import Native.List //

var _elm_lang$core$Native_Array = function() {

// A RRB-Tree has two distinct data types.
// Leaf -> "height"  is always 0
//         "table"   is an array of elements
// Node -> "height"  is always greater than 0
//         "table"   is an array of child nodes
//         "lengths" is an array of accumulated lengths of the child nodes

// M is the maximal table size. 32 seems fast. E is the allowed increase
// of search steps when concatting to find an index. Lower values will
// decrease balancing, but will increase search steps.
var M = 32;
var E = 2;

// An empty array.
var empty = {
	ctor: '_Array',
	height: 0,
	table: []
};


function get(i, array)
{
	if (i < 0 || i >= length(array))
	{
		throw new Error(
			'Index ' + i + ' is out of range. Check the length of ' +
			'your array first or use getMaybe or getWithDefault.');
	}
	return unsafeGet(i, array);
}


function unsafeGet(i, array)
{
	for (var x = array.height; x > 0; x--)
	{
		var slot = i >> (x * 5);
		while (array.lengths[slot] <= i)
		{
			slot++;
		}
		if (slot > 0)
		{
			i -= array.lengths[slot - 1];
		}
		array = array.table[slot];
	}
	return array.table[i];
}


// Sets the value at the index i. Only the nodes leading to i will get
// copied and updated.
function set(i, item, array)
{
	if (i < 0 || length(array) <= i)
	{
		return array;
	}
	return unsafeSet(i, item, array);
}


function unsafeSet(i, item, array)
{
	array = nodeCopy(array);

	if (array.height === 0)
	{
		array.table[i] = item;
	}
	else
	{
		var slot = getSlot(i, array);
		if (slot > 0)
		{
			i -= array.lengths[slot - 1];
		}
		array.table[slot] = unsafeSet(i, item, array.table[slot]);
	}
	return array;
}


function initialize(len, f)
{
	if (len <= 0)
	{
		return empty;
	}
	var h = Math.floor( Math.log(len) / Math.log(M) );
	return initialize_(f, h, 0, len);
}

function initialize_(f, h, from, to)
{
	if (h === 0)
	{
		var table = new Array((to - from) % (M + 1));
		for (var i = 0; i < table.length; i++)
		{
		  table[i] = f(from + i);
		}
		return {
			ctor: '_Array',
			height: 0,
			table: table
		};
	}

	var step = Math.pow(M, h);
	var table = new Array(Math.ceil((to - from) / step));
	var lengths = new Array(table.length);
	for (var i = 0; i < table.length; i++)
	{
		table[i] = initialize_(f, h - 1, from + (i * step), Math.min(from + ((i + 1) * step), to));
		lengths[i] = length(table[i]) + (i > 0 ? lengths[i-1] : 0);
	}
	return {
		ctor: '_Array',
		height: h,
		table: table,
		lengths: lengths
	};
}

function fromList(list)
{
	if (list.ctor === '[]')
	{
		return empty;
	}

	// Allocate M sized blocks (table) and write list elements to it.
	var table = new Array(M);
	var nodes = [];
	var i = 0;

	while (list.ctor !== '[]')
	{
		table[i] = list._0;
		list = list._1;
		i++;

		// table is full, so we can push a leaf containing it into the
		// next node.
		if (i === M)
		{
			var leaf = {
				ctor: '_Array',
				height: 0,
				table: table
			};
			fromListPush(leaf, nodes);
			table = new Array(M);
			i = 0;
		}
	}

	// Maybe there is something left on the table.
	if (i > 0)
	{
		var leaf = {
			ctor: '_Array',
			height: 0,
			table: table.splice(0, i)
		};
		fromListPush(leaf, nodes);
	}

	// Go through all of the nodes and eventually push them into higher nodes.
	for (var h = 0; h < nodes.length - 1; h++)
	{
		if (nodes[h].table.length > 0)
		{
			fromListPush(nodes[h], nodes);
		}
	}

	var head = nodes[nodes.length - 1];
	if (head.height > 0 && head.table.length === 1)
	{
		return head.table[0];
	}
	else
	{
		return head;
	}
}

// Push a node into a higher node as a child.
function fromListPush(toPush, nodes)
{
	var h = toPush.height;

	// Maybe the node on this height does not exist.
	if (nodes.length === h)
	{
		var node = {
			ctor: '_Array',
			height: h + 1,
			table: [],
			lengths: []
		};
		nodes.push(node);
	}

	nodes[h].table.push(toPush);
	var len = length(toPush);
	if (nodes[h].lengths.length > 0)
	{
		len += nodes[h].lengths[nodes[h].lengths.length - 1];
	}
	nodes[h].lengths.push(len);

	if (nodes[h].table.length === M)
	{
		fromListPush(nodes[h], nodes);
		nodes[h] = {
			ctor: '_Array',
			height: h + 1,
			table: [],
			lengths: []
		};
	}
}

// Pushes an item via push_ to the bottom right of a tree.
function push(item, a)
{
	var pushed = push_(item, a);
	if (pushed !== null)
	{
		return pushed;
	}

	var newTree = create(item, a.height);
	return siblise(a, newTree);
}

// Recursively tries to push an item to the bottom-right most
// tree possible. If there is no space left for the item,
// null will be returned.
function push_(item, a)
{
	// Handle resursion stop at leaf level.
	if (a.height === 0)
	{
		if (a.table.length < M)
		{
			var newA = {
				ctor: '_Array',
				height: 0,
				table: a.table.slice()
			};
			newA.table.push(item);
			return newA;
		}
		else
		{
		  return null;
		}
	}

	// Recursively push
	var pushed = push_(item, botRight(a));

	// There was space in the bottom right tree, so the slot will
	// be updated.
	if (pushed !== null)
	{
		var newA = nodeCopy(a);
		newA.table[newA.table.length - 1] = pushed;
		newA.lengths[newA.lengths.length - 1]++;
		return newA;
	}

	// When there was no space left, check if there is space left
	// for a new slot with a tree which contains only the item
	// at the bottom.
	if (a.table.length < M)
	{
		var newSlot = create(item, a.height - 1);
		var newA = nodeCopy(a);
		newA.table.push(newSlot);
		newA.lengths.push(newA.lengths[newA.lengths.length - 1] + length(newSlot));
		return newA;
	}
	else
	{
		return null;
	}
}

// Converts an array into a list of elements.
function toList(a)
{
	return toList_(_elm_lang$core$Native_List.Nil, a);
}

function toList_(list, a)
{
	for (var i = a.table.length - 1; i >= 0; i--)
	{
		list =
			a.height === 0
				? _elm_lang$core$Native_List.Cons(a.table[i], list)
				: toList_(list, a.table[i]);
	}
	return list;
}

// Maps a function over the elements of an array.
function map(f, a)
{
	var newA = {
		ctor: '_Array',
		height: a.height,
		table: new Array(a.table.length)
	};
	if (a.height > 0)
	{
		newA.lengths = a.lengths;
	}
	for (var i = 0; i < a.table.length; i++)
	{
		newA.table[i] =
			a.height === 0
				? f(a.table[i])
				: map(f, a.table[i]);
	}
	return newA;
}

// Maps a function over the elements with their index as first argument.
function indexedMap(f, a)
{
	return indexedMap_(f, a, 0);
}

function indexedMap_(f, a, from)
{
	var newA = {
		ctor: '_Array',
		height: a.height,
		table: new Array(a.table.length)
	};
	if (a.height > 0)
	{
		newA.lengths = a.lengths;
	}
	for (var i = 0; i < a.table.length; i++)
	{
		newA.table[i] =
			a.height === 0
				? A2(f, from + i, a.table[i])
				: indexedMap_(f, a.table[i], i == 0 ? from : from + a.lengths[i - 1]);
	}
	return newA;
}

function foldl(f, b, a)
{
	if (a.height === 0)
	{
		for (var i = 0; i < a.table.length; i++)
		{
			b = A2(f, a.table[i], b);
		}
	}
	else
	{
		for (var i = 0; i < a.table.length; i++)
		{
			b = foldl(f, b, a.table[i]);
		}
	}
	return b;
}

function foldr(f, b, a)
{
	if (a.height === 0)
	{
		for (var i = a.table.length; i--; )
		{
			b = A2(f, a.table[i], b);
		}
	}
	else
	{
		for (var i = a.table.length; i--; )
		{
			b = foldr(f, b, a.table[i]);
		}
	}
	return b;
}

// TODO: currently, it slices the right, then the left. This can be
// optimized.
function slice(from, to, a)
{
	if (from < 0)
	{
		from += length(a);
	}
	if (to < 0)
	{
		to += length(a);
	}
	return sliceLeft(from, sliceRight(to, a));
}

function sliceRight(to, a)
{
	if (to === length(a))
	{
		return a;
	}

	// Handle leaf level.
	if (a.height === 0)
	{
		var newA = { ctor:'_Array', height:0 };
		newA.table = a.table.slice(0, to);
		return newA;
	}

	// Slice the right recursively.
	var right = getSlot(to, a);
	var sliced = sliceRight(to - (right > 0 ? a.lengths[right - 1] : 0), a.table[right]);

	// Maybe the a node is not even needed, as sliced contains the whole slice.
	if (right === 0)
	{
		return sliced;
	}

	// Create new node.
	var newA = {
		ctor: '_Array',
		height: a.height,
		table: a.table.slice(0, right),
		lengths: a.lengths.slice(0, right)
	};
	if (sliced.table.length > 0)
	{
		newA.table[right] = sliced;
		newA.lengths[right] = length(sliced) + (right > 0 ? newA.lengths[right - 1] : 0);
	}
	return newA;
}

function sliceLeft(from, a)
{
	if (from === 0)
	{
		return a;
	}

	// Handle leaf level.
	if (a.height === 0)
	{
		var newA = { ctor:'_Array', height:0 };
		newA.table = a.table.slice(from, a.table.length + 1);
		return newA;
	}

	// Slice the left recursively.
	var left = getSlot(from, a);
	var sliced = sliceLeft(from - (left > 0 ? a.lengths[left - 1] : 0), a.table[left]);

	// Maybe the a node is not even needed, as sliced contains the whole slice.
	if (left === a.table.length - 1)
	{
		return sliced;
	}

	// Create new node.
	var newA = {
		ctor: '_Array',
		height: a.height,
		table: a.table.slice(left, a.table.length + 1),
		lengths: new Array(a.table.length - left)
	};
	newA.table[0] = sliced;
	var len = 0;
	for (var i = 0; i < newA.table.length; i++)
	{
		len += length(newA.table[i]);
		newA.lengths[i] = len;
	}

	return newA;
}

// Appends two trees.
function append(a,b)
{
	if (a.table.length === 0)
	{
		return b;
	}
	if (b.table.length === 0)
	{
		return a;
	}

	var c = append_(a, b);

	// Check if both nodes can be crunshed together.
	if (c[0].table.length + c[1].table.length <= M)
	{
		if (c[0].table.length === 0)
		{
			return c[1];
		}
		if (c[1].table.length === 0)
		{
			return c[0];
		}

		// Adjust .table and .lengths
		c[0].table = c[0].table.concat(c[1].table);
		if (c[0].height > 0)
		{
			var len = length(c[0]);
			for (var i = 0; i < c[1].lengths.length; i++)
			{
				c[1].lengths[i] += len;
			}
			c[0].lengths = c[0].lengths.concat(c[1].lengths);
		}

		return c[0];
	}

	if (c[0].height > 0)
	{
		var toRemove = calcToRemove(a, b);
		if (toRemove > E)
		{
			c = shuffle(c[0], c[1], toRemove);
		}
	}

	return siblise(c[0], c[1]);
}

// Returns an array of two nodes; right and left. One node _may_ be empty.
function append_(a, b)
{
	if (a.height === 0 && b.height === 0)
	{
		return [a, b];
	}

	if (a.height !== 1 || b.height !== 1)
	{
		if (a.height === b.height)
		{
			a = nodeCopy(a);
			b = nodeCopy(b);
			var appended = append_(botRight(a), botLeft(b));

			insertRight(a, appended[1]);
			insertLeft(b, appended[0]);
		}
		else if (a.height > b.height)
		{
			a = nodeCopy(a);
			var appended = append_(botRight(a), b);

			insertRight(a, appended[0]);
			b = parentise(appended[1], appended[1].height + 1);
		}
		else
		{
			b = nodeCopy(b);
			var appended = append_(a, botLeft(b));

			var left = appended[0].table.length === 0 ? 0 : 1;
			var right = left === 0 ? 1 : 0;
			insertLeft(b, appended[left]);
			a = parentise(appended[right], appended[right].height + 1);
		}
	}

	// Check if balancing is needed and return based on that.
	if (a.table.length === 0 || b.table.length === 0)
	{
		return [a, b];
	}

	var toRemove = calcToRemove(a, b);
	if (toRemove <= E)
	{
		return [a, b];
	}
	return shuffle(a, b, toRemove);
}

// Helperfunctions for append_. Replaces a child node at the side of the parent.
function insertRight(parent, node)
{
	var index = parent.table.length - 1;
	parent.table[index] = node;
	parent.lengths[index] = length(node);
	parent.lengths[index] += index > 0 ? parent.lengths[index - 1] : 0;
}

function insertLeft(parent, node)
{
	if (node.table.length > 0)
	{
		parent.table[0] = node;
		parent.lengths[0] = length(node);

		var len = length(parent.table[0]);
		for (var i = 1; i < parent.lengths.length; i++)
		{
			len += length(parent.table[i]);
			parent.lengths[i] = len;
		}
	}
	else
	{
		parent.table.shift();
		for (var i = 1; i < parent.lengths.length; i++)
		{
			parent.lengths[i] = parent.lengths[i] - parent.lengths[0];
		}
		parent.lengths.shift();
	}
}

// Returns the extra search steps for E. Refer to the paper.
function calcToRemove(a, b)
{
	var subLengths = 0;
	for (var i = 0; i < a.table.length; i++)
	{
		subLengths += a.table[i].table.length;
	}
	for (var i = 0; i < b.table.length; i++)
	{
		subLengths += b.table[i].table.length;
	}

	var toRemove = a.table.length + b.table.length;
	return toRemove - (Math.floor((subLengths - 1) / M) + 1);
}

// get2, set2 and saveSlot are helpers for accessing elements over two arrays.
function get2(a, b, index)
{
	return index < a.length
		? a[index]
		: b[index - a.length];
}

function set2(a, b, index, value)
{
	if (index < a.length)
	{
		a[index] = value;
	}
	else
	{
		b[index - a.length] = value;
	}
}

function saveSlot(a, b, index, slot)
{
	set2(a.table, b.table, index, slot);

	var l = (index === 0 || index === a.lengths.length)
		? 0
		: get2(a.lengths, a.lengths, index - 1);

	set2(a.lengths, b.lengths, index, l + length(slot));
}

// Creates a node or leaf with a given length at their arrays for perfomance.
// Is only used by shuffle.
function createNode(h, length)
{
	if (length < 0)
	{
		length = 0;
	}
	var a = {
		ctor: '_Array',
		height: h,
		table: new Array(length)
	};
	if (h > 0)
	{
		a.lengths = new Array(length);
	}
	return a;
}

// Returns an array of two balanced nodes.
function shuffle(a, b, toRemove)
{
	var newA = createNode(a.height, Math.min(M, a.table.length + b.table.length - toRemove));
	var newB = createNode(a.height, newA.table.length - (a.table.length + b.table.length - toRemove));

	// Skip the slots with size M. More precise: copy the slot references
	// to the new node
	var read = 0;
	while (get2(a.table, b.table, read).table.length % M === 0)
	{
		set2(newA.table, newB.table, read, get2(a.table, b.table, read));
		set2(newA.lengths, newB.lengths, read, get2(a.lengths, b.lengths, read));
		read++;
	}

	// Pulling items from left to right, caching in a slot before writing
	// it into the new nodes.
	var write = read;
	var slot = new createNode(a.height - 1, 0);
	var from = 0;

	// If the current slot is still containing data, then there will be at
	// least one more write, so we do not break this loop yet.
	while (read - write - (slot.table.length > 0 ? 1 : 0) < toRemove)
	{
		// Find out the max possible items for copying.
		var source = get2(a.table, b.table, read);
		var to = Math.min(M - slot.table.length, source.table.length);

		// Copy and adjust size table.
		slot.table = slot.table.concat(source.table.slice(from, to));
		if (slot.height > 0)
		{
			var len = slot.lengths.length;
			for (var i = len; i < len + to - from; i++)
			{
				slot.lengths[i] = length(slot.table[i]);
				slot.lengths[i] += (i > 0 ? slot.lengths[i - 1] : 0);
			}
		}

		from += to;

		// Only proceed to next slots[i] if the current one was
		// fully copied.
		if (source.table.length <= to)
		{
			read++; from = 0;
		}

		// Only create a new slot if the current one is filled up.
		if (slot.table.length === M)
		{
			saveSlot(newA, newB, write, slot);
			slot = createNode(a.height - 1, 0);
			write++;
		}
	}

	// Cleanup after the loop. Copy the last slot into the new nodes.
	if (slot.table.length > 0)
	{
		saveSlot(newA, newB, write, slot);
		write++;
	}

	// Shift the untouched slots to the left
	while (read < a.table.length + b.table.length )
	{
		saveSlot(newA, newB, write, get2(a.table, b.table, read));
		read++;
		write++;
	}

	return [newA, newB];
}

// Navigation functions
function botRight(a)
{
	return a.table[a.table.length - 1];
}
function botLeft(a)
{
	return a.table[0];
}

// Copies a node for updating. Note that you should not use this if
// only updating only one of "table" or "lengths" for performance reasons.
function nodeCopy(a)
{
	var newA = {
		ctor: '_Array',
		height: a.height,
		table: a.table.slice()
	};
	if (a.height > 0)
	{
		newA.lengths = a.lengths.slice();
	}
	return newA;
}

// Returns how many items are in the tree.
function length(array)
{
	if (array.height === 0)
	{
		return array.table.length;
	}
	else
	{
		return array.lengths[array.lengths.length - 1];
	}
}

// Calculates in which slot of "table" the item probably is, then
// find the exact slot via forward searching in  "lengths". Returns the index.
function getSlot(i, a)
{
	var slot = i >> (5 * a.height);
	while (a.lengths[slot] <= i)
	{
		slot++;
	}
	return slot;
}

// Recursively creates a tree with a given height containing
// only the given item.
function create(item, h)
{
	if (h === 0)
	{
		return {
			ctor: '_Array',
			height: 0,
			table: [item]
		};
	}
	return {
		ctor: '_Array',
		height: h,
		table: [create(item, h - 1)],
		lengths: [1]
	};
}

// Recursively creates a tree that contains the given tree.
function parentise(tree, h)
{
	if (h === tree.height)
	{
		return tree;
	}

	return {
		ctor: '_Array',
		height: h,
		table: [parentise(tree, h - 1)],
		lengths: [length(tree)]
	};
}

// Emphasizes blood brotherhood beneath two trees.
function siblise(a, b)
{
	return {
		ctor: '_Array',
		height: a.height + 1,
		table: [a, b],
		lengths: [length(a), length(a) + length(b)]
	};
}

function toJSArray(a)
{
	var jsArray = new Array(length(a));
	toJSArray_(jsArray, 0, a);
	return jsArray;
}

function toJSArray_(jsArray, i, a)
{
	for (var t = 0; t < a.table.length; t++)
	{
		if (a.height === 0)
		{
			jsArray[i + t] = a.table[t];
		}
		else
		{
			var inc = t === 0 ? 0 : a.lengths[t - 1];
			toJSArray_(jsArray, i + inc, a.table[t]);
		}
	}
}

function fromJSArray(jsArray)
{
	if (jsArray.length === 0)
	{
		return empty;
	}
	var h = Math.floor(Math.log(jsArray.length) / Math.log(M));
	return fromJSArray_(jsArray, h, 0, jsArray.length);
}

function fromJSArray_(jsArray, h, from, to)
{
	if (h === 0)
	{
		return {
			ctor: '_Array',
			height: 0,
			table: jsArray.slice(from, to)
		};
	}

	var step = Math.pow(M, h);
	var table = new Array(Math.ceil((to - from) / step));
	var lengths = new Array(table.length);
	for (var i = 0; i < table.length; i++)
	{
		table[i] = fromJSArray_(jsArray, h - 1, from + (i * step), Math.min(from + ((i + 1) * step), to));
		lengths[i] = length(table[i]) + (i > 0 ? lengths[i - 1] : 0);
	}
	return {
		ctor: '_Array',
		height: h,
		table: table,
		lengths: lengths
	};
}

return {
	empty: empty,
	fromList: fromList,
	toList: toList,
	initialize: F2(initialize),
	append: F2(append),
	push: F2(push),
	slice: F3(slice),
	get: F2(get),
	set: F3(set),
	map: F2(map),
	indexedMap: F2(indexedMap),
	foldl: F3(foldl),
	foldr: F3(foldr),
	length: length,

	toJSArray: toJSArray,
	fromJSArray: fromJSArray
};

}();
var _elm_lang$core$Array$append = _elm_lang$core$Native_Array.append;
var _elm_lang$core$Array$length = _elm_lang$core$Native_Array.length;
var _elm_lang$core$Array$isEmpty = function (array) {
	return _elm_lang$core$Native_Utils.eq(
		_elm_lang$core$Array$length(array),
		0);
};
var _elm_lang$core$Array$slice = _elm_lang$core$Native_Array.slice;
var _elm_lang$core$Array$set = _elm_lang$core$Native_Array.set;
var _elm_lang$core$Array$get = F2(
	function (i, array) {
		return ((_elm_lang$core$Native_Utils.cmp(0, i) < 1) && (_elm_lang$core$Native_Utils.cmp(
			i,
			_elm_lang$core$Native_Array.length(array)) < 0)) ? _elm_lang$core$Maybe$Just(
			A2(_elm_lang$core$Native_Array.get, i, array)) : _elm_lang$core$Maybe$Nothing;
	});
var _elm_lang$core$Array$push = _elm_lang$core$Native_Array.push;
var _elm_lang$core$Array$empty = _elm_lang$core$Native_Array.empty;
var _elm_lang$core$Array$filter = F2(
	function (isOkay, arr) {
		var update = F2(
			function (x, xs) {
				return isOkay(x) ? A2(_elm_lang$core$Native_Array.push, x, xs) : xs;
			});
		return A3(_elm_lang$core$Native_Array.foldl, update, _elm_lang$core$Native_Array.empty, arr);
	});
var _elm_lang$core$Array$foldr = _elm_lang$core$Native_Array.foldr;
var _elm_lang$core$Array$foldl = _elm_lang$core$Native_Array.foldl;
var _elm_lang$core$Array$indexedMap = _elm_lang$core$Native_Array.indexedMap;
var _elm_lang$core$Array$map = _elm_lang$core$Native_Array.map;
var _elm_lang$core$Array$toIndexedList = function (array) {
	return A3(
		_elm_lang$core$List$map2,
		F2(
			function (v0, v1) {
				return {ctor: '_Tuple2', _0: v0, _1: v1};
			}),
		_elm_lang$core$Native_List.range(
			0,
			_elm_lang$core$Native_Array.length(array) - 1),
		_elm_lang$core$Native_Array.toList(array));
};
var _elm_lang$core$Array$toList = _elm_lang$core$Native_Array.toList;
var _elm_lang$core$Array$fromList = _elm_lang$core$Native_Array.fromList;
var _elm_lang$core$Array$initialize = _elm_lang$core$Native_Array.initialize;
var _elm_lang$core$Array$repeat = F2(
	function (n, e) {
		return A2(
			_elm_lang$core$Array$initialize,
			n,
			_elm_lang$core$Basics$always(e));
	});
var _elm_lang$core$Array$Array = {ctor: 'Array'};

var _elm_lang$core$Task$onError = _elm_lang$core$Native_Scheduler.onError;
var _elm_lang$core$Task$andThen = _elm_lang$core$Native_Scheduler.andThen;
var _elm_lang$core$Task$spawnCmd = F2(
	function (router, _p0) {
		var _p1 = _p0;
		return _elm_lang$core$Native_Scheduler.spawn(
			A2(
				_elm_lang$core$Task$andThen,
				_p1._0,
				_elm_lang$core$Platform$sendToApp(router)));
	});
var _elm_lang$core$Task$fail = _elm_lang$core$Native_Scheduler.fail;
var _elm_lang$core$Task$mapError = F2(
	function (f, task) {
		return A2(
			_elm_lang$core$Task$onError,
			task,
			function (err) {
				return _elm_lang$core$Task$fail(
					f(err));
			});
	});
var _elm_lang$core$Task$succeed = _elm_lang$core$Native_Scheduler.succeed;
var _elm_lang$core$Task$map = F2(
	function (func, taskA) {
		return A2(
			_elm_lang$core$Task$andThen,
			taskA,
			function (a) {
				return _elm_lang$core$Task$succeed(
					func(a));
			});
	});
var _elm_lang$core$Task$map2 = F3(
	function (func, taskA, taskB) {
		return A2(
			_elm_lang$core$Task$andThen,
			taskA,
			function (a) {
				return A2(
					_elm_lang$core$Task$andThen,
					taskB,
					function (b) {
						return _elm_lang$core$Task$succeed(
							A2(func, a, b));
					});
			});
	});
var _elm_lang$core$Task$map3 = F4(
	function (func, taskA, taskB, taskC) {
		return A2(
			_elm_lang$core$Task$andThen,
			taskA,
			function (a) {
				return A2(
					_elm_lang$core$Task$andThen,
					taskB,
					function (b) {
						return A2(
							_elm_lang$core$Task$andThen,
							taskC,
							function (c) {
								return _elm_lang$core$Task$succeed(
									A3(func, a, b, c));
							});
					});
			});
	});
var _elm_lang$core$Task$map4 = F5(
	function (func, taskA, taskB, taskC, taskD) {
		return A2(
			_elm_lang$core$Task$andThen,
			taskA,
			function (a) {
				return A2(
					_elm_lang$core$Task$andThen,
					taskB,
					function (b) {
						return A2(
							_elm_lang$core$Task$andThen,
							taskC,
							function (c) {
								return A2(
									_elm_lang$core$Task$andThen,
									taskD,
									function (d) {
										return _elm_lang$core$Task$succeed(
											A4(func, a, b, c, d));
									});
							});
					});
			});
	});
var _elm_lang$core$Task$map5 = F6(
	function (func, taskA, taskB, taskC, taskD, taskE) {
		return A2(
			_elm_lang$core$Task$andThen,
			taskA,
			function (a) {
				return A2(
					_elm_lang$core$Task$andThen,
					taskB,
					function (b) {
						return A2(
							_elm_lang$core$Task$andThen,
							taskC,
							function (c) {
								return A2(
									_elm_lang$core$Task$andThen,
									taskD,
									function (d) {
										return A2(
											_elm_lang$core$Task$andThen,
											taskE,
											function (e) {
												return _elm_lang$core$Task$succeed(
													A5(func, a, b, c, d, e));
											});
									});
							});
					});
			});
	});
var _elm_lang$core$Task$andMap = F2(
	function (taskFunc, taskValue) {
		return A2(
			_elm_lang$core$Task$andThen,
			taskFunc,
			function (func) {
				return A2(
					_elm_lang$core$Task$andThen,
					taskValue,
					function (value) {
						return _elm_lang$core$Task$succeed(
							func(value));
					});
			});
	});
var _elm_lang$core$Task$sequence = function (tasks) {
	var _p2 = tasks;
	if (_p2.ctor === '[]') {
		return _elm_lang$core$Task$succeed(
			_elm_lang$core$Native_List.fromArray(
				[]));
	} else {
		return A3(
			_elm_lang$core$Task$map2,
			F2(
				function (x, y) {
					return A2(_elm_lang$core$List_ops['::'], x, y);
				}),
			_p2._0,
			_elm_lang$core$Task$sequence(_p2._1));
	}
};
var _elm_lang$core$Task$onEffects = F3(
	function (router, commands, state) {
		return A2(
			_elm_lang$core$Task$map,
			function (_p3) {
				return {ctor: '_Tuple0'};
			},
			_elm_lang$core$Task$sequence(
				A2(
					_elm_lang$core$List$map,
					_elm_lang$core$Task$spawnCmd(router),
					commands)));
	});
var _elm_lang$core$Task$toMaybe = function (task) {
	return A2(
		_elm_lang$core$Task$onError,
		A2(_elm_lang$core$Task$map, _elm_lang$core$Maybe$Just, task),
		function (_p4) {
			return _elm_lang$core$Task$succeed(_elm_lang$core$Maybe$Nothing);
		});
};
var _elm_lang$core$Task$fromMaybe = F2(
	function ($default, maybe) {
		var _p5 = maybe;
		if (_p5.ctor === 'Just') {
			return _elm_lang$core$Task$succeed(_p5._0);
		} else {
			return _elm_lang$core$Task$fail($default);
		}
	});
var _elm_lang$core$Task$toResult = function (task) {
	return A2(
		_elm_lang$core$Task$onError,
		A2(_elm_lang$core$Task$map, _elm_lang$core$Result$Ok, task),
		function (msg) {
			return _elm_lang$core$Task$succeed(
				_elm_lang$core$Result$Err(msg));
		});
};
var _elm_lang$core$Task$fromResult = function (result) {
	var _p6 = result;
	if (_p6.ctor === 'Ok') {
		return _elm_lang$core$Task$succeed(_p6._0);
	} else {
		return _elm_lang$core$Task$fail(_p6._0);
	}
};
var _elm_lang$core$Task$init = _elm_lang$core$Task$succeed(
	{ctor: '_Tuple0'});
var _elm_lang$core$Task$onSelfMsg = F3(
	function (_p9, _p8, _p7) {
		return _elm_lang$core$Task$succeed(
			{ctor: '_Tuple0'});
	});
var _elm_lang$core$Task$command = _elm_lang$core$Native_Platform.leaf('Task');
var _elm_lang$core$Task$T = function (a) {
	return {ctor: 'T', _0: a};
};
var _elm_lang$core$Task$perform = F3(
	function (onFail, onSuccess, task) {
		return _elm_lang$core$Task$command(
			_elm_lang$core$Task$T(
				A2(
					_elm_lang$core$Task$onError,
					A2(_elm_lang$core$Task$map, onSuccess, task),
					function (x) {
						return _elm_lang$core$Task$succeed(
							onFail(x));
					})));
	});
var _elm_lang$core$Task$cmdMap = F2(
	function (tagger, _p10) {
		var _p11 = _p10;
		return _elm_lang$core$Task$T(
			A2(_elm_lang$core$Task$map, tagger, _p11._0));
	});
_elm_lang$core$Native_Platform.effectManagers['Task'] = {pkg: 'elm-lang/core', init: _elm_lang$core$Task$init, onEffects: _elm_lang$core$Task$onEffects, onSelfMsg: _elm_lang$core$Task$onSelfMsg, tag: 'cmd', cmdMap: _elm_lang$core$Task$cmdMap};

//import Maybe, Native.List, Native.Utils, Result //

var _elm_lang$core$Native_String = function() {

function isEmpty(str)
{
	return str.length === 0;
}
function cons(chr, str)
{
	return chr + str;
}
function uncons(str)
{
	var hd = str[0];
	if (hd)
	{
		return _elm_lang$core$Maybe$Just(_elm_lang$core$Native_Utils.Tuple2(_elm_lang$core$Native_Utils.chr(hd), str.slice(1)));
	}
	return _elm_lang$core$Maybe$Nothing;
}
function append(a, b)
{
	return a + b;
}
function concat(strs)
{
	return _elm_lang$core$Native_List.toArray(strs).join('');
}
function length(str)
{
	return str.length;
}
function map(f, str)
{
	var out = str.split('');
	for (var i = out.length; i--; )
	{
		out[i] = f(_elm_lang$core$Native_Utils.chr(out[i]));
	}
	return out.join('');
}
function filter(pred, str)
{
	return str.split('').map(_elm_lang$core$Native_Utils.chr).filter(pred).join('');
}
function reverse(str)
{
	return str.split('').reverse().join('');
}
function foldl(f, b, str)
{
	var len = str.length;
	for (var i = 0; i < len; ++i)
	{
		b = A2(f, _elm_lang$core$Native_Utils.chr(str[i]), b);
	}
	return b;
}
function foldr(f, b, str)
{
	for (var i = str.length; i--; )
	{
		b = A2(f, _elm_lang$core$Native_Utils.chr(str[i]), b);
	}
	return b;
}
function split(sep, str)
{
	return _elm_lang$core$Native_List.fromArray(str.split(sep));
}
function join(sep, strs)
{
	return _elm_lang$core$Native_List.toArray(strs).join(sep);
}
function repeat(n, str)
{
	var result = '';
	while (n > 0)
	{
		if (n & 1)
		{
			result += str;
		}
		n >>= 1, str += str;
	}
	return result;
}
function slice(start, end, str)
{
	return str.slice(start, end);
}
function left(n, str)
{
	return n < 1 ? '' : str.slice(0, n);
}
function right(n, str)
{
	return n < 1 ? '' : str.slice(-n);
}
function dropLeft(n, str)
{
	return n < 1 ? str : str.slice(n);
}
function dropRight(n, str)
{
	return n < 1 ? str : str.slice(0, -n);
}
function pad(n, chr, str)
{
	var half = (n - str.length) / 2;
	return repeat(Math.ceil(half), chr) + str + repeat(half | 0, chr);
}
function padRight(n, chr, str)
{
	return str + repeat(n - str.length, chr);
}
function padLeft(n, chr, str)
{
	return repeat(n - str.length, chr) + str;
}

function trim(str)
{
	return str.trim();
}
function trimLeft(str)
{
	return str.replace(/^\s+/, '');
}
function trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function words(str)
{
	return _elm_lang$core$Native_List.fromArray(str.trim().split(/\s+/g));
}
function lines(str)
{
	return _elm_lang$core$Native_List.fromArray(str.split(/\r\n|\r|\n/g));
}

function toUpper(str)
{
	return str.toUpperCase();
}
function toLower(str)
{
	return str.toLowerCase();
}

function any(pred, str)
{
	for (var i = str.length; i--; )
	{
		if (pred(_elm_lang$core$Native_Utils.chr(str[i])))
		{
			return true;
		}
	}
	return false;
}
function all(pred, str)
{
	for (var i = str.length; i--; )
	{
		if (!pred(_elm_lang$core$Native_Utils.chr(str[i])))
		{
			return false;
		}
	}
	return true;
}

function contains(sub, str)
{
	return str.indexOf(sub) > -1;
}
function startsWith(sub, str)
{
	return str.indexOf(sub) === 0;
}
function endsWith(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
}
function indexes(sub, str)
{
	var subLen = sub.length;
	var i = 0;
	var is = [];
	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}
	return _elm_lang$core$Native_List.fromArray(is);
}

function toInt(s)
{
	var len = s.length;
	if (len === 0)
	{
		return _elm_lang$core$Result$Err("could not convert string '" + s + "' to an Int" );
	}
	var start = 0;
	if (s[0] === '-')
	{
		if (len === 1)
		{
			return _elm_lang$core$Result$Err("could not convert string '" + s + "' to an Int" );
		}
		start = 1;
	}
	for (var i = start; i < len; ++i)
	{
		var c = s[i];
		if (c < '0' || '9' < c)
		{
			return _elm_lang$core$Result$Err("could not convert string '" + s + "' to an Int" );
		}
	}
	return _elm_lang$core$Result$Ok(parseInt(s, 10));
}

function toFloat(s)
{
	var len = s.length;
	if (len === 0)
	{
		return _elm_lang$core$Result$Err("could not convert string '" + s + "' to a Float" );
	}
	var start = 0;
	if (s[0] === '-')
	{
		if (len === 1)
		{
			return _elm_lang$core$Result$Err("could not convert string '" + s + "' to a Float" );
		}
		start = 1;
	}
	var dotCount = 0;
	for (var i = start; i < len; ++i)
	{
		var c = s[i];
		if ('0' <= c && c <= '9')
		{
			continue;
		}
		if (c === '.')
		{
			dotCount += 1;
			if (dotCount <= 1)
			{
				continue;
			}
		}
		return _elm_lang$core$Result$Err("could not convert string '" + s + "' to a Float" );
	}
	return _elm_lang$core$Result$Ok(parseFloat(s));
}

function toList(str)
{
	return _elm_lang$core$Native_List.fromArray(str.split('').map(_elm_lang$core$Native_Utils.chr));
}
function fromList(chars)
{
	return _elm_lang$core$Native_List.toArray(chars).join('');
}

return {
	isEmpty: isEmpty,
	cons: F2(cons),
	uncons: uncons,
	append: F2(append),
	concat: concat,
	length: length,
	map: F2(map),
	filter: F2(filter),
	reverse: reverse,
	foldl: F3(foldl),
	foldr: F3(foldr),

	split: F2(split),
	join: F2(join),
	repeat: F2(repeat),

	slice: F3(slice),
	left: F2(left),
	right: F2(right),
	dropLeft: F2(dropLeft),
	dropRight: F2(dropRight),

	pad: F3(pad),
	padLeft: F3(padLeft),
	padRight: F3(padRight),

	trim: trim,
	trimLeft: trimLeft,
	trimRight: trimRight,

	words: words,
	lines: lines,

	toUpper: toUpper,
	toLower: toLower,

	any: F2(any),
	all: F2(all),

	contains: F2(contains),
	startsWith: F2(startsWith),
	endsWith: F2(endsWith),
	indexes: F2(indexes),

	toInt: toInt,
	toFloat: toFloat,
	toList: toList,
	fromList: fromList
};

}();
//import Native.Utils //

var _elm_lang$core$Native_Char = function() {

return {
	fromCode: function(c) { return _elm_lang$core$Native_Utils.chr(String.fromCharCode(c)); },
	toCode: function(c) { return c.charCodeAt(0); },
	toUpper: function(c) { return _elm_lang$core$Native_Utils.chr(c.toUpperCase()); },
	toLower: function(c) { return _elm_lang$core$Native_Utils.chr(c.toLowerCase()); },
	toLocaleUpper: function(c) { return _elm_lang$core$Native_Utils.chr(c.toLocaleUpperCase()); },
	toLocaleLower: function(c) { return _elm_lang$core$Native_Utils.chr(c.toLocaleLowerCase()); }
};

}();
var _elm_lang$core$Char$fromCode = _elm_lang$core$Native_Char.fromCode;
var _elm_lang$core$Char$toCode = _elm_lang$core$Native_Char.toCode;
var _elm_lang$core$Char$toLocaleLower = _elm_lang$core$Native_Char.toLocaleLower;
var _elm_lang$core$Char$toLocaleUpper = _elm_lang$core$Native_Char.toLocaleUpper;
var _elm_lang$core$Char$toLower = _elm_lang$core$Native_Char.toLower;
var _elm_lang$core$Char$toUpper = _elm_lang$core$Native_Char.toUpper;
var _elm_lang$core$Char$isBetween = F3(
	function (low, high, $char) {
		var code = _elm_lang$core$Char$toCode($char);
		return (_elm_lang$core$Native_Utils.cmp(
			code,
			_elm_lang$core$Char$toCode(low)) > -1) && (_elm_lang$core$Native_Utils.cmp(
			code,
			_elm_lang$core$Char$toCode(high)) < 1);
	});
var _elm_lang$core$Char$isUpper = A2(
	_elm_lang$core$Char$isBetween,
	_elm_lang$core$Native_Utils.chr('A'),
	_elm_lang$core$Native_Utils.chr('Z'));
var _elm_lang$core$Char$isLower = A2(
	_elm_lang$core$Char$isBetween,
	_elm_lang$core$Native_Utils.chr('a'),
	_elm_lang$core$Native_Utils.chr('z'));
var _elm_lang$core$Char$isDigit = A2(
	_elm_lang$core$Char$isBetween,
	_elm_lang$core$Native_Utils.chr('0'),
	_elm_lang$core$Native_Utils.chr('9'));
var _elm_lang$core$Char$isOctDigit = A2(
	_elm_lang$core$Char$isBetween,
	_elm_lang$core$Native_Utils.chr('0'),
	_elm_lang$core$Native_Utils.chr('7'));
var _elm_lang$core$Char$isHexDigit = function ($char) {
	return _elm_lang$core$Char$isDigit($char) || (A3(
		_elm_lang$core$Char$isBetween,
		_elm_lang$core$Native_Utils.chr('a'),
		_elm_lang$core$Native_Utils.chr('f'),
		$char) || A3(
		_elm_lang$core$Char$isBetween,
		_elm_lang$core$Native_Utils.chr('A'),
		_elm_lang$core$Native_Utils.chr('F'),
		$char));
};

var _elm_lang$core$String$fromList = _elm_lang$core$Native_String.fromList;
var _elm_lang$core$String$toList = _elm_lang$core$Native_String.toList;
var _elm_lang$core$String$toFloat = _elm_lang$core$Native_String.toFloat;
var _elm_lang$core$String$toInt = _elm_lang$core$Native_String.toInt;
var _elm_lang$core$String$indices = _elm_lang$core$Native_String.indexes;
var _elm_lang$core$String$indexes = _elm_lang$core$Native_String.indexes;
var _elm_lang$core$String$endsWith = _elm_lang$core$Native_String.endsWith;
var _elm_lang$core$String$startsWith = _elm_lang$core$Native_String.startsWith;
var _elm_lang$core$String$contains = _elm_lang$core$Native_String.contains;
var _elm_lang$core$String$all = _elm_lang$core$Native_String.all;
var _elm_lang$core$String$any = _elm_lang$core$Native_String.any;
var _elm_lang$core$String$toLower = _elm_lang$core$Native_String.toLower;
var _elm_lang$core$String$toUpper = _elm_lang$core$Native_String.toUpper;
var _elm_lang$core$String$lines = _elm_lang$core$Native_String.lines;
var _elm_lang$core$String$words = _elm_lang$core$Native_String.words;
var _elm_lang$core$String$trimRight = _elm_lang$core$Native_String.trimRight;
var _elm_lang$core$String$trimLeft = _elm_lang$core$Native_String.trimLeft;
var _elm_lang$core$String$trim = _elm_lang$core$Native_String.trim;
var _elm_lang$core$String$padRight = _elm_lang$core$Native_String.padRight;
var _elm_lang$core$String$padLeft = _elm_lang$core$Native_String.padLeft;
var _elm_lang$core$String$pad = _elm_lang$core$Native_String.pad;
var _elm_lang$core$String$dropRight = _elm_lang$core$Native_String.dropRight;
var _elm_lang$core$String$dropLeft = _elm_lang$core$Native_String.dropLeft;
var _elm_lang$core$String$right = _elm_lang$core$Native_String.right;
var _elm_lang$core$String$left = _elm_lang$core$Native_String.left;
var _elm_lang$core$String$slice = _elm_lang$core$Native_String.slice;
var _elm_lang$core$String$repeat = _elm_lang$core$Native_String.repeat;
var _elm_lang$core$String$join = _elm_lang$core$Native_String.join;
var _elm_lang$core$String$split = _elm_lang$core$Native_String.split;
var _elm_lang$core$String$foldr = _elm_lang$core$Native_String.foldr;
var _elm_lang$core$String$foldl = _elm_lang$core$Native_String.foldl;
var _elm_lang$core$String$reverse = _elm_lang$core$Native_String.reverse;
var _elm_lang$core$String$filter = _elm_lang$core$Native_String.filter;
var _elm_lang$core$String$map = _elm_lang$core$Native_String.map;
var _elm_lang$core$String$length = _elm_lang$core$Native_String.length;
var _elm_lang$core$String$concat = _elm_lang$core$Native_String.concat;
var _elm_lang$core$String$append = _elm_lang$core$Native_String.append;
var _elm_lang$core$String$uncons = _elm_lang$core$Native_String.uncons;
var _elm_lang$core$String$cons = _elm_lang$core$Native_String.cons;
var _elm_lang$core$String$fromChar = function ($char) {
	return A2(_elm_lang$core$String$cons, $char, '');
};
var _elm_lang$core$String$isEmpty = _elm_lang$core$Native_String.isEmpty;

var _elm_lang$core$Dict$foldr = F3(
	function (f, acc, t) {
		foldr:
		while (true) {
			var _p0 = t;
			if (_p0.ctor === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var _v1 = f,
					_v2 = A3(
					f,
					_p0._1,
					_p0._2,
					A3(_elm_lang$core$Dict$foldr, f, acc, _p0._4)),
					_v3 = _p0._3;
				f = _v1;
				acc = _v2;
				t = _v3;
				continue foldr;
			}
		}
	});
var _elm_lang$core$Dict$keys = function (dict) {
	return A3(
		_elm_lang$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return A2(_elm_lang$core$List_ops['::'], key, keyList);
			}),
		_elm_lang$core$Native_List.fromArray(
			[]),
		dict);
};
var _elm_lang$core$Dict$values = function (dict) {
	return A3(
		_elm_lang$core$Dict$foldr,
		F3(
			function (key, value, valueList) {
				return A2(_elm_lang$core$List_ops['::'], value, valueList);
			}),
		_elm_lang$core$Native_List.fromArray(
			[]),
		dict);
};
var _elm_lang$core$Dict$toList = function (dict) {
	return A3(
		_elm_lang$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return A2(
					_elm_lang$core$List_ops['::'],
					{ctor: '_Tuple2', _0: key, _1: value},
					list);
			}),
		_elm_lang$core$Native_List.fromArray(
			[]),
		dict);
};
var _elm_lang$core$Dict$foldl = F3(
	function (f, acc, dict) {
		foldl:
		while (true) {
			var _p1 = dict;
			if (_p1.ctor === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var _v5 = f,
					_v6 = A3(
					f,
					_p1._1,
					_p1._2,
					A3(_elm_lang$core$Dict$foldl, f, acc, _p1._3)),
					_v7 = _p1._4;
				f = _v5;
				acc = _v6;
				dict = _v7;
				continue foldl;
			}
		}
	});
var _elm_lang$core$Dict$merge = F6(
	function (leftStep, bothStep, rightStep, leftDict, rightDict, initialResult) {
		var stepState = F3(
			function (rKey, rValue, _p2) {
				var _p3 = _p2;
				var _p9 = _p3._1;
				var _p8 = _p3._0;
				var _p4 = _p8;
				if (_p4.ctor === '[]') {
					return {
						ctor: '_Tuple2',
						_0: _p8,
						_1: A3(rightStep, rKey, rValue, _p9)
					};
				} else {
					var _p7 = _p4._1;
					var _p6 = _p4._0._1;
					var _p5 = _p4._0._0;
					return (_elm_lang$core$Native_Utils.cmp(_p5, rKey) < 0) ? {
						ctor: '_Tuple2',
						_0: _p7,
						_1: A3(leftStep, _p5, _p6, _p9)
					} : ((_elm_lang$core$Native_Utils.cmp(_p5, rKey) > 0) ? {
						ctor: '_Tuple2',
						_0: _p8,
						_1: A3(rightStep, rKey, rValue, _p9)
					} : {
						ctor: '_Tuple2',
						_0: _p7,
						_1: A4(bothStep, _p5, _p6, rValue, _p9)
					});
				}
			});
		var _p10 = A3(
			_elm_lang$core$Dict$foldl,
			stepState,
			{
				ctor: '_Tuple2',
				_0: _elm_lang$core$Dict$toList(leftDict),
				_1: initialResult
			},
			rightDict);
		var leftovers = _p10._0;
		var intermediateResult = _p10._1;
		return A3(
			_elm_lang$core$List$foldl,
			F2(
				function (_p11, result) {
					var _p12 = _p11;
					return A3(leftStep, _p12._0, _p12._1, result);
				}),
			intermediateResult,
			leftovers);
	});
var _elm_lang$core$Dict$reportRemBug = F4(
	function (msg, c, lgot, rgot) {
		return _elm_lang$core$Native_Debug.crash(
			_elm_lang$core$String$concat(
				_elm_lang$core$Native_List.fromArray(
					[
						'Internal red-black tree invariant violated, expected ',
						msg,
						' and got ',
						_elm_lang$core$Basics$toString(c),
						'/',
						lgot,
						'/',
						rgot,
						'\nPlease report this bug to <https://github.com/elm-lang/core/issues>'
					])));
	});
var _elm_lang$core$Dict$isBBlack = function (dict) {
	var _p13 = dict;
	_v11_2:
	do {
		if (_p13.ctor === 'RBNode_elm_builtin') {
			if (_p13._0.ctor === 'BBlack') {
				return true;
			} else {
				break _v11_2;
			}
		} else {
			if (_p13._0.ctor === 'LBBlack') {
				return true;
			} else {
				break _v11_2;
			}
		}
	} while(false);
	return false;
};
var _elm_lang$core$Dict$sizeHelp = F2(
	function (n, dict) {
		sizeHelp:
		while (true) {
			var _p14 = dict;
			if (_p14.ctor === 'RBEmpty_elm_builtin') {
				return n;
			} else {
				var _v13 = A2(_elm_lang$core$Dict$sizeHelp, n + 1, _p14._4),
					_v14 = _p14._3;
				n = _v13;
				dict = _v14;
				continue sizeHelp;
			}
		}
	});
var _elm_lang$core$Dict$size = function (dict) {
	return A2(_elm_lang$core$Dict$sizeHelp, 0, dict);
};
var _elm_lang$core$Dict$get = F2(
	function (targetKey, dict) {
		get:
		while (true) {
			var _p15 = dict;
			if (_p15.ctor === 'RBEmpty_elm_builtin') {
				return _elm_lang$core$Maybe$Nothing;
			} else {
				var _p16 = A2(_elm_lang$core$Basics$compare, targetKey, _p15._1);
				switch (_p16.ctor) {
					case 'LT':
						var _v17 = targetKey,
							_v18 = _p15._3;
						targetKey = _v17;
						dict = _v18;
						continue get;
					case 'EQ':
						return _elm_lang$core$Maybe$Just(_p15._2);
					default:
						var _v19 = targetKey,
							_v20 = _p15._4;
						targetKey = _v19;
						dict = _v20;
						continue get;
				}
			}
		}
	});
var _elm_lang$core$Dict$member = F2(
	function (key, dict) {
		var _p17 = A2(_elm_lang$core$Dict$get, key, dict);
		if (_p17.ctor === 'Just') {
			return true;
		} else {
			return false;
		}
	});
var _elm_lang$core$Dict$maxWithDefault = F3(
	function (k, v, r) {
		maxWithDefault:
		while (true) {
			var _p18 = r;
			if (_p18.ctor === 'RBEmpty_elm_builtin') {
				return {ctor: '_Tuple2', _0: k, _1: v};
			} else {
				var _v23 = _p18._1,
					_v24 = _p18._2,
					_v25 = _p18._4;
				k = _v23;
				v = _v24;
				r = _v25;
				continue maxWithDefault;
			}
		}
	});
var _elm_lang$core$Dict$NBlack = {ctor: 'NBlack'};
var _elm_lang$core$Dict$BBlack = {ctor: 'BBlack'};
var _elm_lang$core$Dict$Black = {ctor: 'Black'};
var _elm_lang$core$Dict$blackish = function (t) {
	var _p19 = t;
	if (_p19.ctor === 'RBNode_elm_builtin') {
		var _p20 = _p19._0;
		return _elm_lang$core$Native_Utils.eq(_p20, _elm_lang$core$Dict$Black) || _elm_lang$core$Native_Utils.eq(_p20, _elm_lang$core$Dict$BBlack);
	} else {
		return true;
	}
};
var _elm_lang$core$Dict$Red = {ctor: 'Red'};
var _elm_lang$core$Dict$moreBlack = function (color) {
	var _p21 = color;
	switch (_p21.ctor) {
		case 'Black':
			return _elm_lang$core$Dict$BBlack;
		case 'Red':
			return _elm_lang$core$Dict$Black;
		case 'NBlack':
			return _elm_lang$core$Dict$Red;
		default:
			return _elm_lang$core$Native_Debug.crash('Can\'t make a double black node more black!');
	}
};
var _elm_lang$core$Dict$lessBlack = function (color) {
	var _p22 = color;
	switch (_p22.ctor) {
		case 'BBlack':
			return _elm_lang$core$Dict$Black;
		case 'Black':
			return _elm_lang$core$Dict$Red;
		case 'Red':
			return _elm_lang$core$Dict$NBlack;
		default:
			return _elm_lang$core$Native_Debug.crash('Can\'t make a negative black node less black!');
	}
};
var _elm_lang$core$Dict$LBBlack = {ctor: 'LBBlack'};
var _elm_lang$core$Dict$LBlack = {ctor: 'LBlack'};
var _elm_lang$core$Dict$RBEmpty_elm_builtin = function (a) {
	return {ctor: 'RBEmpty_elm_builtin', _0: a};
};
var _elm_lang$core$Dict$empty = _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
var _elm_lang$core$Dict$isEmpty = function (dict) {
	return _elm_lang$core$Native_Utils.eq(dict, _elm_lang$core$Dict$empty);
};
var _elm_lang$core$Dict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {ctor: 'RBNode_elm_builtin', _0: a, _1: b, _2: c, _3: d, _4: e};
	});
var _elm_lang$core$Dict$ensureBlackRoot = function (dict) {
	var _p23 = dict;
	if ((_p23.ctor === 'RBNode_elm_builtin') && (_p23._0.ctor === 'Red')) {
		return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p23._1, _p23._2, _p23._3, _p23._4);
	} else {
		return dict;
	}
};
var _elm_lang$core$Dict$lessBlackTree = function (dict) {
	var _p24 = dict;
	if (_p24.ctor === 'RBNode_elm_builtin') {
		return A5(
			_elm_lang$core$Dict$RBNode_elm_builtin,
			_elm_lang$core$Dict$lessBlack(_p24._0),
			_p24._1,
			_p24._2,
			_p24._3,
			_p24._4);
	} else {
		return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
	}
};
var _elm_lang$core$Dict$balancedTree = function (col) {
	return function (xk) {
		return function (xv) {
			return function (yk) {
				return function (yv) {
					return function (zk) {
						return function (zv) {
							return function (a) {
								return function (b) {
									return function (c) {
										return function (d) {
											return A5(
												_elm_lang$core$Dict$RBNode_elm_builtin,
												_elm_lang$core$Dict$lessBlack(col),
												yk,
												yv,
												A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, xk, xv, a, b),
												A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, zk, zv, c, d));
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};
};
var _elm_lang$core$Dict$blacken = function (t) {
	var _p25 = t;
	if (_p25.ctor === 'RBEmpty_elm_builtin') {
		return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
	} else {
		return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p25._1, _p25._2, _p25._3, _p25._4);
	}
};
var _elm_lang$core$Dict$redden = function (t) {
	var _p26 = t;
	if (_p26.ctor === 'RBEmpty_elm_builtin') {
		return _elm_lang$core$Native_Debug.crash('can\'t make a Leaf red');
	} else {
		return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Red, _p26._1, _p26._2, _p26._3, _p26._4);
	}
};
var _elm_lang$core$Dict$balanceHelp = function (tree) {
	var _p27 = tree;
	_v33_6:
	do {
		_v33_5:
		do {
			_v33_4:
			do {
				_v33_3:
				do {
					_v33_2:
					do {
						_v33_1:
						do {
							_v33_0:
							do {
								if (_p27.ctor === 'RBNode_elm_builtin') {
									if (_p27._3.ctor === 'RBNode_elm_builtin') {
										if (_p27._4.ctor === 'RBNode_elm_builtin') {
											switch (_p27._3._0.ctor) {
												case 'Red':
													switch (_p27._4._0.ctor) {
														case 'Red':
															if ((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Red')) {
																break _v33_0;
															} else {
																if ((_p27._3._4.ctor === 'RBNode_elm_builtin') && (_p27._3._4._0.ctor === 'Red')) {
																	break _v33_1;
																} else {
																	if ((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Red')) {
																		break _v33_2;
																	} else {
																		if ((_p27._4._4.ctor === 'RBNode_elm_builtin') && (_p27._4._4._0.ctor === 'Red')) {
																			break _v33_3;
																		} else {
																			break _v33_6;
																		}
																	}
																}
															}
														case 'NBlack':
															if ((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Red')) {
																break _v33_0;
															} else {
																if ((_p27._3._4.ctor === 'RBNode_elm_builtin') && (_p27._3._4._0.ctor === 'Red')) {
																	break _v33_1;
																} else {
																	if (((((_p27._0.ctor === 'BBlack') && (_p27._4._3.ctor === 'RBNode_elm_builtin')) && (_p27._4._3._0.ctor === 'Black')) && (_p27._4._4.ctor === 'RBNode_elm_builtin')) && (_p27._4._4._0.ctor === 'Black')) {
																		break _v33_4;
																	} else {
																		break _v33_6;
																	}
																}
															}
														default:
															if ((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Red')) {
																break _v33_0;
															} else {
																if ((_p27._3._4.ctor === 'RBNode_elm_builtin') && (_p27._3._4._0.ctor === 'Red')) {
																	break _v33_1;
																} else {
																	break _v33_6;
																}
															}
													}
												case 'NBlack':
													switch (_p27._4._0.ctor) {
														case 'Red':
															if ((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Red')) {
																break _v33_2;
															} else {
																if ((_p27._4._4.ctor === 'RBNode_elm_builtin') && (_p27._4._4._0.ctor === 'Red')) {
																	break _v33_3;
																} else {
																	if (((((_p27._0.ctor === 'BBlack') && (_p27._3._3.ctor === 'RBNode_elm_builtin')) && (_p27._3._3._0.ctor === 'Black')) && (_p27._3._4.ctor === 'RBNode_elm_builtin')) && (_p27._3._4._0.ctor === 'Black')) {
																		break _v33_5;
																	} else {
																		break _v33_6;
																	}
																}
															}
														case 'NBlack':
															if (_p27._0.ctor === 'BBlack') {
																if ((((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Black')) && (_p27._4._4.ctor === 'RBNode_elm_builtin')) && (_p27._4._4._0.ctor === 'Black')) {
																	break _v33_4;
																} else {
																	if ((((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Black')) && (_p27._3._4.ctor === 'RBNode_elm_builtin')) && (_p27._3._4._0.ctor === 'Black')) {
																		break _v33_5;
																	} else {
																		break _v33_6;
																	}
																}
															} else {
																break _v33_6;
															}
														default:
															if (((((_p27._0.ctor === 'BBlack') && (_p27._3._3.ctor === 'RBNode_elm_builtin')) && (_p27._3._3._0.ctor === 'Black')) && (_p27._3._4.ctor === 'RBNode_elm_builtin')) && (_p27._3._4._0.ctor === 'Black')) {
																break _v33_5;
															} else {
																break _v33_6;
															}
													}
												default:
													switch (_p27._4._0.ctor) {
														case 'Red':
															if ((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Red')) {
																break _v33_2;
															} else {
																if ((_p27._4._4.ctor === 'RBNode_elm_builtin') && (_p27._4._4._0.ctor === 'Red')) {
																	break _v33_3;
																} else {
																	break _v33_6;
																}
															}
														case 'NBlack':
															if (((((_p27._0.ctor === 'BBlack') && (_p27._4._3.ctor === 'RBNode_elm_builtin')) && (_p27._4._3._0.ctor === 'Black')) && (_p27._4._4.ctor === 'RBNode_elm_builtin')) && (_p27._4._4._0.ctor === 'Black')) {
																break _v33_4;
															} else {
																break _v33_6;
															}
														default:
															break _v33_6;
													}
											}
										} else {
											switch (_p27._3._0.ctor) {
												case 'Red':
													if ((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Red')) {
														break _v33_0;
													} else {
														if ((_p27._3._4.ctor === 'RBNode_elm_builtin') && (_p27._3._4._0.ctor === 'Red')) {
															break _v33_1;
														} else {
															break _v33_6;
														}
													}
												case 'NBlack':
													if (((((_p27._0.ctor === 'BBlack') && (_p27._3._3.ctor === 'RBNode_elm_builtin')) && (_p27._3._3._0.ctor === 'Black')) && (_p27._3._4.ctor === 'RBNode_elm_builtin')) && (_p27._3._4._0.ctor === 'Black')) {
														break _v33_5;
													} else {
														break _v33_6;
													}
												default:
													break _v33_6;
											}
										}
									} else {
										if (_p27._4.ctor === 'RBNode_elm_builtin') {
											switch (_p27._4._0.ctor) {
												case 'Red':
													if ((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Red')) {
														break _v33_2;
													} else {
														if ((_p27._4._4.ctor === 'RBNode_elm_builtin') && (_p27._4._4._0.ctor === 'Red')) {
															break _v33_3;
														} else {
															break _v33_6;
														}
													}
												case 'NBlack':
													if (((((_p27._0.ctor === 'BBlack') && (_p27._4._3.ctor === 'RBNode_elm_builtin')) && (_p27._4._3._0.ctor === 'Black')) && (_p27._4._4.ctor === 'RBNode_elm_builtin')) && (_p27._4._4._0.ctor === 'Black')) {
														break _v33_4;
													} else {
														break _v33_6;
													}
												default:
													break _v33_6;
											}
										} else {
											break _v33_6;
										}
									}
								} else {
									break _v33_6;
								}
							} while(false);
							return _elm_lang$core$Dict$balancedTree(_p27._0)(_p27._3._3._1)(_p27._3._3._2)(_p27._3._1)(_p27._3._2)(_p27._1)(_p27._2)(_p27._3._3._3)(_p27._3._3._4)(_p27._3._4)(_p27._4);
						} while(false);
						return _elm_lang$core$Dict$balancedTree(_p27._0)(_p27._3._1)(_p27._3._2)(_p27._3._4._1)(_p27._3._4._2)(_p27._1)(_p27._2)(_p27._3._3)(_p27._3._4._3)(_p27._3._4._4)(_p27._4);
					} while(false);
					return _elm_lang$core$Dict$balancedTree(_p27._0)(_p27._1)(_p27._2)(_p27._4._3._1)(_p27._4._3._2)(_p27._4._1)(_p27._4._2)(_p27._3)(_p27._4._3._3)(_p27._4._3._4)(_p27._4._4);
				} while(false);
				return _elm_lang$core$Dict$balancedTree(_p27._0)(_p27._1)(_p27._2)(_p27._4._1)(_p27._4._2)(_p27._4._4._1)(_p27._4._4._2)(_p27._3)(_p27._4._3)(_p27._4._4._3)(_p27._4._4._4);
			} while(false);
			return A5(
				_elm_lang$core$Dict$RBNode_elm_builtin,
				_elm_lang$core$Dict$Black,
				_p27._4._3._1,
				_p27._4._3._2,
				A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p27._1, _p27._2, _p27._3, _p27._4._3._3),
				A5(
					_elm_lang$core$Dict$balance,
					_elm_lang$core$Dict$Black,
					_p27._4._1,
					_p27._4._2,
					_p27._4._3._4,
					_elm_lang$core$Dict$redden(_p27._4._4)));
		} while(false);
		return A5(
			_elm_lang$core$Dict$RBNode_elm_builtin,
			_elm_lang$core$Dict$Black,
			_p27._3._4._1,
			_p27._3._4._2,
			A5(
				_elm_lang$core$Dict$balance,
				_elm_lang$core$Dict$Black,
				_p27._3._1,
				_p27._3._2,
				_elm_lang$core$Dict$redden(_p27._3._3),
				_p27._3._4._3),
			A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p27._1, _p27._2, _p27._3._4._4, _p27._4));
	} while(false);
	return tree;
};
var _elm_lang$core$Dict$balance = F5(
	function (c, k, v, l, r) {
		var tree = A5(_elm_lang$core$Dict$RBNode_elm_builtin, c, k, v, l, r);
		return _elm_lang$core$Dict$blackish(tree) ? _elm_lang$core$Dict$balanceHelp(tree) : tree;
	});
var _elm_lang$core$Dict$bubble = F5(
	function (c, k, v, l, r) {
		return (_elm_lang$core$Dict$isBBlack(l) || _elm_lang$core$Dict$isBBlack(r)) ? A5(
			_elm_lang$core$Dict$balance,
			_elm_lang$core$Dict$moreBlack(c),
			k,
			v,
			_elm_lang$core$Dict$lessBlackTree(l),
			_elm_lang$core$Dict$lessBlackTree(r)) : A5(_elm_lang$core$Dict$RBNode_elm_builtin, c, k, v, l, r);
	});
var _elm_lang$core$Dict$removeMax = F5(
	function (c, k, v, l, r) {
		var _p28 = r;
		if (_p28.ctor === 'RBEmpty_elm_builtin') {
			return A3(_elm_lang$core$Dict$rem, c, l, r);
		} else {
			return A5(
				_elm_lang$core$Dict$bubble,
				c,
				k,
				v,
				l,
				A5(_elm_lang$core$Dict$removeMax, _p28._0, _p28._1, _p28._2, _p28._3, _p28._4));
		}
	});
var _elm_lang$core$Dict$rem = F3(
	function (c, l, r) {
		var _p29 = {ctor: '_Tuple2', _0: l, _1: r};
		if (_p29._0.ctor === 'RBEmpty_elm_builtin') {
			if (_p29._1.ctor === 'RBEmpty_elm_builtin') {
				var _p30 = c;
				switch (_p30.ctor) {
					case 'Red':
						return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
					case 'Black':
						return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBBlack);
					default:
						return _elm_lang$core$Native_Debug.crash('cannot have bblack or nblack nodes at this point');
				}
			} else {
				var _p33 = _p29._1._0;
				var _p32 = _p29._0._0;
				var _p31 = {ctor: '_Tuple3', _0: c, _1: _p32, _2: _p33};
				if ((((_p31.ctor === '_Tuple3') && (_p31._0.ctor === 'Black')) && (_p31._1.ctor === 'LBlack')) && (_p31._2.ctor === 'Red')) {
					return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p29._1._1, _p29._1._2, _p29._1._3, _p29._1._4);
				} else {
					return A4(
						_elm_lang$core$Dict$reportRemBug,
						'Black/LBlack/Red',
						c,
						_elm_lang$core$Basics$toString(_p32),
						_elm_lang$core$Basics$toString(_p33));
				}
			}
		} else {
			if (_p29._1.ctor === 'RBEmpty_elm_builtin') {
				var _p36 = _p29._1._0;
				var _p35 = _p29._0._0;
				var _p34 = {ctor: '_Tuple3', _0: c, _1: _p35, _2: _p36};
				if ((((_p34.ctor === '_Tuple3') && (_p34._0.ctor === 'Black')) && (_p34._1.ctor === 'Red')) && (_p34._2.ctor === 'LBlack')) {
					return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p29._0._1, _p29._0._2, _p29._0._3, _p29._0._4);
				} else {
					return A4(
						_elm_lang$core$Dict$reportRemBug,
						'Black/Red/LBlack',
						c,
						_elm_lang$core$Basics$toString(_p35),
						_elm_lang$core$Basics$toString(_p36));
				}
			} else {
				var _p40 = _p29._0._2;
				var _p39 = _p29._0._4;
				var _p38 = _p29._0._1;
				var l$ = A5(_elm_lang$core$Dict$removeMax, _p29._0._0, _p38, _p40, _p29._0._3, _p39);
				var _p37 = A3(_elm_lang$core$Dict$maxWithDefault, _p38, _p40, _p39);
				var k = _p37._0;
				var v = _p37._1;
				return A5(_elm_lang$core$Dict$bubble, c, k, v, l$, r);
			}
		}
	});
var _elm_lang$core$Dict$map = F2(
	function (f, dict) {
		var _p41 = dict;
		if (_p41.ctor === 'RBEmpty_elm_builtin') {
			return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
		} else {
			var _p42 = _p41._1;
			return A5(
				_elm_lang$core$Dict$RBNode_elm_builtin,
				_p41._0,
				_p42,
				A2(f, _p42, _p41._2),
				A2(_elm_lang$core$Dict$map, f, _p41._3),
				A2(_elm_lang$core$Dict$map, f, _p41._4));
		}
	});
var _elm_lang$core$Dict$Same = {ctor: 'Same'};
var _elm_lang$core$Dict$Remove = {ctor: 'Remove'};
var _elm_lang$core$Dict$Insert = {ctor: 'Insert'};
var _elm_lang$core$Dict$update = F3(
	function (k, alter, dict) {
		var up = function (dict) {
			var _p43 = dict;
			if (_p43.ctor === 'RBEmpty_elm_builtin') {
				var _p44 = alter(_elm_lang$core$Maybe$Nothing);
				if (_p44.ctor === 'Nothing') {
					return {ctor: '_Tuple2', _0: _elm_lang$core$Dict$Same, _1: _elm_lang$core$Dict$empty};
				} else {
					return {
						ctor: '_Tuple2',
						_0: _elm_lang$core$Dict$Insert,
						_1: A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Red, k, _p44._0, _elm_lang$core$Dict$empty, _elm_lang$core$Dict$empty)
					};
				}
			} else {
				var _p55 = _p43._2;
				var _p54 = _p43._4;
				var _p53 = _p43._3;
				var _p52 = _p43._1;
				var _p51 = _p43._0;
				var _p45 = A2(_elm_lang$core$Basics$compare, k, _p52);
				switch (_p45.ctor) {
					case 'EQ':
						var _p46 = alter(
							_elm_lang$core$Maybe$Just(_p55));
						if (_p46.ctor === 'Nothing') {
							return {
								ctor: '_Tuple2',
								_0: _elm_lang$core$Dict$Remove,
								_1: A3(_elm_lang$core$Dict$rem, _p51, _p53, _p54)
							};
						} else {
							return {
								ctor: '_Tuple2',
								_0: _elm_lang$core$Dict$Same,
								_1: A5(_elm_lang$core$Dict$RBNode_elm_builtin, _p51, _p52, _p46._0, _p53, _p54)
							};
						}
					case 'LT':
						var _p47 = up(_p53);
						var flag = _p47._0;
						var newLeft = _p47._1;
						var _p48 = flag;
						switch (_p48.ctor) {
							case 'Same':
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Same,
									_1: A5(_elm_lang$core$Dict$RBNode_elm_builtin, _p51, _p52, _p55, newLeft, _p54)
								};
							case 'Insert':
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Insert,
									_1: A5(_elm_lang$core$Dict$balance, _p51, _p52, _p55, newLeft, _p54)
								};
							default:
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Remove,
									_1: A5(_elm_lang$core$Dict$bubble, _p51, _p52, _p55, newLeft, _p54)
								};
						}
					default:
						var _p49 = up(_p54);
						var flag = _p49._0;
						var newRight = _p49._1;
						var _p50 = flag;
						switch (_p50.ctor) {
							case 'Same':
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Same,
									_1: A5(_elm_lang$core$Dict$RBNode_elm_builtin, _p51, _p52, _p55, _p53, newRight)
								};
							case 'Insert':
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Insert,
									_1: A5(_elm_lang$core$Dict$balance, _p51, _p52, _p55, _p53, newRight)
								};
							default:
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Remove,
									_1: A5(_elm_lang$core$Dict$bubble, _p51, _p52, _p55, _p53, newRight)
								};
						}
				}
			}
		};
		var _p56 = up(dict);
		var flag = _p56._0;
		var updatedDict = _p56._1;
		var _p57 = flag;
		switch (_p57.ctor) {
			case 'Same':
				return updatedDict;
			case 'Insert':
				return _elm_lang$core$Dict$ensureBlackRoot(updatedDict);
			default:
				return _elm_lang$core$Dict$blacken(updatedDict);
		}
	});
var _elm_lang$core$Dict$insert = F3(
	function (key, value, dict) {
		return A3(
			_elm_lang$core$Dict$update,
			key,
			_elm_lang$core$Basics$always(
				_elm_lang$core$Maybe$Just(value)),
			dict);
	});
var _elm_lang$core$Dict$singleton = F2(
	function (key, value) {
		return A3(_elm_lang$core$Dict$insert, key, value, _elm_lang$core$Dict$empty);
	});
var _elm_lang$core$Dict$union = F2(
	function (t1, t2) {
		return A3(_elm_lang$core$Dict$foldl, _elm_lang$core$Dict$insert, t2, t1);
	});
var _elm_lang$core$Dict$filter = F2(
	function (predicate, dictionary) {
		var add = F3(
			function (key, value, dict) {
				return A2(predicate, key, value) ? A3(_elm_lang$core$Dict$insert, key, value, dict) : dict;
			});
		return A3(_elm_lang$core$Dict$foldl, add, _elm_lang$core$Dict$empty, dictionary);
	});
var _elm_lang$core$Dict$intersect = F2(
	function (t1, t2) {
		return A2(
			_elm_lang$core$Dict$filter,
			F2(
				function (k, _p58) {
					return A2(_elm_lang$core$Dict$member, k, t2);
				}),
			t1);
	});
var _elm_lang$core$Dict$partition = F2(
	function (predicate, dict) {
		var add = F3(
			function (key, value, _p59) {
				var _p60 = _p59;
				var _p62 = _p60._1;
				var _p61 = _p60._0;
				return A2(predicate, key, value) ? {
					ctor: '_Tuple2',
					_0: A3(_elm_lang$core$Dict$insert, key, value, _p61),
					_1: _p62
				} : {
					ctor: '_Tuple2',
					_0: _p61,
					_1: A3(_elm_lang$core$Dict$insert, key, value, _p62)
				};
			});
		return A3(
			_elm_lang$core$Dict$foldl,
			add,
			{ctor: '_Tuple2', _0: _elm_lang$core$Dict$empty, _1: _elm_lang$core$Dict$empty},
			dict);
	});
var _elm_lang$core$Dict$fromList = function (assocs) {
	return A3(
		_elm_lang$core$List$foldl,
		F2(
			function (_p63, dict) {
				var _p64 = _p63;
				return A3(_elm_lang$core$Dict$insert, _p64._0, _p64._1, dict);
			}),
		_elm_lang$core$Dict$empty,
		assocs);
};
var _elm_lang$core$Dict$remove = F2(
	function (key, dict) {
		return A3(
			_elm_lang$core$Dict$update,
			key,
			_elm_lang$core$Basics$always(_elm_lang$core$Maybe$Nothing),
			dict);
	});
var _elm_lang$core$Dict$diff = F2(
	function (t1, t2) {
		return A3(
			_elm_lang$core$Dict$foldl,
			F3(
				function (k, v, t) {
					return A2(_elm_lang$core$Dict$remove, k, t);
				}),
			t1,
			t2);
	});

//import Native.Scheduler //

var _elm_lang$core$Native_Time = function() {

var now = _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
{
	callback(_elm_lang$core$Native_Scheduler.succeed(Date.now()));
});

function setInterval_(interval, task)
{
	return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
	{
		var id = setInterval(function() {
			_elm_lang$core$Native_Scheduler.rawSpawn(task);
		}, interval);

		return function() { clearInterval(id); };
	});
}

return {
	now: now,
	setInterval_: F2(setInterval_)
};

}();
var _elm_lang$core$Time$setInterval = _elm_lang$core$Native_Time.setInterval_;
var _elm_lang$core$Time$spawnHelp = F3(
	function (router, intervals, processes) {
		var _p0 = intervals;
		if (_p0.ctor === '[]') {
			return _elm_lang$core$Task$succeed(processes);
		} else {
			var _p1 = _p0._0;
			return A2(
				_elm_lang$core$Task$andThen,
				_elm_lang$core$Native_Scheduler.spawn(
					A2(
						_elm_lang$core$Time$setInterval,
						_p1,
						A2(_elm_lang$core$Platform$sendToSelf, router, _p1))),
				function (id) {
					return A3(
						_elm_lang$core$Time$spawnHelp,
						router,
						_p0._1,
						A3(_elm_lang$core$Dict$insert, _p1, id, processes));
				});
		}
	});
var _elm_lang$core$Time$addMySub = F2(
	function (_p2, state) {
		var _p3 = _p2;
		var _p6 = _p3._1;
		var _p5 = _p3._0;
		var _p4 = A2(_elm_lang$core$Dict$get, _p5, state);
		if (_p4.ctor === 'Nothing') {
			return A3(
				_elm_lang$core$Dict$insert,
				_p5,
				_elm_lang$core$Native_List.fromArray(
					[_p6]),
				state);
		} else {
			return A3(
				_elm_lang$core$Dict$insert,
				_p5,
				A2(_elm_lang$core$List_ops['::'], _p6, _p4._0),
				state);
		}
	});
var _elm_lang$core$Time$inMilliseconds = function (t) {
	return t;
};
var _elm_lang$core$Time$millisecond = 1;
var _elm_lang$core$Time$second = 1000 * _elm_lang$core$Time$millisecond;
var _elm_lang$core$Time$minute = 60 * _elm_lang$core$Time$second;
var _elm_lang$core$Time$hour = 60 * _elm_lang$core$Time$minute;
var _elm_lang$core$Time$inHours = function (t) {
	return t / _elm_lang$core$Time$hour;
};
var _elm_lang$core$Time$inMinutes = function (t) {
	return t / _elm_lang$core$Time$minute;
};
var _elm_lang$core$Time$inSeconds = function (t) {
	return t / _elm_lang$core$Time$second;
};
var _elm_lang$core$Time$now = _elm_lang$core$Native_Time.now;
var _elm_lang$core$Time$onSelfMsg = F3(
	function (router, interval, state) {
		var _p7 = A2(_elm_lang$core$Dict$get, interval, state.taggers);
		if (_p7.ctor === 'Nothing') {
			return _elm_lang$core$Task$succeed(state);
		} else {
			return A2(
				_elm_lang$core$Task$andThen,
				_elm_lang$core$Time$now,
				function (time) {
					return A2(
						_elm_lang$core$Task$andThen,
						_elm_lang$core$Task$sequence(
							A2(
								_elm_lang$core$List$map,
								function (tagger) {
									return A2(
										_elm_lang$core$Platform$sendToApp,
										router,
										tagger(time));
								},
								_p7._0)),
						function (_p8) {
							return _elm_lang$core$Task$succeed(state);
						});
				});
		}
	});
var _elm_lang$core$Time$subscription = _elm_lang$core$Native_Platform.leaf('Time');
var _elm_lang$core$Time$State = F2(
	function (a, b) {
		return {taggers: a, processes: b};
	});
var _elm_lang$core$Time$init = _elm_lang$core$Task$succeed(
	A2(_elm_lang$core$Time$State, _elm_lang$core$Dict$empty, _elm_lang$core$Dict$empty));
var _elm_lang$core$Time$onEffects = F3(
	function (router, subs, _p9) {
		var _p10 = _p9;
		var rightStep = F3(
			function (_p12, id, _p11) {
				var _p13 = _p11;
				return {
					ctor: '_Tuple3',
					_0: _p13._0,
					_1: _p13._1,
					_2: A2(
						_elm_lang$core$Task$andThen,
						_elm_lang$core$Native_Scheduler.kill(id),
						function (_p14) {
							return _p13._2;
						})
				};
			});
		var bothStep = F4(
			function (interval, taggers, id, _p15) {
				var _p16 = _p15;
				return {
					ctor: '_Tuple3',
					_0: _p16._0,
					_1: A3(_elm_lang$core$Dict$insert, interval, id, _p16._1),
					_2: _p16._2
				};
			});
		var leftStep = F3(
			function (interval, taggers, _p17) {
				var _p18 = _p17;
				return {
					ctor: '_Tuple3',
					_0: A2(_elm_lang$core$List_ops['::'], interval, _p18._0),
					_1: _p18._1,
					_2: _p18._2
				};
			});
		var newTaggers = A3(_elm_lang$core$List$foldl, _elm_lang$core$Time$addMySub, _elm_lang$core$Dict$empty, subs);
		var _p19 = A6(
			_elm_lang$core$Dict$merge,
			leftStep,
			bothStep,
			rightStep,
			newTaggers,
			_p10.processes,
			{
				ctor: '_Tuple3',
				_0: _elm_lang$core$Native_List.fromArray(
					[]),
				_1: _elm_lang$core$Dict$empty,
				_2: _elm_lang$core$Task$succeed(
					{ctor: '_Tuple0'})
			});
		var spawnList = _p19._0;
		var existingDict = _p19._1;
		var killTask = _p19._2;
		return A2(
			_elm_lang$core$Task$andThen,
			killTask,
			function (_p20) {
				return A2(
					_elm_lang$core$Task$andThen,
					A3(_elm_lang$core$Time$spawnHelp, router, spawnList, existingDict),
					function (newProcesses) {
						return _elm_lang$core$Task$succeed(
							A2(_elm_lang$core$Time$State, newTaggers, newProcesses));
					});
			});
	});
var _elm_lang$core$Time$Every = F2(
	function (a, b) {
		return {ctor: 'Every', _0: a, _1: b};
	});
var _elm_lang$core$Time$every = F2(
	function (interval, tagger) {
		return _elm_lang$core$Time$subscription(
			A2(_elm_lang$core$Time$Every, interval, tagger));
	});
var _elm_lang$core$Time$subMap = F2(
	function (f, _p21) {
		var _p22 = _p21;
		return A2(
			_elm_lang$core$Time$Every,
			_p22._0,
			function (_p23) {
				return f(
					_p22._1(_p23));
			});
	});
_elm_lang$core$Native_Platform.effectManagers['Time'] = {pkg: 'elm-lang/core', init: _elm_lang$core$Time$init, onEffects: _elm_lang$core$Time$onEffects, onSelfMsg: _elm_lang$core$Time$onSelfMsg, tag: 'sub', subMap: _elm_lang$core$Time$subMap};

var _elm_lang$core$Random$onSelfMsg = F3(
	function (_p1, _p0, seed) {
		return _elm_lang$core$Task$succeed(seed);
	});
var _elm_lang$core$Random$magicNum8 = 2147483562;
var _elm_lang$core$Random$range = function (_p2) {
	return {ctor: '_Tuple2', _0: 0, _1: _elm_lang$core$Random$magicNum8};
};
var _elm_lang$core$Random$magicNum7 = 2137383399;
var _elm_lang$core$Random$magicNum6 = 2147483563;
var _elm_lang$core$Random$magicNum5 = 3791;
var _elm_lang$core$Random$magicNum4 = 40692;
var _elm_lang$core$Random$magicNum3 = 52774;
var _elm_lang$core$Random$magicNum2 = 12211;
var _elm_lang$core$Random$magicNum1 = 53668;
var _elm_lang$core$Random$magicNum0 = 40014;
var _elm_lang$core$Random$step = F2(
	function (_p3, seed) {
		var _p4 = _p3;
		return _p4._0(seed);
	});
var _elm_lang$core$Random$onEffects = F3(
	function (router, commands, seed) {
		var _p5 = commands;
		if (_p5.ctor === '[]') {
			return _elm_lang$core$Task$succeed(seed);
		} else {
			var _p6 = A2(_elm_lang$core$Random$step, _p5._0._0, seed);
			var value = _p6._0;
			var newSeed = _p6._1;
			return A2(
				_elm_lang$core$Task$andThen,
				A2(_elm_lang$core$Platform$sendToApp, router, value),
				function (_p7) {
					return A3(_elm_lang$core$Random$onEffects, router, _p5._1, newSeed);
				});
		}
	});
var _elm_lang$core$Random$listHelp = F4(
	function (list, n, generate, seed) {
		listHelp:
		while (true) {
			if (_elm_lang$core$Native_Utils.cmp(n, 1) < 0) {
				return {
					ctor: '_Tuple2',
					_0: _elm_lang$core$List$reverse(list),
					_1: seed
				};
			} else {
				var _p8 = generate(seed);
				var value = _p8._0;
				var newSeed = _p8._1;
				var _v2 = A2(_elm_lang$core$List_ops['::'], value, list),
					_v3 = n - 1,
					_v4 = generate,
					_v5 = newSeed;
				list = _v2;
				n = _v3;
				generate = _v4;
				seed = _v5;
				continue listHelp;
			}
		}
	});
var _elm_lang$core$Random$minInt = -2147483648;
var _elm_lang$core$Random$maxInt = 2147483647;
var _elm_lang$core$Random$iLogBase = F2(
	function (b, i) {
		return (_elm_lang$core$Native_Utils.cmp(i, b) < 0) ? 1 : (1 + A2(_elm_lang$core$Random$iLogBase, b, (i / b) | 0));
	});
var _elm_lang$core$Random$command = _elm_lang$core$Native_Platform.leaf('Random');
var _elm_lang$core$Random$Generator = function (a) {
	return {ctor: 'Generator', _0: a};
};
var _elm_lang$core$Random$list = F2(
	function (n, _p9) {
		var _p10 = _p9;
		return _elm_lang$core$Random$Generator(
			function (seed) {
				return A4(
					_elm_lang$core$Random$listHelp,
					_elm_lang$core$Native_List.fromArray(
						[]),
					n,
					_p10._0,
					seed);
			});
	});
var _elm_lang$core$Random$map = F2(
	function (func, _p11) {
		var _p12 = _p11;
		return _elm_lang$core$Random$Generator(
			function (seed0) {
				var _p13 = _p12._0(seed0);
				var a = _p13._0;
				var seed1 = _p13._1;
				return {
					ctor: '_Tuple2',
					_0: func(a),
					_1: seed1
				};
			});
	});
var _elm_lang$core$Random$map2 = F3(
	function (func, _p15, _p14) {
		var _p16 = _p15;
		var _p17 = _p14;
		return _elm_lang$core$Random$Generator(
			function (seed0) {
				var _p18 = _p16._0(seed0);
				var a = _p18._0;
				var seed1 = _p18._1;
				var _p19 = _p17._0(seed1);
				var b = _p19._0;
				var seed2 = _p19._1;
				return {
					ctor: '_Tuple2',
					_0: A2(func, a, b),
					_1: seed2
				};
			});
	});
var _elm_lang$core$Random$pair = F2(
	function (genA, genB) {
		return A3(
			_elm_lang$core$Random$map2,
			F2(
				function (v0, v1) {
					return {ctor: '_Tuple2', _0: v0, _1: v1};
				}),
			genA,
			genB);
	});
var _elm_lang$core$Random$map3 = F4(
	function (func, _p22, _p21, _p20) {
		var _p23 = _p22;
		var _p24 = _p21;
		var _p25 = _p20;
		return _elm_lang$core$Random$Generator(
			function (seed0) {
				var _p26 = _p23._0(seed0);
				var a = _p26._0;
				var seed1 = _p26._1;
				var _p27 = _p24._0(seed1);
				var b = _p27._0;
				var seed2 = _p27._1;
				var _p28 = _p25._0(seed2);
				var c = _p28._0;
				var seed3 = _p28._1;
				return {
					ctor: '_Tuple2',
					_0: A3(func, a, b, c),
					_1: seed3
				};
			});
	});
var _elm_lang$core$Random$map4 = F5(
	function (func, _p32, _p31, _p30, _p29) {
		var _p33 = _p32;
		var _p34 = _p31;
		var _p35 = _p30;
		var _p36 = _p29;
		return _elm_lang$core$Random$Generator(
			function (seed0) {
				var _p37 = _p33._0(seed0);
				var a = _p37._0;
				var seed1 = _p37._1;
				var _p38 = _p34._0(seed1);
				var b = _p38._0;
				var seed2 = _p38._1;
				var _p39 = _p35._0(seed2);
				var c = _p39._0;
				var seed3 = _p39._1;
				var _p40 = _p36._0(seed3);
				var d = _p40._0;
				var seed4 = _p40._1;
				return {
					ctor: '_Tuple2',
					_0: A4(func, a, b, c, d),
					_1: seed4
				};
			});
	});
var _elm_lang$core$Random$map5 = F6(
	function (func, _p45, _p44, _p43, _p42, _p41) {
		var _p46 = _p45;
		var _p47 = _p44;
		var _p48 = _p43;
		var _p49 = _p42;
		var _p50 = _p41;
		return _elm_lang$core$Random$Generator(
			function (seed0) {
				var _p51 = _p46._0(seed0);
				var a = _p51._0;
				var seed1 = _p51._1;
				var _p52 = _p47._0(seed1);
				var b = _p52._0;
				var seed2 = _p52._1;
				var _p53 = _p48._0(seed2);
				var c = _p53._0;
				var seed3 = _p53._1;
				var _p54 = _p49._0(seed3);
				var d = _p54._0;
				var seed4 = _p54._1;
				var _p55 = _p50._0(seed4);
				var e = _p55._0;
				var seed5 = _p55._1;
				return {
					ctor: '_Tuple2',
					_0: A5(func, a, b, c, d, e),
					_1: seed5
				};
			});
	});
var _elm_lang$core$Random$andThen = F2(
	function (_p56, callback) {
		var _p57 = _p56;
		return _elm_lang$core$Random$Generator(
			function (seed) {
				var _p58 = _p57._0(seed);
				var result = _p58._0;
				var newSeed = _p58._1;
				var _p59 = callback(result);
				var genB = _p59._0;
				return genB(newSeed);
			});
	});
var _elm_lang$core$Random$State = F2(
	function (a, b) {
		return {ctor: 'State', _0: a, _1: b};
	});
var _elm_lang$core$Random$initState = function (s$) {
	var s = A2(_elm_lang$core$Basics$max, s$, 0 - s$);
	var q = (s / (_elm_lang$core$Random$magicNum6 - 1)) | 0;
	var s2 = A2(_elm_lang$core$Basics_ops['%'], q, _elm_lang$core$Random$magicNum7 - 1);
	var s1 = A2(_elm_lang$core$Basics_ops['%'], s, _elm_lang$core$Random$magicNum6 - 1);
	return A2(_elm_lang$core$Random$State, s1 + 1, s2 + 1);
};
var _elm_lang$core$Random$next = function (_p60) {
	var _p61 = _p60;
	var _p63 = _p61._1;
	var _p62 = _p61._0;
	var k$ = (_p63 / _elm_lang$core$Random$magicNum3) | 0;
	var s2$ = (_elm_lang$core$Random$magicNum4 * (_p63 - (k$ * _elm_lang$core$Random$magicNum3))) - (k$ * _elm_lang$core$Random$magicNum5);
	var s2$$ = (_elm_lang$core$Native_Utils.cmp(s2$, 0) < 0) ? (s2$ + _elm_lang$core$Random$magicNum7) : s2$;
	var k = (_p62 / _elm_lang$core$Random$magicNum1) | 0;
	var s1$ = (_elm_lang$core$Random$magicNum0 * (_p62 - (k * _elm_lang$core$Random$magicNum1))) - (k * _elm_lang$core$Random$magicNum2);
	var s1$$ = (_elm_lang$core$Native_Utils.cmp(s1$, 0) < 0) ? (s1$ + _elm_lang$core$Random$magicNum6) : s1$;
	var z = s1$$ - s2$$;
	var z$ = (_elm_lang$core$Native_Utils.cmp(z, 1) < 0) ? (z + _elm_lang$core$Random$magicNum8) : z;
	return {
		ctor: '_Tuple2',
		_0: z$,
		_1: A2(_elm_lang$core$Random$State, s1$$, s2$$)
	};
};
var _elm_lang$core$Random$split = function (_p64) {
	var _p65 = _p64;
	var _p68 = _p65._1;
	var _p67 = _p65._0;
	var _p66 = _elm_lang$core$Basics$snd(
		_elm_lang$core$Random$next(_p65));
	var t1 = _p66._0;
	var t2 = _p66._1;
	var new_s2 = _elm_lang$core$Native_Utils.eq(_p68, 1) ? (_elm_lang$core$Random$magicNum7 - 1) : (_p68 - 1);
	var new_s1 = _elm_lang$core$Native_Utils.eq(_p67, _elm_lang$core$Random$magicNum6 - 1) ? 1 : (_p67 + 1);
	return {
		ctor: '_Tuple2',
		_0: A2(_elm_lang$core$Random$State, new_s1, t2),
		_1: A2(_elm_lang$core$Random$State, t1, new_s2)
	};
};
var _elm_lang$core$Random$Seed = function (a) {
	return {ctor: 'Seed', _0: a};
};
var _elm_lang$core$Random$int = F2(
	function (a, b) {
		return _elm_lang$core$Random$Generator(
			function (_p69) {
				var _p70 = _p69;
				var _p75 = _p70._0;
				var base = 2147483561;
				var f = F3(
					function (n, acc, state) {
						f:
						while (true) {
							var _p71 = n;
							if (_p71 === 0) {
								return {ctor: '_Tuple2', _0: acc, _1: state};
							} else {
								var _p72 = _p75.next(state);
								var x = _p72._0;
								var state$ = _p72._1;
								var _v27 = n - 1,
									_v28 = x + (acc * base),
									_v29 = state$;
								n = _v27;
								acc = _v28;
								state = _v29;
								continue f;
							}
						}
					});
				var _p73 = (_elm_lang$core$Native_Utils.cmp(a, b) < 0) ? {ctor: '_Tuple2', _0: a, _1: b} : {ctor: '_Tuple2', _0: b, _1: a};
				var lo = _p73._0;
				var hi = _p73._1;
				var k = (hi - lo) + 1;
				var n = A2(_elm_lang$core$Random$iLogBase, base, k);
				var _p74 = A3(f, n, 1, _p75.state);
				var v = _p74._0;
				var state$ = _p74._1;
				return {
					ctor: '_Tuple2',
					_0: lo + A2(_elm_lang$core$Basics_ops['%'], v, k),
					_1: _elm_lang$core$Random$Seed(
						_elm_lang$core$Native_Utils.update(
							_p75,
							{state: state$}))
				};
			});
	});
var _elm_lang$core$Random$bool = A2(
	_elm_lang$core$Random$map,
	F2(
		function (x, y) {
			return _elm_lang$core$Native_Utils.eq(x, y);
		})(1),
	A2(_elm_lang$core$Random$int, 0, 1));
var _elm_lang$core$Random$float = F2(
	function (a, b) {
		return _elm_lang$core$Random$Generator(
			function (seed) {
				var _p76 = A2(
					_elm_lang$core$Random$step,
					A2(_elm_lang$core$Random$int, _elm_lang$core$Random$minInt, _elm_lang$core$Random$maxInt),
					seed);
				var number = _p76._0;
				var newSeed = _p76._1;
				var negativeOneToOne = _elm_lang$core$Basics$toFloat(number) / _elm_lang$core$Basics$toFloat(_elm_lang$core$Random$maxInt - _elm_lang$core$Random$minInt);
				var _p77 = (_elm_lang$core$Native_Utils.cmp(a, b) < 0) ? {ctor: '_Tuple2', _0: a, _1: b} : {ctor: '_Tuple2', _0: b, _1: a};
				var lo = _p77._0;
				var hi = _p77._1;
				var scaled = ((lo + hi) / 2) + ((hi - lo) * negativeOneToOne);
				return {ctor: '_Tuple2', _0: scaled, _1: newSeed};
			});
	});
var _elm_lang$core$Random$initialSeed = function (n) {
	return _elm_lang$core$Random$Seed(
		{
			state: _elm_lang$core$Random$initState(n),
			next: _elm_lang$core$Random$next,
			split: _elm_lang$core$Random$split,
			range: _elm_lang$core$Random$range
		});
};
var _elm_lang$core$Random$init = A2(
	_elm_lang$core$Task$andThen,
	_elm_lang$core$Time$now,
	function (t) {
		return _elm_lang$core$Task$succeed(
			_elm_lang$core$Random$initialSeed(
				_elm_lang$core$Basics$round(t)));
	});
var _elm_lang$core$Random$Generate = function (a) {
	return {ctor: 'Generate', _0: a};
};
var _elm_lang$core$Random$generate = F2(
	function (tagger, generator) {
		return _elm_lang$core$Random$command(
			_elm_lang$core$Random$Generate(
				A2(_elm_lang$core$Random$map, tagger, generator)));
	});
var _elm_lang$core$Random$cmdMap = F2(
	function (func, _p78) {
		var _p79 = _p78;
		return _elm_lang$core$Random$Generate(
			A2(_elm_lang$core$Random$map, func, _p79._0));
	});
_elm_lang$core$Native_Platform.effectManagers['Random'] = {pkg: 'elm-lang/core', init: _elm_lang$core$Random$init, onEffects: _elm_lang$core$Random$onEffects, onSelfMsg: _elm_lang$core$Random$onSelfMsg, tag: 'cmd', cmdMap: _elm_lang$core$Random$cmdMap};

var _elm_lang$lazy$Native_Lazy = function() {

function memoize(thunk)
{
    var value;
    var isForced = false;
    return function(tuple0) {
        if (!isForced) {
            value = thunk(tuple0);
            isForced = true;
        }
        return value;
    };
}

return {
    memoize: memoize
};

}();

var _elm_lang$lazy$Lazy$force = function (_p0) {
	var _p1 = _p0;
	return _p1._0(
		{ctor: '_Tuple0'});
};
var _elm_lang$lazy$Lazy$Lazy = function (a) {
	return {ctor: 'Lazy', _0: a};
};
var _elm_lang$lazy$Lazy$lazy = function (thunk) {
	return _elm_lang$lazy$Lazy$Lazy(
		_elm_lang$lazy$Native_Lazy.memoize(thunk));
};
var _elm_lang$lazy$Lazy$map = F2(
	function (f, a) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p2) {
				var _p3 = _p2;
				return f(
					_elm_lang$lazy$Lazy$force(a));
			});
	});
var _elm_lang$lazy$Lazy$map2 = F3(
	function (f, a, b) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p4) {
				var _p5 = _p4;
				return A2(
					f,
					_elm_lang$lazy$Lazy$force(a),
					_elm_lang$lazy$Lazy$force(b));
			});
	});
var _elm_lang$lazy$Lazy$map3 = F4(
	function (f, a, b, c) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p6) {
				var _p7 = _p6;
				return A3(
					f,
					_elm_lang$lazy$Lazy$force(a),
					_elm_lang$lazy$Lazy$force(b),
					_elm_lang$lazy$Lazy$force(c));
			});
	});
var _elm_lang$lazy$Lazy$map4 = F5(
	function (f, a, b, c, d) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p8) {
				var _p9 = _p8;
				return A4(
					f,
					_elm_lang$lazy$Lazy$force(a),
					_elm_lang$lazy$Lazy$force(b),
					_elm_lang$lazy$Lazy$force(c),
					_elm_lang$lazy$Lazy$force(d));
			});
	});
var _elm_lang$lazy$Lazy$map5 = F6(
	function (f, a, b, c, d, e) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p10) {
				var _p11 = _p10;
				return A5(
					f,
					_elm_lang$lazy$Lazy$force(a),
					_elm_lang$lazy$Lazy$force(b),
					_elm_lang$lazy$Lazy$force(c),
					_elm_lang$lazy$Lazy$force(d),
					_elm_lang$lazy$Lazy$force(e));
			});
	});
var _elm_lang$lazy$Lazy$apply = F2(
	function (f, x) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p12) {
				var _p13 = _p12;
				return A2(
					_elm_lang$lazy$Lazy$force,
					f,
					_elm_lang$lazy$Lazy$force(x));
			});
	});
var _elm_lang$lazy$Lazy$andThen = F2(
	function (a, callback) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p14) {
				var _p15 = _p14;
				return _elm_lang$lazy$Lazy$force(
					callback(
						_elm_lang$lazy$Lazy$force(a)));
			});
	});

var _elm_community$elm_lazy_list$Lazy_List$toArray = function (list) {
	var _p0 = _elm_lang$lazy$Lazy$force(list);
	if (_p0.ctor === 'Nil') {
		return _elm_lang$core$Array$empty;
	} else {
		return A2(
			_elm_lang$core$Array$append,
			A2(_elm_lang$core$Array$push, _p0._0, _elm_lang$core$Array$empty),
			_elm_community$elm_lazy_list$Lazy_List$toArray(_p0._1));
	}
};
var _elm_community$elm_lazy_list$Lazy_List$toList = function (list) {
	var _p1 = _elm_lang$lazy$Lazy$force(list);
	if (_p1.ctor === 'Nil') {
		return _elm_lang$core$Native_List.fromArray(
			[]);
	} else {
		return A2(
			_elm_lang$core$List_ops['::'],
			_p1._0,
			_elm_community$elm_lazy_list$Lazy_List$toList(_p1._1));
	}
};
var _elm_community$elm_lazy_list$Lazy_List$foldr = F3(
	function (reducer, b, list) {
		return A3(
			_elm_lang$core$Array$foldr,
			reducer,
			b,
			_elm_community$elm_lazy_list$Lazy_List$toArray(list));
	});
var _elm_community$elm_lazy_list$Lazy_List$reduce = F3(
	function (reducer, b, list) {
		reduce:
		while (true) {
			var _p2 = _elm_lang$lazy$Lazy$force(list);
			if (_p2.ctor === 'Nil') {
				return b;
			} else {
				var _v3 = reducer,
					_v4 = A2(reducer, _p2._0, b),
					_v5 = _p2._1;
				reducer = _v3;
				b = _v4;
				list = _v5;
				continue reduce;
			}
		}
	});
var _elm_community$elm_lazy_list$Lazy_List$foldl = _elm_community$elm_lazy_list$Lazy_List$reduce;
var _elm_community$elm_lazy_list$Lazy_List$sum = A2(
	_elm_community$elm_lazy_list$Lazy_List$reduce,
	F2(
		function (x, y) {
			return x + y;
		}),
	0);
var _elm_community$elm_lazy_list$Lazy_List$product = A2(
	_elm_community$elm_lazy_list$Lazy_List$reduce,
	F2(
		function (x, y) {
			return x * y;
		}),
	1);
var _elm_community$elm_lazy_list$Lazy_List$length = A2(
	_elm_community$elm_lazy_list$Lazy_List$reduce,
	F2(
		function (_p3, n) {
			return n + 1;
		}),
	0);
var _elm_community$elm_lazy_list$Lazy_List$member = F2(
	function (a, list) {
		var _p4 = _elm_lang$lazy$Lazy$force(list);
		if (_p4.ctor === 'Nil') {
			return false;
		} else {
			return _elm_lang$core$Native_Utils.eq(_p4._0, a) || A2(_elm_community$elm_lazy_list$Lazy_List$member, a, _p4._1);
		}
	});
var _elm_community$elm_lazy_list$Lazy_List$tail = function (list) {
	var _p5 = _elm_lang$lazy$Lazy$force(list);
	if (_p5.ctor === 'Nil') {
		return _elm_lang$core$Maybe$Nothing;
	} else {
		return _elm_lang$core$Maybe$Just(_p5._1);
	}
};
var _elm_community$elm_lazy_list$Lazy_List$head = function (list) {
	var _p6 = _elm_lang$lazy$Lazy$force(list);
	if (_p6.ctor === 'Nil') {
		return _elm_lang$core$Maybe$Nothing;
	} else {
		return _elm_lang$core$Maybe$Just(_p6._0);
	}
};
var _elm_community$elm_lazy_list$Lazy_List$isEmpty = function (list) {
	var _p7 = _elm_lang$lazy$Lazy$force(list);
	if (_p7.ctor === 'Nil') {
		return true;
	} else {
		return false;
	}
};
var _elm_community$elm_lazy_list$Lazy_List$Cons = F2(
	function (a, b) {
		return {ctor: 'Cons', _0: a, _1: b};
	});
var _elm_community$elm_lazy_list$Lazy_List$cons = F2(
	function (a, list) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p8) {
				var _p9 = _p8;
				return A2(_elm_community$elm_lazy_list$Lazy_List$Cons, a, list);
			});
	});
var _elm_community$elm_lazy_list$Lazy_List_ops = _elm_community$elm_lazy_list$Lazy_List_ops || {};
_elm_community$elm_lazy_list$Lazy_List_ops[':::'] = _elm_community$elm_lazy_list$Lazy_List$cons;
var _elm_community$elm_lazy_list$Lazy_List$append = F2(
	function (list1, list2) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p10) {
				var _p11 = _p10;
				var _p12 = _elm_lang$lazy$Lazy$force(list1);
				if (_p12.ctor === 'Nil') {
					return _elm_lang$lazy$Lazy$force(list2);
				} else {
					return _elm_lang$lazy$Lazy$force(
						A2(
							_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
							_p12._0,
							A2(_elm_community$elm_lazy_list$Lazy_List_ops['+++'], _p12._1, list2)));
				}
			});
	});
var _elm_community$elm_lazy_list$Lazy_List_ops = _elm_community$elm_lazy_list$Lazy_List_ops || {};
_elm_community$elm_lazy_list$Lazy_List_ops['+++'] = _elm_community$elm_lazy_list$Lazy_List$append;
var _elm_community$elm_lazy_list$Lazy_List$cycle = function (list) {
	return A2(
		_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
		list,
		_elm_lang$lazy$Lazy$lazy(
			function (_p13) {
				var _p14 = _p13;
				return _elm_lang$lazy$Lazy$force(
					_elm_community$elm_lazy_list$Lazy_List$cycle(list));
			}));
};
var _elm_community$elm_lazy_list$Lazy_List$interleave = F2(
	function (list1, list2) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p15) {
				var _p16 = _p15;
				var _p17 = _elm_lang$lazy$Lazy$force(list1);
				if (_p17.ctor === 'Nil') {
					return _elm_lang$lazy$Lazy$force(list2);
				} else {
					var _p18 = _elm_lang$lazy$Lazy$force(list2);
					if (_p18.ctor === 'Nil') {
						return _elm_lang$lazy$Lazy$force(list1);
					} else {
						return _elm_lang$lazy$Lazy$force(
							A2(
								_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
								_p17._0,
								A2(
									_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
									_p18._0,
									A2(_elm_community$elm_lazy_list$Lazy_List$interleave, _p17._1, _p18._1))));
					}
				}
			});
	});
var _elm_community$elm_lazy_list$Lazy_List$repeat = function (a) {
	return _elm_lang$lazy$Lazy$lazy(
		function (_p19) {
			var _p20 = _p19;
			return A2(
				_elm_community$elm_lazy_list$Lazy_List$Cons,
				a,
				_elm_community$elm_lazy_list$Lazy_List$repeat(a));
		});
};
var _elm_community$elm_lazy_list$Lazy_List$iterate = F2(
	function (f, a) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p21) {
				var _p22 = _p21;
				return A2(
					_elm_community$elm_lazy_list$Lazy_List$Cons,
					a,
					A2(
						_elm_community$elm_lazy_list$Lazy_List$iterate,
						f,
						f(a)));
			});
	});
var _elm_community$elm_lazy_list$Lazy_List$numbers = A2(
	_elm_community$elm_lazy_list$Lazy_List$iterate,
	F2(
		function (x, y) {
			return x + y;
		})(1),
	1);
var _elm_community$elm_lazy_list$Lazy_List$Nil = {ctor: 'Nil'};
var _elm_community$elm_lazy_list$Lazy_List$empty = _elm_lang$lazy$Lazy$lazy(
	function (_p23) {
		var _p24 = _p23;
		return _elm_community$elm_lazy_list$Lazy_List$Nil;
	});
var _elm_community$elm_lazy_list$Lazy_List$singleton = function (a) {
	return A2(_elm_community$elm_lazy_list$Lazy_List$cons, a, _elm_community$elm_lazy_list$Lazy_List$empty);
};
var _elm_community$elm_lazy_list$Lazy_List$reverse = A2(_elm_community$elm_lazy_list$Lazy_List$reduce, _elm_community$elm_lazy_list$Lazy_List$cons, _elm_community$elm_lazy_list$Lazy_List$empty);
var _elm_community$elm_lazy_list$Lazy_List$fromList = A2(_elm_lang$core$List$foldr, _elm_community$elm_lazy_list$Lazy_List$cons, _elm_community$elm_lazy_list$Lazy_List$empty);
var _elm_community$elm_lazy_list$Lazy_List$fromArray = A2(_elm_lang$core$Array$foldr, _elm_community$elm_lazy_list$Lazy_List$cons, _elm_community$elm_lazy_list$Lazy_List$empty);
var _elm_community$elm_lazy_list$Lazy_List$intersperse = F2(
	function (a, list) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p25) {
				var _p26 = _p25;
				var _p27 = _elm_lang$lazy$Lazy$force(list);
				if (_p27.ctor === 'Nil') {
					return _elm_community$elm_lazy_list$Lazy_List$Nil;
				} else {
					var _p32 = _p27._0;
					var _p28 = _elm_lang$lazy$Lazy$force(_p27._1);
					if (_p28.ctor === 'Nil') {
						return _elm_lang$lazy$Lazy$force(
							A2(_elm_community$elm_lazy_list$Lazy_List_ops[':::'], _p32, _elm_community$elm_lazy_list$Lazy_List$empty));
					} else {
						var _p31 = _p28._1;
						var _p30 = _p28._0;
						var _p29 = _elm_lang$lazy$Lazy$force(_p31);
						if (_p29.ctor === 'Nil') {
							return _elm_lang$lazy$Lazy$force(
								A2(
									_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
									_p32,
									A2(
										_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
										a,
										A2(_elm_community$elm_lazy_list$Lazy_List_ops[':::'], _p30, _elm_community$elm_lazy_list$Lazy_List$empty))));
						} else {
							return _elm_lang$lazy$Lazy$force(
								A2(
									_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
									_p32,
									A2(
										_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
										a,
										A2(
											_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
											_p30,
											A2(
												_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
												a,
												A2(_elm_community$elm_lazy_list$Lazy_List$intersperse, a, _p31))))));
						}
					}
				}
			});
	});
var _elm_community$elm_lazy_list$Lazy_List$take = F2(
	function (n, list) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p33) {
				var _p34 = _p33;
				if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
					return _elm_community$elm_lazy_list$Lazy_List$Nil;
				} else {
					var _p35 = _elm_lang$lazy$Lazy$force(list);
					if (_p35.ctor === 'Nil') {
						return _elm_community$elm_lazy_list$Lazy_List$Nil;
					} else {
						return A2(
							_elm_community$elm_lazy_list$Lazy_List$Cons,
							_p35._0,
							A2(_elm_community$elm_lazy_list$Lazy_List$take, n - 1, _p35._1));
					}
				}
			});
	});
var _elm_community$elm_lazy_list$Lazy_List$takeWhile = F2(
	function (predicate, list) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p36) {
				var _p37 = _p36;
				var _p38 = _elm_lang$lazy$Lazy$force(list);
				if (_p38.ctor === 'Nil') {
					return _elm_community$elm_lazy_list$Lazy_List$Nil;
				} else {
					var _p39 = _p38._0;
					return predicate(_p39) ? A2(
						_elm_community$elm_lazy_list$Lazy_List$Cons,
						_p39,
						A2(_elm_community$elm_lazy_list$Lazy_List$takeWhile, predicate, _p38._1)) : _elm_community$elm_lazy_list$Lazy_List$Nil;
				}
			});
	});
var _elm_community$elm_lazy_list$Lazy_List$drop = F2(
	function (n, list) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p40) {
				var _p41 = _p40;
				if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
					return _elm_lang$lazy$Lazy$force(list);
				} else {
					var _p42 = _elm_lang$lazy$Lazy$force(list);
					if (_p42.ctor === 'Nil') {
						return _elm_community$elm_lazy_list$Lazy_List$Nil;
					} else {
						return _elm_lang$lazy$Lazy$force(
							A2(_elm_community$elm_lazy_list$Lazy_List$drop, n - 1, _p42._1));
					}
				}
			});
	});
var _elm_community$elm_lazy_list$Lazy_List$dropWhile = F2(
	function (predicate, list) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p43) {
				var _p44 = _p43;
				var _p45 = _elm_lang$lazy$Lazy$force(list);
				if (_p45.ctor === 'Nil') {
					return _elm_community$elm_lazy_list$Lazy_List$Nil;
				} else {
					return predicate(_p45._0) ? _elm_lang$lazy$Lazy$force(
						A2(_elm_community$elm_lazy_list$Lazy_List$dropWhile, predicate, _p45._1)) : _elm_lang$lazy$Lazy$force(list);
				}
			});
	});
var _elm_community$elm_lazy_list$Lazy_List$unique = function (list) {
	return _elm_lang$lazy$Lazy$lazy(
		function (_p46) {
			var _p47 = _p46;
			var _p48 = _elm_lang$lazy$Lazy$force(list);
			if (_p48.ctor === 'Nil') {
				return _elm_community$elm_lazy_list$Lazy_List$Nil;
			} else {
				var _p50 = _p48._1;
				var _p49 = _p48._0;
				return A2(_elm_community$elm_lazy_list$Lazy_List$member, _p49, _p50) ? _elm_lang$lazy$Lazy$force(
					_elm_community$elm_lazy_list$Lazy_List$unique(_p50)) : A2(
					_elm_community$elm_lazy_list$Lazy_List$Cons,
					_p49,
					_elm_community$elm_lazy_list$Lazy_List$unique(_p50));
			}
		});
};
var _elm_community$elm_lazy_list$Lazy_List$keepIf = F2(
	function (predicate, list) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p51) {
				var _p52 = _p51;
				var _p53 = _elm_lang$lazy$Lazy$force(list);
				if (_p53.ctor === 'Nil') {
					return _elm_community$elm_lazy_list$Lazy_List$Nil;
				} else {
					var _p55 = _p53._1;
					var _p54 = _p53._0;
					return predicate(_p54) ? A2(
						_elm_community$elm_lazy_list$Lazy_List$Cons,
						_p54,
						A2(_elm_community$elm_lazy_list$Lazy_List$keepIf, predicate, _p55)) : _elm_lang$lazy$Lazy$force(
						A2(_elm_community$elm_lazy_list$Lazy_List$keepIf, predicate, _p55));
				}
			});
	});
var _elm_community$elm_lazy_list$Lazy_List$dropIf = function (predicate) {
	return _elm_community$elm_lazy_list$Lazy_List$keepIf(
		function (n) {
			return _elm_lang$core$Basics$not(
				predicate(n));
		});
};
var _elm_community$elm_lazy_list$Lazy_List$flatten = function (list) {
	return _elm_lang$lazy$Lazy$lazy(
		function (_p56) {
			var _p57 = _p56;
			var _p58 = _elm_lang$lazy$Lazy$force(list);
			if (_p58.ctor === 'Nil') {
				return _elm_community$elm_lazy_list$Lazy_List$Nil;
			} else {
				return _elm_lang$lazy$Lazy$force(
					A2(
						_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
						_p58._0,
						_elm_community$elm_lazy_list$Lazy_List$flatten(_p58._1)));
			}
		});
};
var _elm_community$elm_lazy_list$Lazy_List$map = F2(
	function (f, list) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p59) {
				var _p60 = _p59;
				var _p61 = _elm_lang$lazy$Lazy$force(list);
				if (_p61.ctor === 'Nil') {
					return _elm_community$elm_lazy_list$Lazy_List$Nil;
				} else {
					return A2(
						_elm_community$elm_lazy_list$Lazy_List$Cons,
						f(_p61._0),
						A2(_elm_community$elm_lazy_list$Lazy_List$map, f, _p61._1));
				}
			});
	});
var _elm_community$elm_lazy_list$Lazy_List$flatMap = function (f) {
	return function (_p62) {
		return _elm_community$elm_lazy_list$Lazy_List$flatten(
			A2(_elm_community$elm_lazy_list$Lazy_List$map, f, _p62));
	};
};
var _elm_community$elm_lazy_list$Lazy_List$andThen = _elm_lang$core$Basics$flip(_elm_community$elm_lazy_list$Lazy_List$flatMap);
var _elm_community$elm_lazy_list$Lazy_List$map2 = F3(
	function (f, list1, list2) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p63) {
				var _p64 = _p63;
				var _p65 = _elm_lang$lazy$Lazy$force(list1);
				if (_p65.ctor === 'Nil') {
					return _elm_community$elm_lazy_list$Lazy_List$Nil;
				} else {
					var _p66 = _elm_lang$lazy$Lazy$force(list2);
					if (_p66.ctor === 'Nil') {
						return _elm_community$elm_lazy_list$Lazy_List$Nil;
					} else {
						return A2(
							_elm_community$elm_lazy_list$Lazy_List$Cons,
							A2(f, _p65._0, _p66._0),
							A3(_elm_community$elm_lazy_list$Lazy_List$map2, f, _p65._1, _p66._1));
					}
				}
			});
	});
var _elm_community$elm_lazy_list$Lazy_List$andMap = _elm_community$elm_lazy_list$Lazy_List$map2(
	F2(
		function (x, y) {
			return x(y);
		}));
var _elm_community$elm_lazy_list$Lazy_List$map3 = F4(
	function (f, l1, l2, l3) {
		return A2(
			_elm_community$elm_lazy_list$Lazy_List$andMap,
			A2(
				_elm_community$elm_lazy_list$Lazy_List$andMap,
				A2(_elm_community$elm_lazy_list$Lazy_List$map, f, l1),
				l2),
			l3);
	});
var _elm_community$elm_lazy_list$Lazy_List$zip3 = _elm_community$elm_lazy_list$Lazy_List$map3(
	F3(
		function (v0, v1, v2) {
			return {ctor: '_Tuple3', _0: v0, _1: v1, _2: v2};
		}));
var _elm_community$elm_lazy_list$Lazy_List$map4 = F5(
	function (f, l1, l2, l3, l4) {
		return A2(
			_elm_community$elm_lazy_list$Lazy_List$andMap,
			A2(
				_elm_community$elm_lazy_list$Lazy_List$andMap,
				A2(
					_elm_community$elm_lazy_list$Lazy_List$andMap,
					A2(_elm_community$elm_lazy_list$Lazy_List$map, f, l1),
					l2),
				l3),
			l4);
	});
var _elm_community$elm_lazy_list$Lazy_List$zip4 = _elm_community$elm_lazy_list$Lazy_List$map4(
	F4(
		function (v0, v1, v2, v3) {
			return {ctor: '_Tuple4', _0: v0, _1: v1, _2: v2, _3: v3};
		}));
var _elm_community$elm_lazy_list$Lazy_List$map5 = F6(
	function (f, l1, l2, l3, l4, l5) {
		return A2(
			_elm_community$elm_lazy_list$Lazy_List$andMap,
			A2(
				_elm_community$elm_lazy_list$Lazy_List$andMap,
				A2(
					_elm_community$elm_lazy_list$Lazy_List$andMap,
					A2(
						_elm_community$elm_lazy_list$Lazy_List$andMap,
						A2(_elm_community$elm_lazy_list$Lazy_List$map, f, l1),
						l2),
					l3),
				l4),
			l5);
	});
var _elm_community$elm_lazy_list$Lazy_List$zip5 = _elm_community$elm_lazy_list$Lazy_List$map5(
	F5(
		function (v0, v1, v2, v3, v4) {
			return {ctor: '_Tuple5', _0: v0, _1: v1, _2: v2, _3: v3, _4: v4};
		}));
var _elm_community$elm_lazy_list$Lazy_List$zip = _elm_community$elm_lazy_list$Lazy_List$map2(
	F2(
		function (v0, v1) {
			return {ctor: '_Tuple2', _0: v0, _1: v1};
		}));

var _elm_lang$trampoline$Trampoline$evaluate = function (trampoline) {
	evaluate:
	while (true) {
		var _p0 = trampoline;
		if (_p0.ctor === 'Done') {
			return _p0._0;
		} else {
			var _v1 = _p0._0(
				{ctor: '_Tuple0'});
			trampoline = _v1;
			continue evaluate;
		}
	}
};
var _elm_lang$trampoline$Trampoline$Jump = function (a) {
	return {ctor: 'Jump', _0: a};
};
var _elm_lang$trampoline$Trampoline$jump = _elm_lang$trampoline$Trampoline$Jump;
var _elm_lang$trampoline$Trampoline$Done = function (a) {
	return {ctor: 'Done', _0: a};
};
var _elm_lang$trampoline$Trampoline$done = _elm_lang$trampoline$Trampoline$Done;

var _elm_community$shrink$Shrink$seriesFloat = F2(
	function (low, high) {
		if (_elm_lang$core$Native_Utils.cmp(low, high - 1.0e-4) > -1) {
			return _elm_community$elm_lazy_list$Lazy_List$empty;
		} else {
			var low$ = low + ((high - low) / 2);
			return A2(
				_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
				low,
				A2(_elm_community$shrink$Shrink$seriesFloat, low$, high));
		}
	});
var _elm_community$shrink$Shrink$seriesInt = F2(
	function (low, high) {
		if (_elm_lang$core$Native_Utils.cmp(low, high) > -1) {
			return _elm_community$elm_lazy_list$Lazy_List$empty;
		} else {
			if (_elm_lang$core$Native_Utils.eq(low, high - 1)) {
				return A2(_elm_community$elm_lazy_list$Lazy_List_ops[':::'], low, _elm_community$elm_lazy_list$Lazy_List$empty);
			} else {
				var low$ = low + (((high - low) / 2) | 0);
				return A2(
					_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
					low,
					A2(_elm_community$shrink$Shrink$seriesInt, low$, high));
			}
		}
	});
var _elm_community$shrink$Shrink$andMap = _elm_community$elm_lazy_list$Lazy_List$andMap;
var _elm_community$shrink$Shrink$map = _elm_community$elm_lazy_list$Lazy_List$map;
var _elm_community$shrink$Shrink$merge = F3(
	function (shrink1, shrink2, a) {
		return _elm_community$elm_lazy_list$Lazy_List$unique(
			A2(
				_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
				shrink1(a),
				shrink2(a)));
	});
var _elm_community$shrink$Shrink$keepIf = F3(
	function (predicate, shrink, a) {
		return A2(
			_elm_community$elm_lazy_list$Lazy_List$keepIf,
			predicate,
			shrink(a));
	});
var _elm_community$shrink$Shrink$dropIf = function (predicate) {
	return _elm_community$shrink$Shrink$keepIf(
		function (_p0) {
			return _elm_lang$core$Basics$not(
				predicate(_p0));
		});
};
var _elm_community$shrink$Shrink$convert = F4(
	function (f, f$, shrink, b) {
		return A2(
			_elm_community$elm_lazy_list$Lazy_List$map,
			f,
			shrink(
				f$(b)));
	});
var _elm_community$shrink$Shrink$tuple5 = F2(
	function (_p2, _p1) {
		var _p3 = _p2;
		var _p14 = _p3._4;
		var _p13 = _p3._3;
		var _p12 = _p3._2;
		var _p11 = _p3._1;
		var _p10 = _p3._0;
		var _p4 = _p1;
		var _p9 = _p4._4;
		var _p8 = _p4._3;
		var _p7 = _p4._2;
		var _p6 = _p4._1;
		var _p5 = _p4._0;
		return A2(
			_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
			A2(
				_elm_community$elm_lazy_list$Lazy_List$map,
				function (e) {
					return {ctor: '_Tuple5', _0: _p5, _1: _p6, _2: _p7, _3: _p8, _4: e};
				},
				_p14(_p9)),
			A2(
				_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
				A2(
					_elm_community$elm_lazy_list$Lazy_List$map,
					function (d) {
						return {ctor: '_Tuple5', _0: _p5, _1: _p6, _2: _p7, _3: d, _4: _p9};
					},
					_p13(_p8)),
				A2(
					_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
					A2(
						_elm_community$elm_lazy_list$Lazy_List$map,
						function (c) {
							return {ctor: '_Tuple5', _0: _p5, _1: _p6, _2: c, _3: _p8, _4: _p9};
						},
						_p12(_p7)),
					A2(
						_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
						A2(
							_elm_community$elm_lazy_list$Lazy_List$map,
							function (b) {
								return {ctor: '_Tuple5', _0: _p5, _1: b, _2: _p7, _3: _p8, _4: _p9};
							},
							_p11(_p6)),
						A2(
							_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
							A2(
								_elm_community$elm_lazy_list$Lazy_List$map,
								function (a) {
									return {ctor: '_Tuple5', _0: a, _1: _p6, _2: _p7, _3: _p8, _4: _p9};
								},
								_p10(_p5)),
							A2(
								_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
								A3(
									_elm_community$elm_lazy_list$Lazy_List$map2,
									F2(
										function (d, e) {
											return {ctor: '_Tuple5', _0: _p5, _1: _p6, _2: _p7, _3: d, _4: e};
										}),
									_p13(_p8),
									_p14(_p9)),
								A2(
									_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
									A3(
										_elm_community$elm_lazy_list$Lazy_List$map2,
										F2(
											function (c, e) {
												return {ctor: '_Tuple5', _0: _p5, _1: _p6, _2: c, _3: _p8, _4: e};
											}),
										_p12(_p7),
										_p14(_p9)),
									A2(
										_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
										A3(
											_elm_community$elm_lazy_list$Lazy_List$map2,
											F2(
												function (b, e) {
													return {ctor: '_Tuple5', _0: _p5, _1: b, _2: _p7, _3: _p8, _4: e};
												}),
											_p11(_p6),
											_p14(_p9)),
										A2(
											_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
											A3(
												_elm_community$elm_lazy_list$Lazy_List$map2,
												F2(
													function (a, e) {
														return {ctor: '_Tuple5', _0: a, _1: _p6, _2: _p7, _3: _p8, _4: e};
													}),
												_p10(_p5),
												_p14(_p9)),
											A2(
												_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
												A3(
													_elm_community$elm_lazy_list$Lazy_List$map2,
													F2(
														function (c, d) {
															return {ctor: '_Tuple5', _0: _p5, _1: _p6, _2: c, _3: d, _4: _p9};
														}),
													_p12(_p7),
													_p13(_p8)),
												A2(
													_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
													A3(
														_elm_community$elm_lazy_list$Lazy_List$map2,
														F2(
															function (b, d) {
																return {ctor: '_Tuple5', _0: _p5, _1: b, _2: _p7, _3: d, _4: _p9};
															}),
														_p11(_p6),
														_p13(_p8)),
													A2(
														_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
														A3(
															_elm_community$elm_lazy_list$Lazy_List$map2,
															F2(
																function (a, d) {
																	return {ctor: '_Tuple5', _0: a, _1: _p6, _2: _p7, _3: d, _4: _p9};
																}),
															_p10(_p5),
															_p13(_p8)),
														A2(
															_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
															A3(
																_elm_community$elm_lazy_list$Lazy_List$map2,
																F2(
																	function (b, c) {
																		return {ctor: '_Tuple5', _0: _p5, _1: b, _2: c, _3: _p8, _4: _p9};
																	}),
																_p11(_p6),
																_p12(_p7)),
															A2(
																_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																A3(
																	_elm_community$elm_lazy_list$Lazy_List$map2,
																	F2(
																		function (a, c) {
																			return {ctor: '_Tuple5', _0: a, _1: _p6, _2: c, _3: _p8, _4: _p9};
																		}),
																	_p10(_p5),
																	_p12(_p7)),
																A2(
																	_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																	A3(
																		_elm_community$elm_lazy_list$Lazy_List$map2,
																		F2(
																			function (a, b) {
																				return {ctor: '_Tuple5', _0: a, _1: b, _2: _p7, _3: _p8, _4: _p9};
																			}),
																		_p10(_p5),
																		_p11(_p6)),
																	A2(
																		_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																		A4(
																			_elm_community$elm_lazy_list$Lazy_List$map3,
																			F3(
																				function (a, b, c) {
																					return {ctor: '_Tuple5', _0: a, _1: b, _2: c, _3: _p8, _4: _p9};
																				}),
																			_p10(_p5),
																			_p11(_p6),
																			_p12(_p7)),
																		A2(
																			_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																			A4(
																				_elm_community$elm_lazy_list$Lazy_List$map3,
																				F3(
																					function (a, b, d) {
																						return {ctor: '_Tuple5', _0: a, _1: b, _2: _p7, _3: d, _4: _p9};
																					}),
																				_p10(_p5),
																				_p11(_p6),
																				_p13(_p8)),
																			A2(
																				_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																				A4(
																					_elm_community$elm_lazy_list$Lazy_List$map3,
																					F3(
																						function (a, c, d) {
																							return {ctor: '_Tuple5', _0: a, _1: _p6, _2: c, _3: d, _4: _p9};
																						}),
																					_p10(_p5),
																					_p12(_p7),
																					_p13(_p8)),
																				A2(
																					_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																					A4(
																						_elm_community$elm_lazy_list$Lazy_List$map3,
																						F3(
																							function (b, c, d) {
																								return {ctor: '_Tuple5', _0: _p5, _1: b, _2: c, _3: d, _4: _p9};
																							}),
																						_p11(_p6),
																						_p12(_p7),
																						_p13(_p8)),
																					A2(
																						_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																						A4(
																							_elm_community$elm_lazy_list$Lazy_List$map3,
																							F3(
																								function (a, b, e) {
																									return {ctor: '_Tuple5', _0: a, _1: b, _2: _p7, _3: _p8, _4: e};
																								}),
																							_p10(_p5),
																							_p11(_p6),
																							_p14(_p9)),
																						A2(
																							_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																							A4(
																								_elm_community$elm_lazy_list$Lazy_List$map3,
																								F3(
																									function (a, c, e) {
																										return {ctor: '_Tuple5', _0: a, _1: _p6, _2: c, _3: _p8, _4: e};
																									}),
																								_p10(_p5),
																								_p12(_p7),
																								_p14(_p9)),
																							A2(
																								_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																								A4(
																									_elm_community$elm_lazy_list$Lazy_List$map3,
																									F3(
																										function (b, c, e) {
																											return {ctor: '_Tuple5', _0: _p5, _1: b, _2: c, _3: _p8, _4: e};
																										}),
																									_p11(_p6),
																									_p12(_p7),
																									_p14(_p9)),
																								A2(
																									_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																									A4(
																										_elm_community$elm_lazy_list$Lazy_List$map3,
																										F3(
																											function (a, d, e) {
																												return {ctor: '_Tuple5', _0: a, _1: _p6, _2: _p7, _3: d, _4: e};
																											}),
																										_p10(_p5),
																										_p13(_p8),
																										_p14(_p9)),
																									A2(
																										_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																										A4(
																											_elm_community$elm_lazy_list$Lazy_List$map3,
																											F3(
																												function (b, d, e) {
																													return {ctor: '_Tuple5', _0: _p5, _1: b, _2: _p7, _3: d, _4: e};
																												}),
																											_p11(_p6),
																											_p13(_p8),
																											_p14(_p9)),
																										A2(
																											_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																											A4(
																												_elm_community$elm_lazy_list$Lazy_List$map3,
																												F3(
																													function (c, d, e) {
																														return {ctor: '_Tuple5', _0: _p5, _1: _p6, _2: c, _3: d, _4: e};
																													}),
																												_p12(_p7),
																												_p13(_p8),
																												_p14(_p9)),
																											A2(
																												_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																												A5(
																													_elm_community$elm_lazy_list$Lazy_List$map4,
																													F4(
																														function (b, c, d, e) {
																															return {ctor: '_Tuple5', _0: _p5, _1: b, _2: c, _3: d, _4: e};
																														}),
																													_p11(_p6),
																													_p12(_p7),
																													_p13(_p8),
																													_p14(_p9)),
																												A2(
																													_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																													A5(
																														_elm_community$elm_lazy_list$Lazy_List$map4,
																														F4(
																															function (a, c, d, e) {
																																return {ctor: '_Tuple5', _0: a, _1: _p6, _2: c, _3: d, _4: e};
																															}),
																														_p10(_p5),
																														_p12(_p7),
																														_p13(_p8),
																														_p14(_p9)),
																													A2(
																														_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																														A5(
																															_elm_community$elm_lazy_list$Lazy_List$map4,
																															F4(
																																function (a, b, d, e) {
																																	return {ctor: '_Tuple5', _0: a, _1: b, _2: _p7, _3: d, _4: e};
																																}),
																															_p10(_p5),
																															_p11(_p6),
																															_p13(_p8),
																															_p14(_p9)),
																														A2(
																															_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																															A5(
																																_elm_community$elm_lazy_list$Lazy_List$map4,
																																F4(
																																	function (a, b, c, d) {
																																		return {ctor: '_Tuple5', _0: a, _1: b, _2: c, _3: d, _4: _p9};
																																	}),
																																_p10(_p5),
																																_p11(_p6),
																																_p12(_p7),
																																_p13(_p8)),
																															A6(
																																_elm_community$elm_lazy_list$Lazy_List$map5,
																																F5(
																																	function (v0, v1, v2, v3, v4) {
																																		return {ctor: '_Tuple5', _0: v0, _1: v1, _2: v2, _3: v3, _4: v4};
																																	}),
																																_p10(_p5),
																																_p11(_p6),
																																_p12(_p7),
																																_p13(_p8),
																																_p14(_p9)))))))))))))))))))))))))))))));
	});
var _elm_community$shrink$Shrink$tuple4 = F2(
	function (_p16, _p15) {
		var _p17 = _p16;
		var _p26 = _p17._3;
		var _p25 = _p17._2;
		var _p24 = _p17._1;
		var _p23 = _p17._0;
		var _p18 = _p15;
		var _p22 = _p18._3;
		var _p21 = _p18._2;
		var _p20 = _p18._1;
		var _p19 = _p18._0;
		return A2(
			_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
			A2(
				_elm_community$elm_lazy_list$Lazy_List$map,
				function (d) {
					return {ctor: '_Tuple4', _0: _p19, _1: _p20, _2: _p21, _3: d};
				},
				_p26(_p22)),
			A2(
				_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
				A2(
					_elm_community$elm_lazy_list$Lazy_List$map,
					function (c) {
						return {ctor: '_Tuple4', _0: _p19, _1: _p20, _2: c, _3: _p22};
					},
					_p25(_p21)),
				A2(
					_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
					A2(
						_elm_community$elm_lazy_list$Lazy_List$map,
						function (b) {
							return {ctor: '_Tuple4', _0: _p19, _1: b, _2: _p21, _3: _p22};
						},
						_p24(_p20)),
					A2(
						_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
						A2(
							_elm_community$elm_lazy_list$Lazy_List$map,
							function (a) {
								return {ctor: '_Tuple4', _0: a, _1: _p20, _2: _p21, _3: _p22};
							},
							_p23(_p19)),
						A2(
							_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
							A3(
								_elm_community$elm_lazy_list$Lazy_List$map2,
								F2(
									function (c, d) {
										return {ctor: '_Tuple4', _0: _p19, _1: _p20, _2: c, _3: d};
									}),
								_p25(_p21),
								_p26(_p22)),
							A2(
								_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
								A3(
									_elm_community$elm_lazy_list$Lazy_List$map2,
									F2(
										function (b, d) {
											return {ctor: '_Tuple4', _0: _p19, _1: b, _2: _p21, _3: d};
										}),
									_p24(_p20),
									_p26(_p22)),
								A2(
									_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
									A3(
										_elm_community$elm_lazy_list$Lazy_List$map2,
										F2(
											function (a, d) {
												return {ctor: '_Tuple4', _0: a, _1: _p20, _2: _p21, _3: d};
											}),
										_p23(_p19),
										_p26(_p22)),
									A2(
										_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
										A3(
											_elm_community$elm_lazy_list$Lazy_List$map2,
											F2(
												function (b, c) {
													return {ctor: '_Tuple4', _0: _p19, _1: b, _2: c, _3: _p22};
												}),
											_p24(_p20),
											_p25(_p21)),
										A2(
											_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
											A3(
												_elm_community$elm_lazy_list$Lazy_List$map2,
												F2(
													function (a, c) {
														return {ctor: '_Tuple4', _0: a, _1: _p20, _2: c, _3: _p22};
													}),
												_p23(_p19),
												_p25(_p21)),
											A2(
												_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
												A3(
													_elm_community$elm_lazy_list$Lazy_List$map2,
													F2(
														function (a, b) {
															return {ctor: '_Tuple4', _0: a, _1: b, _2: _p21, _3: _p22};
														}),
													_p23(_p19),
													_p24(_p20)),
												A2(
													_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
													A4(
														_elm_community$elm_lazy_list$Lazy_List$map3,
														F3(
															function (b, c, d) {
																return {ctor: '_Tuple4', _0: _p19, _1: b, _2: c, _3: d};
															}),
														_p24(_p20),
														_p25(_p21),
														_p26(_p22)),
													A2(
														_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
														A4(
															_elm_community$elm_lazy_list$Lazy_List$map3,
															F3(
																function (a, c, d) {
																	return {ctor: '_Tuple4', _0: a, _1: _p20, _2: c, _3: d};
																}),
															_p23(_p19),
															_p25(_p21),
															_p26(_p22)),
														A2(
															_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
															A4(
																_elm_community$elm_lazy_list$Lazy_List$map3,
																F3(
																	function (a, b, d) {
																		return {ctor: '_Tuple4', _0: a, _1: b, _2: _p21, _3: d};
																	}),
																_p23(_p19),
																_p24(_p20),
																_p26(_p22)),
															A2(
																_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
																A4(
																	_elm_community$elm_lazy_list$Lazy_List$map3,
																	F3(
																		function (a, b, c) {
																			return {ctor: '_Tuple4', _0: a, _1: b, _2: c, _3: _p22};
																		}),
																	_p23(_p19),
																	_p24(_p20),
																	_p25(_p21)),
																A5(
																	_elm_community$elm_lazy_list$Lazy_List$map4,
																	F4(
																		function (v0, v1, v2, v3) {
																			return {ctor: '_Tuple4', _0: v0, _1: v1, _2: v2, _3: v3};
																		}),
																	_p23(_p19),
																	_p24(_p20),
																	_p25(_p21),
																	_p26(_p22))))))))))))))));
	});
var _elm_community$shrink$Shrink$tuple3 = F2(
	function (_p28, _p27) {
		var _p29 = _p28;
		var _p36 = _p29._2;
		var _p35 = _p29._1;
		var _p34 = _p29._0;
		var _p30 = _p27;
		var _p33 = _p30._2;
		var _p32 = _p30._1;
		var _p31 = _p30._0;
		return A2(
			_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
			A2(
				_elm_community$elm_lazy_list$Lazy_List$map,
				function (c) {
					return {ctor: '_Tuple3', _0: _p31, _1: _p32, _2: c};
				},
				_p36(_p33)),
			A2(
				_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
				A2(
					_elm_community$elm_lazy_list$Lazy_List$map,
					function (b) {
						return {ctor: '_Tuple3', _0: _p31, _1: b, _2: _p33};
					},
					_p35(_p32)),
				A2(
					_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
					A2(
						_elm_community$elm_lazy_list$Lazy_List$map,
						function (a) {
							return {ctor: '_Tuple3', _0: a, _1: _p32, _2: _p33};
						},
						_p34(_p31)),
					A2(
						_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
						A3(
							_elm_community$elm_lazy_list$Lazy_List$map2,
							F2(
								function (b, c) {
									return {ctor: '_Tuple3', _0: _p31, _1: b, _2: c};
								}),
							_p35(_p32),
							_p36(_p33)),
						A2(
							_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
							A3(
								_elm_community$elm_lazy_list$Lazy_List$map2,
								F2(
									function (a, c) {
										return {ctor: '_Tuple3', _0: a, _1: _p32, _2: c};
									}),
								_p34(_p31),
								_p36(_p33)),
							A2(
								_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
								A3(
									_elm_community$elm_lazy_list$Lazy_List$map2,
									F2(
										function (a, b) {
											return {ctor: '_Tuple3', _0: a, _1: b, _2: _p33};
										}),
									_p34(_p31),
									_p35(_p32)),
								A4(
									_elm_community$elm_lazy_list$Lazy_List$map3,
									F3(
										function (v0, v1, v2) {
											return {ctor: '_Tuple3', _0: v0, _1: v1, _2: v2};
										}),
									_p34(_p31),
									_p35(_p32),
									_p36(_p33))))))));
	});
var _elm_community$shrink$Shrink$tuple = F2(
	function (_p38, _p37) {
		var _p39 = _p38;
		var _p44 = _p39._1;
		var _p43 = _p39._0;
		var _p40 = _p37;
		var _p42 = _p40._1;
		var _p41 = _p40._0;
		return A2(
			_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
			A2(
				_elm_community$elm_lazy_list$Lazy_List$map,
				F2(
					function (v0, v1) {
						return {ctor: '_Tuple2', _0: v0, _1: v1};
					})(_p41),
				_p44(_p42)),
			A2(
				_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
				A2(
					_elm_community$elm_lazy_list$Lazy_List$map,
					A2(
						_elm_lang$core$Basics$flip,
						F2(
							function (v0, v1) {
								return {ctor: '_Tuple2', _0: v0, _1: v1};
							}),
						_p42),
					_p43(_p41)),
				A3(
					_elm_community$elm_lazy_list$Lazy_List$map2,
					F2(
						function (v0, v1) {
							return {ctor: '_Tuple2', _0: v0, _1: v1};
						}),
					_p43(_p41),
					_p44(_p42))));
	});
var _elm_community$shrink$Shrink$lazylist = F2(
	function (shrink, l) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p45) {
				var _p46 = _p45;
				var removes = F3(
					function (k, n, l) {
						return _elm_lang$lazy$Lazy$lazy(
							function (_p47) {
								var _p48 = _p47;
								if (_elm_lang$core$Native_Utils.cmp(k, n) > 0) {
									return _elm_lang$lazy$Lazy$force(_elm_community$elm_lazy_list$Lazy_List$empty);
								} else {
									if (_elm_community$elm_lazy_list$Lazy_List$isEmpty(l)) {
										return _elm_lang$lazy$Lazy$force(
											A2(_elm_community$elm_lazy_list$Lazy_List_ops[':::'], _elm_community$elm_lazy_list$Lazy_List$empty, _elm_community$elm_lazy_list$Lazy_List$empty));
									} else {
										var rest = A2(_elm_community$elm_lazy_list$Lazy_List$drop, k, l);
										var first = A2(_elm_community$elm_lazy_list$Lazy_List$take, k, l);
										return _elm_lang$lazy$Lazy$force(
											A2(
												_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
												rest,
												A2(
													_elm_community$elm_lazy_list$Lazy_List$map,
													F2(
														function (x, y) {
															return A2(_elm_community$elm_lazy_list$Lazy_List_ops['+++'], x, y);
														})(first),
													A3(removes, k, n - k, rest))));
									}
								}
							});
					});
				var shrinkOne = function (l) {
					return _elm_lang$lazy$Lazy$lazy(
						function (_p49) {
							var _p50 = _p49;
							var _p51 = _elm_lang$lazy$Lazy$force(l);
							if (_p51.ctor === 'Nil') {
								return _elm_lang$lazy$Lazy$force(_elm_community$elm_lazy_list$Lazy_List$empty);
							} else {
								var _p53 = _p51._1;
								var _p52 = _p51._0;
								return _elm_lang$lazy$Lazy$force(
									A2(
										_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
										A2(
											_elm_community$elm_lazy_list$Lazy_List$map,
											A2(
												_elm_lang$core$Basics$flip,
												F2(
													function (x, y) {
														return A2(_elm_community$elm_lazy_list$Lazy_List_ops[':::'], x, y);
													}),
												_p53),
											shrink(_p52)),
										A2(
											_elm_community$elm_lazy_list$Lazy_List$map,
											F2(
												function (x, y) {
													return A2(_elm_community$elm_lazy_list$Lazy_List_ops[':::'], x, y);
												})(_p52),
											shrinkOne(_p53))));
							}
						});
				};
				var n = _elm_community$elm_lazy_list$Lazy_List$length(l);
				return _elm_lang$lazy$Lazy$force(
					A2(
						_elm_community$elm_lazy_list$Lazy_List_ops['+++'],
						A2(
							_elm_community$elm_lazy_list$Lazy_List$flatMap,
							function (k) {
								return A3(removes, k, n, l);
							},
							A2(
								_elm_community$elm_lazy_list$Lazy_List$takeWhile,
								function (x) {
									return _elm_lang$core$Native_Utils.cmp(x, 0) > 0;
								},
								A2(
									_elm_community$elm_lazy_list$Lazy_List$iterate,
									function (n) {
										return (n / 2) | 0;
									},
									n))),
						shrinkOne(l)));
			});
	});
var _elm_community$shrink$Shrink$list = function (shrink) {
	return A3(
		_elm_community$shrink$Shrink$convert,
		_elm_community$elm_lazy_list$Lazy_List$toList,
		_elm_community$elm_lazy_list$Lazy_List$fromList,
		_elm_community$shrink$Shrink$lazylist(shrink));
};
var _elm_community$shrink$Shrink$array = function (shrink) {
	return A3(
		_elm_community$shrink$Shrink$convert,
		_elm_community$elm_lazy_list$Lazy_List$toArray,
		_elm_community$elm_lazy_list$Lazy_List$fromArray,
		_elm_community$shrink$Shrink$lazylist(shrink));
};
var _elm_community$shrink$Shrink$result = F3(
	function (shrinkError, shrinkValue, r) {
		var _p54 = r;
		if (_p54.ctor === 'Ok') {
			return A2(
				_elm_community$elm_lazy_list$Lazy_List$map,
				_elm_lang$core$Result$Ok,
				shrinkValue(_p54._0));
		} else {
			return A2(
				_elm_community$elm_lazy_list$Lazy_List$map,
				_elm_lang$core$Result$Err,
				shrinkError(_p54._0));
		}
	});
var _elm_community$shrink$Shrink$maybe = F2(
	function (shrink, m) {
		var _p55 = m;
		if (_p55.ctor === 'Just') {
			return A2(
				_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
				_elm_lang$core$Maybe$Nothing,
				A2(
					_elm_community$elm_lazy_list$Lazy_List$map,
					_elm_lang$core$Maybe$Just,
					shrink(_p55._0)));
		} else {
			return _elm_community$elm_lazy_list$Lazy_List$empty;
		}
	});
var _elm_community$shrink$Shrink$atLeastFloat = F2(
	function (min, n) {
		return ((_elm_lang$core$Native_Utils.cmp(n, 0) < 0) && (_elm_lang$core$Native_Utils.cmp(n, min) > -1)) ? A2(
			_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
			0 - n,
			A2(
				_elm_community$elm_lazy_list$Lazy_List$map,
				F2(
					function (x, y) {
						return x * y;
					})(-1),
				A2(_elm_community$shrink$Shrink$seriesFloat, 0, 0 - n))) : A2(
			_elm_community$shrink$Shrink$seriesFloat,
			A2(_elm_lang$core$Basics$max, 0, min),
			n);
	});
var _elm_community$shrink$Shrink$float = function (n) {
	return (_elm_lang$core$Native_Utils.cmp(n, 0) < 0) ? A2(
		_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
		0 - n,
		A2(
			_elm_community$elm_lazy_list$Lazy_List$map,
			F2(
				function (x, y) {
					return x * y;
				})(-1),
			A2(_elm_community$shrink$Shrink$seriesFloat, 0, 0 - n))) : A2(_elm_community$shrink$Shrink$seriesFloat, 0, n);
};
var _elm_community$shrink$Shrink$atLeastInt = F2(
	function (min, n) {
		return ((_elm_lang$core$Native_Utils.cmp(n, 0) < 0) && (_elm_lang$core$Native_Utils.cmp(n, min) > -1)) ? A2(
			_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
			0 - n,
			A2(
				_elm_community$elm_lazy_list$Lazy_List$map,
				F2(
					function (x, y) {
						return x * y;
					})(-1),
				A2(_elm_community$shrink$Shrink$seriesInt, 0, 0 - n))) : A2(
			_elm_community$shrink$Shrink$seriesInt,
			A2(_elm_lang$core$Basics$max, 0, min),
			n);
	});
var _elm_community$shrink$Shrink$atLeastChar = function ($char) {
	return A3(
		_elm_community$shrink$Shrink$convert,
		_elm_lang$core$Char$fromCode,
		_elm_lang$core$Char$toCode,
		_elm_community$shrink$Shrink$atLeastInt(
			_elm_lang$core$Char$toCode($char)));
};
var _elm_community$shrink$Shrink$character = _elm_community$shrink$Shrink$atLeastChar(
	_elm_lang$core$Char$fromCode(32));
var _elm_community$shrink$Shrink$string = A3(
	_elm_community$shrink$Shrink$convert,
	_elm_lang$core$String$fromList,
	_elm_lang$core$String$toList,
	_elm_community$shrink$Shrink$list(_elm_community$shrink$Shrink$character));
var _elm_community$shrink$Shrink$int = function (n) {
	return (_elm_lang$core$Native_Utils.cmp(n, 0) < 0) ? A2(
		_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
		0 - n,
		A2(
			_elm_community$elm_lazy_list$Lazy_List$map,
			F2(
				function (x, y) {
					return x * y;
				})(-1),
			A2(_elm_community$shrink$Shrink$seriesInt, 0, 0 - n))) : A2(_elm_community$shrink$Shrink$seriesInt, 0, n);
};
var _elm_community$shrink$Shrink$char = A3(_elm_community$shrink$Shrink$convert, _elm_lang$core$Char$fromCode, _elm_lang$core$Char$toCode, _elm_community$shrink$Shrink$int);
var _elm_community$shrink$Shrink$order = function (o) {
	var _p56 = o;
	switch (_p56.ctor) {
		case 'GT':
			return A2(
				_elm_community$elm_lazy_list$Lazy_List_ops[':::'],
				_elm_lang$core$Basics$EQ,
				A2(_elm_community$elm_lazy_list$Lazy_List_ops[':::'], _elm_lang$core$Basics$LT, _elm_community$elm_lazy_list$Lazy_List$empty));
		case 'LT':
			return A2(_elm_community$elm_lazy_list$Lazy_List_ops[':::'], _elm_lang$core$Basics$EQ, _elm_community$elm_lazy_list$Lazy_List$empty);
		default:
			return _elm_community$elm_lazy_list$Lazy_List$empty;
	}
};
var _elm_community$shrink$Shrink$bool = function (b) {
	var _p57 = b;
	if (_p57 === true) {
		return A2(_elm_community$elm_lazy_list$Lazy_List_ops[':::'], false, _elm_community$elm_lazy_list$Lazy_List$empty);
	} else {
		return _elm_community$elm_lazy_list$Lazy_List$empty;
	}
};
var _elm_community$shrink$Shrink$noShrink = function (_p58) {
	return _elm_community$elm_lazy_list$Lazy_List$empty;
};
var _elm_community$shrink$Shrink$unit = _elm_community$shrink$Shrink$noShrink;
var _elm_community$shrink$Shrink$shrink = F3(
	function (keepShrinking, shrinker, originalVal) {
		var helper = F2(
			function (lazyList, val) {
				helper:
				while (true) {
					var _p59 = _elm_lang$lazy$Lazy$force(lazyList);
					if (_p59.ctor === 'Nil') {
						return val;
					} else {
						var _p60 = _p59._0;
						if (keepShrinking(_p60)) {
							var _v17 = shrinker(_p60),
								_v18 = _p60;
							lazyList = _v17;
							val = _v18;
							continue helper;
						} else {
							var _v19 = _p59._1,
								_v20 = val;
							lazyList = _v19;
							val = _v20;
							continue helper;
						}
					}
				}
			});
		return A2(
			helper,
			shrinker(originalVal),
			originalVal);
	});

var _elm_community$random_extra$Random_Extra$flatMap6 = F7(
	function (constructor, generatorA, generatorB, generatorC, generatorD, generatorE, generatorF) {
		return A2(
			_elm_lang$core$Random$andThen,
			generatorA,
			function (a) {
				return A2(
					_elm_lang$core$Random$andThen,
					generatorB,
					function (b) {
						return A2(
							_elm_lang$core$Random$andThen,
							generatorC,
							function (c) {
								return A2(
									_elm_lang$core$Random$andThen,
									generatorD,
									function (d) {
										return A2(
											_elm_lang$core$Random$andThen,
											generatorE,
											function (e) {
												return A2(
													_elm_lang$core$Random$andThen,
													generatorF,
													function (f) {
														return A6(constructor, a, b, c, d, e, f);
													});
											});
									});
							});
					});
			});
	});
var _elm_community$random_extra$Random_Extra$flatMap5 = F6(
	function (constructor, generatorA, generatorB, generatorC, generatorD, generatorE) {
		return A2(
			_elm_lang$core$Random$andThen,
			generatorA,
			function (a) {
				return A2(
					_elm_lang$core$Random$andThen,
					generatorB,
					function (b) {
						return A2(
							_elm_lang$core$Random$andThen,
							generatorC,
							function (c) {
								return A2(
									_elm_lang$core$Random$andThen,
									generatorD,
									function (d) {
										return A2(
											_elm_lang$core$Random$andThen,
											generatorE,
											function (e) {
												return A5(constructor, a, b, c, d, e);
											});
									});
							});
					});
			});
	});
var _elm_community$random_extra$Random_Extra$flatMap4 = F5(
	function (constructor, generatorA, generatorB, generatorC, generatorD) {
		return A2(
			_elm_lang$core$Random$andThen,
			generatorA,
			function (a) {
				return A2(
					_elm_lang$core$Random$andThen,
					generatorB,
					function (b) {
						return A2(
							_elm_lang$core$Random$andThen,
							generatorC,
							function (c) {
								return A2(
									_elm_lang$core$Random$andThen,
									generatorD,
									function (d) {
										return A4(constructor, a, b, c, d);
									});
							});
					});
			});
	});
var _elm_community$random_extra$Random_Extra$flatMap3 = F4(
	function (constructor, generatorA, generatorB, generatorC) {
		return A2(
			_elm_lang$core$Random$andThen,
			generatorA,
			function (a) {
				return A2(
					_elm_lang$core$Random$andThen,
					generatorB,
					function (b) {
						return A2(
							_elm_lang$core$Random$andThen,
							generatorC,
							function (c) {
								return A3(constructor, a, b, c);
							});
					});
			});
	});
var _elm_community$random_extra$Random_Extra$flatMap2 = F3(
	function (constructor, generatorA, generatorB) {
		return A2(
			_elm_lang$core$Random$andThen,
			generatorA,
			function (a) {
				return A2(
					_elm_lang$core$Random$andThen,
					generatorB,
					function (b) {
						return A2(constructor, a, b);
					});
			});
	});
var _elm_community$random_extra$Random_Extra$flatMap = _elm_lang$core$Basics$flip(_elm_lang$core$Random$andThen);
var _elm_community$random_extra$Random_Extra$rangeLengthList = F3(
	function (minLength, maxLength, generator) {
		return A2(
			_elm_community$random_extra$Random_Extra$flatMap,
			function (len) {
				return A2(_elm_lang$core$Random$list, len, generator);
			},
			A2(_elm_lang$core$Random$int, minLength, maxLength));
	});
var _elm_community$random_extra$Random_Extra$result = F3(
	function (genBool, genErr, genVal) {
		return A2(
			_elm_lang$core$Random$andThen,
			genBool,
			function (b) {
				return b ? A2(_elm_lang$core$Random$map, _elm_lang$core$Result$Ok, genVal) : A2(_elm_lang$core$Random$map, _elm_lang$core$Result$Err, genErr);
			});
	});
var _elm_community$random_extra$Random_Extra$sample = function () {
	var find = F2(
		function (k, ys) {
			find:
			while (true) {
				var _p0 = ys;
				if (_p0.ctor === '[]') {
					return _elm_lang$core$Maybe$Nothing;
				} else {
					if (_elm_lang$core$Native_Utils.eq(k, 0)) {
						return _elm_lang$core$Maybe$Just(_p0._0);
					} else {
						var _v1 = k - 1,
							_v2 = _p0._1;
						k = _v1;
						ys = _v2;
						continue find;
					}
				}
			}
		});
	return function (xs) {
		return A2(
			_elm_lang$core$Random$map,
			function (i) {
				return A2(find, i, xs);
			},
			A2(
				_elm_lang$core$Random$int,
				0,
				_elm_lang$core$List$length(xs) - 1));
	};
}();
var _elm_community$random_extra$Random_Extra$frequency = function (pairs) {
	var pick = F2(
		function (choices, n) {
			pick:
			while (true) {
				var _p1 = choices;
				if ((_p1.ctor === '::') && (_p1._0.ctor === '_Tuple2')) {
					var _p2 = _p1._0._0;
					if (_elm_lang$core$Native_Utils.cmp(n, _p2) < 1) {
						return _p1._0._1;
					} else {
						var _v4 = _p1._1,
							_v5 = n - _p2;
						choices = _v4;
						n = _v5;
						continue pick;
					}
				} else {
					return _elm_lang$core$Native_Utils.crashCase(
						'Random.Extra',
						{
							start: {line: 153, column: 13},
							end: {line: 161, column: 79}
						},
						_p1)('Empty list passed to Random.Extra.frequency!');
				}
			}
		});
	var total = _elm_lang$core$List$sum(
		A2(
			_elm_lang$core$List$map,
			function (_p4) {
				return _elm_lang$core$Basics$abs(
					_elm_lang$core$Basics$fst(_p4));
			},
			pairs));
	return A2(
		_elm_lang$core$Random$andThen,
		A2(_elm_lang$core$Random$float, 0, total),
		pick(pairs));
};
var _elm_community$random_extra$Random_Extra$choices = function (gens) {
	return _elm_community$random_extra$Random_Extra$frequency(
		A2(
			_elm_lang$core$List$map,
			function (g) {
				return {ctor: '_Tuple2', _0: 1, _1: g};
			},
			gens));
};
var _elm_community$random_extra$Random_Extra$choice = F2(
	function (x, y) {
		return A2(
			_elm_lang$core$Random$map,
			function (b) {
				return b ? x : y;
			},
			_elm_lang$core$Random$bool);
	});
var _elm_community$random_extra$Random_Extra$oneIn = function (n) {
	return A2(
		_elm_lang$core$Random$map,
		F2(
			function (x, y) {
				return _elm_lang$core$Native_Utils.eq(x, y);
			})(1),
		A2(_elm_lang$core$Random$int, 1, n));
};
var _elm_community$random_extra$Random_Extra$andMap = F2(
	function (funcGenerator, generator) {
		return A3(
			_elm_lang$core$Random$map2,
			F2(
				function (x, y) {
					return x(y);
				}),
			funcGenerator,
			generator);
	});
var _elm_community$random_extra$Random_Extra$map6 = F7(
	function (f, generatorA, generatorB, generatorC, generatorD, generatorE, generatorF) {
		return A2(
			_elm_community$random_extra$Random_Extra$andMap,
			A6(_elm_lang$core$Random$map5, f, generatorA, generatorB, generatorC, generatorD, generatorE),
			generatorF);
	});
var _elm_community$random_extra$Random_Extra$constant = function (value) {
	return A2(
		_elm_lang$core$Random$map,
		function (_p5) {
			return value;
		},
		_elm_lang$core$Random$bool);
};
var _elm_community$random_extra$Random_Extra$filter = F2(
	function (predicate, generator) {
		return A2(
			_elm_lang$core$Random$andThen,
			generator,
			function (a) {
				return predicate(a) ? _elm_community$random_extra$Random_Extra$constant(a) : A2(_elm_community$random_extra$Random_Extra$filter, predicate, generator);
			});
	});
var _elm_community$random_extra$Random_Extra$together = function (generators) {
	var _p6 = generators;
	if (_p6.ctor === '[]') {
		return _elm_community$random_extra$Random_Extra$constant(
			_elm_lang$core$Native_List.fromArray(
				[]));
	} else {
		return A3(
			_elm_lang$core$Random$map2,
			F2(
				function (x, y) {
					return A2(_elm_lang$core$List_ops['::'], x, y);
				}),
			_p6._0,
			_elm_community$random_extra$Random_Extra$together(_p6._1));
	}
};
var _elm_community$random_extra$Random_Extra$maybe = F2(
	function (genBool, genA) {
		return A2(
			_elm_lang$core$Random$andThen,
			genBool,
			function (b) {
				return b ? A2(_elm_lang$core$Random$map, _elm_lang$core$Maybe$Just, genA) : _elm_community$random_extra$Random_Extra$constant(_elm_lang$core$Maybe$Nothing);
			});
	});

var _elm_community$random_extra$Random_Order$order = A2(
	_elm_lang$core$Random$map,
	_elm_lang$core$Maybe$withDefault(_elm_lang$core$Basics$EQ),
	_elm_community$random_extra$Random_Extra$sample(
		_elm_lang$core$Native_List.fromArray(
			[_elm_lang$core$Basics$LT, _elm_lang$core$Basics$EQ, _elm_lang$core$Basics$GT])));

var _elm_community$random_extra$Random_Char$char = F2(
	function (start, end) {
		return A2(
			_elm_lang$core$Random$map,
			_elm_lang$core$Char$fromCode,
			A2(_elm_lang$core$Random$int, start, end));
	});
var _elm_community$random_extra$Random_Char$upperCaseLatin = A2(_elm_community$random_extra$Random_Char$char, 65, 90);
var _elm_community$random_extra$Random_Char$lowerCaseLatin = A2(_elm_community$random_extra$Random_Char$char, 97, 122);
var _elm_community$random_extra$Random_Char$latin = _elm_community$random_extra$Random_Extra$choices(
	_elm_lang$core$Native_List.fromArray(
		[_elm_community$random_extra$Random_Char$lowerCaseLatin, _elm_community$random_extra$Random_Char$upperCaseLatin]));
var _elm_community$random_extra$Random_Char$english = _elm_community$random_extra$Random_Char$latin;
var _elm_community$random_extra$Random_Char$ascii = A2(_elm_community$random_extra$Random_Char$char, 0, 127);
var _elm_community$random_extra$Random_Char$unicode = A2(_elm_community$random_extra$Random_Char$char, 0, 1114111);
var _elm_community$random_extra$Random_Char$basicLatin = A2(_elm_community$random_extra$Random_Char$char, 0, 127);
var _elm_community$random_extra$Random_Char$latin1Supplement = A2(_elm_community$random_extra$Random_Char$char, 128, 255);
var _elm_community$random_extra$Random_Char$latinExtendedA = A2(_elm_community$random_extra$Random_Char$char, 256, 383);
var _elm_community$random_extra$Random_Char$latinExtendedB = A2(_elm_community$random_extra$Random_Char$char, 384, 591);
var _elm_community$random_extra$Random_Char$ipaExtensions = A2(_elm_community$random_extra$Random_Char$char, 592, 687);
var _elm_community$random_extra$Random_Char$spacingModifier = A2(_elm_community$random_extra$Random_Char$char, 688, 767);
var _elm_community$random_extra$Random_Char$combiningDiacriticalMarks = A2(_elm_community$random_extra$Random_Char$char, 768, 879);
var _elm_community$random_extra$Random_Char$greekAndCoptic = A2(_elm_community$random_extra$Random_Char$char, 880, 1023);
var _elm_community$random_extra$Random_Char$cyrillic = A2(_elm_community$random_extra$Random_Char$char, 1024, 1279);
var _elm_community$random_extra$Random_Char$cyrillicSupplement = A2(_elm_community$random_extra$Random_Char$char, 1280, 1327);
var _elm_community$random_extra$Random_Char$armenian = A2(_elm_community$random_extra$Random_Char$char, 1328, 1423);
var _elm_community$random_extra$Random_Char$hebrew = A2(_elm_community$random_extra$Random_Char$char, 1424, 1535);
var _elm_community$random_extra$Random_Char$arabic = A2(_elm_community$random_extra$Random_Char$char, 1536, 1791);
var _elm_community$random_extra$Random_Char$syriac = A2(_elm_community$random_extra$Random_Char$char, 1792, 1871);
var _elm_community$random_extra$Random_Char$arabicSupplement = A2(_elm_community$random_extra$Random_Char$char, 1872, 1919);
var _elm_community$random_extra$Random_Char$thaana = A2(_elm_community$random_extra$Random_Char$char, 1920, 1983);
var _elm_community$random_extra$Random_Char$nko = A2(_elm_community$random_extra$Random_Char$char, 1984, 2047);
var _elm_community$random_extra$Random_Char$samaritan = A2(_elm_community$random_extra$Random_Char$char, 2048, 2111);
var _elm_community$random_extra$Random_Char$mandaic = A2(_elm_community$random_extra$Random_Char$char, 2112, 2143);
var _elm_community$random_extra$Random_Char$arabicExtendedA = A2(_elm_community$random_extra$Random_Char$char, 2208, 2303);
var _elm_community$random_extra$Random_Char$devanagari = A2(_elm_community$random_extra$Random_Char$char, 2304, 2431);
var _elm_community$random_extra$Random_Char$bengali = A2(_elm_community$random_extra$Random_Char$char, 2432, 2559);
var _elm_community$random_extra$Random_Char$gurmukhi = A2(_elm_community$random_extra$Random_Char$char, 2560, 2687);
var _elm_community$random_extra$Random_Char$gujarati = A2(_elm_community$random_extra$Random_Char$char, 2688, 2815);
var _elm_community$random_extra$Random_Char$oriya = A2(_elm_community$random_extra$Random_Char$char, 2816, 2943);
var _elm_community$random_extra$Random_Char$tamil = A2(_elm_community$random_extra$Random_Char$char, 2944, 3071);
var _elm_community$random_extra$Random_Char$telugu = A2(_elm_community$random_extra$Random_Char$char, 3072, 3199);
var _elm_community$random_extra$Random_Char$kannada = A2(_elm_community$random_extra$Random_Char$char, 3200, 3327);
var _elm_community$random_extra$Random_Char$malayalam = A2(_elm_community$random_extra$Random_Char$char, 3328, 3455);
var _elm_community$random_extra$Random_Char$sinhala = A2(_elm_community$random_extra$Random_Char$char, 3456, 3583);
var _elm_community$random_extra$Random_Char$thai = A2(_elm_community$random_extra$Random_Char$char, 3584, 3711);
var _elm_community$random_extra$Random_Char$lao = A2(_elm_community$random_extra$Random_Char$char, 3712, 3839);
var _elm_community$random_extra$Random_Char$tibetan = A2(_elm_community$random_extra$Random_Char$char, 3840, 4095);
var _elm_community$random_extra$Random_Char$myanmar = A2(_elm_community$random_extra$Random_Char$char, 4096, 4255);
var _elm_community$random_extra$Random_Char$georgian = A2(_elm_community$random_extra$Random_Char$char, 4256, 4351);
var _elm_community$random_extra$Random_Char$hangulJamo = A2(_elm_community$random_extra$Random_Char$char, 4352, 4607);
var _elm_community$random_extra$Random_Char$ethiopic = A2(_elm_community$random_extra$Random_Char$char, 4608, 4991);
var _elm_community$random_extra$Random_Char$ethiopicSupplement = A2(_elm_community$random_extra$Random_Char$char, 4992, 5023);
var _elm_community$random_extra$Random_Char$cherokee = A2(_elm_community$random_extra$Random_Char$char, 5024, 5119);
var _elm_community$random_extra$Random_Char$unifiedCanadianAboriginalSyllabic = A2(_elm_community$random_extra$Random_Char$char, 5120, 5759);
var _elm_community$random_extra$Random_Char$ogham = A2(_elm_community$random_extra$Random_Char$char, 5760, 5791);
var _elm_community$random_extra$Random_Char$runic = A2(_elm_community$random_extra$Random_Char$char, 5792, 5887);
var _elm_community$random_extra$Random_Char$tagalog = A2(_elm_community$random_extra$Random_Char$char, 5888, 5919);
var _elm_community$random_extra$Random_Char$hanunoo = A2(_elm_community$random_extra$Random_Char$char, 5920, 5951);
var _elm_community$random_extra$Random_Char$buhid = A2(_elm_community$random_extra$Random_Char$char, 5952, 5983);
var _elm_community$random_extra$Random_Char$tagbanwa = A2(_elm_community$random_extra$Random_Char$char, 5984, 6015);
var _elm_community$random_extra$Random_Char$khmer = A2(_elm_community$random_extra$Random_Char$char, 6016, 6143);
var _elm_community$random_extra$Random_Char$mongolian = A2(_elm_community$random_extra$Random_Char$char, 6144, 6319);
var _elm_community$random_extra$Random_Char$unifiedCanadianAboriginalSyllabicExtended = A2(_elm_community$random_extra$Random_Char$char, 6320, 6399);
var _elm_community$random_extra$Random_Char$limbu = A2(_elm_community$random_extra$Random_Char$char, 6400, 6479);
var _elm_community$random_extra$Random_Char$taiLe = A2(_elm_community$random_extra$Random_Char$char, 6480, 6527);
var _elm_community$random_extra$Random_Char$newTaiLue = A2(_elm_community$random_extra$Random_Char$char, 6528, 6623);
var _elm_community$random_extra$Random_Char$khmerSymbol = A2(_elm_community$random_extra$Random_Char$char, 6624, 6655);
var _elm_community$random_extra$Random_Char$buginese = A2(_elm_community$random_extra$Random_Char$char, 6656, 6687);
var _elm_community$random_extra$Random_Char$taiTham = A2(_elm_community$random_extra$Random_Char$char, 6688, 6831);
var _elm_community$random_extra$Random_Char$balinese = A2(_elm_community$random_extra$Random_Char$char, 6912, 7039);
var _elm_community$random_extra$Random_Char$sundanese = A2(_elm_community$random_extra$Random_Char$char, 7040, 7103);
var _elm_community$random_extra$Random_Char$batak = A2(_elm_community$random_extra$Random_Char$char, 7104, 7167);
var _elm_community$random_extra$Random_Char$lepcha = A2(_elm_community$random_extra$Random_Char$char, 7168, 7247);
var _elm_community$random_extra$Random_Char$olChiki = A2(_elm_community$random_extra$Random_Char$char, 7248, 7295);
var _elm_community$random_extra$Random_Char$sundaneseSupplement = A2(_elm_community$random_extra$Random_Char$char, 7360, 7375);
var _elm_community$random_extra$Random_Char$vedicExtensions = A2(_elm_community$random_extra$Random_Char$char, 7376, 7423);
var _elm_community$random_extra$Random_Char$phoneticExtensions = A2(_elm_community$random_extra$Random_Char$char, 7424, 7551);
var _elm_community$random_extra$Random_Char$phoneticExtensionsSupplement = A2(_elm_community$random_extra$Random_Char$char, 7552, 7615);
var _elm_community$random_extra$Random_Char$combiningDiacriticalMarksSupplement = A2(_elm_community$random_extra$Random_Char$char, 7616, 7679);
var _elm_community$random_extra$Random_Char$latinExtendedAdditional = A2(_elm_community$random_extra$Random_Char$char, 7680, 7935);
var _elm_community$random_extra$Random_Char$greekExtended = A2(_elm_community$random_extra$Random_Char$char, 7936, 8191);
var _elm_community$random_extra$Random_Char$generalPunctuation = A2(_elm_community$random_extra$Random_Char$char, 8192, 8303);
var _elm_community$random_extra$Random_Char$superscriptOrSubscript = A2(_elm_community$random_extra$Random_Char$char, 8304, 8351);
var _elm_community$random_extra$Random_Char$currencySymbol = A2(_elm_community$random_extra$Random_Char$char, 8352, 8399);
var _elm_community$random_extra$Random_Char$combiningDiacriticalMarksForSymbols = A2(_elm_community$random_extra$Random_Char$char, 8400, 8447);
var _elm_community$random_extra$Random_Char$letterlikeSymbol = A2(_elm_community$random_extra$Random_Char$char, 8448, 8527);
var _elm_community$random_extra$Random_Char$numberForm = A2(_elm_community$random_extra$Random_Char$char, 8528, 8591);
var _elm_community$random_extra$Random_Char$arrow = A2(_elm_community$random_extra$Random_Char$char, 8592, 8703);
var _elm_community$random_extra$Random_Char$mathematicalOperator = A2(_elm_community$random_extra$Random_Char$char, 8704, 8959);
var _elm_community$random_extra$Random_Char$miscellaneousTechnical = A2(_elm_community$random_extra$Random_Char$char, 8960, 9215);
var _elm_community$random_extra$Random_Char$controlPicture = A2(_elm_community$random_extra$Random_Char$char, 9216, 9279);
var _elm_community$random_extra$Random_Char$opticalCharacterRecognition = A2(_elm_community$random_extra$Random_Char$char, 9280, 9311);
var _elm_community$random_extra$Random_Char$enclosedAlphanumeric = A2(_elm_community$random_extra$Random_Char$char, 9312, 9471);
var _elm_community$random_extra$Random_Char$boxDrawing = A2(_elm_community$random_extra$Random_Char$char, 9472, 9599);
var _elm_community$random_extra$Random_Char$blockElement = A2(_elm_community$random_extra$Random_Char$char, 9600, 9631);
var _elm_community$random_extra$Random_Char$geometricShape = A2(_elm_community$random_extra$Random_Char$char, 9632, 9727);
var _elm_community$random_extra$Random_Char$miscellaneousSymbol = A2(_elm_community$random_extra$Random_Char$char, 9728, 9983);
var _elm_community$random_extra$Random_Char$dingbat = A2(_elm_community$random_extra$Random_Char$char, 9984, 10175);
var _elm_community$random_extra$Random_Char$miscellaneousMathematicalSymbolA = A2(_elm_community$random_extra$Random_Char$char, 10176, 10223);
var _elm_community$random_extra$Random_Char$supplementalArrowA = A2(_elm_community$random_extra$Random_Char$char, 10224, 10239);
var _elm_community$random_extra$Random_Char$braillePattern = A2(_elm_community$random_extra$Random_Char$char, 10240, 10495);
var _elm_community$random_extra$Random_Char$supplementalArrowB = A2(_elm_community$random_extra$Random_Char$char, 10496, 10623);
var _elm_community$random_extra$Random_Char$miscellaneousMathematicalSymbolB = A2(_elm_community$random_extra$Random_Char$char, 10624, 10751);
var _elm_community$random_extra$Random_Char$supplementalMathematicalOperator = A2(_elm_community$random_extra$Random_Char$char, 10752, 11007);
var _elm_community$random_extra$Random_Char$miscellaneousSymbolOrArrow = A2(_elm_community$random_extra$Random_Char$char, 11008, 11263);
var _elm_community$random_extra$Random_Char$glagolitic = A2(_elm_community$random_extra$Random_Char$char, 11264, 11359);
var _elm_community$random_extra$Random_Char$latinExtendedC = A2(_elm_community$random_extra$Random_Char$char, 11360, 11391);
var _elm_community$random_extra$Random_Char$coptic = A2(_elm_community$random_extra$Random_Char$char, 11392, 11519);
var _elm_community$random_extra$Random_Char$georgianSupplement = A2(_elm_community$random_extra$Random_Char$char, 11520, 11567);
var _elm_community$random_extra$Random_Char$tifinagh = A2(_elm_community$random_extra$Random_Char$char, 11568, 11647);
var _elm_community$random_extra$Random_Char$ethiopicExtended = A2(_elm_community$random_extra$Random_Char$char, 11648, 11743);
var _elm_community$random_extra$Random_Char$cyrillicExtendedA = A2(_elm_community$random_extra$Random_Char$char, 11744, 11775);
var _elm_community$random_extra$Random_Char$supplementalPunctuation = A2(_elm_community$random_extra$Random_Char$char, 11776, 11903);
var _elm_community$random_extra$Random_Char$cjkRadicalSupplement = A2(_elm_community$random_extra$Random_Char$char, 11904, 12031);
var _elm_community$random_extra$Random_Char$kangxiRadical = A2(_elm_community$random_extra$Random_Char$char, 12032, 12255);
var _elm_community$random_extra$Random_Char$ideographicDescription = A2(_elm_community$random_extra$Random_Char$char, 12272, 12287);
var _elm_community$random_extra$Random_Char$cjkSymbolOrPunctuation = A2(_elm_community$random_extra$Random_Char$char, 12288, 12351);
var _elm_community$random_extra$Random_Char$hiragana = A2(_elm_community$random_extra$Random_Char$char, 12352, 12447);
var _elm_community$random_extra$Random_Char$katakana = A2(_elm_community$random_extra$Random_Char$char, 12448, 12543);
var _elm_community$random_extra$Random_Char$bopomofo = A2(_elm_community$random_extra$Random_Char$char, 12544, 12591);
var _elm_community$random_extra$Random_Char$hangulCompatibilityJamo = A2(_elm_community$random_extra$Random_Char$char, 12592, 12687);
var _elm_community$random_extra$Random_Char$kanbun = A2(_elm_community$random_extra$Random_Char$char, 12688, 12703);
var _elm_community$random_extra$Random_Char$bopomofoExtended = A2(_elm_community$random_extra$Random_Char$char, 12704, 12735);
var _elm_community$random_extra$Random_Char$cjkStroke = A2(_elm_community$random_extra$Random_Char$char, 12736, 12783);
var _elm_community$random_extra$Random_Char$katakanaPhoneticExtension = A2(_elm_community$random_extra$Random_Char$char, 12784, 12799);
var _elm_community$random_extra$Random_Char$enclosedCJKLetterOrMonth = A2(_elm_community$random_extra$Random_Char$char, 12800, 13055);
var _elm_community$random_extra$Random_Char$cjkCompatibility = A2(_elm_community$random_extra$Random_Char$char, 13056, 13311);
var _elm_community$random_extra$Random_Char$cjkUnifiedIdeographExtensionA = A2(_elm_community$random_extra$Random_Char$char, 13312, 19903);
var _elm_community$random_extra$Random_Char$yijingHexagramSymbol = A2(_elm_community$random_extra$Random_Char$char, 19904, 19967);
var _elm_community$random_extra$Random_Char$cjkUnifiedIdeograph = A2(_elm_community$random_extra$Random_Char$char, 19968, 40959);
var _elm_community$random_extra$Random_Char$yiSyllable = A2(_elm_community$random_extra$Random_Char$char, 40960, 42127);
var _elm_community$random_extra$Random_Char$yiRadical = A2(_elm_community$random_extra$Random_Char$char, 42128, 42191);
var _elm_community$random_extra$Random_Char$lisu = A2(_elm_community$random_extra$Random_Char$char, 42192, 42239);
var _elm_community$random_extra$Random_Char$vai = A2(_elm_community$random_extra$Random_Char$char, 42240, 42559);
var _elm_community$random_extra$Random_Char$cyrillicExtendedB = A2(_elm_community$random_extra$Random_Char$char, 42560, 42655);
var _elm_community$random_extra$Random_Char$bamum = A2(_elm_community$random_extra$Random_Char$char, 42656, 42751);
var _elm_community$random_extra$Random_Char$modifierToneLetter = A2(_elm_community$random_extra$Random_Char$char, 42752, 42783);
var _elm_community$random_extra$Random_Char$latinExtendedD = A2(_elm_community$random_extra$Random_Char$char, 42784, 43007);
var _elm_community$random_extra$Random_Char$sylotiNagri = A2(_elm_community$random_extra$Random_Char$char, 43008, 43055);
var _elm_community$random_extra$Random_Char$commonIndicNumberForm = A2(_elm_community$random_extra$Random_Char$char, 43056, 43071);
var _elm_community$random_extra$Random_Char$phagsPa = A2(_elm_community$random_extra$Random_Char$char, 43072, 43135);
var _elm_community$random_extra$Random_Char$saurashtra = A2(_elm_community$random_extra$Random_Char$char, 43136, 43231);
var _elm_community$random_extra$Random_Char$devanagariExtended = A2(_elm_community$random_extra$Random_Char$char, 43232, 43263);
var _elm_community$random_extra$Random_Char$kayahLi = A2(_elm_community$random_extra$Random_Char$char, 43264, 43311);
var _elm_community$random_extra$Random_Char$rejang = A2(_elm_community$random_extra$Random_Char$char, 43312, 43359);
var _elm_community$random_extra$Random_Char$hangulJamoExtendedA = A2(_elm_community$random_extra$Random_Char$char, 43360, 43391);
var _elm_community$random_extra$Random_Char$javanese = A2(_elm_community$random_extra$Random_Char$char, 43392, 43487);
var _elm_community$random_extra$Random_Char$cham = A2(_elm_community$random_extra$Random_Char$char, 43520, 43615);
var _elm_community$random_extra$Random_Char$myanmarExtendedA = A2(_elm_community$random_extra$Random_Char$char, 43616, 43647);
var _elm_community$random_extra$Random_Char$taiViet = A2(_elm_community$random_extra$Random_Char$char, 43648, 43743);
var _elm_community$random_extra$Random_Char$meeteiMayekExtension = A2(_elm_community$random_extra$Random_Char$char, 43744, 43775);
var _elm_community$random_extra$Random_Char$ethiopicExtendedA = A2(_elm_community$random_extra$Random_Char$char, 43776, 43823);
var _elm_community$random_extra$Random_Char$meeteiMayek = A2(_elm_community$random_extra$Random_Char$char, 43968, 44031);
var _elm_community$random_extra$Random_Char$hangulSyllable = A2(_elm_community$random_extra$Random_Char$char, 44032, 55215);
var _elm_community$random_extra$Random_Char$hangulJamoExtendedB = A2(_elm_community$random_extra$Random_Char$char, 55216, 55295);
var _elm_community$random_extra$Random_Char$highSurrogate = A2(_elm_community$random_extra$Random_Char$char, 55296, 56191);
var _elm_community$random_extra$Random_Char$highPrivateUseSurrogate = A2(_elm_community$random_extra$Random_Char$char, 56192, 56319);
var _elm_community$random_extra$Random_Char$lowSurrogate = A2(_elm_community$random_extra$Random_Char$char, 56320, 57343);
var _elm_community$random_extra$Random_Char$privateUseArea = A2(_elm_community$random_extra$Random_Char$char, 57344, 63743);
var _elm_community$random_extra$Random_Char$cjkCompatibilityIdeograph = A2(_elm_community$random_extra$Random_Char$char, 63744, 64255);
var _elm_community$random_extra$Random_Char$alphabeticPresentationForm = A2(_elm_community$random_extra$Random_Char$char, 64256, 64335);
var _elm_community$random_extra$Random_Char$arabicPresentationFormA = A2(_elm_community$random_extra$Random_Char$char, 64336, 65023);
var _elm_community$random_extra$Random_Char$variationSelector = A2(_elm_community$random_extra$Random_Char$char, 65024, 65039);
var _elm_community$random_extra$Random_Char$verticalForm = A2(_elm_community$random_extra$Random_Char$char, 65040, 65055);
var _elm_community$random_extra$Random_Char$combiningHalfMark = A2(_elm_community$random_extra$Random_Char$char, 65056, 65071);
var _elm_community$random_extra$Random_Char$cjkCompatibilityForm = A2(_elm_community$random_extra$Random_Char$char, 65072, 65103);
var _elm_community$random_extra$Random_Char$smallFormVariant = A2(_elm_community$random_extra$Random_Char$char, 65104, 65135);
var _elm_community$random_extra$Random_Char$arabicPresentationFormB = A2(_elm_community$random_extra$Random_Char$char, 65136, 65279);
var _elm_community$random_extra$Random_Char$halfwidthOrFullwidthForm = A2(_elm_community$random_extra$Random_Char$char, 65280, 65519);
var _elm_community$random_extra$Random_Char$special = A2(_elm_community$random_extra$Random_Char$char, 65520, 65535);
var _elm_community$random_extra$Random_Char$linearBSyllable = A2(_elm_community$random_extra$Random_Char$char, 65536, 65663);
var _elm_community$random_extra$Random_Char$linearBIdeogram = A2(_elm_community$random_extra$Random_Char$char, 65664, 65791);
var _elm_community$random_extra$Random_Char$aegeanNumber = A2(_elm_community$random_extra$Random_Char$char, 65792, 65855);
var _elm_community$random_extra$Random_Char$ancientGreekNumber = A2(_elm_community$random_extra$Random_Char$char, 65856, 65935);
var _elm_community$random_extra$Random_Char$ancientSymbol = A2(_elm_community$random_extra$Random_Char$char, 65936, 65999);
var _elm_community$random_extra$Random_Char$phaistosDisc = A2(_elm_community$random_extra$Random_Char$char, 66000, 66047);
var _elm_community$random_extra$Random_Char$lycian = A2(_elm_community$random_extra$Random_Char$char, 66176, 66207);
var _elm_community$random_extra$Random_Char$carian = A2(_elm_community$random_extra$Random_Char$char, 66208, 66271);
var _elm_community$random_extra$Random_Char$oldItalic = A2(_elm_community$random_extra$Random_Char$char, 66304, 66351);
var _elm_community$random_extra$Random_Char$gothic = A2(_elm_community$random_extra$Random_Char$char, 66352, 66383);
var _elm_community$random_extra$Random_Char$ugaritic = A2(_elm_community$random_extra$Random_Char$char, 66432, 66463);
var _elm_community$random_extra$Random_Char$oldPersian = A2(_elm_community$random_extra$Random_Char$char, 66464, 66527);
var _elm_community$random_extra$Random_Char$deseret = A2(_elm_community$random_extra$Random_Char$char, 66560, 66639);
var _elm_community$random_extra$Random_Char$shavian = A2(_elm_community$random_extra$Random_Char$char, 66640, 66687);
var _elm_community$random_extra$Random_Char$osmanya = A2(_elm_community$random_extra$Random_Char$char, 66688, 66735);
var _elm_community$random_extra$Random_Char$cypriotSyllable = A2(_elm_community$random_extra$Random_Char$char, 67584, 67647);
var _elm_community$random_extra$Random_Char$imperialAramaic = A2(_elm_community$random_extra$Random_Char$char, 67648, 67679);
var _elm_community$random_extra$Random_Char$phoenician = A2(_elm_community$random_extra$Random_Char$char, 67840, 67871);
var _elm_community$random_extra$Random_Char$lydian = A2(_elm_community$random_extra$Random_Char$char, 67872, 67903);
var _elm_community$random_extra$Random_Char$meroiticHieroglyph = A2(_elm_community$random_extra$Random_Char$char, 67968, 67999);
var _elm_community$random_extra$Random_Char$meroiticCursive = A2(_elm_community$random_extra$Random_Char$char, 68000, 68095);
var _elm_community$random_extra$Random_Char$kharoshthi = A2(_elm_community$random_extra$Random_Char$char, 68096, 68191);
var _elm_community$random_extra$Random_Char$oldSouthArabian = A2(_elm_community$random_extra$Random_Char$char, 68192, 68223);
var _elm_community$random_extra$Random_Char$avestan = A2(_elm_community$random_extra$Random_Char$char, 68352, 68415);
var _elm_community$random_extra$Random_Char$inscriptionalParthian = A2(_elm_community$random_extra$Random_Char$char, 68416, 68447);
var _elm_community$random_extra$Random_Char$inscriptionalPahlavi = A2(_elm_community$random_extra$Random_Char$char, 68448, 68479);
var _elm_community$random_extra$Random_Char$oldTurkic = A2(_elm_community$random_extra$Random_Char$char, 68608, 68687);
var _elm_community$random_extra$Random_Char$rumiNumericalSymbol = A2(_elm_community$random_extra$Random_Char$char, 69216, 69247);
var _elm_community$random_extra$Random_Char$brahmi = A2(_elm_community$random_extra$Random_Char$char, 69632, 69759);
var _elm_community$random_extra$Random_Char$kaithi = A2(_elm_community$random_extra$Random_Char$char, 69760, 69839);
var _elm_community$random_extra$Random_Char$soraSompeng = A2(_elm_community$random_extra$Random_Char$char, 69840, 69887);
var _elm_community$random_extra$Random_Char$chakma = A2(_elm_community$random_extra$Random_Char$char, 69888, 69967);
var _elm_community$random_extra$Random_Char$sharada = A2(_elm_community$random_extra$Random_Char$char, 70016, 70111);
var _elm_community$random_extra$Random_Char$takri = A2(_elm_community$random_extra$Random_Char$char, 71296, 71375);
var _elm_community$random_extra$Random_Char$cuneiform = A2(_elm_community$random_extra$Random_Char$char, 73728, 74751);
var _elm_community$random_extra$Random_Char$cuneiformNumberOrPunctuation = A2(_elm_community$random_extra$Random_Char$char, 74752, 74879);
var _elm_community$random_extra$Random_Char$egyptianHieroglyph = A2(_elm_community$random_extra$Random_Char$char, 77824, 78895);
var _elm_community$random_extra$Random_Char$bamumSupplement = A2(_elm_community$random_extra$Random_Char$char, 92160, 92735);
var _elm_community$random_extra$Random_Char$miao = A2(_elm_community$random_extra$Random_Char$char, 93952, 94111);
var _elm_community$random_extra$Random_Char$kanaSupplement = A2(_elm_community$random_extra$Random_Char$char, 110592, 110847);
var _elm_community$random_extra$Random_Char$byzantineMusicalSymbol = A2(_elm_community$random_extra$Random_Char$char, 118784, 119039);
var _elm_community$random_extra$Random_Char$musicalSymbol = A2(_elm_community$random_extra$Random_Char$char, 119040, 119295);
var _elm_community$random_extra$Random_Char$ancientGreekMusicalNotationSymbol = A2(_elm_community$random_extra$Random_Char$char, 119296, 119375);
var _elm_community$random_extra$Random_Char$taiXuanJingSymbol = A2(_elm_community$random_extra$Random_Char$char, 119552, 119647);
var _elm_community$random_extra$Random_Char$countingRodNumeral = A2(_elm_community$random_extra$Random_Char$char, 119648, 119679);
var _elm_community$random_extra$Random_Char$mathematicalAlphanumericSymbol = A2(_elm_community$random_extra$Random_Char$char, 119808, 120831);
var _elm_community$random_extra$Random_Char$arabicMathematicalAlphabeticSymbol = A2(_elm_community$random_extra$Random_Char$char, 126464, 126719);
var _elm_community$random_extra$Random_Char$mahjongTile = A2(_elm_community$random_extra$Random_Char$char, 126976, 127023);
var _elm_community$random_extra$Random_Char$dominoTile = A2(_elm_community$random_extra$Random_Char$char, 127024, 127135);
var _elm_community$random_extra$Random_Char$playingCard = A2(_elm_community$random_extra$Random_Char$char, 127136, 127231);
var _elm_community$random_extra$Random_Char$enclosedAlphanumericSupplement = A2(_elm_community$random_extra$Random_Char$char, 127232, 127487);
var _elm_community$random_extra$Random_Char$enclosedIdeographicSupplement = A2(_elm_community$random_extra$Random_Char$char, 127488, 127743);
var _elm_community$random_extra$Random_Char$miscellaneousSymbolOrPictograph = A2(_elm_community$random_extra$Random_Char$char, 127744, 128511);
var _elm_community$random_extra$Random_Char$emoticon = A2(_elm_community$random_extra$Random_Char$char, 128512, 128591);
var _elm_community$random_extra$Random_Char$transportOrMapSymbol = A2(_elm_community$random_extra$Random_Char$char, 128640, 128767);
var _elm_community$random_extra$Random_Char$alchemicalSymbol = A2(_elm_community$random_extra$Random_Char$char, 128768, 128895);
var _elm_community$random_extra$Random_Char$cjkUnifiedIdeographExtensionB = A2(_elm_community$random_extra$Random_Char$char, 131072, 173791);
var _elm_community$random_extra$Random_Char$cjkUnifiedIdeographExtensionC = A2(_elm_community$random_extra$Random_Char$char, 173824, 177983);
var _elm_community$random_extra$Random_Char$cjkUnifiedIdeographExtensionD = A2(_elm_community$random_extra$Random_Char$char, 177984, 178207);
var _elm_community$random_extra$Random_Char$cjkCompatibilityIdeographSupplement = A2(_elm_community$random_extra$Random_Char$char, 194560, 195103);
var _elm_community$random_extra$Random_Char$tag = A2(_elm_community$random_extra$Random_Char$char, 917504, 917631);
var _elm_community$random_extra$Random_Char$variationSelectorSupplement = A2(_elm_community$random_extra$Random_Char$char, 917760, 917999);
var _elm_community$random_extra$Random_Char$supplementaryPrivateUseAreaA = A2(_elm_community$random_extra$Random_Char$char, 983040, 1048575);
var _elm_community$random_extra$Random_Char$supplementaryPrivateUseAreaB = A2(_elm_community$random_extra$Random_Char$char, 1048576, 1114111);

var _elm_community$random_extra$Random_String$string = F2(
	function (stringLength, charGenerator) {
		return A2(
			_elm_lang$core$Random$map,
			_elm_lang$core$String$fromList,
			A2(_elm_lang$core$Random$list, stringLength, charGenerator));
	});
var _elm_community$random_extra$Random_String$rangeLengthString = F3(
	function (minLength, maxLength, charGenerator) {
		return A2(
			_elm_community$random_extra$Random_Extra$flatMap,
			function (len) {
				return A2(_elm_community$random_extra$Random_String$string, len, charGenerator);
			},
			A2(_elm_lang$core$Random$int, minLength, maxLength));
	});

var _elm_community$random_extra$Random_Array$choose = function (arr) {
	if (_elm_lang$core$Array$isEmpty(arr)) {
		return _elm_community$random_extra$Random_Extra$constant(
			{ctor: '_Tuple2', _0: _elm_lang$core$Maybe$Nothing, _1: arr});
	} else {
		var front = function (i) {
			return A3(_elm_lang$core$Array$slice, 0, i, arr);
		};
		var lastIndex = _elm_lang$core$Array$length(arr) - 1;
		var back = function (i) {
			return _elm_lang$core$Native_Utils.eq(i, lastIndex) ? _elm_lang$core$Array$empty : A3(_elm_lang$core$Array$slice, i + 1, lastIndex + 1, arr);
		};
		var gen = A2(_elm_lang$core$Random$int, 0, lastIndex);
		return A2(
			_elm_lang$core$Random$map,
			function (index) {
				return {
					ctor: '_Tuple2',
					_0: A2(_elm_lang$core$Array$get, index, arr),
					_1: A2(
						_elm_lang$core$Array$append,
						front(index),
						back(index))
				};
			},
			gen);
	}
};
var _elm_community$random_extra$Random_Array$shuffle = function (arr) {
	if (_elm_lang$core$Array$isEmpty(arr)) {
		return _elm_community$random_extra$Random_Extra$constant(arr);
	} else {
		var helper = function (_p0) {
			var _p1 = _p0;
			var _p6 = _p1._0;
			return A2(
				_elm_lang$core$Random$andThen,
				_elm_community$random_extra$Random_Array$choose(_p1._1),
				function (_p2) {
					var _p3 = _p2;
					var _p5 = _p3._1;
					var _p4 = _p3._0;
					if (_p4.ctor === 'Nothing') {
						return _elm_community$random_extra$Random_Extra$constant(
							{ctor: '_Tuple2', _0: _p6, _1: _p5});
					} else {
						return helper(
							{
								ctor: '_Tuple2',
								_0: A2(_elm_lang$core$List_ops['::'], _p4._0, _p6),
								_1: _p5
							});
					}
				});
		};
		return A2(
			_elm_lang$core$Random$map,
			function (_p7) {
				return _elm_lang$core$Array$fromList(
					_elm_lang$core$Basics$fst(_p7));
			},
			helper(
				{
					ctor: '_Tuple2',
					_0: _elm_lang$core$Native_List.fromArray(
						[]),
					_1: arr
				}));
	}
};
var _elm_community$random_extra$Random_Array$sample = function (arr) {
	var gen = A2(
		_elm_lang$core$Random$int,
		0,
		_elm_lang$core$Array$length(arr) - 1);
	return A2(
		_elm_lang$core$Random$map,
		function (index) {
			return A2(_elm_lang$core$Array$get, index, arr);
		},
		gen);
};
var _elm_community$random_extra$Random_Array$array = F2(
	function (arrayLength, generator) {
		return A2(
			_elm_lang$core$Random$map,
			_elm_lang$core$Array$fromList,
			A2(_elm_lang$core$Random$list, arrayLength, generator));
	});
var _elm_community$random_extra$Random_Array$rangeLengthArray = F3(
	function (minLength, maxLength, generator) {
		return A2(
			_elm_community$random_extra$Random_Extra$flatMap,
			function (len) {
				return A2(_elm_community$random_extra$Random_Array$array, len, generator);
			},
			A2(_elm_lang$core$Random$int, minLength, maxLength));
	});

var _elm_community$elm_check$Check_Producer$Producer = F2(
	function (a, b) {
		return {generator: a, shrinker: b};
	});
var _elm_community$elm_check$Check_Producer$unit = A2(
	_elm_community$elm_check$Check_Producer$Producer,
	_elm_community$random_extra$Random_Extra$constant(
		{ctor: '_Tuple0'}),
	_elm_community$shrink$Shrink$noShrink);
var _elm_community$elm_check$Check_Producer$bool = A2(_elm_community$elm_check$Check_Producer$Producer, _elm_lang$core$Random$bool, _elm_community$shrink$Shrink$bool);
var _elm_community$elm_check$Check_Producer$order = A2(_elm_community$elm_check$Check_Producer$Producer, _elm_community$random_extra$Random_Order$order, _elm_community$shrink$Shrink$order);
var _elm_community$elm_check$Check_Producer$int = function () {
	var generator = _elm_community$random_extra$Random_Extra$frequency(
		_elm_lang$core$Native_List.fromArray(
			[
				{
				ctor: '_Tuple2',
				_0: 3,
				_1: A2(_elm_lang$core$Random$int, -50, 50)
			},
				{
				ctor: '_Tuple2',
				_0: 0.2,
				_1: _elm_community$random_extra$Random_Extra$constant(0)
			},
				{
				ctor: '_Tuple2',
				_0: 1,
				_1: A2(_elm_lang$core$Random$int, 0, _elm_lang$core$Random$maxInt - _elm_lang$core$Random$minInt)
			},
				{
				ctor: '_Tuple2',
				_0: 1,
				_1: A2(_elm_lang$core$Random$int, _elm_lang$core$Random$minInt - _elm_lang$core$Random$maxInt, 0)
			}
			]));
	return A2(_elm_community$elm_check$Check_Producer$Producer, generator, _elm_community$shrink$Shrink$int);
}();
var _elm_community$elm_check$Check_Producer$rangeInt = F2(
	function (min, max) {
		return A2(
			_elm_community$elm_check$Check_Producer$Producer,
			A2(_elm_lang$core$Random$int, min, max),
			A2(
				_elm_community$shrink$Shrink$keepIf,
				function (i) {
					return (_elm_lang$core$Native_Utils.cmp(i, min) > -1) && (_elm_lang$core$Native_Utils.cmp(i, max) < 1);
				},
				_elm_community$shrink$Shrink$int));
	});
var _elm_community$elm_check$Check_Producer$float = function () {
	var generator = _elm_community$random_extra$Random_Extra$frequency(
		_elm_lang$core$Native_List.fromArray(
			[
				{
				ctor: '_Tuple2',
				_0: 3,
				_1: A2(_elm_lang$core$Random$float, -50, 50)
			},
				{
				ctor: '_Tuple2',
				_0: 0.5,
				_1: _elm_community$random_extra$Random_Extra$constant(0)
			},
				{
				ctor: '_Tuple2',
				_0: 1,
				_1: A2(_elm_lang$core$Random$float, -1, 1)
			},
				{
				ctor: '_Tuple2',
				_0: 1,
				_1: A2(
					_elm_lang$core$Random$float,
					0,
					_elm_lang$core$Basics$toFloat(_elm_lang$core$Random$maxInt - _elm_lang$core$Random$minInt))
			},
				{
				ctor: '_Tuple2',
				_0: 1,
				_1: A2(
					_elm_lang$core$Random$float,
					_elm_lang$core$Basics$toFloat(_elm_lang$core$Random$minInt - _elm_lang$core$Random$maxInt),
					0)
			}
			]));
	return A2(_elm_community$elm_check$Check_Producer$Producer, generator, _elm_community$shrink$Shrink$float);
}();
var _elm_community$elm_check$Check_Producer$rangeFloat = F2(
	function (min, max) {
		return A2(
			_elm_community$elm_check$Check_Producer$Producer,
			A2(_elm_lang$core$Random$float, min, max),
			A2(
				_elm_community$shrink$Shrink$keepIf,
				function (i) {
					return (_elm_lang$core$Native_Utils.cmp(i, min) > -1) && (_elm_lang$core$Native_Utils.cmp(i, max) < 1);
				},
				_elm_community$shrink$Shrink$float));
	});
var _elm_community$elm_check$Check_Producer$percentage = function () {
	var generator = _elm_community$random_extra$Random_Extra$frequency(
		_elm_lang$core$Native_List.fromArray(
			[
				{
				ctor: '_Tuple2',
				_0: 8,
				_1: A2(_elm_lang$core$Random$float, 0, 1)
			},
				{
				ctor: '_Tuple2',
				_0: 1,
				_1: _elm_community$random_extra$Random_Extra$constant(0)
			},
				{
				ctor: '_Tuple2',
				_0: 1,
				_1: _elm_community$random_extra$Random_Extra$constant(1)
			}
			]));
	return A2(_elm_community$elm_check$Check_Producer$Producer, generator, _elm_community$shrink$Shrink$float);
}();
var _elm_community$elm_check$Check_Producer$ascii = A2(_elm_community$elm_check$Check_Producer$Producer, _elm_community$random_extra$Random_Char$ascii, _elm_community$shrink$Shrink$char);
var _elm_community$elm_check$Check_Producer$char = A2(
	_elm_community$elm_check$Check_Producer$Producer,
	A2(_elm_community$random_extra$Random_Char$char, 32, 126),
	_elm_community$shrink$Shrink$character);
var _elm_community$elm_check$Check_Producer$upperCaseChar = A2(_elm_community$elm_check$Check_Producer$Producer, _elm_community$random_extra$Random_Char$upperCaseLatin, _elm_community$shrink$Shrink$character);
var _elm_community$elm_check$Check_Producer$lowerCaseChar = A2(_elm_community$elm_check$Check_Producer$Producer, _elm_community$random_extra$Random_Char$lowerCaseLatin, _elm_community$shrink$Shrink$character);
var _elm_community$elm_check$Check_Producer$unicode = A2(_elm_community$elm_check$Check_Producer$Producer, _elm_community$random_extra$Random_Char$unicode, _elm_community$shrink$Shrink$char);
var _elm_community$elm_check$Check_Producer$string = A2(
	_elm_community$elm_check$Check_Producer$Producer,
	A3(_elm_community$random_extra$Random_String$rangeLengthString, 0, 10, _elm_community$elm_check$Check_Producer$char.generator),
	_elm_community$shrink$Shrink$string);
var _elm_community$elm_check$Check_Producer$maybe = function (prod) {
	var genBool = A2(
		_elm_lang$core$Random$map,
		_elm_lang$core$Basics$not,
		_elm_community$random_extra$Random_Extra$oneIn(4));
	return A2(
		_elm_community$elm_check$Check_Producer$Producer,
		A2(_elm_community$random_extra$Random_Extra$maybe, genBool, prod.generator),
		_elm_community$shrink$Shrink$maybe(prod.shrinker));
};
var _elm_community$elm_check$Check_Producer$result = F2(
	function (errProd, valProd) {
		return A2(
			_elm_community$elm_check$Check_Producer$Producer,
			A3(_elm_community$random_extra$Random_Extra$result, _elm_lang$core$Random$bool, errProd.generator, valProd.generator),
			A2(_elm_community$shrink$Shrink$result, errProd.shrinker, valProd.shrinker));
	});
var _elm_community$elm_check$Check_Producer$list = function (prod) {
	return A2(
		_elm_community$elm_check$Check_Producer$Producer,
		_elm_community$random_extra$Random_Extra$frequency(
			_elm_lang$core$Native_List.fromArray(
				[
					{
					ctor: '_Tuple2',
					_0: 1,
					_1: _elm_community$random_extra$Random_Extra$constant(
						_elm_lang$core$Native_List.fromArray(
							[]))
				},
					{
					ctor: '_Tuple2',
					_0: 1,
					_1: A2(
						_elm_lang$core$Random$map,
						function (x) {
							return _elm_lang$core$Native_List.fromArray(
								[x]);
						},
						prod.generator)
				},
					{
					ctor: '_Tuple2',
					_0: 3,
					_1: A3(_elm_community$random_extra$Random_Extra$rangeLengthList, 2, 10, prod.generator)
				},
					{
					ctor: '_Tuple2',
					_0: 2,
					_1: A3(_elm_community$random_extra$Random_Extra$rangeLengthList, 10, 100, prod.generator)
				},
					{
					ctor: '_Tuple2',
					_0: 0.5,
					_1: A3(_elm_community$random_extra$Random_Extra$rangeLengthList, 100, 400, prod.generator)
				}
				])),
		_elm_community$shrink$Shrink$list(prod.shrinker));
};
var _elm_community$elm_check$Check_Producer$array = function (prod) {
	return A2(
		_elm_community$elm_check$Check_Producer$Producer,
		_elm_community$random_extra$Random_Extra$frequency(
			_elm_lang$core$Native_List.fromArray(
				[
					{
					ctor: '_Tuple2',
					_0: 1,
					_1: _elm_community$random_extra$Random_Extra$constant(_elm_lang$core$Array$empty)
				},
					{
					ctor: '_Tuple2',
					_0: 1,
					_1: A2(
						_elm_lang$core$Random$map,
						_elm_lang$core$Array$repeat(1),
						prod.generator)
				},
					{
					ctor: '_Tuple2',
					_0: 3,
					_1: A3(_elm_community$random_extra$Random_Array$rangeLengthArray, 2, 10, prod.generator)
				},
					{
					ctor: '_Tuple2',
					_0: 2,
					_1: A3(_elm_community$random_extra$Random_Array$rangeLengthArray, 10, 100, prod.generator)
				},
					{
					ctor: '_Tuple2',
					_0: 0.5,
					_1: A3(_elm_community$random_extra$Random_Array$rangeLengthArray, 100, 400, prod.generator)
				}
				])),
		_elm_community$shrink$Shrink$array(prod.shrinker));
};
var _elm_community$elm_check$Check_Producer$tuple = function (_p0) {
	var _p1 = _p0;
	var _p3 = _p1._1;
	var _p2 = _p1._0;
	return A2(
		_elm_community$elm_check$Check_Producer$Producer,
		A3(
			_elm_lang$core$Random$map2,
			F2(
				function (v0, v1) {
					return {ctor: '_Tuple2', _0: v0, _1: v1};
				}),
			_p2.generator,
			_p3.generator),
		_elm_community$shrink$Shrink$tuple(
			{ctor: '_Tuple2', _0: _p2.shrinker, _1: _p3.shrinker}));
};
var _elm_community$elm_check$Check_Producer$tuple3 = function (_p4) {
	var _p5 = _p4;
	var _p8 = _p5._2;
	var _p7 = _p5._1;
	var _p6 = _p5._0;
	return A2(
		_elm_community$elm_check$Check_Producer$Producer,
		A4(
			_elm_lang$core$Random$map3,
			F3(
				function (v0, v1, v2) {
					return {ctor: '_Tuple3', _0: v0, _1: v1, _2: v2};
				}),
			_p6.generator,
			_p7.generator,
			_p8.generator),
		_elm_community$shrink$Shrink$tuple3(
			{ctor: '_Tuple3', _0: _p6.shrinker, _1: _p7.shrinker, _2: _p8.shrinker}));
};
var _elm_community$elm_check$Check_Producer$tuple4 = function (_p9) {
	var _p10 = _p9;
	var _p14 = _p10._3;
	var _p13 = _p10._2;
	var _p12 = _p10._1;
	var _p11 = _p10._0;
	return A2(
		_elm_community$elm_check$Check_Producer$Producer,
		A5(
			_elm_lang$core$Random$map4,
			F4(
				function (v0, v1, v2, v3) {
					return {ctor: '_Tuple4', _0: v0, _1: v1, _2: v2, _3: v3};
				}),
			_p11.generator,
			_p12.generator,
			_p13.generator,
			_p14.generator),
		_elm_community$shrink$Shrink$tuple4(
			{ctor: '_Tuple4', _0: _p11.shrinker, _1: _p12.shrinker, _2: _p13.shrinker, _3: _p14.shrinker}));
};
var _elm_community$elm_check$Check_Producer$tuple5 = function (_p15) {
	var _p16 = _p15;
	var _p21 = _p16._4;
	var _p20 = _p16._3;
	var _p19 = _p16._2;
	var _p18 = _p16._1;
	var _p17 = _p16._0;
	return A2(
		_elm_community$elm_check$Check_Producer$Producer,
		A6(
			_elm_lang$core$Random$map5,
			F5(
				function (v0, v1, v2, v3, v4) {
					return {ctor: '_Tuple5', _0: v0, _1: v1, _2: v2, _3: v3, _4: v4};
				}),
			_p17.generator,
			_p18.generator,
			_p19.generator,
			_p20.generator,
			_p21.generator),
		_elm_community$shrink$Shrink$tuple5(
			{ctor: '_Tuple5', _0: _p17.shrinker, _1: _p18.shrinker, _2: _p19.shrinker, _3: _p20.shrinker, _4: _p21.shrinker}));
};
var _elm_community$elm_check$Check_Producer$filter = F2(
	function (predicate, prod) {
		return A2(
			_elm_community$elm_check$Check_Producer$Producer,
			A2(_elm_community$random_extra$Random_Extra$filter, predicate, prod.generator),
			A2(_elm_community$shrink$Shrink$keepIf, predicate, prod.shrinker));
	});
var _elm_community$elm_check$Check_Producer$convert = F3(
	function (f, g, prod) {
		return A2(
			_elm_community$elm_check$Check_Producer$Producer,
			A2(_elm_lang$core$Random$map, f, prod.generator),
			A3(_elm_community$shrink$Shrink$convert, f, g, prod.shrinker));
	});
var _elm_community$elm_check$Check_Producer$map = F2(
	function (f, prod) {
		return A2(
			_elm_community$elm_check$Check_Producer$Producer,
			A2(_elm_lang$core$Random$map, f, prod.generator),
			_elm_community$shrink$Shrink$noShrink);
	});

var _elm_community$elm_check$Check$false = F2(
	function (f, pred) {
		return A2(
			f,
			pred,
			_elm_lang$core$Basics$always(false));
	});
var _elm_community$elm_check$Check$true = F2(
	function (f, pred) {
		return A2(
			f,
			pred,
			_elm_lang$core$Basics$always(true));
	});
var _elm_community$elm_check$Check$for = F2(
	function (f, x) {
		return f(x);
	});
var _elm_community$elm_check$Check$is = F2(
	function (f, x) {
		return f(x);
	});
var _elm_community$elm_check$Check$that = F2(
	function (f, x) {
		return f(x);
	});
var _elm_community$elm_check$Check$SuccessOptions = F3(
	function (a, b, c) {
		return {name: a, seed: b, numberOfChecks: c};
	});
var _elm_community$elm_check$Check$FailureOptions = F8(
	function (a, b, c, d, e, f, g, h) {
		return {name: a, counterExample: b, actual: c, expected: d, original: e, seed: f, numberOfChecks: g, numberOfShrinks: h};
	});
var _elm_community$elm_check$Check$Suite = F2(
	function (a, b) {
		return {ctor: 'Suite', _0: a, _1: b};
	});
var _elm_community$elm_check$Check$suite = F2(
	function (name, claims) {
		return A2(_elm_community$elm_check$Check$Suite, name, claims);
	});
var _elm_community$elm_check$Check$Claim = F2(
	function (a, b) {
		return {ctor: 'Claim', _0: a, _1: b};
	});
var _elm_community$elm_check$Check$Multiple = F2(
	function (a, b) {
		return {ctor: 'Multiple', _0: a, _1: b};
	});
var _elm_community$elm_check$Check$check = F3(
	function (n, seed, claim) {
		var _p0 = claim;
		if (_p0.ctor === 'Claim') {
			return A2(_p0._1, n, seed);
		} else {
			return A2(
				_elm_community$elm_check$Check$Multiple,
				_p0._0,
				A2(
					_elm_lang$core$List$map,
					A2(_elm_community$elm_check$Check$check, n, seed),
					_p0._1));
		}
	});
var _elm_community$elm_check$Check$quickCheck = A2(
	_elm_community$elm_check$Check$check,
	100,
	_elm_lang$core$Random$initialSeed(1));
var _elm_community$elm_check$Check$Unit = function (a) {
	return {ctor: 'Unit', _0: a};
};
var _elm_community$elm_check$Check$claim = F4(
	function (name, actualStatement, expectedStatement, producer) {
		return A2(
			_elm_community$elm_check$Check$Claim,
			name,
			F2(
				function (numberOfChecks, seed) {
					var originalCounterExample$ = F2(
						function (seed, currentNumberOfChecks) {
							if (_elm_lang$core$Native_Utils.cmp(currentNumberOfChecks, numberOfChecks) > -1) {
								return _elm_lang$trampoline$Trampoline$done(
									_elm_lang$core$Result$Ok(numberOfChecks));
							} else {
								var _p1 = A2(_elm_lang$core$Random$step, producer.generator, seed);
								var value = _p1._0;
								var nextSeed = _p1._1;
								var actual = actualStatement(value);
								var expected = expectedStatement(value);
								return _elm_lang$core$Native_Utils.eq(actual, expected) ? _elm_lang$trampoline$Trampoline$jump(
									function (_p2) {
										var _p3 = _p2;
										return A2(originalCounterExample$, nextSeed, currentNumberOfChecks + 1);
									}) : _elm_lang$trampoline$Trampoline$done(
									_elm_lang$core$Result$Err(
										{ctor: '_Tuple5', _0: value, _1: actual, _2: expected, _3: nextSeed, _4: currentNumberOfChecks + 1}));
							}
						});
					var originalCounterExample = _elm_lang$trampoline$Trampoline$evaluate(
						A2(originalCounterExample$, seed, 0));
					var _p4 = originalCounterExample;
					if (_p4.ctor === 'Ok') {
						return _elm_community$elm_check$Check$Unit(
							_elm_lang$core$Result$Ok(
								{
									name: name,
									seed: seed,
									numberOfChecks: A2(_elm_lang$core$Basics$max, 0, _p4._0)
								}));
					} else {
						var _p9 = _p4._0._0;
						var shrink = F2(
							function (counterExample, currentNumberOfShrinks) {
								var shrunkenCounterExamples = producer.shrinker(counterExample);
								var failingShrunkenCounterExamples = A2(
									_elm_community$elm_lazy_list$Lazy_List$keepIf,
									function (shrunk) {
										return _elm_lang$core$Basics$not(
											_elm_lang$core$Native_Utils.eq(
												actualStatement(shrunk),
												expectedStatement(shrunk)));
									},
									shrunkenCounterExamples);
								var _p5 = _elm_community$elm_lazy_list$Lazy_List$head(failingShrunkenCounterExamples);
								if (_p5.ctor === 'Nothing') {
									return _elm_lang$trampoline$Trampoline$done(
										{ctor: '_Tuple2', _0: counterExample, _1: currentNumberOfShrinks});
								} else {
									return _elm_lang$trampoline$Trampoline$jump(
										function (_p6) {
											var _p7 = _p6;
											return A2(shrink, _p5._0, currentNumberOfShrinks + 1);
										});
								}
							});
						var _p8 = _elm_lang$trampoline$Trampoline$evaluate(
							A2(shrink, _p9, 0));
						var minimal = _p8._0;
						var numberOfShrinks = _p8._1;
						var actual = actualStatement(minimal);
						var expected = expectedStatement(minimal);
						return _elm_community$elm_check$Check$Unit(
							_elm_lang$core$Result$Err(
								{
									name: name,
									seed: _p4._0._3,
									counterExample: _elm_lang$core$Basics$toString(minimal),
									expected: _elm_lang$core$Basics$toString(expected),
									actual: _elm_lang$core$Basics$toString(actual),
									original: {
										counterExample: _elm_lang$core$Basics$toString(_p9),
										actual: _elm_lang$core$Basics$toString(_p4._0._1),
										expected: _elm_lang$core$Basics$toString(_p4._0._2)
									},
									numberOfChecks: _p4._0._4,
									numberOfShrinks: numberOfShrinks
								}));
					}
				}));
	});

var _elm_community$elm_test$ElmTest_Assertion$AlwaysFail = function (a) {
	return {ctor: 'AlwaysFail', _0: a};
};
var _elm_community$elm_test$ElmTest_Assertion$AlwaysPass = {ctor: 'AlwaysPass'};
var _elm_community$elm_test$ElmTest_Assertion$AssertNotEqual = F3(
	function (a, b, c) {
		return {ctor: 'AssertNotEqual', _0: a, _1: b, _2: c};
	});
var _elm_community$elm_test$ElmTest_Assertion$assertNotEqual = F2(
	function (a, b) {
		return A3(
			_elm_community$elm_test$ElmTest_Assertion$AssertNotEqual,
			function (_p0) {
				return !_elm_lang$core$Native_Utils.eq(a, b);
			},
			_elm_lang$core$Basics$toString(a),
			_elm_lang$core$Basics$toString(b));
	});
var _elm_community$elm_test$ElmTest_Assertion$AssertEqual = F3(
	function (a, b, c) {
		return {ctor: 'AssertEqual', _0: a, _1: b, _2: c};
	});
var _elm_community$elm_test$ElmTest_Assertion$assertEqual = F2(
	function (a, b) {
		return A3(
			_elm_community$elm_test$ElmTest_Assertion$AssertEqual,
			function (_p1) {
				return _elm_lang$core$Native_Utils.eq(a, b);
			},
			_elm_lang$core$Basics$toString(a),
			_elm_lang$core$Basics$toString(b));
	});
var _elm_community$elm_test$ElmTest_Assertion$assertionList = F2(
	function (xs, ys) {
		return A3(_elm_lang$core$List$map2, _elm_community$elm_test$ElmTest_Assertion$assertEqual, xs, ys);
	});
var _elm_community$elm_test$ElmTest_Assertion$AssertFalse = function (a) {
	return {ctor: 'AssertFalse', _0: a};
};
var _elm_community$elm_test$ElmTest_Assertion$AssertTrue = function (a) {
	return {ctor: 'AssertTrue', _0: a};
};
var _elm_community$elm_test$ElmTest_Assertion$assertT = _elm_community$elm_test$ElmTest_Assertion$AssertTrue;
var _elm_community$elm_test$ElmTest_Assertion$assert = function (b) {
	return _elm_community$elm_test$ElmTest_Assertion$AssertTrue(
		function (_p2) {
			return b;
		});
};

var _elm_community$elm_test$ElmTest_Test$numberOfSuites = function (test) {
	var _p0 = test;
	if (_p0.ctor === 'TestCase') {
		return 0;
	} else {
		return 1 + function (_p1) {
			return _elm_lang$core$List$sum(
				A2(_elm_lang$core$List$map, _elm_community$elm_test$ElmTest_Test$numberOfSuites, _p1));
		}(_p0._1);
	}
};
var _elm_community$elm_test$ElmTest_Test$numberOfTests = function (test) {
	var _p2 = test;
	if (_p2.ctor === 'TestCase') {
		return 1;
	} else {
		return function (_p3) {
			return _elm_lang$core$List$sum(
				A2(_elm_lang$core$List$map, _elm_community$elm_test$ElmTest_Test$numberOfTests, _p3));
		}(_p2._1);
	}
};
var _elm_community$elm_test$ElmTest_Test$nameOf = function (test) {
	var _p4 = test;
	if (_p4.ctor === 'TestCase') {
		return _p4._0;
	} else {
		return _p4._0;
	}
};
var _elm_community$elm_test$ElmTest_Test$Suite = F2(
	function (a, b) {
		return {ctor: 'Suite', _0: a, _1: b};
	});
var _elm_community$elm_test$ElmTest_Test$suite = _elm_community$elm_test$ElmTest_Test$Suite;
var _elm_community$elm_test$ElmTest_Test$TestCase = F2(
	function (a, b) {
		return {ctor: 'TestCase', _0: a, _1: b};
	});
var _elm_community$elm_test$ElmTest_Test$test = F2(
	function (name, a) {
		return A2(_elm_community$elm_test$ElmTest_Test$TestCase, name, a);
	});
var _elm_community$elm_test$ElmTest_Test$defaultTest = function (a) {
	var name = function () {
		var _p5 = a;
		switch (_p5.ctor) {
			case 'AssertTrue':
				return 'True';
			case 'AssertFalse':
				return 'False';
			case 'AssertEqual':
				return A2(
					_elm_lang$core$Basics_ops['++'],
					_p5._1,
					A2(_elm_lang$core$Basics_ops['++'], ' == ', _p5._2));
			case 'AssertNotEqual':
				return A2(
					_elm_lang$core$Basics_ops['++'],
					_p5._1,
					A2(_elm_lang$core$Basics_ops['++'], ' /= ', _p5._2));
			case 'AlwaysPass':
				return 'Always passes';
			default:
				return 'Always fails';
		}
	}();
	return A2(_elm_community$elm_test$ElmTest_Test$test, name, a);
};
var _elm_community$elm_test$ElmTest_Test$equals = F2(
	function (a, b) {
		return _elm_community$elm_test$ElmTest_Test$defaultTest(
			A2(_elm_community$elm_test$ElmTest_Assertion$assertEqual, a, b));
	});

var _elm_community$elm_test$ElmTest_Run$failedSuites = function (result) {
	var _p0 = result;
	if (_p0.ctor === 'Report') {
		var _p2 = _p0._1;
		var failed = (_elm_lang$core$Native_Utils.cmp(
			_elm_lang$core$List$length(_p2.failures),
			0) > 0) ? 1 : 0;
		return failed + function (_p1) {
			return _elm_lang$core$List$sum(
				A2(_elm_lang$core$List$map, _elm_community$elm_test$ElmTest_Run$failedSuites, _p1));
		}(_p2.results);
	} else {
		return 0;
	}
};
var _elm_community$elm_test$ElmTest_Run$passedSuites = function (result) {
	var _p3 = result;
	if (_p3.ctor === 'Report') {
		var _p5 = _p3._1;
		var passed = _elm_lang$core$Native_Utils.eq(
			_elm_lang$core$List$length(_p5.failures),
			0) ? 1 : 0;
		return passed + function (_p4) {
			return _elm_lang$core$List$sum(
				A2(_elm_lang$core$List$map, _elm_community$elm_test$ElmTest_Run$passedSuites, _p4));
		}(_p5.results);
	} else {
		return 0;
	}
};
var _elm_community$elm_test$ElmTest_Run$failedTests = function (result) {
	var _p6 = result;
	switch (_p6.ctor) {
		case 'Pass':
			return 0;
		case 'Fail':
			return 1;
		default:
			return function (_p7) {
				return _elm_lang$core$List$sum(
					A2(_elm_lang$core$List$map, _elm_community$elm_test$ElmTest_Run$failedTests, _p7));
			}(_p6._1.results);
	}
};
var _elm_community$elm_test$ElmTest_Run$passedTests = function (result) {
	var _p8 = result;
	switch (_p8.ctor) {
		case 'Pass':
			return 1;
		case 'Fail':
			return 0;
		default:
			return function (_p9) {
				return _elm_lang$core$List$sum(
					A2(_elm_lang$core$List$map, _elm_community$elm_test$ElmTest_Run$passedTests, _p9));
			}(_p8._1.results);
	}
};
var _elm_community$elm_test$ElmTest_Run$pass = function (m) {
	var _p10 = m;
	switch (_p10.ctor) {
		case 'Pass':
			return true;
		case 'Fail':
			return false;
		default:
			return (_elm_lang$core$Native_Utils.cmp(
				_elm_lang$core$List$length(
					function (_) {
						return _.failures;
					}(_p10._1)),
				0) > 0) ? false : true;
	}
};
var _elm_community$elm_test$ElmTest_Run$fail = function (_p11) {
	return _elm_lang$core$Basics$not(
		_elm_community$elm_test$ElmTest_Run$pass(_p11));
};
var _elm_community$elm_test$ElmTest_Run$Summary = F3(
	function (a, b, c) {
		return {results: a, passes: b, failures: c};
	});
var _elm_community$elm_test$ElmTest_Run$Report = F2(
	function (a, b) {
		return {ctor: 'Report', _0: a, _1: b};
	});
var _elm_community$elm_test$ElmTest_Run$Fail = F2(
	function (a, b) {
		return {ctor: 'Fail', _0: a, _1: b};
	});
var _elm_community$elm_test$ElmTest_Run$Pass = function (a) {
	return {ctor: 'Pass', _0: a};
};
var _elm_community$elm_test$ElmTest_Run$run = function (test) {
	var _p12 = test;
	if (_p12.ctor === 'TestCase') {
		var _p14 = _p12._0;
		var runAssertion = F2(
			function (t, m) {
				return t(
					{ctor: '_Tuple0'}) ? _elm_community$elm_test$ElmTest_Run$Pass(_p14) : A2(_elm_community$elm_test$ElmTest_Run$Fail, _p14, m);
			});
		var _p13 = _p12._1;
		switch (_p13.ctor) {
			case 'AssertEqual':
				return A2(
					runAssertion,
					_p13._0,
					A2(
						_elm_lang$core$Basics_ops['++'],
						'Expected: ',
						A2(
							_elm_lang$core$Basics_ops['++'],
							_p13._1,
							A2(_elm_lang$core$Basics_ops['++'], '; got: ', _p13._2))));
			case 'AssertNotEqual':
				return A2(
					runAssertion,
					_p13._0,
					A2(
						_elm_lang$core$Basics_ops['++'],
						_p13._1,
						A2(_elm_lang$core$Basics_ops['++'], ' equals ', _p13._2)));
			case 'AssertTrue':
				return A2(runAssertion, _p13._0, 'not True');
			case 'AssertFalse':
				return A2(runAssertion, _p13._0, 'not False');
			case 'AlwaysPass':
				return A2(
					runAssertion,
					_elm_lang$core$Basics$always(true),
					'');
			default:
				return A2(
					runAssertion,
					_elm_lang$core$Basics$always(false),
					_p13._0);
		}
	} else {
		var results = A2(_elm_lang$core$List$map, _elm_community$elm_test$ElmTest_Run$run, _p12._1);
		var _p15 = A2(_elm_lang$core$List$partition, _elm_community$elm_test$ElmTest_Run$pass, results);
		var passes = _p15._0;
		var fails = _p15._1;
		return A2(
			_elm_community$elm_test$ElmTest_Run$Report,
			_p12._0,
			{results: results, passes: passes, failures: fails});
	}
};

var _elm_community$elm_test$ElmTest_Runner_String$replicate = F2(
	function (n, c) {
		var go = function (n) {
			return (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) ? _elm_lang$core$Native_List.fromArray(
				[]) : A2(
				_elm_lang$core$List_ops['::'],
				c,
				go(n - 1));
		};
		return function (_p0) {
			return _elm_lang$core$String$fromList(
				go(_p0));
		}(n);
	});
var _elm_community$elm_test$ElmTest_Runner_String$vcat = function (_p1) {
	return _elm_lang$core$String$concat(
		A2(_elm_lang$core$List$intersperse, '\n', _p1));
};
var _elm_community$elm_test$ElmTest_Runner_String$indent = function (n) {
	var indents = A2(
		_elm_community$elm_test$ElmTest_Runner_String$replicate,
		n,
		_elm_lang$core$Native_Utils.chr(' '));
	return function (_p2) {
		return _elm_community$elm_test$ElmTest_Runner_String$vcat(
			A2(
				_elm_lang$core$List$map,
				_elm_lang$core$String$append(indents),
				_elm_lang$core$String$lines(_p2)));
	};
};
var _elm_community$elm_test$ElmTest_Runner_String$pretty = F2(
	function (n, result) {
		var passed = _elm_community$elm_test$ElmTest_Run$pass(result);
		var _p3 = result;
		switch (_p3.ctor) {
			case 'Pass':
				return _elm_lang$core$Native_List.fromArray(
					[
						{
						ctor: '_Tuple2',
						_0: A2(
							_elm_community$elm_test$ElmTest_Runner_String$indent,
							n,
							A2(_elm_lang$core$Basics_ops['++'], _p3._0, ': passed.')),
						_1: result
					}
					]);
			case 'Fail':
				return _elm_lang$core$Native_List.fromArray(
					[
						{
						ctor: '_Tuple2',
						_0: A2(
							_elm_community$elm_test$ElmTest_Runner_String$indent,
							n,
							A2(
								_elm_lang$core$Basics_ops['++'],
								_p3._0,
								A2(_elm_lang$core$Basics_ops['++'], ': FAILED. ', _p3._1))),
						_1: result
					}
					]);
			default:
				var allPassed = _elm_lang$core$Native_Utils.eq(
					_elm_community$elm_test$ElmTest_Run$failedTests(result),
					0);
				var subResults = allPassed ? _elm_lang$core$Native_List.fromArray(
					[]) : A2(
					_elm_lang$core$List$concatMap,
					_elm_community$elm_test$ElmTest_Runner_String$pretty(n + 2),
					_p3._1.results);
				var msg = A2(
					_elm_lang$core$Basics_ops['++'],
					'Test Suite: ',
					A2(
						_elm_lang$core$Basics_ops['++'],
						_p3._0,
						A2(
							_elm_lang$core$Basics_ops['++'],
							': ',
							passed ? 'all tests passed' : 'FAILED')));
				return A2(
					_elm_lang$core$List_ops['::'],
					{
						ctor: '_Tuple2',
						_0: A2(_elm_community$elm_test$ElmTest_Runner_String$indent, n, msg),
						_1: result
					},
					subResults);
		}
	});
var _elm_community$elm_test$ElmTest_Runner_String$run = function (t) {
	var tests = function () {
		var _p4 = t;
		if (_p4.ctor === 'TestCase') {
			return _elm_lang$core$Native_List.fromArray(
				[
					A2(_elm_community$elm_test$ElmTest_Test$TestCase, _p4._0, _p4._1)
				]);
		} else {
			return _p4._1;
		}
	}();
	var result = _elm_community$elm_test$ElmTest_Run$run(t);
	var passedTests$ = _elm_community$elm_test$ElmTest_Run$passedTests(result);
	var passedSuites$ = _elm_community$elm_test$ElmTest_Run$passedSuites(result);
	var failedTests$ = _elm_community$elm_test$ElmTest_Run$failedTests(result);
	var allPassed = _elm_lang$core$Native_Utils.eq(failedTests$, 0) ? _elm_community$elm_test$ElmTest_Run$Pass('') : A2(_elm_community$elm_test$ElmTest_Run$Fail, '', '');
	var failedSuites$ = _elm_community$elm_test$ElmTest_Run$failedSuites(result);
	var summary = function (_p5) {
		return _elm_community$elm_test$ElmTest_Runner_String$vcat(
			A2(
				_elm_lang$core$List$map,
				_elm_community$elm_test$ElmTest_Runner_String$indent(2),
				_p5));
	}(
		_elm_lang$core$Native_List.fromArray(
			[
				A2(
				_elm_lang$core$Basics_ops['++'],
				_elm_lang$core$Basics$toString(
					_elm_community$elm_test$ElmTest_Test$numberOfSuites(t)),
				A2(
					_elm_lang$core$Basics_ops['++'],
					' suites run, containing ',
					A2(
						_elm_lang$core$Basics_ops['++'],
						_elm_lang$core$Basics$toString(
							_elm_community$elm_test$ElmTest_Test$numberOfTests(t)),
						' tests'))),
				_elm_lang$core$Native_Utils.eq(failedTests$, 0) ? 'All tests passed' : A2(
				_elm_lang$core$Basics_ops['++'],
				_elm_lang$core$Basics$toString(passedSuites$),
				A2(
					_elm_lang$core$Basics_ops['++'],
					' suites and ',
					A2(
						_elm_lang$core$Basics_ops['++'],
						_elm_lang$core$Basics$toString(passedTests$),
						' tests passed'))),
				_elm_lang$core$Native_Utils.eq(failedTests$, 0) ? '' : A2(
				_elm_lang$core$Basics_ops['++'],
				_elm_lang$core$Basics$toString(failedSuites$),
				A2(
					_elm_lang$core$Basics_ops['++'],
					' suites and ',
					A2(
						_elm_lang$core$Basics_ops['++'],
						_elm_lang$core$Basics$toString(failedTests$),
						' tests failed')))
			]));
	var results$ = function () {
		var _p6 = allPassed;
		if (_p6.ctor === 'Pass') {
			return _elm_lang$core$Native_List.fromArray(
				[
					{ctor: '_Tuple2', _0: '', _1: allPassed}
				]);
		} else {
			return A2(_elm_community$elm_test$ElmTest_Runner_String$pretty, 0, result);
		}
	}();
	return A2(
		_elm_lang$core$List_ops['::'],
		{ctor: '_Tuple2', _0: summary, _1: allPassed},
		results$);
};
var _elm_community$elm_test$ElmTest_Runner_String$runDisplay = function (t) {
	var _p7 = _elm_community$elm_test$ElmTest_Runner_String$run(t);
	if ((_p7.ctor === '::') && (_p7._0.ctor === '_Tuple2')) {
		return _elm_community$elm_test$ElmTest_Runner_String$vcat(
			A2(
				_elm_lang$core$List_ops['::'],
				A2(_elm_lang$core$Basics_ops['++'], _p7._0._0, '\n'),
				A2(_elm_lang$core$List$map, _elm_lang$core$Basics$fst, _p7._1)));
	} else {
		return '';
	}
};

//import Maybe, Native.Array, Native.List, Native.Utils, Result //

var _elm_lang$core$Native_Json = function() {


// CORE DECODERS

function succeed(msg)
{
	return {
		ctor: '<decoder>',
		tag: 'succeed',
		msg: msg
	};
}

function fail(msg)
{
	return {
		ctor: '<decoder>',
		tag: 'fail',
		msg: msg
	};
}

function decodePrimitive(tag)
{
	return {
		ctor: '<decoder>',
		tag: tag
	};
}

function decodeContainer(tag, decoder)
{
	return {
		ctor: '<decoder>',
		tag: tag,
		decoder: decoder
	};
}

function decodeNull(value)
{
	return {
		ctor: '<decoder>',
		tag: 'null',
		value: value
	};
}

function decodeField(field, decoder)
{
	return {
		ctor: '<decoder>',
		tag: 'field',
		field: field,
		decoder: decoder
	};
}

function decodeKeyValuePairs(decoder)
{
	return {
		ctor: '<decoder>',
		tag: 'key-value',
		decoder: decoder
	};
}

function decodeObject(f, decoders)
{
	return {
		ctor: '<decoder>',
		tag: 'map-many',
		func: f,
		decoders: decoders
	};
}

function decodeTuple(f, decoders)
{
	return {
		ctor: '<decoder>',
		tag: 'tuple',
		func: f,
		decoders: decoders
	};
}

function andThen(decoder, callback)
{
	return {
		ctor: '<decoder>',
		tag: 'andThen',
		decoder: decoder,
		callback: callback
	};
}

function customAndThen(decoder, callback)
{
	return {
		ctor: '<decoder>',
		tag: 'customAndThen',
		decoder: decoder,
		callback: callback
	};
}

function oneOf(decoders)
{
	return {
		ctor: '<decoder>',
		tag: 'oneOf',
		decoders: decoders
	};
}


// DECODING OBJECTS

function decodeObject1(f, d1)
{
	return decodeObject(f, [d1]);
}

function decodeObject2(f, d1, d2)
{
	return decodeObject(f, [d1, d2]);
}

function decodeObject3(f, d1, d2, d3)
{
	return decodeObject(f, [d1, d2, d3]);
}

function decodeObject4(f, d1, d2, d3, d4)
{
	return decodeObject(f, [d1, d2, d3, d4]);
}

function decodeObject5(f, d1, d2, d3, d4, d5)
{
	return decodeObject(f, [d1, d2, d3, d4, d5]);
}

function decodeObject6(f, d1, d2, d3, d4, d5, d6)
{
	return decodeObject(f, [d1, d2, d3, d4, d5, d6]);
}

function decodeObject7(f, d1, d2, d3, d4, d5, d6, d7)
{
	return decodeObject(f, [d1, d2, d3, d4, d5, d6, d7]);
}

function decodeObject8(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return decodeObject(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
}


// DECODING TUPLES

function decodeTuple1(f, d1)
{
	return decodeTuple(f, [d1]);
}

function decodeTuple2(f, d1, d2)
{
	return decodeTuple(f, [d1, d2]);
}

function decodeTuple3(f, d1, d2, d3)
{
	return decodeTuple(f, [d1, d2, d3]);
}

function decodeTuple4(f, d1, d2, d3, d4)
{
	return decodeTuple(f, [d1, d2, d3, d4]);
}

function decodeTuple5(f, d1, d2, d3, d4, d5)
{
	return decodeTuple(f, [d1, d2, d3, d4, d5]);
}

function decodeTuple6(f, d1, d2, d3, d4, d5, d6)
{
	return decodeTuple(f, [d1, d2, d3, d4, d5, d6]);
}

function decodeTuple7(f, d1, d2, d3, d4, d5, d6, d7)
{
	return decodeTuple(f, [d1, d2, d3, d4, d5, d6, d7]);
}

function decodeTuple8(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return decodeTuple(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
}


// DECODE HELPERS

function ok(value)
{
	return { tag: 'ok', value: value };
}

function badPrimitive(type, value)
{
	return { tag: 'primitive', type: type, value: value };
}

function badIndex(index, nestedProblems)
{
	return { tag: 'index', index: index, rest: nestedProblems };
}

function badField(field, nestedProblems)
{
	return { tag: 'field', field: field, rest: nestedProblems };
}

function badOneOf(problems)
{
	return { tag: 'oneOf', problems: problems };
}

function bad(msg)
{
	return { tag: 'fail', msg: msg };
}

function badToString(problem)
{
	var context = '_';
	while (problem)
	{
		switch (problem.tag)
		{
			case 'primitive':
				return 'Expecting ' + problem.type
					+ (context === '_' ? '' : ' at ' + context)
					+ ' but instead got: ' + jsToString(problem.value);

			case 'index':
				context += '[' + problem.index + ']';
				problem = problem.rest;
				break;

			case 'field':
				context += '.' + problem.field;
				problem = problem.rest;
				break;

			case 'oneOf':
				var problems = problem.problems;
				for (var i = 0; i < problems.length; i++)
				{
					problems[i] = badToString(problems[i]);
				}
				return 'I ran into the following problems'
					+ (context === '_' ? '' : ' at ' + context)
					+ ':\n\n' + problems.join('\n');

			case 'fail':
				return 'I ran into a `fail` decoder'
					+ (context === '_' ? '' : ' at ' + context)
					+ ': ' + problem.msg;
		}
	}
}

function jsToString(value)
{
	return value === undefined
		? 'undefined'
		: JSON.stringify(value);
}


// DECODE

function runOnString(decoder, string)
{
	var json;
	try
	{
		json = JSON.parse(string);
	}
	catch (e)
	{
		return _elm_lang$core$Result$Err('Given an invalid JSON: ' + e.message);
	}
	return run(decoder, json);
}

function run(decoder, value)
{
	var result = runHelp(decoder, value);
	return (result.tag === 'ok')
		? _elm_lang$core$Result$Ok(result.value)
		: _elm_lang$core$Result$Err(badToString(result));
}

function runHelp(decoder, value)
{
	switch (decoder.tag)
	{
		case 'bool':
			return (typeof value === 'boolean')
				? ok(value)
				: badPrimitive('a Bool', value);

		case 'int':
			if (typeof value !== 'number') {
				return badPrimitive('an Int', value);
			}

			if (-2147483647 < value && value < 2147483647 && (value | 0) === value) {
				return ok(value);
			}

			if (isFinite(value) && !(value % 1)) {
				return ok(value);
			}

			return badPrimitive('an Int', value);

		case 'float':
			return (typeof value === 'number')
				? ok(value)
				: badPrimitive('a Float', value);

		case 'string':
			return (typeof value === 'string')
				? ok(value)
				: (value instanceof String)
					? ok(value + '')
					: badPrimitive('a String', value);

		case 'null':
			return (value === null)
				? ok(decoder.value)
				: badPrimitive('null', value);

		case 'value':
			return ok(value);

		case 'list':
			if (!(value instanceof Array))
			{
				return badPrimitive('a List', value);
			}

			var list = _elm_lang$core$Native_List.Nil;
			for (var i = value.length; i--; )
			{
				var result = runHelp(decoder.decoder, value[i]);
				if (result.tag !== 'ok')
				{
					return badIndex(i, result)
				}
				list = _elm_lang$core$Native_List.Cons(result.value, list);
			}
			return ok(list);

		case 'array':
			if (!(value instanceof Array))
			{
				return badPrimitive('an Array', value);
			}

			var len = value.length;
			var array = new Array(len);
			for (var i = len; i--; )
			{
				var result = runHelp(decoder.decoder, value[i]);
				if (result.tag !== 'ok')
				{
					return badIndex(i, result);
				}
				array[i] = result.value;
			}
			return ok(_elm_lang$core$Native_Array.fromJSArray(array));

		case 'maybe':
			var result = runHelp(decoder.decoder, value);
			return (result.tag === 'ok')
				? ok(_elm_lang$core$Maybe$Just(result.value))
				: ok(_elm_lang$core$Maybe$Nothing);

		case 'field':
			var field = decoder.field;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return badPrimitive('an object with a field named `' + field + '`', value);
			}

			var result = runHelp(decoder.decoder, value[field]);
			return (result.tag === 'ok')
				? result
				: badField(field, result);

		case 'key-value':
			if (typeof value !== 'object' || value === null || value instanceof Array)
			{
				return badPrimitive('an object', value);
			}

			var keyValuePairs = _elm_lang$core$Native_List.Nil;
			for (var key in value)
			{
				var result = runHelp(decoder.decoder, value[key]);
				if (result.tag !== 'ok')
				{
					return badField(key, result);
				}
				var pair = _elm_lang$core$Native_Utils.Tuple2(key, result.value);
				keyValuePairs = _elm_lang$core$Native_List.Cons(pair, keyValuePairs);
			}
			return ok(keyValuePairs);

		case 'map-many':
			var answer = decoder.func;
			var decoders = decoder.decoders;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = runHelp(decoders[i], value);
				if (result.tag !== 'ok')
				{
					return result;
				}
				answer = answer(result.value);
			}
			return ok(answer);

		case 'tuple':
			var decoders = decoder.decoders;
			var len = decoders.length;

			if ( !(value instanceof Array) || value.length !== len )
			{
				return badPrimitive('a Tuple with ' + len + ' entries', value);
			}

			var answer = decoder.func;
			for (var i = 0; i < len; i++)
			{
				var result = runHelp(decoders[i], value[i]);
				if (result.tag !== 'ok')
				{
					return badIndex(i, result);
				}
				answer = answer(result.value);
			}
			return ok(answer);

		case 'customAndThen':
			var result = runHelp(decoder.decoder, value);
			if (result.tag !== 'ok')
			{
				return result;
			}
			var realResult = decoder.callback(result.value);
			if (realResult.ctor === 'Err')
			{
				return badPrimitive('something custom', value);
			}
			return ok(realResult._0);

		case 'andThen':
			var result = runHelp(decoder.decoder, value);
			return (result.tag !== 'ok')
				? result
				: runHelp(decoder.callback(result.value), value);

		case 'oneOf':
			var errors = [];
			var temp = decoder.decoders;
			while (temp.ctor !== '[]')
			{
				var result = runHelp(temp._0, value);

				if (result.tag === 'ok')
				{
					return result;
				}

				errors.push(result);

				temp = temp._1;
			}
			return badOneOf(errors);

		case 'fail':
			return bad(decoder.msg);

		case 'succeed':
			return ok(decoder.msg);
	}
}


// EQUALITY

function equality(a, b)
{
	if (a === b)
	{
		return true;
	}

	if (a.tag !== b.tag)
	{
		return false;
	}

	switch (a.tag)
	{
		case 'succeed':
		case 'fail':
			return a.msg === b.msg;

		case 'bool':
		case 'int':
		case 'float':
		case 'string':
		case 'value':
			return true;

		case 'null':
			return a.value === b.value;

		case 'list':
		case 'array':
		case 'maybe':
		case 'key-value':
			return equality(a.decoder, b.decoder);

		case 'field':
			return a.field === b.field && equality(a.decoder, b.decoder);

		case 'map-many':
		case 'tuple':
			if (a.func !== b.func)
			{
				return false;
			}
			return listEquality(a.decoders, b.decoders);

		case 'andThen':
		case 'customAndThen':
			return a.callback === b.callback && equality(a.decoder, b.decoder);

		case 'oneOf':
			return listEquality(a.decoders, b.decoders);
	}
}

function listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

function encode(indentLevel, value)
{
	return JSON.stringify(value, null, indentLevel);
}

function identity(value)
{
	return value;
}

function encodeObject(keyValuePairs)
{
	var obj = {};
	while (keyValuePairs.ctor !== '[]')
	{
		var pair = keyValuePairs._0;
		obj[pair._0] = pair._1;
		keyValuePairs = keyValuePairs._1;
	}
	return obj;
}

return {
	encode: F2(encode),
	runOnString: F2(runOnString),
	run: F2(run),

	decodeNull: decodeNull,
	decodePrimitive: decodePrimitive,
	decodeContainer: F2(decodeContainer),

	decodeField: F2(decodeField),

	decodeObject1: F2(decodeObject1),
	decodeObject2: F3(decodeObject2),
	decodeObject3: F4(decodeObject3),
	decodeObject4: F5(decodeObject4),
	decodeObject5: F6(decodeObject5),
	decodeObject6: F7(decodeObject6),
	decodeObject7: F8(decodeObject7),
	decodeObject8: F9(decodeObject8),
	decodeKeyValuePairs: decodeKeyValuePairs,

	decodeTuple1: F2(decodeTuple1),
	decodeTuple2: F3(decodeTuple2),
	decodeTuple3: F4(decodeTuple3),
	decodeTuple4: F5(decodeTuple4),
	decodeTuple5: F6(decodeTuple5),
	decodeTuple6: F7(decodeTuple6),
	decodeTuple7: F8(decodeTuple7),
	decodeTuple8: F9(decodeTuple8),

	andThen: F2(andThen),
	customAndThen: F2(customAndThen),
	fail: fail,
	succeed: succeed,
	oneOf: oneOf,

	identity: identity,
	encodeNull: null,
	encodeArray: _elm_lang$core$Native_Array.toJSArray,
	encodeList: _elm_lang$core$Native_List.toArray,
	encodeObject: encodeObject,

	equality: equality
};

}();

var _elm_lang$core$Json_Encode$list = _elm_lang$core$Native_Json.encodeList;
var _elm_lang$core$Json_Encode$array = _elm_lang$core$Native_Json.encodeArray;
var _elm_lang$core$Json_Encode$object = _elm_lang$core$Native_Json.encodeObject;
var _elm_lang$core$Json_Encode$null = _elm_lang$core$Native_Json.encodeNull;
var _elm_lang$core$Json_Encode$bool = _elm_lang$core$Native_Json.identity;
var _elm_lang$core$Json_Encode$float = _elm_lang$core$Native_Json.identity;
var _elm_lang$core$Json_Encode$int = _elm_lang$core$Native_Json.identity;
var _elm_lang$core$Json_Encode$string = _elm_lang$core$Native_Json.identity;
var _elm_lang$core$Json_Encode$encode = _elm_lang$core$Native_Json.encode;
var _elm_lang$core$Json_Encode$Value = {ctor: 'Value'};

var _elm_lang$core$Json_Decode$tuple8 = _elm_lang$core$Native_Json.decodeTuple8;
var _elm_lang$core$Json_Decode$tuple7 = _elm_lang$core$Native_Json.decodeTuple7;
var _elm_lang$core$Json_Decode$tuple6 = _elm_lang$core$Native_Json.decodeTuple6;
var _elm_lang$core$Json_Decode$tuple5 = _elm_lang$core$Native_Json.decodeTuple5;
var _elm_lang$core$Json_Decode$tuple4 = _elm_lang$core$Native_Json.decodeTuple4;
var _elm_lang$core$Json_Decode$tuple3 = _elm_lang$core$Native_Json.decodeTuple3;
var _elm_lang$core$Json_Decode$tuple2 = _elm_lang$core$Native_Json.decodeTuple2;
var _elm_lang$core$Json_Decode$tuple1 = _elm_lang$core$Native_Json.decodeTuple1;
var _elm_lang$core$Json_Decode$succeed = _elm_lang$core$Native_Json.succeed;
var _elm_lang$core$Json_Decode$fail = _elm_lang$core$Native_Json.fail;
var _elm_lang$core$Json_Decode$andThen = _elm_lang$core$Native_Json.andThen;
var _elm_lang$core$Json_Decode$customDecoder = _elm_lang$core$Native_Json.customAndThen;
var _elm_lang$core$Json_Decode$decodeValue = _elm_lang$core$Native_Json.run;
var _elm_lang$core$Json_Decode$value = _elm_lang$core$Native_Json.decodePrimitive('value');
var _elm_lang$core$Json_Decode$maybe = function (decoder) {
	return A2(_elm_lang$core$Native_Json.decodeContainer, 'maybe', decoder);
};
var _elm_lang$core$Json_Decode$null = _elm_lang$core$Native_Json.decodeNull;
var _elm_lang$core$Json_Decode$array = function (decoder) {
	return A2(_elm_lang$core$Native_Json.decodeContainer, 'array', decoder);
};
var _elm_lang$core$Json_Decode$list = function (decoder) {
	return A2(_elm_lang$core$Native_Json.decodeContainer, 'list', decoder);
};
var _elm_lang$core$Json_Decode$bool = _elm_lang$core$Native_Json.decodePrimitive('bool');
var _elm_lang$core$Json_Decode$int = _elm_lang$core$Native_Json.decodePrimitive('int');
var _elm_lang$core$Json_Decode$float = _elm_lang$core$Native_Json.decodePrimitive('float');
var _elm_lang$core$Json_Decode$string = _elm_lang$core$Native_Json.decodePrimitive('string');
var _elm_lang$core$Json_Decode$oneOf = _elm_lang$core$Native_Json.oneOf;
var _elm_lang$core$Json_Decode$keyValuePairs = _elm_lang$core$Native_Json.decodeKeyValuePairs;
var _elm_lang$core$Json_Decode$object8 = _elm_lang$core$Native_Json.decodeObject8;
var _elm_lang$core$Json_Decode$object7 = _elm_lang$core$Native_Json.decodeObject7;
var _elm_lang$core$Json_Decode$object6 = _elm_lang$core$Native_Json.decodeObject6;
var _elm_lang$core$Json_Decode$object5 = _elm_lang$core$Native_Json.decodeObject5;
var _elm_lang$core$Json_Decode$object4 = _elm_lang$core$Native_Json.decodeObject4;
var _elm_lang$core$Json_Decode$object3 = _elm_lang$core$Native_Json.decodeObject3;
var _elm_lang$core$Json_Decode$object2 = _elm_lang$core$Native_Json.decodeObject2;
var _elm_lang$core$Json_Decode$object1 = _elm_lang$core$Native_Json.decodeObject1;
var _elm_lang$core$Json_Decode_ops = _elm_lang$core$Json_Decode_ops || {};
_elm_lang$core$Json_Decode_ops[':='] = _elm_lang$core$Native_Json.decodeField;
var _elm_lang$core$Json_Decode$at = F2(
	function (fields, decoder) {
		return A3(
			_elm_lang$core$List$foldr,
			F2(
				function (x, y) {
					return A2(_elm_lang$core$Json_Decode_ops[':='], x, y);
				}),
			decoder,
			fields);
	});
var _elm_lang$core$Json_Decode$decodeString = _elm_lang$core$Native_Json.runOnString;
var _elm_lang$core$Json_Decode$map = _elm_lang$core$Native_Json.decodeObject1;
var _elm_lang$core$Json_Decode$dict = function (decoder) {
	return A2(
		_elm_lang$core$Json_Decode$map,
		_elm_lang$core$Dict$fromList,
		_elm_lang$core$Json_Decode$keyValuePairs(decoder));
};
var _elm_lang$core$Json_Decode$Decoder = {ctor: 'Decoder'};

//import Native.Json //

var _elm_lang$virtual_dom$Native_VirtualDom = function() {

var STYLE_KEY = 'STYLE';
var EVENT_KEY = 'EVENT';
var ATTR_KEY = 'ATTR';
var ATTR_NS_KEY = 'ATTR_NS';



////////////  VIRTUAL DOM NODES  ////////////


function text(string)
{
	return {
		type: 'text',
		text: string
	};
}


function node(tag)
{
	return F2(function(factList, kidList) {
		return nodeHelp(tag, factList, kidList);
	});
}


function nodeHelp(tag, factList, kidList)
{
	var organized = organizeFacts(factList);
	var namespace = organized.namespace;
	var facts = organized.facts;

	var children = [];
	var descendantsCount = 0;
	while (kidList.ctor !== '[]')
	{
		var kid = kidList._0;
		descendantsCount += (kid.descendantsCount || 0);
		children.push(kid);
		kidList = kidList._1;
	}
	descendantsCount += children.length;

	return {
		type: 'node',
		tag: tag,
		facts: facts,
		children: children,
		namespace: namespace,
		descendantsCount: descendantsCount
	};
}


function keyedNode(tag, factList, kidList)
{
	var organized = organizeFacts(factList);
	var namespace = organized.namespace;
	var facts = organized.facts;

	var children = [];
	var descendantsCount = 0;
	while (kidList.ctor !== '[]')
	{
		var kid = kidList._0;
		descendantsCount += (kid._1.descendantsCount || 0);
		children.push(kid);
		kidList = kidList._1;
	}
	descendantsCount += children.length;

	return {
		type: 'keyed-node',
		tag: tag,
		facts: facts,
		children: children,
		namespace: namespace,
		descendantsCount: descendantsCount
	};
}


function custom(factList, model, impl)
{
	var facts = organizeFacts(factList).facts;

	return {
		type: 'custom',
		facts: facts,
		model: model,
		impl: impl
	};
}


function map(tagger, node)
{
	return {
		type: 'tagger',
		tagger: tagger,
		node: node,
		descendantsCount: 1 + (node.descendantsCount || 0)
	};
}


function thunk(func, args, thunk)
{
	return {
		type: 'thunk',
		func: func,
		args: args,
		thunk: thunk,
		node: undefined
	};
}

function lazy(fn, a)
{
	return thunk(fn, [a], function() {
		return fn(a);
	});
}

function lazy2(fn, a, b)
{
	return thunk(fn, [a,b], function() {
		return A2(fn, a, b);
	});
}

function lazy3(fn, a, b, c)
{
	return thunk(fn, [a,b,c], function() {
		return A3(fn, a, b, c);
	});
}



// FACTS


function organizeFacts(factList)
{
	var namespace, facts = {};

	while (factList.ctor !== '[]')
	{
		var entry = factList._0;
		var key = entry.key;

		if (key === ATTR_KEY || key === ATTR_NS_KEY || key === EVENT_KEY)
		{
			var subFacts = facts[key] || {};
			subFacts[entry.realKey] = entry.value;
			facts[key] = subFacts;
		}
		else if (key === STYLE_KEY)
		{
			var styles = facts[key] || {};
			var styleList = entry.value;
			while (styleList.ctor !== '[]')
			{
				var style = styleList._0;
				styles[style._0] = style._1;
				styleList = styleList._1;
			}
			facts[key] = styles;
		}
		else if (key === 'namespace')
		{
			namespace = entry.value;
		}
		else
		{
			facts[key] = entry.value;
		}
		factList = factList._1;
	}

	return {
		facts: facts,
		namespace: namespace
	};
}



////////////  PROPERTIES AND ATTRIBUTES  ////////////


function style(value)
{
	return {
		key: STYLE_KEY,
		value: value
	};
}


function property(key, value)
{
	return {
		key: key,
		value: value
	};
}


function attribute(key, value)
{
	return {
		key: ATTR_KEY,
		realKey: key,
		value: value
	};
}


function attributeNS(namespace, key, value)
{
	return {
		key: ATTR_NS_KEY,
		realKey: key,
		value: {
			value: value,
			namespace: namespace
		}
	};
}


function on(name, options, decoder)
{
	return {
		key: EVENT_KEY,
		realKey: name,
		value: {
			options: options,
			decoder: decoder
		}
	};
}


function equalEvents(a, b)
{
	if (!a.options === b.options)
	{
		if (a.stopPropagation !== b.stopPropagation || a.preventDefault !== b.preventDefault)
		{
			return false;
		}
	}
	return _elm_lang$core$Native_Json.equality(a.decoder, b.decoder);
}



////////////  RENDERER  ////////////


function renderer(parent, tagger, initialVirtualNode)
{
	var eventNode = { tagger: tagger, parent: undefined };

	var domNode = render(initialVirtualNode, eventNode);
	parent.appendChild(domNode);

	var state = 'NO_REQUEST';
	var currentVirtualNode = initialVirtualNode;
	var nextVirtualNode = initialVirtualNode;

	function registerVirtualNode(vNode)
	{
		if (state === 'NO_REQUEST')
		{
			rAF(updateIfNeeded);
		}
		state = 'PENDING_REQUEST';
		nextVirtualNode = vNode;
	}

	function updateIfNeeded()
	{
		switch (state)
		{
			case 'NO_REQUEST':
				throw new Error(
					'Unexpected draw callback.\n' +
					'Please report this to <https://github.com/elm-lang/core/issues>.'
				);

			case 'PENDING_REQUEST':
				rAF(updateIfNeeded);
				state = 'EXTRA_REQUEST';

				var patches = diff(currentVirtualNode, nextVirtualNode);
				domNode = applyPatches(domNode, currentVirtualNode, patches, eventNode);
				currentVirtualNode = nextVirtualNode;

				return;

			case 'EXTRA_REQUEST':
				state = 'NO_REQUEST';
				return;
		}
	}

	return { update: registerVirtualNode };
}


var rAF =
	typeof requestAnimationFrame !== 'undefined'
		? requestAnimationFrame
		: function(cb) { setTimeout(cb, 1000 / 60); };



////////////  RENDER  ////////////


function render(vNode, eventNode)
{
	switch (vNode.type)
	{
		case 'thunk':
			if (!vNode.node)
			{
				vNode.node = vNode.thunk();
			}
			return render(vNode.node, eventNode);

		case 'tagger':
			var subNode = vNode.node;
			var tagger = vNode.tagger;

			while (subNode.type === 'tagger')
			{
				typeof tagger !== 'object'
					? tagger = [tagger, subNode.tagger]
					: tagger.push(subNode.tagger);

				subNode = subNode.node;
			}

			var subEventRoot = {
				tagger: tagger,
				parent: eventNode
			};

			var domNode = render(subNode, subEventRoot);
			domNode.elm_event_node_ref = subEventRoot;
			return domNode;

		case 'text':
			return document.createTextNode(vNode.text);

		case 'node':
			var domNode = vNode.namespace
				? document.createElementNS(vNode.namespace, vNode.tag)
				: document.createElement(vNode.tag);

			applyFacts(domNode, eventNode, vNode.facts);

			var children = vNode.children;

			for (var i = 0; i < children.length; i++)
			{
				domNode.appendChild(render(children[i], eventNode));
			}

			return domNode;

		case 'keyed-node':
			var domNode = vNode.namespace
				? document.createElementNS(vNode.namespace, vNode.tag)
				: document.createElement(vNode.tag);

			applyFacts(domNode, eventNode, vNode.facts);

			var children = vNode.children;

			for (var i = 0; i < children.length; i++)
			{
				domNode.appendChild(render(children[i]._1, eventNode));
			}

			return domNode;

		case 'custom':
			var domNode = vNode.impl.render(vNode.model);
			applyFacts(domNode, eventNode, vNode.facts);
			return domNode;
	}
}



////////////  APPLY FACTS  ////////////


function applyFacts(domNode, eventNode, facts)
{
	for (var key in facts)
	{
		var value = facts[key];

		switch (key)
		{
			case STYLE_KEY:
				applyStyles(domNode, value);
				break;

			case EVENT_KEY:
				applyEvents(domNode, eventNode, value);
				break;

			case ATTR_KEY:
				applyAttrs(domNode, value);
				break;

			case ATTR_NS_KEY:
				applyAttrsNS(domNode, value);
				break;

			case 'value':
				if (domNode[key] !== value)
				{
					domNode[key] = value;
				}
				break;

			default:
				domNode[key] = value;
				break;
		}
	}
}

function applyStyles(domNode, styles)
{
	var domNodeStyle = domNode.style;

	for (var key in styles)
	{
		domNodeStyle[key] = styles[key];
	}
}

function applyEvents(domNode, eventNode, events)
{
	var allHandlers = domNode.elm_handlers || {};

	for (var key in events)
	{
		var handler = allHandlers[key];
		var value = events[key];

		if (typeof value === 'undefined')
		{
			domNode.removeEventListener(key, handler);
			allHandlers[key] = undefined;
		}
		else if (typeof handler === 'undefined')
		{
			var handler = makeEventHandler(eventNode, value);
			domNode.addEventListener(key, handler);
			allHandlers[key] = handler;
		}
		else
		{
			handler.info = value;
		}
	}

	domNode.elm_handlers = allHandlers;
}

function makeEventHandler(eventNode, info)
{
	function eventHandler(event)
	{
		var info = eventHandler.info;

		var value = A2(_elm_lang$core$Native_Json.run, info.decoder, event);

		if (value.ctor === 'Ok')
		{
			var options = info.options;
			if (options.stopPropagation)
			{
				event.stopPropagation();
			}
			if (options.preventDefault)
			{
				event.preventDefault();
			}

			var message = value._0;

			var currentEventNode = eventNode;
			while (currentEventNode)
			{
				var tagger = currentEventNode.tagger;
				if (typeof tagger === 'function')
				{
					message = tagger(message);
				}
				else
				{
					for (var i = tagger.length; i--; )
					{
						message = tagger[i](message);
					}
				}
				currentEventNode = currentEventNode.parent;
			}
		}
	};

	eventHandler.info = info;

	return eventHandler;
}

function applyAttrs(domNode, attrs)
{
	for (var key in attrs)
	{
		var value = attrs[key];
		if (typeof value === 'undefined')
		{
			domNode.removeAttribute(key);
		}
		else
		{
			domNode.setAttribute(key, value);
		}
	}
}

function applyAttrsNS(domNode, nsAttrs)
{
	for (var key in nsAttrs)
	{
		var pair = nsAttrs[key];
		var namespace = pair.namespace;
		var value = pair.value;

		if (typeof value === 'undefined')
		{
			domNode.removeAttributeNS(namespace, key);
		}
		else
		{
			domNode.setAttributeNS(namespace, key, value);
		}
	}
}



////////////  DIFF  ////////////


function diff(a, b)
{
	var patches = [];
	diffHelp(a, b, patches, 0);
	return patches;
}


function makePatch(type, index, data)
{
	return {
		index: index,
		type: type,
		data: data,
		domNode: undefined,
		eventNode: undefined
	};
}


function diffHelp(a, b, patches, index)
{
	if (a === b)
	{
		return;
	}

	var aType = a.type;
	var bType = b.type;

	// Bail if you run into different types of nodes. Implies that the
	// structure has changed significantly and it's not worth a diff.
	if (aType !== bType)
	{
		patches.push(makePatch('p-redraw', index, b));
		return;
	}

	// Now we know that both nodes are the same type.
	switch (bType)
	{
		case 'thunk':
			var aArgs = a.args;
			var bArgs = b.args;
			var i = aArgs.length;
			var same = a.func === b.func && i === bArgs.length;
			while (same && i--)
			{
				same = aArgs[i] === bArgs[i];
			}
			if (same)
			{
				b.node = a.node;
				return;
			}
			b.node = b.thunk();
			var subPatches = [];
			diffHelp(a.node, b.node, subPatches, 0);
			if (subPatches.length > 0)
			{
				patches.push(makePatch('p-thunk', index, subPatches));
			}
			return;

		case 'tagger':
			// gather nested taggers
			var aTaggers = a.tagger;
			var bTaggers = b.tagger;
			var nesting = false;

			var aSubNode = a.node;
			while (aSubNode.type === 'tagger')
			{
				nesting = true;

				typeof aTaggers !== 'object'
					? aTaggers = [aTaggers, aSubNode.tagger]
					: aTaggers.push(aSubNode.tagger);

				aSubNode = aSubNode.node;
			}

			var bSubNode = b.node;
			while (bSubNode.type === 'tagger')
			{
				nesting = true;

				typeof bTaggers !== 'object'
					? bTaggers = [bTaggers, bSubNode.tagger]
					: bTaggers.push(bSubNode.tagger);

				bSubNode = bSubNode.node;
			}

			// Just bail if different numbers of taggers. This implies the
			// structure of the virtual DOM has changed.
			if (nesting && aTaggers.length !== bTaggers.length)
			{
				patches.push(makePatch('p-redraw', index, b));
				return;
			}

			// check if taggers are "the same"
			if (nesting ? !pairwiseRefEqual(aTaggers, bTaggers) : aTaggers !== bTaggers)
			{
				patches.push(makePatch('p-tagger', index, bTaggers));
			}

			// diff everything below the taggers
			diffHelp(aSubNode, bSubNode, patches, index + 1);
			return;

		case 'text':
			if (a.text !== b.text)
			{
				patches.push(makePatch('p-text', index, b.text));
				return;
			}

			return;

		case 'node':
			// Bail if obvious indicators have changed. Implies more serious
			// structural changes such that it's not worth it to diff.
			if (a.tag !== b.tag || a.namespace !== b.namespace)
			{
				patches.push(makePatch('p-redraw', index, b));
				return;
			}

			var factsDiff = diffFacts(a.facts, b.facts);

			if (typeof factsDiff !== 'undefined')
			{
				patches.push(makePatch('p-facts', index, factsDiff));
			}

			diffChildren(a, b, patches, index);
			return;

		case 'keyed-node':
			// Bail if obvious indicators have changed. Implies more serious
			// structural changes such that it's not worth it to diff.
			if (a.tag !== b.tag || a.namespace !== b.namespace)
			{
				patches.push(makePatch('p-redraw', index, b));
				return;
			}

			var factsDiff = diffFacts(a.facts, b.facts);

			if (typeof factsDiff !== 'undefined')
			{
				patches.push(makePatch('p-facts', index, factsDiff));
			}

			diffKeyedChildren(a, b, patches, index);
			return;

		case 'custom':
			if (a.impl !== b.impl)
			{
				patches.push(makePatch('p-redraw', index, b));
				return;
			}

			var factsDiff = diffFacts(a.facts, b.facts);
			if (typeof factsDiff !== 'undefined')
			{
				patches.push(makePatch('p-facts', index, factsDiff));
			}

			var patch = b.impl.diff(a,b);
			if (patch)
			{
				patches.push(makePatch('p-custom', index, patch));
				return;
			}

			return;
	}
}


// assumes the incoming arrays are the same length
function pairwiseRefEqual(as, bs)
{
	for (var i = 0; i < as.length; i++)
	{
		if (as[i] !== bs[i])
		{
			return false;
		}
	}

	return true;
}


// TODO Instead of creating a new diff object, it's possible to just test if
// there *is* a diff. During the actual patch, do the diff again and make the
// modifications directly. This way, there's no new allocations. Worth it?
function diffFacts(a, b, category)
{
	var diff;

	// look for changes and removals
	for (var aKey in a)
	{
		if (aKey === STYLE_KEY || aKey === EVENT_KEY || aKey === ATTR_KEY || aKey === ATTR_NS_KEY)
		{
			var subDiff = diffFacts(a[aKey], b[aKey] || {}, aKey);
			if (subDiff)
			{
				diff = diff || {};
				diff[aKey] = subDiff;
			}
			continue;
		}

		// remove if not in the new facts
		if (!(aKey in b))
		{
			diff = diff || {};
			diff[aKey] =
				(typeof category === 'undefined')
					? (typeof a[aKey] === 'string' ? '' : null)
					:
				(category === STYLE_KEY)
					? ''
					:
				(category === EVENT_KEY || category === ATTR_KEY)
					? undefined
					:
				{ namespace: a[aKey].namespace, value: undefined };

			continue;
		}

		var aValue = a[aKey];
		var bValue = b[aKey];

		// reference equal, so don't worry about it
		if (aValue === bValue && aKey !== 'value'
			|| category === EVENT_KEY && equalEvents(aValue, bValue))
		{
			continue;
		}

		diff = diff || {};
		diff[aKey] = bValue;
	}

	// add new stuff
	for (var bKey in b)
	{
		if (!(bKey in a))
		{
			diff = diff || {};
			diff[bKey] = b[bKey];
		}
	}

	return diff;
}


function diffChildren(aParent, bParent, patches, rootIndex)
{
	var aChildren = aParent.children;
	var bChildren = bParent.children;

	var aLen = aChildren.length;
	var bLen = bChildren.length;

	// FIGURE OUT IF THERE ARE INSERTS OR REMOVALS

	if (aLen > bLen)
	{
		patches.push(makePatch('p-remove-last', rootIndex, aLen - bLen));
	}
	else if (aLen < bLen)
	{
		patches.push(makePatch('p-append', rootIndex, bChildren.slice(aLen)));
	}

	// PAIRWISE DIFF EVERYTHING ELSE

	var index = rootIndex;
	var minLen = aLen < bLen ? aLen : bLen;
	for (var i = 0; i < minLen; i++)
	{
		index++;
		var aChild = aChildren[i];
		diffHelp(aChild, bChildren[i], patches, index);
		index += aChild.descendantsCount || 0;
	}
}



////////////  KEYED DIFF  ////////////


function diffKeyedChildren(aParent, bParent, patches, rootIndex)
{
	var localPatches = [];

	var changes = {}; // Dict String Entry
	var inserts = []; // Array { index : Int, entry : Entry }
	// type Entry = { tag : String, vnode : VNode, index : Int, data : _ }

	var aChildren = aParent.children;
	var bChildren = bParent.children;
	var aLen = aChildren.length;
	var bLen = bChildren.length;
	var aIndex = 0;
	var bIndex = 0;

	var index = rootIndex;

	while (aIndex < aLen && bIndex < bLen)
	{
		var a = aChildren[aIndex];
		var b = bChildren[bIndex];

		var aKey = a._0;
		var bKey = b._0;
		var aNode = a._1;
		var bNode = b._1;

		// check if keys match

		if (aKey === bKey)
		{
			index++;
			diffHelp(aNode, bNode, localPatches, index);
			index += aNode.descendantsCount || 0;

			aIndex++;
			bIndex++;
			continue;
		}

		// look ahead 1 to detect insertions and removals.

		var aLookAhead = aIndex + 1 < aLen;
		var bLookAhead = bIndex + 1 < bLen;

		if (aLookAhead)
		{
			var aNext = aChildren[aIndex + 1];
			var aNextKey = aNext._0;
			var aNextNode = aNext._1;
			var oldMatch = bKey === aNextKey;
		}

		if (bLookAhead)
		{
			var bNext = bChildren[bIndex + 1];
			var bNextKey = bNext._0;
			var bNextNode = bNext._1;
			var newMatch = aKey === bNextKey;
		}


		// swap a and b
		if (aLookAhead && bLookAhead && newMatch && oldMatch)
		{
			index++;
			diffHelp(aNode, bNextNode, localPatches, index);
			insertNode(changes, localPatches, aKey, bNode, bIndex, inserts);
			index += aNode.descendantsCount || 0;

			index++;
			removeNode(changes, localPatches, aKey, aNextNode, index);
			index += aNextNode.descendantsCount || 0;

			aIndex += 2;
			bIndex += 2;
			continue;
		}

		// insert b
		if (bLookAhead && newMatch)
		{
			index++;
			insertNode(changes, localPatches, bKey, bNode, bIndex, inserts);
			diffHelp(aNode, bNextNode, localPatches, index);
			index += aNode.descendantsCount || 0;

			aIndex += 1;
			bIndex += 2;
			continue;
		}

		// remove a
		if (aLookAhead && oldMatch)
		{
			index++;
			removeNode(changes, localPatches, aKey, aNode, index);
			index += aNode.descendantsCount || 0;

			index++;
			diffHelp(aNextNode, bNode, localPatches, index);
			index += aNextNode.descendantsCount || 0;

			aIndex += 2;
			bIndex += 1;
			continue;
		}

		// remove a, insert b
		if (aLookAhead && bLookAhead && aNextKey === bNextKey)
		{
			index++;
			removeNode(changes, localPatches, aKey, aNode, index);
			insertNode(changes, localPatches, bKey, bNode, bIndex, inserts);
			index += aNode.descendantsCount || 0;

			index++;
			diffHelp(aNextNode, bNextNode, localPatches, index);
			index += aNextNode.descendantsCount || 0;

			aIndex += 2;
			bIndex += 2;
			continue;
		}

		break;
	}

	// eat up any remaining nodes with removeNode and insertNode

	while (aIndex < aLen)
	{
		index++;
		var a = aChildren[aIndex];
		var aNode = a._1;
		removeNode(changes, localPatches, a._0, aNode, index);
		index += aNode.descendantsCount || 0;
		aIndex++;
	}

	var endInserts;
	while (bIndex < bLen)
	{
		endInserts = endInserts || [];
		var b = bChildren[bIndex];
		insertNode(changes, localPatches, b._0, b._1, undefined, endInserts);
		bIndex++;
	}

	if (localPatches.length > 0 || inserts.length > 0 || typeof endInserts !== 'undefined')
	{
		patches.push(makePatch('p-reorder', rootIndex, {
			patches: localPatches,
			inserts: inserts,
			endInserts: endInserts
		}));
	}
}



////////////  CHANGES FROM KEYED DIFF  ////////////


var POSTFIX = '_elmW6BL';


function insertNode(changes, localPatches, key, vnode, bIndex, inserts)
{
	var entry = changes[key];

	// never seen this key before
	if (typeof entry === 'undefined')
	{
		entry = {
			tag: 'insert',
			vnode: vnode,
			index: bIndex,
			data: undefined
		};

		inserts.push({ index: bIndex, entry: entry });
		changes[key] = entry;

		return;
	}

	// this key was removed earlier, a match!
	if (entry.tag === 'remove')
	{
		inserts.push({ index: bIndex, entry: entry });

		entry.tag = 'move';
		var subPatches = [];
		diffHelp(entry.vnode, vnode, subPatches, entry.index);
		entry.index = bIndex;
		entry.data.data = {
			patches: subPatches,
			entry: entry
		};

		return;
	}

	// this key has already been inserted or moved, a duplicate!
	insertNode(changes, localPatches, key + POSTFIX, vnode, bIndex, inserts);
}


function removeNode(changes, localPatches, key, vnode, index)
{
	var entry = changes[key];

	// never seen this key before
	if (typeof entry === 'undefined')
	{
		var patch = makePatch('p-remove', index, undefined);
		localPatches.push(patch);

		changes[key] = {
			tag: 'remove',
			vnode: vnode,
			index: index,
			data: patch
		};

		return;
	}

	// this key was inserted earlier, a match!
	if (entry.tag === 'insert')
	{
		entry.tag = 'move';
		var subPatches = [];
		diffHelp(vnode, entry.vnode, subPatches, index);

		var patch = makePatch('p-remove', index, {
			patches: subPatches,
			entry: entry
		});
		localPatches.push(patch);

		return;
	}

	// this key has already been removed or moved, a duplicate!
	removeNode(changes, localPatches, key + POSTFIX, vnode, index);
}



////////////  ADD DOM NODES  ////////////
//
// Each DOM node has an "index" assigned in order of traversal. It is important
// to minimize our crawl over the actual DOM, so these indexes (along with the
// descendantsCount of virtual nodes) let us skip touching entire subtrees of
// the DOM if we know there are no patches there.


function addDomNodes(domNode, vNode, patches, eventNode)
{
	addDomNodesHelp(domNode, vNode, patches, 0, 0, vNode.descendantsCount, eventNode);
}


// assumes `patches` is non-empty and indexes increase monotonically.
function addDomNodesHelp(domNode, vNode, patches, i, low, high, eventNode)
{
	var patch = patches[i];
	var index = patch.index;

	while (index === low)
	{
		var patchType = patch.type;

		if (patchType === 'p-thunk')
		{
			addDomNodes(domNode, vNode.node, patch.data, eventNode);
		}
		else if (patchType === 'p-reorder')
		{
			patch.domNode = domNode;
			patch.eventNode = eventNode;

			var subPatches = patch.data.patches;
			if (subPatches.length > 0)
			{
				addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
			}
		}
		else if (patchType === 'p-remove')
		{
			patch.domNode = domNode;
			patch.eventNode = eventNode;

			var data = patch.data;
			if (typeof data !== 'undefined')
			{
				data.entry.data = domNode;
				var subPatches = data.patches;
				if (subPatches.length > 0)
				{
					addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
				}
			}
		}
		else
		{
			patch.domNode = domNode;
			patch.eventNode = eventNode;
		}

		i++;

		if (!(patch = patches[i]) || (index = patch.index) > high)
		{
			return i;
		}
	}

	switch (vNode.type)
	{
		case 'tagger':
			var subNode = vNode.node;

			while (subNode.type === "tagger")
			{
				subNode = subNode.node;
			}

			return addDomNodesHelp(domNode, subNode, patches, i, low + 1, high, domNode.elm_event_node_ref);

		case 'node':
			var vChildren = vNode.children;
			var childNodes = domNode.childNodes;
			for (var j = 0; j < vChildren.length; j++)
			{
				low++;
				var vChild = vChildren[j];
				var nextLow = low + (vChild.descendantsCount || 0);
				if (low <= index && index <= nextLow)
				{
					i = addDomNodesHelp(childNodes[j], vChild, patches, i, low, nextLow, eventNode);
					if (!(patch = patches[i]) || (index = patch.index) > high)
					{
						return i;
					}
				}
				low = nextLow;
			}
			return i;

		case 'keyed-node':
			var vChildren = vNode.children;
			var childNodes = domNode.childNodes;
			for (var j = 0; j < vChildren.length; j++)
			{
				low++;
				var vChild = vChildren[j]._1;
				var nextLow = low + (vChild.descendantsCount || 0);
				if (low <= index && index <= nextLow)
				{
					i = addDomNodesHelp(childNodes[j], vChild, patches, i, low, nextLow, eventNode);
					if (!(patch = patches[i]) || (index = patch.index) > high)
					{
						return i;
					}
				}
				low = nextLow;
			}
			return i;

		case 'text':
		case 'thunk':
			throw new Error('should never traverse `text` or `thunk` nodes like this');
	}
}



////////////  APPLY PATCHES  ////////////


function applyPatches(rootDomNode, oldVirtualNode, patches, eventNode)
{
	if (patches.length === 0)
	{
		return rootDomNode;
	}

	addDomNodes(rootDomNode, oldVirtualNode, patches, eventNode);
	return applyPatchesHelp(rootDomNode, patches);
}

function applyPatchesHelp(rootDomNode, patches)
{
	for (var i = 0; i < patches.length; i++)
	{
		var patch = patches[i];
		var localDomNode = patch.domNode
		var newNode = applyPatch(localDomNode, patch);
		if (localDomNode === rootDomNode)
		{
			rootDomNode = newNode;
		}
	}
	return rootDomNode;
}

function applyPatch(domNode, patch)
{
	switch (patch.type)
	{
		case 'p-redraw':
			return redraw(domNode, patch.data, patch.eventNode);

		case 'p-facts':
			applyFacts(domNode, patch.eventNode, patch.data);
			return domNode;

		case 'p-text':
			domNode.replaceData(0, domNode.length, patch.data);
			return domNode;

		case 'p-thunk':
			return applyPatchesHelp(domNode, patch.data);

		case 'p-tagger':
			domNode.elm_event_node_ref.tagger = patch.data;
			return domNode;

		case 'p-remove-last':
			var i = patch.data;
			while (i--)
			{
				domNode.removeChild(domNode.lastChild);
			}
			return domNode;

		case 'p-append':
			var newNodes = patch.data;
			for (var i = 0; i < newNodes.length; i++)
			{
				domNode.appendChild(render(newNodes[i], patch.eventNode));
			}
			return domNode;

		case 'p-remove':
			var data = patch.data;
			if (typeof data === 'undefined')
			{
				domNode.parentNode.removeChild(domNode);
				return domNode;
			}
			var entry = data.entry;
			if (typeof entry.index !== 'undefined')
			{
				domNode.parentNode.removeChild(domNode);
			}
			entry.data = applyPatchesHelp(domNode, data.patches);
			return domNode;

		case 'p-reorder':
			var data = patch.data;

			// end inserts
			var endInserts = data.endInserts;
			var end;
			if (typeof endInserts !== 'undefined')
			{
				if (endInserts.length === 1)
				{
					var insert = endInserts[0];
					var entry = insert.entry;
					var end = entry.tag === 'move'
						? entry.data
						: render(entry.vnode, patch.eventNode);
				}
				else
				{
					end = document.createDocumentFragment();
					for (var i = 0; i < endInserts.length; i++)
					{
						var insert = endInserts[i];
						var entry = insert.entry;
						var node = entry.tag === 'move'
							? entry.data
							: render(entry.vnode, patch.eventNode);
						end.appendChild(node);
					}
				}
			}

			// removals
			domNode = applyPatchesHelp(domNode, data.patches);

			// inserts
			var inserts = data.inserts;
			for (var i = 0; i < inserts.length; i++)
			{
				var insert = inserts[i];
				var entry = insert.entry;
				var node = entry.tag === 'move'
					? entry.data
					: render(entry.vnode, patch.eventNode);
				domNode.insertBefore(node, domNode.childNodes[insert.index]);
			}

			if (typeof end !== 'undefined')
			{
				domNode.appendChild(end);
			}

			return domNode;

		case 'p-custom':
			var impl = patch.data;
			return impl.applyPatch(domNode, impl.data);

		default:
			throw new Error('Ran into an unknown patch!');
	}
}


function redraw(domNode, vNode, eventNode)
{
	var parentNode = domNode.parentNode;
	var newNode = render(vNode, eventNode);

	if (typeof newNode.elm_event_node_ref === 'undefined')
	{
		newNode.elm_event_node_ref = domNode.elm_event_node_ref;
	}

	if (parentNode && newNode !== domNode)
	{
		parentNode.replaceChild(newNode, domNode);
	}
	return newNode;
}



////////////  PROGRAMS  ////////////


function programWithFlags(details)
{
	return {
		init: details.init,
		update: details.update,
		subscriptions: details.subscriptions,
		view: details.view,
		renderer: renderer
	};
}


return {
	node: node,
	text: text,

	custom: custom,

	map: F2(map),

	on: F3(on),
	style: style,
	property: F2(property),
	attribute: F2(attribute),
	attributeNS: F3(attributeNS),

	lazy: F2(lazy),
	lazy2: F3(lazy2),
	lazy3: F4(lazy3),
	keyedNode: F3(keyedNode),

	programWithFlags: programWithFlags
};

}();
var _elm_lang$virtual_dom$VirtualDom$programWithFlags = _elm_lang$virtual_dom$Native_VirtualDom.programWithFlags;
var _elm_lang$virtual_dom$VirtualDom$keyedNode = _elm_lang$virtual_dom$Native_VirtualDom.keyedNode;
var _elm_lang$virtual_dom$VirtualDom$lazy3 = _elm_lang$virtual_dom$Native_VirtualDom.lazy3;
var _elm_lang$virtual_dom$VirtualDom$lazy2 = _elm_lang$virtual_dom$Native_VirtualDom.lazy2;
var _elm_lang$virtual_dom$VirtualDom$lazy = _elm_lang$virtual_dom$Native_VirtualDom.lazy;
var _elm_lang$virtual_dom$VirtualDom$defaultOptions = {stopPropagation: false, preventDefault: false};
var _elm_lang$virtual_dom$VirtualDom$onWithOptions = _elm_lang$virtual_dom$Native_VirtualDom.on;
var _elm_lang$virtual_dom$VirtualDom$on = F2(
	function (eventName, decoder) {
		return A3(_elm_lang$virtual_dom$VirtualDom$onWithOptions, eventName, _elm_lang$virtual_dom$VirtualDom$defaultOptions, decoder);
	});
var _elm_lang$virtual_dom$VirtualDom$style = _elm_lang$virtual_dom$Native_VirtualDom.style;
var _elm_lang$virtual_dom$VirtualDom$attributeNS = _elm_lang$virtual_dom$Native_VirtualDom.attributeNS;
var _elm_lang$virtual_dom$VirtualDom$attribute = _elm_lang$virtual_dom$Native_VirtualDom.attribute;
var _elm_lang$virtual_dom$VirtualDom$property = _elm_lang$virtual_dom$Native_VirtualDom.property;
var _elm_lang$virtual_dom$VirtualDom$map = _elm_lang$virtual_dom$Native_VirtualDom.map;
var _elm_lang$virtual_dom$VirtualDom$text = _elm_lang$virtual_dom$Native_VirtualDom.text;
var _elm_lang$virtual_dom$VirtualDom$node = _elm_lang$virtual_dom$Native_VirtualDom.node;
var _elm_lang$virtual_dom$VirtualDom$Options = F2(
	function (a, b) {
		return {stopPropagation: a, preventDefault: b};
	});
var _elm_lang$virtual_dom$VirtualDom$Node = {ctor: 'Node'};
var _elm_lang$virtual_dom$VirtualDom$Property = {ctor: 'Property'};

var _elm_lang$html$Html$text = _elm_lang$virtual_dom$VirtualDom$text;
var _elm_lang$html$Html$node = _elm_lang$virtual_dom$VirtualDom$node;
var _elm_lang$html$Html$body = _elm_lang$html$Html$node('body');
var _elm_lang$html$Html$section = _elm_lang$html$Html$node('section');
var _elm_lang$html$Html$nav = _elm_lang$html$Html$node('nav');
var _elm_lang$html$Html$article = _elm_lang$html$Html$node('article');
var _elm_lang$html$Html$aside = _elm_lang$html$Html$node('aside');
var _elm_lang$html$Html$h1 = _elm_lang$html$Html$node('h1');
var _elm_lang$html$Html$h2 = _elm_lang$html$Html$node('h2');
var _elm_lang$html$Html$h3 = _elm_lang$html$Html$node('h3');
var _elm_lang$html$Html$h4 = _elm_lang$html$Html$node('h4');
var _elm_lang$html$Html$h5 = _elm_lang$html$Html$node('h5');
var _elm_lang$html$Html$h6 = _elm_lang$html$Html$node('h6');
var _elm_lang$html$Html$header = _elm_lang$html$Html$node('header');
var _elm_lang$html$Html$footer = _elm_lang$html$Html$node('footer');
var _elm_lang$html$Html$address = _elm_lang$html$Html$node('address');
var _elm_lang$html$Html$main$ = _elm_lang$html$Html$node('main');
var _elm_lang$html$Html$p = _elm_lang$html$Html$node('p');
var _elm_lang$html$Html$hr = _elm_lang$html$Html$node('hr');
var _elm_lang$html$Html$pre = _elm_lang$html$Html$node('pre');
var _elm_lang$html$Html$blockquote = _elm_lang$html$Html$node('blockquote');
var _elm_lang$html$Html$ol = _elm_lang$html$Html$node('ol');
var _elm_lang$html$Html$ul = _elm_lang$html$Html$node('ul');
var _elm_lang$html$Html$li = _elm_lang$html$Html$node('li');
var _elm_lang$html$Html$dl = _elm_lang$html$Html$node('dl');
var _elm_lang$html$Html$dt = _elm_lang$html$Html$node('dt');
var _elm_lang$html$Html$dd = _elm_lang$html$Html$node('dd');
var _elm_lang$html$Html$figure = _elm_lang$html$Html$node('figure');
var _elm_lang$html$Html$figcaption = _elm_lang$html$Html$node('figcaption');
var _elm_lang$html$Html$div = _elm_lang$html$Html$node('div');
var _elm_lang$html$Html$a = _elm_lang$html$Html$node('a');
var _elm_lang$html$Html$em = _elm_lang$html$Html$node('em');
var _elm_lang$html$Html$strong = _elm_lang$html$Html$node('strong');
var _elm_lang$html$Html$small = _elm_lang$html$Html$node('small');
var _elm_lang$html$Html$s = _elm_lang$html$Html$node('s');
var _elm_lang$html$Html$cite = _elm_lang$html$Html$node('cite');
var _elm_lang$html$Html$q = _elm_lang$html$Html$node('q');
var _elm_lang$html$Html$dfn = _elm_lang$html$Html$node('dfn');
var _elm_lang$html$Html$abbr = _elm_lang$html$Html$node('abbr');
var _elm_lang$html$Html$time = _elm_lang$html$Html$node('time');
var _elm_lang$html$Html$code = _elm_lang$html$Html$node('code');
var _elm_lang$html$Html$var = _elm_lang$html$Html$node('var');
var _elm_lang$html$Html$samp = _elm_lang$html$Html$node('samp');
var _elm_lang$html$Html$kbd = _elm_lang$html$Html$node('kbd');
var _elm_lang$html$Html$sub = _elm_lang$html$Html$node('sub');
var _elm_lang$html$Html$sup = _elm_lang$html$Html$node('sup');
var _elm_lang$html$Html$i = _elm_lang$html$Html$node('i');
var _elm_lang$html$Html$b = _elm_lang$html$Html$node('b');
var _elm_lang$html$Html$u = _elm_lang$html$Html$node('u');
var _elm_lang$html$Html$mark = _elm_lang$html$Html$node('mark');
var _elm_lang$html$Html$ruby = _elm_lang$html$Html$node('ruby');
var _elm_lang$html$Html$rt = _elm_lang$html$Html$node('rt');
var _elm_lang$html$Html$rp = _elm_lang$html$Html$node('rp');
var _elm_lang$html$Html$bdi = _elm_lang$html$Html$node('bdi');
var _elm_lang$html$Html$bdo = _elm_lang$html$Html$node('bdo');
var _elm_lang$html$Html$span = _elm_lang$html$Html$node('span');
var _elm_lang$html$Html$br = _elm_lang$html$Html$node('br');
var _elm_lang$html$Html$wbr = _elm_lang$html$Html$node('wbr');
var _elm_lang$html$Html$ins = _elm_lang$html$Html$node('ins');
var _elm_lang$html$Html$del = _elm_lang$html$Html$node('del');
var _elm_lang$html$Html$img = _elm_lang$html$Html$node('img');
var _elm_lang$html$Html$iframe = _elm_lang$html$Html$node('iframe');
var _elm_lang$html$Html$embed = _elm_lang$html$Html$node('embed');
var _elm_lang$html$Html$object = _elm_lang$html$Html$node('object');
var _elm_lang$html$Html$param = _elm_lang$html$Html$node('param');
var _elm_lang$html$Html$video = _elm_lang$html$Html$node('video');
var _elm_lang$html$Html$audio = _elm_lang$html$Html$node('audio');
var _elm_lang$html$Html$source = _elm_lang$html$Html$node('source');
var _elm_lang$html$Html$track = _elm_lang$html$Html$node('track');
var _elm_lang$html$Html$canvas = _elm_lang$html$Html$node('canvas');
var _elm_lang$html$Html$svg = _elm_lang$html$Html$node('svg');
var _elm_lang$html$Html$math = _elm_lang$html$Html$node('math');
var _elm_lang$html$Html$table = _elm_lang$html$Html$node('table');
var _elm_lang$html$Html$caption = _elm_lang$html$Html$node('caption');
var _elm_lang$html$Html$colgroup = _elm_lang$html$Html$node('colgroup');
var _elm_lang$html$Html$col = _elm_lang$html$Html$node('col');
var _elm_lang$html$Html$tbody = _elm_lang$html$Html$node('tbody');
var _elm_lang$html$Html$thead = _elm_lang$html$Html$node('thead');
var _elm_lang$html$Html$tfoot = _elm_lang$html$Html$node('tfoot');
var _elm_lang$html$Html$tr = _elm_lang$html$Html$node('tr');
var _elm_lang$html$Html$td = _elm_lang$html$Html$node('td');
var _elm_lang$html$Html$th = _elm_lang$html$Html$node('th');
var _elm_lang$html$Html$form = _elm_lang$html$Html$node('form');
var _elm_lang$html$Html$fieldset = _elm_lang$html$Html$node('fieldset');
var _elm_lang$html$Html$legend = _elm_lang$html$Html$node('legend');
var _elm_lang$html$Html$label = _elm_lang$html$Html$node('label');
var _elm_lang$html$Html$input = _elm_lang$html$Html$node('input');
var _elm_lang$html$Html$button = _elm_lang$html$Html$node('button');
var _elm_lang$html$Html$select = _elm_lang$html$Html$node('select');
var _elm_lang$html$Html$datalist = _elm_lang$html$Html$node('datalist');
var _elm_lang$html$Html$optgroup = _elm_lang$html$Html$node('optgroup');
var _elm_lang$html$Html$option = _elm_lang$html$Html$node('option');
var _elm_lang$html$Html$textarea = _elm_lang$html$Html$node('textarea');
var _elm_lang$html$Html$keygen = _elm_lang$html$Html$node('keygen');
var _elm_lang$html$Html$output = _elm_lang$html$Html$node('output');
var _elm_lang$html$Html$progress = _elm_lang$html$Html$node('progress');
var _elm_lang$html$Html$meter = _elm_lang$html$Html$node('meter');
var _elm_lang$html$Html$details = _elm_lang$html$Html$node('details');
var _elm_lang$html$Html$summary = _elm_lang$html$Html$node('summary');
var _elm_lang$html$Html$menuitem = _elm_lang$html$Html$node('menuitem');
var _elm_lang$html$Html$menu = _elm_lang$html$Html$node('menu');

var _elm_lang$html$Html_App$programWithFlags = _elm_lang$virtual_dom$VirtualDom$programWithFlags;
var _elm_lang$html$Html_App$program = function (app) {
	return _elm_lang$html$Html_App$programWithFlags(
		_elm_lang$core$Native_Utils.update(
			app,
			{
				init: function (_p0) {
					return app.init;
				}
			}));
};
var _elm_lang$html$Html_App$beginnerProgram = function (_p1) {
	var _p2 = _p1;
	return _elm_lang$html$Html_App$programWithFlags(
		{
			init: function (_p3) {
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_p2.model,
					_elm_lang$core$Native_List.fromArray(
						[]));
			},
			update: F2(
				function (msg, model) {
					return A2(
						_elm_lang$core$Platform_Cmd_ops['!'],
						A2(_p2.update, msg, model),
						_elm_lang$core$Native_List.fromArray(
							[]));
				}),
			view: _p2.view,
			subscriptions: function (_p4) {
				return _elm_lang$core$Platform_Sub$none;
			}
		});
};
var _elm_lang$html$Html_App$map = _elm_lang$virtual_dom$VirtualDom$map;

var _elm_community$elm_test$ElmTest_Runner_Console$runDisplay = function (tests) {
	var _p0 = _elm_community$elm_test$ElmTest_Runner_String$run(tests);
	if ((_p0.ctor === '::') && (_p0._0.ctor === '_Tuple2')) {
		var out = A2(
			_elm_lang$core$Basics_ops['++'],
			_p0._0._0,
			A2(
				_elm_lang$core$Basics_ops['++'],
				'\n\n',
				function (_p1) {
					return _elm_lang$core$String$concat(
						A2(
							_elm_lang$core$List$intersperse,
							'\n',
							A2(_elm_lang$core$List$map, _elm_lang$core$Basics$fst, _p1)));
				}(_p0._1)));
		var _p2 = _elm_community$elm_test$ElmTest_Run$pass(_p0._0._1);
		if (_p2 === true) {
			return A2(_elm_lang$core$Debug$log, out, '');
		} else {
			return _elm_lang$core$Native_Utils.crashCase(
				'ElmTest.Runner.Console',
				{
					start: {line: 28, column: 9},
					end: {line: 33, column: 34}
				},
				_p2)(out);
		}
	} else {
		return _elm_lang$core$Native_Utils.crashCase(
			'ElmTest.Runner.Console',
			{
				start: {line: 22, column: 3},
				end: {line: 36, column: 21}
			},
			_p0)('');
	}
};
var _elm_community$elm_test$ElmTest_Runner_Console$runSuite = function (consoleTests) {
	return _elm_lang$html$Html_App$beginnerProgram(
		{
			model: _elm_community$elm_test$ElmTest_Runner_Console$runDisplay(consoleTests),
			view: function (x) {
				return _elm_lang$html$Html$text('');
			},
			update: F2(
				function (x, y) {
					return y;
				})
		});
};

var _elm_community$elm_test$ElmTest_Runner_Html$runDisplay = function (tests) {
	var _p0 = _elm_community$elm_test$ElmTest_Runner_String$run(tests);
	if ((_p0.ctor === '::') && (_p0._0.ctor === '_Tuple2')) {
		var out = A2(
			_elm_lang$core$Basics_ops['++'],
			_p0._0._0,
			A2(
				_elm_lang$core$Basics_ops['++'],
				'\n\n',
				function (_p1) {
					return _elm_lang$core$String$concat(
						A2(
							_elm_lang$core$List$intersperse,
							'\n',
							A2(_elm_lang$core$List$map, _elm_lang$core$Basics$fst, _p1)));
				}(_p0._1)));
		return out;
	} else {
		return _elm_lang$core$Native_Utils.crashCase(
			'ElmTest.Runner.Html',
			{
				start: {line: 23, column: 3},
				end: {line: 31, column: 21}
			},
			_p0)('');
	}
};
var _elm_community$elm_test$ElmTest_Runner_Html$runSuite = function (consoleTests) {
	return _elm_lang$html$Html_App$beginnerProgram(
		{
			model: _elm_community$elm_test$ElmTest_Runner_Html$runDisplay(consoleTests),
			view: function (x) {
				return A2(
					_elm_lang$html$Html$pre,
					_elm_lang$core$Native_List.fromArray(
						[]),
					_elm_lang$core$Native_List.fromArray(
						[
							_elm_lang$html$Html$text(x)
						]));
			},
			update: F2(
				function (x, y) {
					return x;
				})
		});
};

var _elm_community$elm_test$ElmTest$runSuiteHtml = _elm_community$elm_test$ElmTest_Runner_Html$runSuite;
var _elm_community$elm_test$ElmTest$runSuite = _elm_community$elm_test$ElmTest_Runner_Console$runSuite;
var _elm_community$elm_test$ElmTest$stringRunner = _elm_community$elm_test$ElmTest_Runner_String$runDisplay;
var _elm_community$elm_test$ElmTest$consoleRunner = _elm_community$elm_test$ElmTest_Runner_Console$runDisplay;
var _elm_community$elm_test$ElmTest$fail = _elm_community$elm_test$ElmTest_Assertion$AlwaysFail;
var _elm_community$elm_test$ElmTest$pass = _elm_community$elm_test$ElmTest_Assertion$AlwaysPass;
var _elm_community$elm_test$ElmTest$assertionList = _elm_community$elm_test$ElmTest_Assertion$assertionList;
var _elm_community$elm_test$ElmTest$lazyAssert = _elm_community$elm_test$ElmTest_Assertion$assertT;
var _elm_community$elm_test$ElmTest$assertNotEqual = _elm_community$elm_test$ElmTest_Assertion$assertNotEqual;
var _elm_community$elm_test$ElmTest$assertEqual = _elm_community$elm_test$ElmTest_Assertion$assertEqual;
var _elm_community$elm_test$ElmTest$assert = _elm_community$elm_test$ElmTest_Assertion$assert;
var _elm_community$elm_test$ElmTest$suite = _elm_community$elm_test$ElmTest_Test$suite;
var _elm_community$elm_test$ElmTest$equals = _elm_community$elm_test$ElmTest_Test$equals;
var _elm_community$elm_test$ElmTest$defaultTest = _elm_community$elm_test$ElmTest_Test$defaultTest;
var _elm_community$elm_test$ElmTest$test = _elm_community$elm_test$ElmTest_Test$test;

var _elm_community$elm_check$Check_Test$nChecks = function (n) {
	return _elm_lang$core$Native_Utils.eq(n, 1) ? '1 check' : A2(
		_elm_lang$core$Basics_ops['++'],
		_elm_lang$core$Basics$toString(n),
		' checks');
};
var _elm_community$elm_check$Check_Test$evidenceToTest = function (evidence) {
	var _p0 = evidence;
	if (_p0.ctor === 'Multiple') {
		return A2(
			_elm_community$elm_test$ElmTest$suite,
			_p0._0,
			A2(_elm_lang$core$List$map, _elm_community$elm_check$Check_Test$evidenceToTest, _p0._1));
	} else {
		if (_p0._0.ctor === 'Ok') {
			return A2(
				_elm_community$elm_test$ElmTest$test,
				A2(
					_elm_lang$core$Basics_ops['++'],
					_p0._0._0.name,
					A2(
						_elm_lang$core$Basics_ops['++'],
						' [',
						A2(
							_elm_lang$core$Basics_ops['++'],
							_elm_community$elm_check$Check_Test$nChecks(_p0._0._0.numberOfChecks),
							']'))),
				_elm_community$elm_test$ElmTest$pass);
		} else {
			return A2(
				_elm_community$elm_test$ElmTest$test,
				_p0._0._0.name,
				_elm_community$elm_test$ElmTest$fail(
					A2(
						_elm_lang$core$Basics_ops['++'],
						'\nOn check ',
						A2(
							_elm_lang$core$Basics_ops['++'],
							_elm_lang$core$Basics$toString(_p0._0._0.numberOfChecks),
							A2(
								_elm_lang$core$Basics_ops['++'],
								', found counterexample: ',
								A2(
									_elm_lang$core$Basics_ops['++'],
									_p0._0._0.counterExample,
									A2(
										_elm_lang$core$Basics_ops['++'],
										'\nExpected:   ',
										A2(
											_elm_lang$core$Basics_ops['++'],
											_p0._0._0.expected,
											A2(_elm_lang$core$Basics_ops['++'], '\nBut It Was: ', _p0._0._0.actual)))))))));
		}
	}
};

//import Maybe, Native.List //

var _elm_lang$core$Native_Regex = function() {

function escape(str)
{
	return str.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
}
function caseInsensitive(re)
{
	return new RegExp(re.source, 'gi');
}
function regex(raw)
{
	return new RegExp(raw, 'g');
}

function contains(re, string)
{
	return string.match(re) !== null;
}

function find(n, re, str)
{
	n = n.ctor === 'All' ? Infinity : n._0;
	var out = [];
	var number = 0;
	var string = str;
	var lastIndex = re.lastIndex;
	var prevLastIndex = -1;
	var result;
	while (number++ < n && (result = re.exec(string)))
	{
		if (prevLastIndex === re.lastIndex) break;
		var i = result.length - 1;
		var subs = new Array(i);
		while (i > 0)
		{
			var submatch = result[i];
			subs[--i] = submatch === undefined
				? _elm_lang$core$Maybe$Nothing
				: _elm_lang$core$Maybe$Just(submatch);
		}
		out.push({
			match: result[0],
			submatches: _elm_lang$core$Native_List.fromArray(subs),
			index: result.index,
			number: number
		});
		prevLastIndex = re.lastIndex;
	}
	re.lastIndex = lastIndex;
	return _elm_lang$core$Native_List.fromArray(out);
}

function replace(n, re, replacer, string)
{
	n = n.ctor === 'All' ? Infinity : n._0;
	var count = 0;
	function jsReplacer(match)
	{
		if (count++ >= n)
		{
			return match;
		}
		var i = arguments.length - 3;
		var submatches = new Array(i);
		while (i > 0)
		{
			var submatch = arguments[i];
			submatches[--i] = submatch === undefined
				? _elm_lang$core$Maybe$Nothing
				: _elm_lang$core$Maybe$Just(submatch);
		}
		return replacer({
			match: match,
			submatches: _elm_lang$core$Native_List.fromArray(submatches),
			index: arguments[i - 1],
			number: count
		});
	}
	return string.replace(re, jsReplacer);
}

function split(n, re, str)
{
	n = n.ctor === 'All' ? Infinity : n._0;
	if (n === Infinity)
	{
		return _elm_lang$core$Native_List.fromArray(str.split(re));
	}
	var string = str;
	var result;
	var out = [];
	var start = re.lastIndex;
	while (n--)
	{
		if (!(result = re.exec(string))) break;
		out.push(string.slice(start, result.index));
		start = re.lastIndex;
	}
	out.push(string.slice(start));
	return _elm_lang$core$Native_List.fromArray(out);
}

return {
	regex: regex,
	caseInsensitive: caseInsensitive,
	escape: escape,

	contains: F2(contains),
	find: F3(find),
	replace: F4(replace),
	split: F3(split)
};

}();

var _elm_lang$core$Regex$split = _elm_lang$core$Native_Regex.split;
var _elm_lang$core$Regex$replace = _elm_lang$core$Native_Regex.replace;
var _elm_lang$core$Regex$find = _elm_lang$core$Native_Regex.find;
var _elm_lang$core$Regex$contains = _elm_lang$core$Native_Regex.contains;
var _elm_lang$core$Regex$caseInsensitive = _elm_lang$core$Native_Regex.caseInsensitive;
var _elm_lang$core$Regex$regex = _elm_lang$core$Native_Regex.regex;
var _elm_lang$core$Regex$escape = _elm_lang$core$Native_Regex.escape;
var _elm_lang$core$Regex$Match = F4(
	function (a, b, c, d) {
		return {match: a, submatches: b, index: c, number: d};
	});
var _elm_lang$core$Regex$Regex = {ctor: 'Regex'};
var _elm_lang$core$Regex$AtMost = function (a) {
	return {ctor: 'AtMost', _0: a};
};
var _elm_lang$core$Regex$All = {ctor: 'All'};

var _genthaler$cucumber_elm$Automaton$dequeue = function (q) {
	dequeue:
	while (true) {
		var _p0 = q;
		if (_p0._1.ctor === '[]') {
			if (_p0._0.ctor === '[]') {
				return _elm_lang$core$Maybe$Nothing;
			} else {
				var _v1 = {
					ctor: '_Tuple2',
					_0: _elm_lang$core$Native_List.fromArray(
						[]),
					_1: _elm_lang$core$List$reverse(_p0._0)
				};
				q = _v1;
				continue dequeue;
			}
		} else {
			return _elm_lang$core$Maybe$Just(
				{
					ctor: '_Tuple2',
					_0: _p0._1._0,
					_1: {ctor: '_Tuple2', _0: _p0._0, _1: _p0._1._1}
				});
		}
	}
};
var _genthaler$cucumber_elm$Automaton$enqueue = F2(
	function (x, _p1) {
		var _p2 = _p1;
		return {
			ctor: '_Tuple2',
			_0: A2(_elm_lang$core$List_ops['::'], x, _p2._0),
			_1: _p2._1
		};
	});
var _genthaler$cucumber_elm$Automaton$empty = {
	ctor: '_Tuple2',
	_0: _elm_lang$core$Native_List.fromArray(
		[]),
	_1: _elm_lang$core$Native_List.fromArray(
		[])
};
var _genthaler$cucumber_elm$Automaton$step = F2(
	function (a, _p3) {
		var _p4 = _p3;
		return _p4._0(a);
	});
var _genthaler$cucumber_elm$Automaton$Step = function (a) {
	return {ctor: 'Step', _0: a};
};
var _genthaler$cucumber_elm$Automaton_ops = _genthaler$cucumber_elm$Automaton_ops || {};
_genthaler$cucumber_elm$Automaton_ops['>>>'] = F2(
	function (f, g) {
		return _genthaler$cucumber_elm$Automaton$Step(
			function (a) {
				var _p5 = A2(_genthaler$cucumber_elm$Automaton$step, a, f);
				var f$ = _p5._0;
				var b = _p5._1;
				var _p6 = A2(_genthaler$cucumber_elm$Automaton$step, b, g);
				var g$ = _p6._0;
				var c = _p6._1;
				return {
					ctor: '_Tuple2',
					_0: A2(_genthaler$cucumber_elm$Automaton_ops['>>>'], f$, g$),
					_1: c
				};
			});
	});
var _genthaler$cucumber_elm$Automaton_ops = _genthaler$cucumber_elm$Automaton_ops || {};
_genthaler$cucumber_elm$Automaton_ops['<<<'] = F2(
	function (g, f) {
		return _genthaler$cucumber_elm$Automaton$Step(
			function (a) {
				var _p7 = A2(_genthaler$cucumber_elm$Automaton$step, a, f);
				var f$ = _p7._0;
				var b = _p7._1;
				var _p8 = A2(_genthaler$cucumber_elm$Automaton$step, b, g);
				var g$ = _p8._0;
				var c = _p8._1;
				return {
					ctor: '_Tuple2',
					_0: A2(_genthaler$cucumber_elm$Automaton_ops['<<<'], g$, f$),
					_1: c
				};
			});
	});
var _genthaler$cucumber_elm$Automaton$branch = F2(
	function (f, g) {
		return _genthaler$cucumber_elm$Automaton$Step(
			function (a) {
				var _p9 = A2(_genthaler$cucumber_elm$Automaton$step, a, g);
				var g$ = _p9._0;
				var c = _p9._1;
				var _p10 = A2(_genthaler$cucumber_elm$Automaton$step, a, f);
				var f$ = _p10._0;
				var b = _p10._1;
				return {
					ctor: '_Tuple2',
					_0: A2(_genthaler$cucumber_elm$Automaton$branch, f$, g$),
					_1: {ctor: '_Tuple2', _0: b, _1: c}
				};
			});
	});
var _genthaler$cucumber_elm$Automaton$pair = F2(
	function (f, g) {
		return _genthaler$cucumber_elm$Automaton$Step(
			function (_p11) {
				var _p12 = _p11;
				var _p13 = A2(_genthaler$cucumber_elm$Automaton$step, _p12._1, g);
				var g$ = _p13._0;
				var d = _p13._1;
				var _p14 = A2(_genthaler$cucumber_elm$Automaton$step, _p12._0, f);
				var f$ = _p14._0;
				var c = _p14._1;
				return {
					ctor: '_Tuple2',
					_0: A2(_genthaler$cucumber_elm$Automaton$pair, f$, g$),
					_1: {ctor: '_Tuple2', _0: c, _1: d}
				};
			});
	});
var _genthaler$cucumber_elm$Automaton$first = function (auto) {
	return _genthaler$cucumber_elm$Automaton$Step(
		function (_p15) {
			var _p16 = _p15;
			var _p17 = A2(_genthaler$cucumber_elm$Automaton$step, _p16._0, auto);
			var f = _p17._0;
			var o = _p17._1;
			return {
				ctor: '_Tuple2',
				_0: _genthaler$cucumber_elm$Automaton$first(f),
				_1: {ctor: '_Tuple2', _0: o, _1: _p16._1}
			};
		});
};
var _genthaler$cucumber_elm$Automaton$second = function (auto) {
	return _genthaler$cucumber_elm$Automaton$Step(
		function (_p18) {
			var _p19 = _p18;
			var _p20 = A2(_genthaler$cucumber_elm$Automaton$step, _p19._1, auto);
			var f = _p20._0;
			var o = _p20._1;
			return {
				ctor: '_Tuple2',
				_0: _genthaler$cucumber_elm$Automaton$second(f),
				_1: {ctor: '_Tuple2', _0: _p19._0, _1: o}
			};
		});
};
var _genthaler$cucumber_elm$Automaton$loop = F2(
	function (state, auto) {
		return _genthaler$cucumber_elm$Automaton$Step(
			function (input) {
				var _p21 = A2(
					_genthaler$cucumber_elm$Automaton$step,
					{ctor: '_Tuple2', _0: input, _1: state},
					auto);
				var auto$ = _p21._0;
				var output = _p21._1._0;
				var state$ = _p21._1._1;
				return {
					ctor: '_Tuple2',
					_0: A2(_genthaler$cucumber_elm$Automaton$loop, state$, auto$),
					_1: output
				};
			});
	});
var _genthaler$cucumber_elm$Automaton$combine = function (autos) {
	return _genthaler$cucumber_elm$Automaton$Step(
		function (a) {
			var _p22 = _elm_lang$core$List$unzip(
				A2(
					_elm_lang$core$List$map,
					_genthaler$cucumber_elm$Automaton$step(a),
					autos));
			var autos$ = _p22._0;
			var bs = _p22._1;
			return {
				ctor: '_Tuple2',
				_0: _genthaler$cucumber_elm$Automaton$combine(autos$),
				_1: bs
			};
		});
};
var _genthaler$cucumber_elm$Automaton$pure = function (f) {
	return _genthaler$cucumber_elm$Automaton$Step(
		function (x) {
			return {
				ctor: '_Tuple2',
				_0: _genthaler$cucumber_elm$Automaton$pure(f),
				_1: f(x)
			};
		});
};
var _genthaler$cucumber_elm$Automaton$merge = function (f) {
	return _genthaler$cucumber_elm$Automaton$pure(
		_elm_lang$core$Basics$uncurry(f));
};
var _genthaler$cucumber_elm$Automaton$state = F2(
	function (s, f) {
		return _genthaler$cucumber_elm$Automaton$Step(
			function (x) {
				var s$ = A2(f, x, s);
				return {
					ctor: '_Tuple2',
					_0: A2(_genthaler$cucumber_elm$Automaton$state, s$, f),
					_1: s$
				};
			});
	});
var _genthaler$cucumber_elm$Automaton$count = A2(
	_genthaler$cucumber_elm$Automaton$state,
	0,
	F2(
		function (_p23, c) {
			return c + 1;
		}));
var _genthaler$cucumber_elm$Automaton$hiddenState = F2(
	function (s, f) {
		return _genthaler$cucumber_elm$Automaton$Step(
			function (x) {
				var _p24 = A2(f, x, s);
				var s$ = _p24._0;
				var out = _p24._1;
				return {
					ctor: '_Tuple2',
					_0: A2(_genthaler$cucumber_elm$Automaton$hiddenState, out, f),
					_1: s$
				};
			});
	});
var _genthaler$cucumber_elm$Automaton$average = function (k) {
	var stepFull = F2(
		function (n, _p25) {
			var _p26 = _p25;
			var _p30 = _p26._2;
			var _p29 = _p26._0;
			var _p28 = _p26._1;
			var _p27 = _genthaler$cucumber_elm$Automaton$dequeue(_p29);
			if (_p27.ctor === 'Nothing') {
				return {
					ctor: '_Tuple2',
					_0: 0,
					_1: {ctor: '_Tuple3', _0: _p29, _1: _p28, _2: _p30}
				};
			} else {
				var sum$ = (_p30 + n) - _p27._0._0;
				return {
					ctor: '_Tuple2',
					_0: sum$ / _elm_lang$core$Basics$toFloat(_p28),
					_1: {
						ctor: '_Tuple3',
						_0: A2(_genthaler$cucumber_elm$Automaton$enqueue, n, _p27._0._1),
						_1: _p28,
						_2: sum$
					}
				};
			}
		});
	var step = F2(
		function (n, _p31) {
			var _p32 = _p31;
			var _p35 = _p32._2;
			var _p34 = _p32._0;
			var _p33 = _p32._1;
			return _elm_lang$core$Native_Utils.eq(_p33, k) ? A2(
				stepFull,
				n,
				{ctor: '_Tuple3', _0: _p34, _1: _p33, _2: _p35}) : {
				ctor: '_Tuple2',
				_0: (_p35 + n) / (_elm_lang$core$Basics$toFloat(_p33) + 1),
				_1: {
					ctor: '_Tuple3',
					_0: A2(_genthaler$cucumber_elm$Automaton$enqueue, n, _p34),
					_1: _p33 + 1,
					_2: _p35 + n
				}
			};
		});
	return A2(
		_genthaler$cucumber_elm$Automaton$hiddenState,
		{ctor: '_Tuple3', _0: _genthaler$cucumber_elm$Automaton$empty, _1: 0, _2: 0},
		step);
};

var _genthaler$cucumber_elm$Gherkin$Feature = F6(
	function (a, b, c, d, e, f) {
		return {ctor: 'Feature', _0: a, _1: b, _2: c, _3: d, _4: e, _5: f};
	});
var _genthaler$cucumber_elm$Gherkin$AsA = function (a) {
	return {ctor: 'AsA', _0: a};
};
var _genthaler$cucumber_elm$Gherkin$InOrderTo = function (a) {
	return {ctor: 'InOrderTo', _0: a};
};
var _genthaler$cucumber_elm$Gherkin$IWantTo = function (a) {
	return {ctor: 'IWantTo', _0: a};
};
var _genthaler$cucumber_elm$Gherkin$NoBackground = {ctor: 'NoBackground'};
var _genthaler$cucumber_elm$Gherkin$Background = function (a) {
	return {ctor: 'Background', _0: a};
};
var _genthaler$cucumber_elm$Gherkin$ScenarioOutline = F3(
	function (a, b, c) {
		return {ctor: 'ScenarioOutline', _0: a, _1: b, _2: c};
	});
var _genthaler$cucumber_elm$Gherkin$Scenario = F2(
	function (a, b) {
		return {ctor: 'Scenario', _0: a, _1: b};
	});
var _genthaler$cucumber_elm$Gherkin$But = F2(
	function (a, b) {
		return {ctor: 'But', _0: a, _1: b};
	});
var _genthaler$cucumber_elm$Gherkin$And = F2(
	function (a, b) {
		return {ctor: 'And', _0: a, _1: b};
	});
var _genthaler$cucumber_elm$Gherkin$Then = F2(
	function (a, b) {
		return {ctor: 'Then', _0: a, _1: b};
	});
var _genthaler$cucumber_elm$Gherkin$When = F2(
	function (a, b) {
		return {ctor: 'When', _0: a, _1: b};
	});
var _genthaler$cucumber_elm$Gherkin$Given = F2(
	function (a, b) {
		return {ctor: 'Given', _0: a, _1: b};
	});
var _genthaler$cucumber_elm$Gherkin$DocString = function (a) {
	return {ctor: 'DocString', _0: a};
};
var _genthaler$cucumber_elm$Gherkin$DataTable = function (a) {
	return {ctor: 'DataTable', _0: a};
};
var _genthaler$cucumber_elm$Gherkin$NoArg = {ctor: 'NoArg'};
var _genthaler$cucumber_elm$Gherkin$Examples = function (a) {
	return {ctor: 'Examples', _0: a};
};

var _genthaler$cucumber_elm$Cucumber$runStep = F3(
	function (step, state, _p0) {
		var _p1 = _p0;
		var regex = _elm_lang$core$Regex$regex(_p1._0);
		var _p2 = function () {
			var _p3 = step;
			switch (_p3.ctor) {
				case 'Given':
					return {ctor: '_Tuple3', _0: 'Given', _1: _p3._0, _2: _p3._1};
				case 'When':
					return {ctor: '_Tuple3', _0: 'When', _1: _p3._0, _2: _p3._1};
				case 'Then':
					return {ctor: '_Tuple3', _0: 'Then', _1: _p3._0, _2: _p3._1};
				case 'And':
					return {ctor: '_Tuple3', _0: 'And', _1: _p3._0, _2: _p3._1};
				default:
					return {ctor: '_Tuple3', _0: 'But', _1: _p3._0, _2: _p3._1};
			}
		}();
		var stepName = _p2._0;
		var string = _p2._1;
		var arg = _p2._2;
		var found = A3(_elm_lang$core$Regex$find, _elm_lang$core$Regex$All, regex, string);
		var oneFound = _elm_lang$core$Native_Utils.eq(
			_elm_lang$core$List$length(found),
			1);
		var _p4 = _elm_lang$core$List$head(found);
		if (_p4.ctor === 'Nothing') {
			return {ctor: '_Tuple2', _0: state, _1: _elm_community$elm_test$ElmTest$pass};
		} else {
			return A3(_p1._1, state, _p4._0.submatches, arg);
		}
	});
var _genthaler$cucumber_elm$Cucumber$Glue = F2(
	function (a, b) {
		return {ctor: 'Glue', _0: a, _1: b};
	});

var _genthaler$cucumber_elm$CucumberTest_Fixture$myRealFunction = function (string) {
	var _p0 = string;
	if (_p0 === 'time') {
		return true;
	} else {
		return false;
	}
};

var _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$expectThat = F6(
	function ($function, _p1, checker, _p0, producer, description) {
		var claimToTest = A2(
			_elm_community$elm_check$Check$for,
			A2(
				_elm_community$elm_check$Check$is,
				A2(
					_elm_community$elm_check$Check$that,
					_elm_community$elm_check$Check$claim(description),
					$function),
				checker),
			producer);
		var evidence = A3(
			_elm_community$elm_check$Check$check,
			100,
			_elm_lang$core$Random$initialSeed(1),
			claimToTest);
		return _elm_community$elm_check$Check_Test$evidenceToTest(evidence);
	});
var _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$itAlways = F2(
	function (description, expectation) {
		return expectation(description);
	});
var _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$toBeTruthy = _elm_community$elm_test$ElmTest$assert;
var _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$notToBe = _elm_community$elm_test$ElmTest$assertNotEqual;
var _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$toBe = _elm_community$elm_test$ElmTest$assertEqual;
var _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$expect = F2(
	function (actual, matchs) {
		return matchs(actual);
	});
var _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$it = _elm_community$elm_test$ElmTest$test;
var _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$describe = _elm_community$elm_test$ElmTest$suite;
var _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$Word = {ctor: 'Word'};
var _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$isTheSameAs = _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$Word;
var _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$forEvery = _rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$Word;

var _genthaler$cucumber_elm$CucumberTest_Glue$myGlue = function () {
	var assert = F3(
		function (state, maybeMatches, stepArg) {
			var _p0 = _elm_lang$core$List$head(maybeMatches);
			if (_p0.ctor === 'Nothing') {
				return {
					ctor: '_Tuple2',
					_0: state,
					_1: _elm_community$elm_test$ElmTest$fail('misery')
				};
			} else {
				if (_p0._0.ctor === 'Nothing') {
					return {
						ctor: '_Tuple2',
						_0: state,
						_1: _elm_community$elm_test$ElmTest$fail('misery')
					};
				} else {
					return {
						ctor: '_Tuple2',
						_0: state,
						_1: A2(
							_elm_community$elm_test$ElmTest$assertEqual,
							true,
							_genthaler$cucumber_elm$CucumberTest_Fixture$myRealFunction(_p0._0._0))
					};
				}
			}
		});
	return A2(_genthaler$cucumber_elm$Cucumber$Glue, '^Now is the (.+)$', assert);
}();

var _genthaler$cucumber_elm$CucumberTest$step = A2(
	_genthaler$cucumber_elm$Gherkin$Given,
	'Now is the time',
	_genthaler$cucumber_elm$Gherkin$DocString(''));
var _genthaler$cucumber_elm$CucumberTest$stepTest = A2(
	_rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$describe,
	'Features',
	_elm_lang$core$Native_List.fromArray(
		[
			A2(
			_rogeriochaves$elm_test_bdd_style$ElmTestBDDStyle$it,
			'successfully runs a Step against a Glue function',
			_elm_lang$core$Basics$snd(
				A3(_genthaler$cucumber_elm$Cucumber$runStep, _genthaler$cucumber_elm$CucumberTest$step, '', _genthaler$cucumber_elm$CucumberTest_Glue$myGlue)))
		]));
var _genthaler$cucumber_elm$CucumberTest$all = A2(
	_elm_community$elm_test$ElmTest$suite,
	'Features',
	_elm_lang$core$Native_List.fromArray(
		[_genthaler$cucumber_elm$CucumberTest$stepTest]));

var _genthaler$cucumber_elm$GherkinTest$feature = A6(
	_genthaler$cucumber_elm$Gherkin$Feature,
	'Having fun',
	_genthaler$cucumber_elm$Gherkin$AsA('person'),
	_genthaler$cucumber_elm$Gherkin$InOrderTo('have fun'),
	_genthaler$cucumber_elm$Gherkin$IWantTo('play baseball'),
	_genthaler$cucumber_elm$Gherkin$NoBackground,
	_elm_lang$core$Native_List.fromArray(
		[
			A3(
			_genthaler$cucumber_elm$Gherkin$ScenarioOutline,
			'guys are swimming',
			_elm_lang$core$Native_List.fromArray(
				[
					A2(
					_genthaler$cucumber_elm$Gherkin$Given,
					'a precondition has value <param_1>',
					_genthaler$cucumber_elm$Gherkin$DocString('')),
					A2(
					_genthaler$cucumber_elm$Gherkin$And,
					'something with <param_2>',
					_genthaler$cucumber_elm$Gherkin$DataTable(
						_elm_lang$core$Native_List.fromArray(
							[
								_elm_lang$core$Native_List.fromArray(
								[])
							]))),
					A2(_genthaler$cucumber_elm$Gherkin$Then, 'check <param_3> is the output', _genthaler$cucumber_elm$Gherkin$NoArg)
				]),
			_genthaler$cucumber_elm$Gherkin$Examples(
				_elm_lang$core$Native_List.fromArray(
					[
						_elm_lang$core$Native_List.fromArray(
						[''])
					]))),
			A2(
			_genthaler$cucumber_elm$Gherkin$Scenario,
			'guys are sailing',
			_elm_lang$core$Native_List.fromArray(
				[
					A2(_genthaler$cucumber_elm$Gherkin$Given, 'a precondition is valid', _genthaler$cucumber_elm$Gherkin$NoArg),
					A2(_genthaler$cucumber_elm$Gherkin$When, 'an action is performed', _genthaler$cucumber_elm$Gherkin$NoArg),
					A2(_genthaler$cucumber_elm$Gherkin$Then, 'something should be asserted', _genthaler$cucumber_elm$Gherkin$NoArg)
				]))
		]));
var _genthaler$cucumber_elm$GherkinTest$featureTest = A2(
	_elm_community$elm_test$ElmTest$test,
	'Features',
	A2(_elm_community$elm_test$ElmTest$assertEqual, _genthaler$cucumber_elm$GherkinTest$feature, _genthaler$cucumber_elm$GherkinTest$feature));
var _genthaler$cucumber_elm$GherkinTest$all = A2(
	_elm_community$elm_test$ElmTest$suite,
	'GherkinTest',
	_elm_lang$core$Native_List.fromArray(
		[_genthaler$cucumber_elm$GherkinTest$featureTest]));

var _genthaler$cucumber_elm$Main$allTests = A2(
	_elm_community$elm_test$ElmTest$suite,
	'All tests',
	_elm_lang$core$Native_List.fromArray(
		[_genthaler$cucumber_elm$GherkinTest$all, _genthaler$cucumber_elm$CucumberTest$all]));
var _genthaler$cucumber_elm$Main$main = {
	main: _elm_community$elm_test$ElmTest$runSuite(_genthaler$cucumber_elm$Main$allTests)
};

var Elm = {};
Elm['Main'] = Elm['Main'] || {};
_elm_lang$core$Native_Platform.addPublicModule(Elm['Main'], 'Main', typeof _genthaler$cucumber_elm$Main$main === 'undefined' ? null : _genthaler$cucumber_elm$Main$main);

if (typeof define === "function" && define['amd'])
{
  define([], function() { return Elm; });
  return;
}

if (typeof module === "object")
{
  module['exports'] = Elm;
  return;
}

var globalElm = this['Elm'];
if (typeof globalElm === "undefined")
{
  this['Elm'] = Elm;
  return;
}

for (var publicModule in Elm)
{
  if (publicModule in globalElm)
  {
    throw new Error('There are two Elm modules called `' + publicModule + '` on this page! Rename one of them.');
  }
  globalElm[publicModule] = Elm[publicModule];
}

}).call(this);

