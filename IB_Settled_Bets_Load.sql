## date change 2016-01-04
use romaniastg;
drop table `stg_settled_bets_csv`;
CREATE TABLE `stg_settled_bets_csv` (
  `BetId` bigint(20) DEFAULT NULL,
  `SettleTime` varchar(50) DEFAULT NULL,
  `BetStatus` varchar(20)  DEFAULT NULL,
  `NumLeg` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `SelectionName` varchar(1000)  DEFAULT NULL,
  `SelectionSort` varchar(20)  DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000)  DEFAULT NULL,
  `MarketSort` varchar(20)  DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000)  DEFAULT NULL,
  `EventStartTime` varchar(50) DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000)  DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000)  DEFAULT NULL,
  `SportCode` varchar(20)  DEFAULT NULL,
  `SportName` varchar(100)  DEFAULT NULL,
  `DecreasingOdds` decimal(18,6) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100)  DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `NumLinesWin` int(11) DEFAULT NULL,
  `NumLinesLose` int(11) DEFAULT NULL,
  `NumLinesVoid` int(11) DEFAULT NULL,
  `CurrencyCode` varchar(20)  DEFAULT NULL,
  `BonusId` bigint(20) DEFAULT NULL,
  `CampaignId` bigint(20) DEFAULT NULL,
  `TotalReturn` decimal(18,6) DEFAULT NULL,
  `TotalReturnBC` decimal(18,6) DEFAULT NULL,
  `CashReturn` decimal(18,6) DEFAULT NULL,
  `CashReturnBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceReturn` decimal(18,6) DEFAULT NULL,
  `BonusBalancereturnBC` decimal(18,6) DEFAULT NULL,
  `CashRefund` decimal(18,6) DEFAULT NULL,
  `CashRefundBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceRefund` decimal(18,6) DEFAULT NULL,
  `BonusBalanceRefundBC` decimal(18,6) DEFAULT NULL,
  `TokenRefund` decimal(18,6) DEFAULT NULL,
  `TokenRefundBC` decimal(18,6) DEFAULT NULL,
  `CashOutStake` decimal(18,6) DEFAULT NULL,
  `CashOutStakeBC` decimal(18,6) DEFAULT NULL,
  `CashOutWin` decimal(18,6) DEFAULT NULL,
  `CashOutWinBC` decimal(18,6) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20)  DEFAULT NULL,
  `Operator` varchar(20)  DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\Settled_Bets2016-01-04.csv' 
INTO TABLE  stg_settled_bets_csv
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 
 BetId
,STR_TO_DATE(SettleTime, '%Y-%m-%d %H:%i:%s')
,DATE(STR_TO_DATE(SettleTime, '%Y-%m-%d %H:%i:%s'))
,BetStatus
,NumLeg
,NumPart
,SelectionId
,SelectionName
,SelectionSort
,MarketId
,MarketName
,MarketSort
,EventId
,EventName
,STR_TO_DATE(EventStartTime, '%Y-%m-%d %H:%i:%s')
,TypeId
,TypeName
,ClassId
,ClassName
,SportCode
,SportName
,DecreasingOdds
,PlayerId
,UserName
,NumLines
,NumLinesWin
,NumLinesLose
,NumLinesVoid
,CurrencyCode
,BonusId
,CampaignId
,TotalReturn
,TotalReturnBC
,CashReturn
,CashReturnBC
,BonusBalanceReturn
,BonusBalancereturnBC
,CashRefund
,CashRefundBC
,BonusBalanceRefund
,BonusBalanceRefundBC
,TokenRefund
,TokenRefundBC
,CashOutStake
,CashOutStakeBC
,CashOutWin
,CashOutWinBC
,ViewId
,Channel
,Operator
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\stg_settled_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from stg_settled_bets_csv;

drop table `stg_settled_bets`;
CREATE TABLE `stg_settled_bets` (
  `BetId` bigint(20) DEFAULT NULL,
  `SettleTime` datetime DEFAULT NULL,
  `SettledDate` date default null,
  `BetStatus` varchar(20)  DEFAULT NULL,
  `NumLeg` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `SelectionName` varchar(1000)  DEFAULT NULL,
  `SelectionSort` varchar(20)  DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000)  DEFAULT NULL,
  `MarketSort` varchar(20)  DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000)  DEFAULT NULL,
  `EventStartTime` datetime DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000)  DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000)  DEFAULT NULL,
  `SportCode` varchar(20)  DEFAULT NULL,
  `SportName` varchar(100)  DEFAULT NULL,
  `DecreasingOdds` decimal(18,6) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100)  DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `NumLinesWin` int(11) DEFAULT NULL,
  `NumLinesLose` int(11) DEFAULT NULL,
  `NumLinesVoid` int(11) DEFAULT NULL,
  `CurrencyCode` varchar(20)  DEFAULT NULL,
  `BonusId` bigint(20) DEFAULT NULL,
  `CampaignId` bigint(20) DEFAULT NULL,
  `TotalReturn` decimal(18,6) DEFAULT NULL,
  `TotalReturnBC` decimal(18,6) DEFAULT NULL,
  `CashReturn` decimal(18,6) DEFAULT NULL,
  `CashReturnBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceReturn` decimal(18,6) DEFAULT NULL,
  `BonusBalancereturnBC` decimal(18,6) DEFAULT NULL,
  `CashRefund` decimal(18,6) DEFAULT NULL,
  `CashRefundBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceRefund` decimal(18,6) DEFAULT NULL,
  `BonusBalanceRefundBC` decimal(18,6) DEFAULT NULL,
  `TokenRefund` decimal(18,6) DEFAULT NULL,
  `TokenRefundBC` decimal(18,6) DEFAULT NULL,
  `CashOutStake` decimal(18,6) DEFAULT NULL,
  `CashOutStakeBC` decimal(18,6) DEFAULT NULL,
  `CashOutWin` decimal(18,6) DEFAULT NULL,
  `CashOutWinBC` decimal(18,6) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20)  DEFAULT NULL,
  `Operator` varchar(20)  DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\stg_settled_bets.csv' 
INTO TABLE  stg_settled_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

use romaniastg;
select 
  pb.BetslipId
, pb.BetslipStatus
, sb.BetId
, pb.BetType
, pb.BetTime
, pb.BetDate
, sb.SettleTime
, sb.SettledDate
, sb.BetStatus
, pb.ReferredYN
, sb.NumLeg
, sb.NumPart
, pb.LegSort
, sb.SelectionId
, sb.SelectionName
, sb.SelectionSort
, sb.MarketId
, sb.MarketName
, sb.MarketSort
, sb.EventId
, sb.EventName
, sb.EventStartTime
, sb.TypeId
, sb.TypeName
, sb.ClassId
, sb.ClassName
, sb.SportCode
, sb.SportName
, sb.DecreasingOdds
, pb.PlayerId
, sb.UserName
, sb.CurrencyCode
, sb.NumLines
, sb.NumLinesWin
, sb.NumLinesLose
, sb.NumLinesVoid
, pb.StakePerLine
, pb.StakePerLineBC
, (IF(sb.CashOutStake <> 0,0,pb.CashStakeAmt)+IF(sb.CashOutStake <> 0,0,pb.BonusStakeAmt)+IF(sb.CashOutStake <> 0,0,pb.BonusBalanceStake)+sb.CashOutStake) as TotalStakeAmt
, (IF(sb.CashOutStake <> 0,0,pb.CashStakeAmtBC)+IF(sb.CashOutStake <> 0,0,pb.BonusStakeAmtBC)+IF(sb.CashOutStake <> 0,0,pb.BonusBalanceStakeBC)+sb.CashOutStakeBC) as TotalStakeAmtBC
, (case when sb.CashOutStake <> 0 then 0 else pb.CashStakeAmt end) as CashStakeAmt
, (case when sb.CashOutStake <> 0 then 0 else pb.CashStakeAmtBC end) as CashStakeAmtBC
, (case when sb.CashOutStake <> 0 then 0 else pb.BonusStakeAmt end) as BonusStakeAmt
, (case when sb.CashOutStake <> 0 then 0 else pb.BonusStakeAmtBC end) as BonusStakeAmtBC
, (case when sb.CashOutStake <> 0 then 0 else pb.BonusBalanceStake end) as BonusBalanceStake
, (case when sb.CashOutStake <> 0 then 0 else pb.BonusBalanceStakeBC end) as BonusBalanceStakeBC
, sb.BonusId
, sb.CampaignId
, sb.TotalReturn
, sb.TotalReturnBC
, sb.CashReturn
, sb.CashReturnBC
, sb.BonusBalanceReturn
, sb.BonusBalancereturnBC
, sb.CashRefund
, sb.CashRefundBC
, sb.BonusBalanceRefund
, sb.BonusBalanceRefundBC
, sb.TokenRefund
, sb.TokenRefundBC
, sb.CashOutStake
, sb.CashOutStakeBC
, sb.CashOutWin
, sb.CashOutWinBC
, pb.LiveYN
, pb.OddsType
, pb.Odds
, pb.EitherwaySort
, sb.ViewId
, sb.Channel
, sb.Operator
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\fd_settled_bets.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from stg_settled_bets as sb
join romaniamain.fd_placed_bets as pb 
on sb.BetId = pb.BetId and sb.SelectionId = pb.SelectionId and sb.MarketId = pb.MarketId
;


#use romaniamain;
#drop table `fd_settled_bets`;
CREATE TABLE `fd_settled_bets` (
  `BetslipId` bigint(20) DEFAULT NULL,
  `BetslipStatus` varchar(10) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `BetTime` datetime DEFAULT NULL,
  `BetDate` date DEFAULT NULL,
  `SettleTime` datetime DEFAULT NULL,
  `SettledDate` date default null,
  `BetStatus` varchar(20)  DEFAULT NULL,
  `ReferredYN` varchar(10)  DEFAULT NULL,
  `NumLeg` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` int(11) default null,
  `SelectionId` bigint(20) DEFAULT NULL,
  `SelectionName` varchar(1000)  DEFAULT NULL,
  `SelectionSort` varchar(20)  DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000)  DEFAULT NULL,
  `MarketSort` varchar(20)  DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000)  DEFAULT NULL,
  `EventStartTime` datetime DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000)  DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000)  DEFAULT NULL,
  `SportCode` varchar(20)  DEFAULT NULL,
  `SportName` varchar(100)  DEFAULT NULL,
  `DecreasingOdds` decimal(18,6) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100)  DEFAULT NULL,
  `CurrencyCode` varchar(20)  DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `NumLinesWin` int(11) DEFAULT NULL,
  `NumLinesLose` int(11) DEFAULT NULL,
  `NumLinesVoid` int(11) DEFAULT NULL,
  `StakePerLine` decimal(18,6) DEFAULT NULL,
  `StakePerLineBC` decimal(18,6) DEFAULT NULL,
  `TotalStakeAmt` decimal(18,6) DEFAULT NULL,
  `TotalStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `CashStakeAmt` decimal(18,6) DEFAULT NULL,
  `CashStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `BonusId` bigint(20) DEFAULT NULL,
  `CampaignId` bigint(20) DEFAULT NULL,
  `TotalReturn` decimal(18,6) DEFAULT NULL,
  `TotalReturnBC` decimal(18,6) DEFAULT NULL,
  `CashReturn` decimal(18,6) DEFAULT NULL,
  `CashReturnBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceReturn` decimal(18,6) DEFAULT NULL,
  `BonusBalancereturnBC` decimal(18,6) DEFAULT NULL,
  `TotalRefund` decimal(18,6) DEFAULT NULL,
  `TotalRefundBC` decimal(18,6) DEFAULT NULL,
  `CashRefund` decimal(18,6) DEFAULT NULL,
  `CashRefundBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceRefund` decimal(18,6) DEFAULT NULL,
  `BonusBalanceRefundBC` decimal(18,6) DEFAULT NULL,
  `TokenRefund` decimal(18,6) DEFAULT NULL,
  `TokenRefundBC` decimal(18,6) DEFAULT NULL,
  `CashOutStake` decimal(18,6) DEFAULT NULL,
  `CashOutStakeBC` decimal(18,6) DEFAULT NULL,
  `CashOutWin` decimal(18,6) DEFAULT NULL,
  `CashOutWinBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(10) DEFAULT NULL,
  `OddsType` varchar(10)  DEFAULT NULL,
  `Odds` decimal(18,6) DEFAULT NULL,
  `EitherwaySort` varchar(10)  DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20)  DEFAULT NULL,
  `Operator` varchar(20)  DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

###################################################################### FD Fix #######################################################################################

select sb.*
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\fd_settled_bets_bkp.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from fd_settled_bets as sb;


select * from fd_settled_bets as sb where TotalReturn > 0 and CashReturn > 0 and TotalReturn <> CashReturn;

select
BetslipId
,BetslipStatus
,BetId
,BetType
,BetTime
,BetDate
,SettleTime
,SettledDate
,BetStatus
,ReferredYN
,NumLeg
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
,TypeId
,TypeName
,ClassId
,ClassName
,SportCode
,SportName
,DecreasingOdds
,PlayerId
,UserName
,CurrencyCode
,NumLines
,NumLinesWin
,NumLinesLose
,NumLinesVoid
,StakePerLine
,StakePerLineBC
,(CashStakeAmt+BonusStakeAmt+BonusBalanceStake+CashOutStake) as TotalStakeAmt
,(CashStakeAmtBC+BonusStakeAmtBC+BonusBalanceStakeBC+CashOutStakeBC) as TotalStakeAmtBC
,CashStakeAmt
,CashStakeAmtBC
,BonusStakeAmt
,BonusStakeAmtBC
,BonusBalanceStake
,BonusBalanceStakeBC
,BonusId
,CampaignId
,(CashReturn + CashOutWin + BonusBalanceReturn) as TotalReturn
,(CashReturnBC + CashOutWinBC + BonusBalancereturnBC) as TotalReturnBC
,CashReturn
,CashReturnBC
,BonusBalanceReturn
,BonusBalancereturnBC
,(CashRefund+BonusBalanceRefund+TokenRefund) as TotalRefund
,(CashRefundBC+BonusBalanceRefundBC+TokenRefundBC) as TotalRefund
,CashRefund
,CashRefundBC
,BonusBalanceRefund
,BonusBalanceRefundBC
,TokenRefund
,TokenRefundBC
,CashOutStake
,CashOutStakeBC
,CashOutWin
,CashOutWinBC
,LiveYN
,OddsType
,Odds
,EitherwaySort
,ViewId
,Channel
,Operator
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\fd_settled_bets_chg_hist.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from fd_settled_bets as sb;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\fd_settled_bets_chg_hist.csv' 
INTO TABLE  romaniamain.fd_settled_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select * from romaniamain.fd_settled_bets where TotalReturn > 0 and CashOutWin > 0 ;
select * from romaniamain.fd_settled_bets where BonusBalanceReturn > 0;

###################################################################### FD Fix #######################################################################################


use romaniastg;
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\fd_settled_bets.csv' 
INTO TABLE  romaniamain.fd_settled_bets
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select SettledDate, count(*) from romaniamain.fd_settled_bets group by 1 order by 1 desc;