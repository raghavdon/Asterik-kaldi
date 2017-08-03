#!/usr/bin/php -q                                 
<?php
require('phpagi.php');

$mypath="/usr/underworld/others/raghav_call";


require "${mypath}/raghav_fun.inc";




	$agi 		= new AGI();
	$extension  = $agi->request['agi_extension'];
	$channel    = $agi->request['agi_channel'];
	$callerid   = $agi->request['agi_callerid'];
	$callstatus	= 0;
	$date		= date('Ymd');	
	$timestamp	= date('His');
	$starttime 	= "$date$timestamp";
	$uniqueid 	= "$extension"."_"."$channel"."_"."$callerid"."_"."$starttime";
	$fname		= "$date"."_"."$timestamp"."_"."$callerid";	// File Name with <Date Time Stamp and Cal
	$dbschema	= "Agri_ASR";
	$max_attempts	= 4;

$dbconn = raghav_database_connect();


if (!file_exists("$mypath/record")) {
    mkdir("$mypath/record", 0777, true);
}

raghav_log("*******************************************");
raghav_log("Recognition Test Call Date & Time : ".date('d/m/Y H:i:s'));
raghav_log("Channel: $channel, Extension: $extension, Caller ID: $callerid");

	$agi->stream_file("$mypath/don/1");
	$agi->stream_file("$mypath/don/1");
	$agi->stream_file("$mypath/don/1");
	
	$agi->stream_file("$mypath/don/intro");
	
	sleep(0.1);


	




////////////////////////////district recognisation ////////////////////////


$state=raghav_state();

$districtarr=raghav_district_recognisation($state);


#$districtarr=raghav_fect_market_district("UPMB","district");

//////////////////////commodity recognisation  //////////////////////



raghav_log("commodity recognisation :");
$attempt=1;

$repeat=false;

do{
if ($attempt>=$max_attempts)
{
$repeat=false;			
$agi->stream_file("$mypath/don/you_have_reached_maximum_try_limit_please_try_again_later");
raghav_ending_procedure();
}


if($repeat==false){
	
	
	
	
	$agi->stream_file("$mypath/don/say_comm_like");
	raghav_log("say commodity ");
	$agi->stream_file("$mypath/don/for_example");
	$agi->stream_file("$mypath/don/Wheat_Other");
	sleep(0.1);
	$agi->stream_file("$mypath/don/or");
	sleep(0.1);
	$agi->stream_file("$mypath/don/Bajra_Other");
	sleep(0.6);
 }

else{
	$agi->stream_file("$mypath/don/say_commodity_again");
	raghav_log("say commodity again");
	sleep(0.6);
 }

$utterance = date('His').substr((string)microtime(), 2, 3);

raghav_log("commodity Recording Start");

$recodord_path="$mypath/record/$utterance";
if (!file_exists($recodord_path)) {
    mkdir($recodord_path, 0777, true);
}
sleep(0.3);
$agi->record_file("$recodord_path/$utterance","wav","0",3000,NULL,true,3);

raghav_log("commodity Recording END");

$crop=shell_exec('sh '.$mypath.'/online_speech.sh '.$recodord_path.' '.$utterance.'.wav comodity');

list($u1, $u2,$u3) = explode("\n", $crop);

raghav_log("Recognized $u2 with  Score: $u3");

$valid_word=NULL;

if(strpos($u2, 'no final-state reached') !== false || $u3 < 0.4){
raghav_log("Score Less than 0.5, Repeating...");
$repeat=true;
$attempt++;
$agi->stream_file("$mypath/don/we_are_not_able_hear_you_correctly");
raghav_log("we_are_not_able_hear_you_correctly");

}


else {
raghav_log("query for valid word");
$valid = raghav_validate_recognized_word($u2, "commodity");
$valid_word=$valid[1];
	
	if($valid_word !=NULL){
		$agi->stream_file("$mypath/don/yousaid");
		$agi->stream_file("$mypath/don/${valid_word}");
		raghav_log("yousaid: $valid_word----- pls say yes or no");
		
		
		$confirmation = raghav_confirmation();
		raghav_log("confirmation : $confirmation");
			if ($confirmation == "haan")
				{
				$repeat = false;
				}
			else if ($confirmation == "nahiin")
				{
				$attempt++;
				$repeat = true;
				}
			
		}
	else{
		
		$agi->stream_file("$mypath/don/sorry");
		$agi->stream_file("$mypath/don/in_this_district_commodity_information_not_reported");
		raghav_log("commodity information not reported do you need other commodity price ");
		$agi->stream_file("$mypath/don/do_you_need_other_commodity_price");
		raghav_log("yousaid: $$valid_word----- pls say yes or no");
		$confirmation = raghav_confirmation();
		raghav_log("confirmation : $confirmation");
			
			if ($confirmation == "haan")
				{
				$attempt++;
				$repeat = true;
				}
			else if ($confirmation == "nahiin")
				{
				$repeat = false;
				raghav_ending_procedure();
				}
			

	    }
}




if($repeat==false){
$commodity_code=raghav_commodity_Code($u2);

$counting=count($districtarr);


  $rv=false;
 if ($counting!=0)
   {	$ii=0;
	
	$j=0;
	raghav_log("total market =$ii");
	while($ii<$counting)
	{
	$counting2=count($commodity_code);
	$k=0;
	while($k<$counting2)
	{
		
		$a1=$districtarr[$ii]["DistrictCode"];
		$a2=$districtarr[$ii]["MarketCode"];


	raghav_log("fetching for market $a2 of district $a1");
	
	$rv=raghav_fetch_and_play_price($districtarr[$ii]["DistrictCode"],$commodity_code[$k]["CommodityCode"], $districtarr[$ii]["MarketCode"]);
		
	$k++;
	
		if($rv==true){
		$j++;
		}
	}
		raghav_log("$ii");
		$ii++;
		
	
}

	if($j==0){
		raghav_log("No Price Info avaliable in Database for ${commodity} in ${district}");
		raghav_log("Fetching Price for ${commodity} in Neighbouring Districts in");
			
		$agi->stream_file("$mypath/don/in_this_district_commodity_information_not_reported");
		$agi->stream_file("$mypath/don/but_info_fetched_from_neighbouring_district");
	
		$rvn=raghav_fetch_and_play_price_neighbour($districtarr[$i]["DistrictCode"],$commodity_code, $districtarr[$i]["MarketCode"]);
		
		if($rvn==false){
		
		raghav_log("No Price Info avaliable in Database for ${commodity} in Neighbouring Districts");
				
		$agi->stream_file("$mypath/don/sorry_commodity_price_information_currently_not_available_with_us");
	
		
		}
			

  		}
  

}
else{
	$agi->stream_file("$mypath/don/sorry");
	$agi->stream_file("$mypath/don/in_this_district_commodity_information_not_reported");
	raghav_ending_procedure();
	$repeat = false;
     }




$agi->stream_file("$mypath/don/do_you_need_other_commodity_price");
		raghav_log("yousaid: $$valid_word----- pls say yes or no");
		$confirmation = raghav_confirmation();
		raghav_log("confirmation : $confirmation");
			if ($confirmation == "haan")
				{
				$attempt++;
				$repeat = true;
				}
			else if ($confirmation == "nahiin")
				{
				$repeat = false;
				raghav_ending_procedure();
				}
			else{
				$repeat = false;
				raghav_ending_procedure();

	  		    }



}

}while($repeat);


?>
