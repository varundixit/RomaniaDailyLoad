##date change 2016-02-02
###place file "Rejected_Bets2016-02-02.csv"
##Full Run
use romaniastg;
drop table stg_rejected_bets_csv;
create table `stg_rejected_bets_csv`(
 `BetslipId` bigint(20) DEFAULT NULL
,`BetId` bigint(20) DEFAULT NULL
,`TraderName` varchar(100) DEFAULT NULL
,`BetTime` varchar(200) DEFAULT NULL
,`Username` varchar(50) DEFAULT NULL
,`CustSegmentName` varchar(200) DEFAULT NULL
,`UnitStakeAmt` decimal(18,4) default null
,`BetType` varchar(20) DEFAULT NULL
,`CancelReason` varchar(200) DEFAULT NULL
,`SelectionDetail` varchar(4000) DEFAULT NULL
,`Odds` decimal(18,4) default null
,`PotentialReturns` decimal(18,4) default null
,`StakeAmt` decimal(18,4) default null
,`TokenStakeAmt` decimal(18,4) default null
,`PotentialReturnsBC` decimal(18,4) default null
,`StakeAmtBC` decimal(18,4) default null
,`BonusStakeAmtBC` decimal(18,4) default null
,`Channel` varchar(200) DEFAULT NULL
,`ViewName` varchar(200) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\RejectedBets\\Rejected_Bets2016-02-02.csv' 
INTO TABLE  stg_rejected_bets_csv
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
 BetslipId
,BetId
,TraderName
,STR_TO_DATE(BetTime, '%Y-%m-%d %H:%i:%s')
,date(STR_TO_DATE(BetTime, '%Y-%m-%d %H:%i:%s'))
,Username
,CustSegmentName
,UnitStakeAmt
,BetType
,CancelReason
,SelectionDetail
,Odds
,PotentialReturns
,StakeAmt
,TokenStakeAmt
,PotentialReturnsBC
,StakeAmtBC
,BonusStakeAmtBC
,Channel
,ViewName
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\RejectedBets\\stg_rejected_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from stg_rejected_bets_csv;

use romaniastg;
drop table stg_rejected_bets;
create table `stg_rejected_bets`(
 `BetslipId` bigint(20) DEFAULT NULL
,`BetId` bigint(20) DEFAULT NULL
,`TraderName` varchar(100) DEFAULT NULL
,`BetTime` datetime DEFAULT NULL
,`BetDate` date DEFAULT NULL
,`Username` varchar(50) DEFAULT NULL
,`CustSegmentName` varchar(200) DEFAULT NULL
,`UnitStakeAmtBC` decimal(18,4) default null
,`BetType` varchar(20) DEFAULT NULL
,`CancelReason` varchar(200) DEFAULT NULL
,`SelectionDetail` varchar(4000) DEFAULT NULL
,`Odds` decimal(18,4) default null
,`PotentialReturns` decimal(18,4) default null
,`StakeAmt` decimal(18,4) default null
,`TokenStakeAmt` decimal(18,4) default null
,`PotentialReturnsBC` decimal(18,4) default null
,`StakeAmtBC` decimal(18,4) default null
,`BonusStakeAmtBC` decimal(18,4) default null
,`Channel` varchar(200) DEFAULT NULL
,`ViewName` varchar(200) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\RejectedBets\\stg_rejected_bets.csv' 
INTO TABLE  stg_rejected_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

/*
#use romaniamain;
#drop table `fd_rejected_bets`;
create table `fd_rejected_bets`(
 `BetslipId` bigint(20) DEFAULT NULL
,`BetId` bigint(20) DEFAULT NULL
,`TraderName` varchar(100) DEFAULT NULL
,`BetTime` datetime DEFAULT NULL
,`BetDate` date DEFAULT NULL
,`PlayerId` bigint(20) DEFAULT NULL
,`UserName` varchar(100) DEFAULT NULL
,`CurrencyCode` varchar(20) DEFAULT NULL
,`CustSegmentName` varchar(200) DEFAULT NULL
,`UnitStakeAmt` decimal(18,4) default null
,`BetType` varchar(20) DEFAULT NULL
,`CancelReason` varchar(200) DEFAULT NULL
,`SelectionDetail` varchar(4000) DEFAULT NULL
,`Odds` decimal(18,4) default null
,`PotentialReturns` decimal(18,4) default null
,`StakeAmt` decimal(18,4) default null
,`TokenStakeAmt` decimal(18,4) default null
,`PotentialReturnsBC` decimal(18,4) default null
,`StakeAmtBC` decimal(18,4) default null
,`BonusStakeAmtBC` decimal(18,4) default null
,`Channel` varchar(200) DEFAULT NULL
,`ViewName` varchar(200) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
*/

use romaniastg;
select
 stg.BetslipId
,stg.BetId
,stg.TraderName
,stg.BetTime
,stg.BetDate
,p.PlayerId
,p.UserName
,p.CurrencyCode
,stg.CustSegmentName
,stg.UnitStakeAmtBC
,stg.BetType
,stg.CancelReason
,stg.SelectionDetail
,stg.Odds
,stg.PotentialReturns
,stg.StakeAmt
,stg.TokenStakeAmt
,stg.PotentialReturnsBC
,stg.StakeAmtBC
,stg.BonusStakeAmtBC
,stg.Channel
,stg.ViewName
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\RejectedBets\\fd_rejected_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from stg_rejected_bets as stg 
join romaniamain.DIM_PLAYER as p on stg.UserName = p.UserName;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\RejectedBets\\fd_rejected_bets.csv' 
INTO TABLE  romaniamain.fd_rejected_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

#select BetDate, count(*) from romaniamain.fd_rejected_bets group by 1 order by 1 desc;