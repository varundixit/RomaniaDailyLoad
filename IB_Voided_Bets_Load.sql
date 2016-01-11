##date change 2016-01-10
use romaniastg;
drop table stg_voided_bets_csv;
create table `stg_voided_bets_csv`(
 `CustName` varchar(200) DEFAULT NULL
,`BetTime` varchar(50) DEFAULT NULL
,`PlayerId` bigint(20) DEFAULT NULL
,`Username` varchar(50) DEFAULT NULL
,`BetId` bigint(20) DEFAULT NULL
,`BetslipId` bigint(20) DEFAULT NULL
,`UnitStakeBC` decimal(18,6) DEFAULT NULL
,`BetType` varchar(20) DEFAULT NULL
,`SelectionDetail` varchar(4000) DEFAULT NULL
,`Odds` decimal(18,4) default null
,`BonusStakeDesc` varchar(200) DEFAULT NULL
,`TotalStakeDesc` varchar(200) DEFAULT NULL
,`FirstSettledTime` varchar(200) DEFAULT NULL
,`BetResult` varchar(10) DEFAULT NULL
,`FirstSettlerUsername` varchar(50) DEFAULT NULL
,`VoidedTime` varchar(200) DEFAULT NULL
,`VoiderUsername` varchar(50) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\VoidedBets\\Voided_Bets2016-01-10.csv' 
INTO TABLE  stg_voided_bets_csv
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


select 
 CustName
,STR_TO_DATE(BetTime, '%Y-%m-%d %H:%i:%s')
,date(STR_TO_DATE(BetTime, '%Y-%m-%d %H:%i:%s'))
,PlayerId
,Username
,BetId
,BetslipId
,UnitStakeBC
,BetType
,SelectionDetail
,Odds
,BonusStakeDesc
,TotalStakeDesc
,STR_TO_DATE(FirstSettledTime, '%Y-%m-%d %H:%i:%s')
,date(STR_TO_DATE(FirstSettledTime, '%Y-%m-%d %H:%i:%s'))
,BetResult
,FirstSettlerUsername
,STR_TO_DATE(VoidedTime, '%Y-%m-%d %H:%i:%s')
,date(STR_TO_DATE(VoidedTime, '%Y-%m-%d %H:%i:%s'))
,VoiderUsername
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\VoidedBets\\stg_voided_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from stg_voided_bets_csv;


use romaniastg;
drop table stg_voided_bets;
create table `stg_voided_bets`(
 `CustName` varchar(200) DEFAULT NULL
,`BetTime` datetime DEFAULT NULL
,`BetDate` date DEFAULT NULL
,`PlayerId` bigint(20) DEFAULT NULL
,`Username` varchar(50) DEFAULT NULL
,`BetId` bigint(20) DEFAULT NULL
,`BetSlipId` bigint(20) DEFAULT NULL
,`UnitStakeBC` decimal(18,6) DEFAULT NULL
,`BetType` varchar(20) DEFAULT NULL
,`SelectionDetail` varchar(4000) DEFAULT NULL
,`Odds` decimal(18,4) default null
,`BonusStakeDesc` varchar(200) DEFAULT NULL
,`TotalStakeDesc` varchar(200) DEFAULT NULL
,`FirstSettledTime` datetime DEFAULT NULL
,`FirstSettledDate` date DEFAULT NULL
,`BetResult` varchar(10) DEFAULT NULL
,`FirstSettlerUsername` varchar(50) DEFAULT NULL
,`VoidedTime` datetime DEFAULT NULL
,`VoidedDate` date DEFAULT NULL
,`VoiderUsername` varchar(50) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\VoidedBets\\stg_voided_bets.csv' 
INTO TABLE  stg_voided_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

#use romaniamain;
#drop table `fd_voided_bets`;
create table `fd_voided_bets`(
 `CustName` varchar(200) DEFAULT NULL
,`BetTime` datetime DEFAULT NULL
,`BetDate` date DEFAULT NULL
,`PlayerId` bigint(20) DEFAULT NULL
,`Username` varchar(50) DEFAULT NULL
,`BetId` bigint(20) DEFAULT NULL
,`BetSlipId` bigint(20) DEFAULT NULL
,`UnitStakeBC` decimal(18,6) DEFAULT NULL
,`BetType` varchar(20) DEFAULT NULL
,`SelectionDetail` varchar(4000) DEFAULT NULL
,`Odds` decimal(18,4) default null
,`BonusStakeDesc` varchar(200) DEFAULT NULL
,`TotalStakeDesc` varchar(200) DEFAULT NULL
,`FirstSettledTime` datetime DEFAULT NULL
,`FirstSettledDate` date DEFAULT NULL
,`BetResult` varchar(10) DEFAULT NULL
,`FirstSettlerUsername` varchar(50) DEFAULT NULL
,`VoidedTime` datetime DEFAULT NULL
,`VoidedDate` date DEFAULT NULL
,`VoiderUsername` varchar(50) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

use romaniastg;

select * 
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\VoidedBets\\fd_voided_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from stg_voided_bets;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\VoidedBets\\fd_voided_bets.csv' 
INTO TABLE  romaniamain.fd_voided_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';