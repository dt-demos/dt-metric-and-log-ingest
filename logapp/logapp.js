/*
Expects the following ENV variables
LOOPS
LOGFILE
*/

const localLogFile='/tmp/locallog.log'

logfile=process.env.LOGFILE;
if (!logfile) {
    logfile='logapp.log'
}

loops=process.env.LOOPS;
if (!loops) {
    loops=2;
}

var fs = require('fs');

function sleep(time) {
    var stop = new Date().getTime();
    while(new Date().getTime() < stop + time) {
        ;
    }
}

// Adds log in this format
// {"@timestamp":"2021-12-21T17:16:43.743+02:00","level":"INFO","thread_name":"main","class":"PrimeMainMR","method":"main","message":"LOGPOINT: Hi Rob!  Num - 3750"}
function writelog(logfile,logtype,msg){
    var now = new Date();
    logMsg = '{"@timestamp":"';
    logMsg += now.getFullYear() + '-'+ ("0" + (now.getMonth() + 1)).slice(-2)+ '-'+  ("0" + now.getDate()).slice(-2) + 'T';
    //logMsg += now.getUTCHours() + ':'+ now.getUTCMinutes() + ':'+ ('0'+now.getUTCSeconds()).slice(-2)+'.000+05:00';
    logMsg += ('0'+now.getUTCHours()).slice(-2) + ':'+ ('0'+now.getUTCMinutes()).slice(-2) + ':'+ ('0'+now.getUTCSeconds()).slice(-2)+'.112412Z';
    logMsg += '","level":"'+logtype+'","thread_name":"main","class":"PrimeMainMR","method":"main","message":"';
    logMsg += msg+'"}';
    fs.appendFileSync(logfile, logMsg+'\n');
    console.log('{"source":"Console","log":'+logMsg+'}');
    //localLogMsg += msg+'","source":"locallog"}';
    //fs.appendFileSync(localLogFile, localLogMsg+'\n');
}

for (let loop = 0; loop < loops; loop++) {
    writelog(logfile,'INFO','INFO log message '+loop);
    writelog(logfile,'WARN','WARN log message '+loop);
    writelog(logfile,'ERROR','ERROR log message '+loop);
    sleep(1000); // sleep for 1 second
}
