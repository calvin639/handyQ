// Loggin interface for kdb

\d .log

levels:`error`warn`info`debug;
lvl:`debug;
.log.out:{[lvl;msg]
	0N!"### ",string[.z.p]," ### ::",string[lvl]," :: ",msg;
	};

debug:{[msg]
	if[first(where`debug=levels)<=where lvl=levels;
		.log.out[`DEBUG;msg]]
	};

info:{[msg]
        if[first(where`info=levels)<=where lvl=levels;
                .log.out[`INFO;msg]]
        };

warn:{[msg]
        if[first(where`warn=levels)<=where lvl=levels;
                .log.out[`WARN;msg]]
        };

error:{[msg]
        if[first(where`error=levels)<=where lvl=levels;
                .log.out[`ERROR;msg]]
        };


