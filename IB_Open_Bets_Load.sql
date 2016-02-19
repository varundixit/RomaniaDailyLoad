## date change 2016-02-05
##place file "Open_Bets26Onwards.csv" remove header
##Full Run
use romaniastg;
drop table stg_open_bets_csv;
CREATE TABLE `stg_open_bets_csv` (
  `BetSlipId` bigint(20) DEFAULT NULL,
  `BetSlipStatus` varchar(50) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `Placedate` varchar(50) DEFAULT NULL,
  `BetStatus` varchar(20) DEFAULT NULL,
  `NumLeg` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` varchar(20) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `Selectionname` varchar(1000) DEFAULT NULL,
  `Selectionsort` varchar(20) DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000) DEFAULT NULL,
  `MarketSort` varchar(100) DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000) DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000) DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000) DEFAULT NULL,
  `SportCode` varchar(20) DEFAULT NULL,
  `SportName` varchar(100) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `CurrencyCode` varchar(20) DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `StakePerLine` decimal(18,6) DEFAULT NULL,
  `StakePerLineBC` decimal(18,6) DEFAULT NULL,
  `StakeAmt` decimal(18,6) DEFAULT NULL,
  `StakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(5) DEFAULT NULL,
  `OddsType` varchar(5) DEFAULT NULL,
  `DecreasingOdds` decimal(18,6) DEFAULT NULL,
  `EitherWaySort` varchar(50) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL,
  `PotentialReturn` decimal(18,6) DEFAULT NULL,
  `ViewName` varchar(100) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\OpenBets\\Open_Bets26Onwards.csv' 
INTO TABLE stg_open_bets_csv
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select
 BetSlipId
,BetSlipStatus
,BetId
,BetType
,STR_TO_DATE(Placedate, '%Y-%m-%d %H:%i:%s')
,DATE(STR_TO_DATE(Placedate, '%Y-%m-%d %H:%i:%s'))
,BetStatus
,NumLeg
,NumPart
,LegSort
,SelectionId
,Selectionname
,Selectionsort
,MarketId
,MarketName
,MarketSort
,EventId
,EventName
,TypeId
,TypeName
,ClassId
,ClassName
,SportCode
,SportName
,PlayerId
,UserName
,CurrencyCode
,NumLines
,StakePerLine
,StakePerLineBC
,StakeAmt
,StakeAmtBC
,BonusStakeAmt
,BonusStakeAmtBC
,BonusBalanceStake
,BonusBalanceStakeBC
,LiveYN
,OddsType
,DecreasingOdds
,EitherWaySort
,ViewId
,Channel
,Operator
,PotentialReturn
,ViewName
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\OpenBets\\STG_OPEN_BETS.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from stg_open_bets_csv;

drop table stg_open_bets;
CREATE TABLE `stg_open_bets` (
  `BetSlipId` bigint(20) DEFAULT NULL,
  `BetSlipStatus` varchar(50) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `PlaceTime` datetime DEFAULT NULL,
  `BetDate` date DEFAULT null,
  `BetStatus` varchar(20) DEFAULT NULL,
  `NumLeg` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` varchar(20) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `Selectionname` varchar(1000) DEFAULT NULL,
  `Selectionsort` varchar(20) DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000) DEFAULT NULL,
  `MarketSort` varchar(100) DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000) DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000) DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000) DEFAULT NULL,
  `SportCode` varchar(20) DEFAULT NULL,
  `SportName` varchar(100) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `CurrencyCode` varchar(20) DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `StakePerLine` decimal(18,6) DEFAULT NULL,
  `StakePerLineBC` decimal(18,6) DEFAULT NULL,
  `StakeAmt` decimal(18,6) DEFAULT NULL,
  `StakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(5) DEFAULT NULL,
  `OddsType` varchar(5) DEFAULT NULL,
  `DecreasingOdds` decimal(18,6) DEFAULT NULL,
  `EitherWaySort` varchar(50) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL,
  `PotentialReturn` decimal(18,6) DEFAULT NULL,
  `ViewName` varchar(100) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\OpenBets\\STG_OPEN_BETS.csv' 
INTO TABLE  stg_open_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

#select BetDate, count(*) from stg_open_bets group by BetDate order by 1 desc;

select
 BetSlipId
,BetSlipStatus
,BetId
,BetType
,PlaceTime
,BetDate
,BetStatus
,NumLeg
,NumPart
,LegSort
,SelectionId
,Selectionname
,Selectionsort
,MarketId
,MarketName
,MarketSort
,EventId
,EventName
,TypeId
,TypeName
,ClassId
,ClassName
,SportCode
,SportName
,p.PlayerId
,p.UserName
,stg.CurrencyCode
,NumLines
,StakePerLine
,StakePerLineBC
,StakeAmt
,StakeAmtBC
,BonusStakeAmt
,BonusStakeAmtBC
,BonusBalanceStake
,BonusBalanceStakeBC
,LiveYN
,OddsType
,DecreasingOdds
,EitherWaySort
,ViewId
,Channel
,Operator
,PotentialReturn
,ViewName
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\OpenBets\\fd_open_bets.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
from stg_open_bets as stg 
join romaniamain.DIM_PLAYER as p on stg.PlayerId = p.PlayerSPId
where BetDate <= '2016-02-05';


use romaniamain;
drop table fd_open_bets;
CREATE TABLE `fd_open_bets` (
  `BetSlipId` bigint(20) DEFAULT NULL,
  `BetSlipStatus` varchar(50) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `PlaceTime` datetime DEFAULT NULL,
  `BetDate` date DEFAULT null,
  `BetStatus` varchar(20) DEFAULT NULL,
  `NumLeg` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` varchar(20) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `Selectionname` varchar(1000) DEFAULT NULL,
  `Selectionsort` varchar(20) DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000) DEFAULT NULL,
  `MarketSort` varchar(100) DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000) DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000) DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000) DEFAULT NULL,
  `SportCode` varchar(20) DEFAULT NULL,
  `SportName` varchar(100) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `CurrencyCode` varchar(20) DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `StakePerLine` decimal(18,6) DEFAULT NULL,
  `StakePerLineBC` decimal(18,6) DEFAULT NULL,
  `StakeAmt` decimal(18,6) DEFAULT NULL,
  `StakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(5) DEFAULT NULL,
  `OddsType` varchar(5) DEFAULT NULL,
  `DecreasingOdds` decimal(18,6) DEFAULT NULL,
  `EitherWaySort` varchar(50) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL,
  `PotentialReturn` decimal(18,6) DEFAULT NULL,
  `ViewName` varchar(100) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\OpenBets\\fd_open_bets.csv' 
INTO TABLE romaniamain.fd_open_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

#select BetDate, count(*) from romaniamain.fd_open_bets group by 1;

#########stake per line distribution

drop table romaniamain.fd_open_bets_ext;
CREATE TABLE `romaniamain`.`fd_open_bets_ext` (
  `BetSlipId` bigint(20) DEFAULT NULL,
  `BetSlipStatus` varchar(50) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `PlaceTime` datetime DEFAULT NULL,
  `BetDate` date DEFAULT null,
  `BetStatus` varchar(20) DEFAULT NULL,
  `NumLeg` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` varchar(20) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `Selectionname` varchar(1000) DEFAULT NULL,
  `Selectionsort` varchar(20) DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000) DEFAULT NULL,
  `MarketSort` varchar(100) DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000) DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000) DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000) DEFAULT NULL,
  `SportCode` varchar(20) DEFAULT NULL,
  `SportName` varchar(100) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `CurrencyCode` varchar(20) DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `StakePerLine` decimal(18,6) DEFAULT NULL,
  `StakePerLineBC` decimal(18,6) DEFAULT NULL,
  `StakeAmt` decimal(18,6) DEFAULT NULL,
  `StakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(5) DEFAULT NULL,
  `OddsType` varchar(5) DEFAULT NULL,
  `DecreasingOdds` decimal(18,6) DEFAULT NULL,
  `EitherWaySort` varchar(50) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL,
  `PotentialReturn` decimal(18,6) DEFAULT NULL,
  `ViewName` varchar(100) DEFAULT NULL,
  `StakePerLineMtplr` decimal(18,6)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

select 
sb.* 
,cast((spl/leg_cnt)*(prt_cnt/pp)*100/sb.TotalStakeAmt as decimal(18,6)) SpLCalc
from fd_open_bets sb
join (select BetId,(StakeAmt/(max(NumPart)+1)) spl, max(NumLeg)+1 leg_cnt,max(NumPart)+1 prt_cnt 
from fd_open_bets
group by BetId,StakeAmt) bt on sb.BetId= bt.BetId
join (select BetId,NumLeg,count(NumPart) pp 
from fd_open_bets 
group by BetId,NumLeg) lg on sb.BetId= lg.BetId and sb.NumLeg = lg.NumLeg
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\OpenBets\\fd_Open_bets_distribBetId.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\OpenBets\\fd_Open_bets_distribBetId.csv' 
INTO TABLE romaniamain.fd_open_bets_ext
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n'; 

/*
select count(BetId), round(sum(co)/100,2) from 
(select BetId,sum(StakePerLineMtplr) co from romaniamain.fd_open_bets_ext
group by 1) ab;
*/

select '2016-02-14' dat,sum(case LiveYN when 'No' then cashstake end) fixedOpenBets,sum(case LiveYN when 'Yes' then cashstake end) liveOpenBets from (
select LiveYN,sum(cast(StakePerLineMtplr*(StakeAmt-BonusStakeAmt-BonusBalanceStake)/100 as decimal(18,6))) cashstake 
from romaniamain.fd_open_bets_ext b
join romaniamain.dim_player p  on b.PlayerId=p.PlayerId and p.PlayerId is not null
group by 1) ab
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\DayWiseOpenBetSummary.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ;

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\DayWiseOpenBetSummary.csv'
INTO TABLE romaniafl.DayWiseOpenBetSummary
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';