/// Numerous random functions for real life problems using kdb ///

//
//@Desc 		Multi assign variables to values
//
//@Input vars{sym[]}	List of variable names
//@Input vals{list} 	List of values to assign
//
multiAssign:{[vars;vals]
	@[`.;vars;:;vals];
	};
//
//@Desc			Dynamically build a functional where clause from a dictionary
//
//@Input d{dict}	Dict of col names to values
//
//@Return {list}	List for functional where clause
//
bwc:{[d]
    ffn:(10 0 -11 11h)!({(like;x;y)};{(max;((/:;like);x;enlist y))}),2#{(in;x;enlist y)}; / Filter functions
    ffn:ffn value type'[d];
    ffn[where null ffn]:{(in;x;y)}; / Non special case filter functions
    ffn .'flip(key d;value d)
    };

//
// @desc 	Filters a table for column value pairs in dict.
//
//@Input 	d{dict}		Contains values to filter against, must have column names as keys.
//@param 	t{table}	Table to act on.
//
//@return	{table}		The filtered table.
//
filterTbl:{[d;t]?[t;bwc d;0b;()]}

//
//@Desc 		Force confirmation before running function
//
//@Input f{sym}		Sym of function name
//
//@Return 		Returns whatever the function would return, only if you confirm

confirmFunc:{[f]
	if["y"=lower first confirm["Do you wish to continue? (y/n) "];
	f[]]
	};

//Helper for above, asks for input
confirm:{1 x;read0 0}


//Data sizes in human readible format
byteUnits:("bytes";"KB";"MB";"GB";"TB");
byteSizes:xexp[1024;]til 5;

//@Desc                 Puts memory usage in human readible form
//
//@Input sz{float}      Result of -22! for example   
//
//@Return  {string}     Human readible format
fmtBytes:{[sz]
	i:last where byteSizes<abs sz;
	(-27!(2i;sz%byteSizes i))," ",byteUnits i
	};

//@Desc                 Rough decider on if you should use sym/string in terms of memory only
//
//@Input n{long}	Number of occurances of the string
//@Input str{string}	The string of interest
//
//@Return  {sym}	String or Sym
symOrString:{[n;str]
    if[1>=count str;:`string];
    memStr:n*-22!str;
    memSym:sum(-22!str;n*-22!0nj);
    `sym`string[memStr<memSym]
    };

//@Desc                 Rough decider on if you should use sym/string for column in terms of memory only
//
//@Input col{list}      Column of interest
//
//@Return  {sym}        String or Sym
symOrStringCol:{[col]
    d:count each group col;
    d:count each group symOrString'[value d;key d];
    first key desc d
    }

//@Desc                 Pivots a table on a set of columns
//
//@Input t{tbl}      	Your table
//@Input k{sym}		Column to pivot on
//@Input c{sym}         New columns in pivoted table
//@Input v{sym}         Value column to retain
//
//@Return  {tbl}        Pivotted table
//
pivot:{[t;k;c;v]
    P:asc distinct t[c];
    pv:?[t;();enlist[k]!enlist k;enlist[v]!enlist(!;c;v)];
    pv:(value pv)v;
    flip P!flip {x each y}[;P]each pv
    };		
