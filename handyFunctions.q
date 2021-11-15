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

