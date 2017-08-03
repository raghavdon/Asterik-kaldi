#!/usr/bin/php -q                                 
<?php
require('phpagi.php');

$mypath="/usr/imp/raghav_call";


	$agi 		= new AGI();
	$extension  = $agi->request['agi_extension'];
	$channel    = $agi->request['agi_channel'];
	$callerid   = $agi->request['agi_callerid'];
	$callstatus	= 0;
	$date		= date('Ymd');	
	$timestamp	= date('His');
	
if (!file_exists("$mypath/yes_no_record")) {
    mkdir("$mypath/record", 0777, true);
}




$i=0;
do{

$utterance = date('His').substr((string)microtime(), 2, 3);

raghav_log("commodity Recording Start");
$agi->stream_file("$mypath/don/say_yes_or_no_1");
sleep(0.6);
$recodord_path="$mypath/yes_no_record";
$agi->record_file("$recodord_path","wav","0",2000,NULL,true,1);
sleep(1.0);
raghav_log("commodity Recording END");
$i++;
}while($i <=30);

$agi->stream_file("$mypath/don/end_credit");	
raghav_log("Call Ended at : ".date('d/m/Y H:i:s'));
raghav_log("*******************************************\n");
exit();

?>
