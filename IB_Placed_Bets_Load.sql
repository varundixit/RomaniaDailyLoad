##date change 2016-01-05
use romaniastg;
drop table stg_placed_bets_csv;
CREATE TABLE `stg_placed_bets_csv` (
  `BetslipId` bigint(20) DEFAULT NULL,
  `BetslipStatus` varchar(20) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `BetTime` varchar(50) DEFAULT NULL,
  `BetStatus` varchar(20) DEFAULT NULL,
  `ReferredYN` varchar(50) DEFAULT NULL,
  `CancelReason` varchar(500) DEFAULT NULL,
  `NumLegs` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` varchar(20) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `SelectionName` varchar(1000) DEFAULT NULL,
  `SelectionSort` varchar(20) DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000) DEFAULT NULL,
  `MarketSort` varchar(20) DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000) DEFAULT NULL,
  `EventStartTime` varchar(50) DEFAULT NULL,
  `MeetingName` varchar(1000) DEFAULT NULL,
  `RaceType` varchar(500) DEFAULT NULL,
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
  `BonusId` bigint(20) DEFAULT NULL,
  `CampaignId` bigint(20) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(5) DEFAULT NULL,
  `OddsType` varchar(5) DEFAULT NULL,
  `Odds` decimal(18,6) DEFAULT NULL,
  `EitherwaySort` varchar(5) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\Placed_Bets2016-01-05.csv' 
INTO TABLE  stg_placed_bets_csv
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


select
 BetslipId
,BetslipStatus
,BetId
,BetType
,STR_TO_DATE(BetTime, '%Y-%m-%d %H:%i:%s')
,DATE(STR_TO_DATE(BetTime, '%Y-%m-%d %H:%i:%s'))
,BetStatus
,ReferredYN
,CancelReason
,NumLegs
,NumPart
,LegSort
,SelectionId
,SelectionName
,SelectionSort
,MarketId
,MarketName
,MarketSort
,EventId
,EventName
,STR_TO_DATE(EventStartTime, '%Y-%m-%d %H:%i:%s')
,MeetingName
,RaceType
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
,BonusId
,CampaignId
,BonusStakeAmt
,BonusStakeAmtBC
,BonusBalanceStake
,BonusBalanceStakeBC
,LiveYN
,OddsType
,Odds
,EitherwaySort
,ViewId
,Channel
,Operator
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\stg_placed_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from stg_placed_bets_csv;

drop table stg_placed_bets;
CREATE TABLE `stg_placed_bets` (
  `BetslipId` bigint(20) DEFAULT NULL,
  `BetslipStatus` varchar(20) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `BetTime` datetime DEFAULT NULL,
  `BetDate` date DEFAULT NULL,
  `BetStatus` varchar(20) DEFAULT NULL,
  `ReferredYN` varchar(50) DEFAULT NULL,
  `CancelReason` varchar(500) DEFAULT NULL,
  `NumLegs` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` varchar(20) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `SelectionName` varchar(1000) DEFAULT NULL,
  `SelectionSort` varchar(20) DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000) DEFAULT NULL,
  `MarketSort` varchar(20) DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000) DEFAULT NULL,
  `EventStartTime` datetime DEFAULT NULL,
  `MeetingName` varchar(1000) DEFAULT NULL,
  `RaceType` varchar(500) DEFAULT NULL,
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
  `BonusId` bigint(20) DEFAULT NULL,
  `CampaignId` bigint(20) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(5) DEFAULT NULL,
  `OddsType` varchar(5) DEFAULT NULL,
  `Odds` decimal(18,6) DEFAULT NULL,
  `EitherwaySort` varchar(5) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\stg_placed_bets.csv' 
INTO TABLE  stg_placed_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select
 BetslipId
,BetslipStatus
,BetId
,BetType
,BetTime
,BetDate
,BetStatus
,ReferredYN
,CancelReason
,NumLegs
,NumPart
,LegSort
,SelectionId
,SelectionName
,SelectionSort
,MarketId
,MarketName
,MarketSort
,EventId
,EventName
,EventStartTime
,MeetingName
,RaceType
,TypeId
,TypeName
,ClassId
,ClassName
,SportCode
,SportName
,p.PlayerId
,p.UserName
,p.CurrencyCode
,NumLines
,StakePerLine
,StakePerLineBC
,StakeAmt
,StakeAmtBC
,(StakeAmt - BonusStakeAmt - BonusBalanceStake) as CashStakeAmt
,(StakeAmtBC - BonusStakeAmtBC - BonusBalanceStakeBC) as CashStakeAmtBC
,BonusId
,CampaignId
,BonusStakeAmt
,BonusStakeAmtBC
,BonusBalanceStake
,BonusBalanceStakeBC
,LiveYN
,OddsType
,Odds
,EitherwaySort
,ViewId
,Channel
,Operator
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\stg_placed_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from stg_placed_bets as stg 
join romaniamain.DIM_PLAYER as p on stg.PlayerId = p.PlayerSPId;

#use romaniamain;
#drop table fd_placed_bets;
CREATE TABLE `fd_placed_bets` (
  `BetslipId` bigint(20) DEFAULT NULL,
  `BetslipStatus` varchar(20) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `BetTime` datetime DEFAULT NULL,
  `BetDate` date DEFAULT NULL,
  `BetStatus` varchar(20) DEFAULT NULL,
  `ReferredYN` varchar(50) DEFAULT NULL,
  `CancelReason` varchar(500) DEFAULT NULL,
  `NumLegs` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` varchar(20) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `SelectionName` varchar(1000) DEFAULT NULL,
  `SelectionSort` varchar(20) DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000) DEFAULT NULL,
  `MarketSort` varchar(20) DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000) DEFAULT NULL,
  `EventStartTime` datetime DEFAULT NULL,
  `MeetingName` varchar(1000) DEFAULT NULL,
  `RaceType` varchar(500) DEFAULT NULL,
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
  `CashStakeAmt` decimal(18,6) DEFAULT NULL,
  `CashStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusId` bigint(20) DEFAULT NULL,
  `CampaignId` bigint(20) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(5) DEFAULT NULL,
  `OddsType` varchar(5) DEFAULT NULL,
  `Odds` decimal(18,6) DEFAULT NULL,
  `EitherwaySort` varchar(5) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

use romaniastg;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\stg_placed_bets.csv' 
INTO TABLE  romaniamain.fd_placed_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';
