#change dates 2016-01-10

use romaniamain;

select 
PlayerId as PlayerId,
UserName as UserName,
BetDate as SummaryDate,
Channel as Channel,
'Single' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
LiveYN as LiveYN,
SelectionId as SelectionId,
SelectionName as SelectionName,
MarketId as MarketId,
MarketName as MarketName,
EventId as EventId,
EventName as EventName,
TypeId as TypeId,
TypeName as TypeName,
ClassId as ClassId,
ClassName as ClassName,
SportName as Sport,
SUM(StakeAmt) as StakeAmt,
SUM(StakeAmtBC) as StakeAmtBC,
SUM(CashStakeAmt) as CashStakeAmt,
SUM(CashStakeAmtBC) as CashStakeAmtBC,
SUM(BonusStakeAmt) as BonusStakeAmt,
SUM(BonusStakeAmtBC) as BonusStakeAmtBC,
SUM(BonusBalanceStake) as BonusBalanceStake,
SUM(BonusBalanceStakeBC) as BonusBalanceStakeBC
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\fd_gv_placed_bets_simple_single.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from fd_placed_bets
where BetType = 'SGL' and BetDate = '2016-01-10'
group by 
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21;


select 
PlayerId as PlayerId,
UserName as UserName,
BetDate as SummaryDate,
Channel as Channel,
'Combi' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
'C' as LiveYN,
0 as SelectionId,
'Combi' as SelectionName,
0 as MarketId,
'Combi' as MarketName,
0 as EventId,
'Combi' as EventName,
0 as TypeId,
'Combi' as TypeName,
0 as ClassId,
'Combi' as ClassName,
'Combi' as Sport,
AVG(StakeAmt) as StakeAmt,
AVG(StakeAmtBC) as StakeAmtBC,
AVG(CashStakeAmt) as CashStakeAmt,
AVG(CashStakeAmtBC) as CashStakeAmtBC,
AVG(BonusStakeAmt) as BonusStakeAmt,
AVG(BonusStakeAmtBC) as BonusStakeAmtBC,
AVG(BonusBalanceStake) as BonusBalanceStake,
AVG(BonusBalanceStakeBC) as BonusBalanceStakeBC
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\fd_gv_placed_bets_simple_combi.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from fd_placed_bets
where BetType <> 'SGL' and BetDate = '2016-01-10'
group by 
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21;


#use romaniamain;
#drop table fd_gv_placed_bets_simple;
create table `fd_gv_placed_bets_simple` (
 PlayerId bigint(20) DEFAULT NULL
,UserName varchar(100) DEFAULT NULL
,SummaryDate date DEFAULT NULL
,Channel varchar(200) DEFAULT NULL
,BetClass varchar(20) DEFAULT NULL
,BetType varchar(20) DEFAULT NULL
,BetSlipId bigint(20) DEFAULT NULL
,BetId bigint(20) DEFAULT NULL
,BetSlipStatus varchar(5) DEFAULT NULL
,LiveYN varchar(5) DEFAULT NULL
,SelectionId bigint(20) DEFAULT NULL
,SelectionName varchar(200) DEFAULT NULL
,MarketId bigint(20) DEFAULT NULL
,MarketName varchar(200) DEFAULT NULL
,EventId bigint(20) DEFAULT NULL
,EventName varchar(200) DEFAULT NULL
,TypeId bigint(20) DEFAULT NULL
,TypeName varchar(200) DEFAULT NULL
,ClassId bigint(20) DEFAULT NULL
,ClassName varchar(200) DEFAULT NULL
,Sport varchar(200) DEFAULT NULL
,StakeAmt decimal(18,4) DEFAULT NULL
,StakeAmtBC decimal(18,4) DEFAULT NULL
,CashStakeAmt decimal(18,4) DEFAULT NULL
,CashStakeAmtBC decimal(18,4) DEFAULT NULL
,BonusStakeAmt decimal(18,4) DEFAULT NULL
,BonusStakeAmtBC decimal(18,4) DEFAULT NULL
,BonusBalanceStake decimal(18,4) DEFAULT NULL
,BonusBalanceStakeBC decimal(18,4) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;


LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\fd_gv_placed_bets_simple_single.csv'
INTO TABLE romaniamain.fd_gv_placed_bets_simple
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\fd_gv_placed_bets_simple_combi.csv'
INTO TABLE romaniamain.fd_gv_placed_bets_simple
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';



select SummaryDate, count(distinct PlayerId) from romaniamain.fd_gv_placed_bets_simple group by 1 order by 1 desc;

select 
PlayerId as PlayerId,
UserName as UserName,
SettledDate as SummaryDate,
Channel as Channel,
'Single' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
LiveYN as LiveYN,
SelectionId as SelectionId,
SelectionName as SelectionName,
MarketId as MarketId,
MarketName as MarketName,
EventId as EventId,
EventName as EventName,
TypeId as TypeId,
TypeName as TypeName,
ClassId as ClassId,
ClassName as ClassName,
SportName as Sport,
SUM(TotalStakeAmt) as TotalStakeAmt,
SUM(TotalStakeAmtBC) as TotalStakeAmtBC,
SUM(CashStakeAmt) as CashStakeAmt,
SUM(CashStakeAmtBC) as CashStakeAmtBC,
SUM(BonusStakeAmt) as BonusStakeAmt,
SUM(BonusStakeAmtBC) as BonusStakeAmtBC,
SUM(BonusBalanceStake) as BonusBalanceStake,
SUM(BonusBalanceStakeBC) as BonusBalanceStakeBC,
SUM(TotalReturn) as TotalReturn,
SUM(TotalReturnBC) as TotalReturnBC,
SUM(CashReturn) as CashReturn,
SUM(CashReturnBC) as CashReturnBC,
SUM(BonusBalanceReturn) as BonusBalanceReturn,
SUM(BonusBalancereturnBC) as BonusBalancereturnBC,
SUM(TotalRefund) as TotalRefund,
SUM(TotalRefundBC) as TotalRefundBC,
SUM(CashRefund) as CashRefund,
SUM(CashRefundBC) as CashRefundBC,
SUM(BonusBalanceRefund) as BonusBalanceRefund,
SUM(BonusBalanceRefundBC) as BonusBalanceRefundBC,
SUM(TokenRefund) as TokenRefund,
SUM(TokenRefundBC) as TokenRefundBC,
SUM(CashOutStake) as CashOutStake,
SUM(CashOutStakeBC) as CashOutStakeBC,
SUM(CashOutWin) as CashOutWin,
SUM(CashOutWinBC) as CashOutWinBC
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\fd_cv_settled_bets_simple_single.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from fd_settled_bets
where BetType = 'SGL' and SettledDate = '2016-01-10'
group by 
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21;

select 
PlayerId as PlayerId,
UserName as UserName,
SettledDate as SummaryDate,
Channel as Channel,
'Combi' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
'C' as LiveYN,
0 as SelectionId,
'Combi' as SelectionName,
0 as MarketId,
'Combi' as MarketName,
0 as EventId,
'Combi' as EventName,
0 as TypeId,
'Combi' as TypeName,
0 as ClassId,
'Combi' as ClassName,
'Combi' as Sport,
AVG(TotalStakeAmt) as TotalStakeAmt,
AVG(TotalStakeAmtBC) as TotalStakeAmtBC,
AVG(CashStakeAmt) as CashStakeAmt,
AVG(CashStakeAmtBC) as CashStakeAmtBC,
AVG(BonusStakeAmt) as BonusStakeAmt,
AVG(BonusStakeAmtBC) as BonusStakeAmtBC,
AVG(BonusBalanceStake) as BonusBalanceStake,
AVG(BonusBalanceStakeBC) as BonusBalanceStakeBC,
AVG(TotalReturn) as TotalReturn,
AVG(TotalReturnBC) as TotalReturnBC,
AVG(CashReturn) as CashReturn,
AVG(CashReturnBC) as CashReturnBC,
AVG(BonusBalanceReturn) as BonusBalanceReturn,
AVG(BonusBalancereturnBC) as BonusBalanceReturnBC,
AVG(TotalRefund) as TotalRefund,
AVG(TotalRefundBC) as TotalRefundBC,
AVG(CashRefund) as CashRefund,
AVG(CashRefundBC) as CashRefundBC,
AVG(BonusBalanceRefund) as BonusBalanceRefund,
AVG(BonusBalanceRefundBC) as BonusBalanceRefundBC,
AVG(TokenRefund) as TokenRefund,
AVG(TokenRefundBC) as TokenRefundBC,
AVG(CashOutStake) as CashOutStake,
AVG(CashOutStakeBC) as CashOutStakeBC,
AVG(CashOutWin) as CashOutWin,
AVG(CashOutWinBC) as CashOutWinBC
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\fd_cv_settled_bets_simple_combi.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from fd_settled_bets
where BetType <> 'SGL' and SettledDate = '2016-01-10'
group by 
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21;


#use romaniamain;
#drop table fd_cv_settled_bets_simple;
create table `fd_cv_settled_bets_simple` (
 PlayerId bigint(20) DEFAULT NULL
,UserName varchar(100) DEFAULT NULL
,SummaryDate date DEFAULT NULL
,Channel varchar(200) DEFAULT NULL
,BetClass varchar(20) DEFAULT NULL
,BetType varchar(20) DEFAULT NULL
,BetSlipId bigint(20) DEFAULT NULL
,BetId bigint(20) DEFAULT NULL
,BetSlipStatus varchar(5) DEFAULT NULL
,LiveYN varchar(5) DEFAULT NULL
,SelectionId bigint(20) DEFAULT NULL
,SelectionName varchar(200) DEFAULT NULL
,MarketId bigint(20) DEFAULT NULL
,MarketName varchar(200) DEFAULT NULL
,EventId bigint(20) DEFAULT NULL
,EventName varchar(200) DEFAULT NULL
,TypeId bigint(20) DEFAULT NULL
,TypeName varchar(200) DEFAULT NULL
,ClassId bigint(20) DEFAULT NULL
,ClassName varchar(200) DEFAULT NULL
,Sport varchar(200) DEFAULT NULL
,TotalStakeAmt decimal(18,4) DEFAULT NULL
,TotalStakeAmtBC decimal(18,4) DEFAULT NULL
,CashStakeAmt decimal(18,4) DEFAULT NULL
,CashStakeAmtBC decimal(18,4) DEFAULT NULL
,BonusStakeAmt decimal(18,4) DEFAULT NULL
,BonusStakeAmtBC decimal(18,4) DEFAULT NULL
,BonusBalanceStake decimal(18,4) DEFAULT NULL
,BonusBalanceStakeBC decimal(18,4) DEFAULT NULL
,TotalReturn decimal(18,4) DEFAULT NULL
,TotalReturnBC decimal(18,4) DEFAULT NULL
,CashReturn decimal(18,4) DEFAULT NULL
,CashReturnBC decimal(18,4) DEFAULT NULL
,BonusBalanceReturn decimal(18,4) DEFAULT NULL
,BonusBalancereturnBC decimal(18,4) DEFAULT NULL
,TotalRefund decimal(18,4) DEFAULT NULL
,TotalRefundBC decimal(18,4) DEFAULT NULL
,CashRefund decimal(18,4) DEFAULT NULL
,CashRefundBC decimal(18,4) DEFAULT NULL
,BonusBalanceRefund decimal(18,4) DEFAULT NULL
,BonusBalanceRefundBC decimal(18,4) DEFAULT NULL
,TokenRefund decimal(18,4) DEFAULT NULL
,TokenRefundBC decimal(18,4) DEFAULT NULL
,CashOutStake decimal(18,4) DEFAULT NULL
,CashOutStakeBC decimal(18,4) DEFAULT NULL
,CashOutWin decimal(18,4) DEFAULT NULL
,CashOutWinBC decimal(18,4) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;


LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\fd_cv_settled_bets_simple_single.csv'
INTO TABLE romaniamain.fd_cv_settled_bets_simple
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\fd_cv_settled_bets_simple_combi.csv'
INTO TABLE romaniamain.fd_cv_settled_bets_simple
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select SummaryDate, count(distinct PlayerId) from fd_cv_settled_bets_simple group by 1 order by 1 desc;

select 
PlayerId,
Username,
SummaryDate,
SUM(TotalStakeAmt) as TotalStakeAmt,
SUM(TotalStakeAmtBC) as TotalStakeAmtBC,
SUM(CashStakeAmt) as CashStakeAmt,
SUM(CashStakeAmtBC) as CashStakeAmtBC,
SUM(BonusStakeAmt) as BonusStakeAmt,
SUM(BonusStakeAmtBC) as BonusStakeAmtBC,
SUM(BonusBalanceStake) as BonusBalanceStake,
SUM(BonusBalanceStakeBC) as BonusBalanceStakeBC,
SUM(TotalReturn) as TotalReturn,
SUM(TotalReturnBC) as TotalReturnBC,
SUM(CashReturn) as CashReturn,
SUM(CashReturnBC) as CashReturnBC,
SUM(BonusBalanceReturn) as BonusBalanceReturn,
SUM(BonusBalancereturnBC) as BonusBalancereturnBC,
SUM(TotalRefund) as TotalRefund,
SUM(TotalRefundBC) as TotalRefundBC,
SUM(CashRefund) as CashRefund,
SUM(CashRefundBC) as CashRefundBC,
SUM(BonusBalanceRefund) as BonusBalanceRefund,
SUM(BonusBalanceRefundBC) as BonusBalanceRefundBC,
SUM(TokenRefund) as TokenRefund,
SUM(TokenRefundBC) as TokenRefundBC,
SUM(CashOutStake) as CashOutStake,
SUM(CashOutStakeBC) as CashOutStakeBC,
SUM(CashOutWin) as CashOutWin,
SUM(CashOutWinBC) as CashOutWinBC
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\sd_cv_sp_daily_player_summary.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from romaniamain.fd_cv_settled_bets_simple
where SummaryDate = '2016-01-10'
group by PlayerId,Username,SummaryDate;

#use romaniamain;
#drop table sd_cv_sp_daily_player_summary;
create table `sd_cv_sp_daily_player_summary` (
 PlayerId bigint(20) DEFAULT NULL
,UserName varchar(100) DEFAULT NULL
,SummaryDate date DEFAULT NULL
,StakeAmt decimal(18,4) DEFAULT NULL
,StakeAmtBC decimal(18,4) DEFAULT NULL
,CashStakeAmt decimal(18,4) DEFAULT NULL
,CashStakeAmtBC decimal(18,4) DEFAULT NULL
,BonusStakeAmt decimal(18,4) DEFAULT NULL
,BonusStakeAmtBC decimal(18,4) DEFAULT NULL
,BonusBalanceStake decimal(18,4) DEFAULT NULL
,BonusBalanceStakeBC decimal(18,4) DEFAULT NULL
,TotalReturn decimal(18,4) DEFAULT NULL
,TotalReturnBC decimal(18,4) DEFAULT NULL
,CashReturn decimal(18,4) DEFAULT NULL
,CashReturnBC decimal(18,4) DEFAULT NULL
,BonusBalanceReturn decimal(18,4) DEFAULT NULL
,BonusBalancereturnBC decimal(18,4) DEFAULT NULL
,TotalRefund decimal(18,4) DEFAULT NULL
,TotalRefundBC decimal(18,4) DEFAULT NULL
,CashRefund decimal(18,4) DEFAULT NULL
,CashRefundBC decimal(18,4) DEFAULT NULL
,BonusBalanceRefund decimal(18,4) DEFAULT NULL
,BonusBalanceRefundBC decimal(18,4) DEFAULT NULL
,TokenRefund decimal(18,4) DEFAULT NULL
,TokenRefundBC decimal(18,4) DEFAULT NULL
,CashOutStake decimal(18,4) DEFAULT NULL
,CashOutStakeBC decimal(18,4) DEFAULT NULL
,CashOutWin decimal(18,4) DEFAULT NULL
,CashOutWinBC decimal(18,4) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\sd_cv_sp_daily_player_summary.csv'
INTO TABLE romaniamain.sd_cv_sp_daily_player_summary
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


use romaniamain;
select temp.*
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\sd_cv_daily_player_summary.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from
(select
 spdps.PlayerId
,spdps.SummaryDate
,coalesce(spdps.StakeAmt,0)
,coalesce(spdps.StakeAmtBC,0)
,coalesce(spdps.CashStakeAmt,0)
,coalesce(spdps.CashStakeAmtBC,0)
,coalesce(spdps.BonusStakeAmt,0)
,coalesce(spdps.BonusStakeAmtBC,0)
,coalesce(spdps.BonusBalanceStake,0)
,coalesce(spdps.BonusBalanceStakeBC,0)
,coalesce(spdps.TotalReturn,0)
,coalesce(spdps.TotalReturnBC,0)
,coalesce(spdps.CashReturn,0)
,coalesce(spdps.CashReturnBC,0)
,coalesce(spdps.BonusBalanceReturn,0)
,coalesce(spdps.BonusBalancereturnBC,0)
,coalesce(spdps.TotalRefund,0)
,coalesce(spdps.TotalRefundBC,0)
,coalesce(spdps.CashRefund,0)
,coalesce(spdps.CashRefundBC,0)
,coalesce(spdps.BonusBalanceRefund,0)
,coalesce(spdps.BonusBalanceRefundBC,0)
,coalesce(spdps.TokenRefund,0)
,coalesce(spdps.TokenRefundBC,0)
,coalesce(spdps.CashOutStake,0)
,coalesce(spdps.CashOutStakeBC,0)
,coalesce(spdps.CashOutWin,0)
,coalesce(spdps.CashOutWinBC,0)
,coalesce(egdps.Bet,0)
,coalesce(egdps.CashBet,0)
,coalesce(egdps.BonusBet,0)
,coalesce(egdps.Win,0)
,coalesce(egdps.CashWin,0)
,coalesce(egdps.BonusWin,0)
,coalesce(egdps.BonusFreeGamesCount,0)
,coalesce(egdps.FreeGamesCount,0)
,coalesce(egdps.JackpotBet,0)
,coalesce(egdps.JackpotWin,0)
from romaniamain.sd_cv_sp_daily_player_summary as spdps
left outer join romaniamain.sd_eg_daily_player_summary as egdps
on spdps.PlayerId = egdps.PlayerId and spdps.SummaryDate = egdps.SummaryDate
where spdps.SummaryDate = '2016-01-10' 
UNION
select
 egdps.PlayerId
,egdps.SummaryDate
,coalesce(spdps.StakeAmt,0)
,coalesce(spdps.StakeAmtBC,0)
,coalesce(spdps.CashStakeAmt,0)
,coalesce(spdps.CashStakeAmtBC,0)
,coalesce(spdps.BonusStakeAmt,0)
,coalesce(spdps.BonusStakeAmtBC,0)
,coalesce(spdps.BonusBalanceStake,0)
,coalesce(spdps.BonusBalanceStakeBC,0)
,coalesce(spdps.TotalReturn,0)
,coalesce(spdps.TotalReturnBC,0)
,coalesce(spdps.CashReturn,0)
,coalesce(spdps.CashReturnBC,0)
,coalesce(spdps.BonusBalanceReturn,0)
,coalesce(spdps.BonusBalancereturnBC,0)
,coalesce(spdps.TotalRefund,0)
,coalesce(spdps.TotalRefundBC,0)
,coalesce(spdps.CashRefund,0)
,coalesce(spdps.CashRefundBC,0)
,coalesce(spdps.BonusBalanceRefund,0)
,coalesce(spdps.BonusBalanceRefundBC,0)
,coalesce(spdps.TokenRefund,0)
,coalesce(spdps.TokenRefundBC,0)
,coalesce(spdps.CashOutStake,0)
,coalesce(spdps.CashOutStakeBC,0)
,coalesce(spdps.CashOutWin,0)
,coalesce(spdps.CashOutWinBC,0)
,coalesce(egdps.Bet,0)
,coalesce(egdps.CashBet,0)
,coalesce(egdps.BonusBet,0)
,coalesce(egdps.Win,0)
,coalesce(egdps.CashWin,0)
,coalesce(egdps.BonusWin,0)
,coalesce(egdps.BonusFreeGamesCount,0)
,coalesce(egdps.FreeGamesCount,0)
,coalesce(egdps.JackpotBet,0)
,coalesce(egdps.JackpotWin,0)
from romaniamain.sd_cv_sp_daily_player_summary as spdps
right outer join romaniamain.sd_eg_daily_player_summary as egdps
on spdps.PlayerId = egdps.PlayerId and spdps.SummaryDate = egdps.SummaryDate
where egdps.SummaryDate = '2016-01-10' 
) as temp;


#use romaniamain;
#drop table sd_cv_daily_player_summary;
create table `sd_cv_daily_player_summary` ( 
 PlayerId bigint(20) DEFAULT NULL
,SummaryDate date DEFAULT NULL
,SPTotalStakeAmt decimal(18,4) DEFAULT NULL
,SPTotalStakeAmtBC decimal(18,4) DEFAULT NULL
,SPCashStakeAmt decimal(18,4) DEFAULT NULL
,SPCashStakeAmtBC decimal(18,4) DEFAULT NULL
,SPBonusStakeAmt decimal(18,4) DEFAULT NULL
,SPBonusStakeAmtBC decimal(18,4) DEFAULT NULL
,SPBonusBalanceStake decimal(18,4) DEFAULT NULL
,SPBonusBalanceStakeBC decimal(18,4) DEFAULT NULL
,SPTotalReturn decimal(18,4) DEFAULT NULL
,SPTotalReturnBC decimal(18,4) DEFAULT NULL
,SPCashReturn decimal(18,4) DEFAULT NULL
,SPCashReturnBC decimal(18,4) DEFAULT NULL
,SPBonusBalanceReturn decimal(18,4) DEFAULT NULL
,SPBonusBalancereturnBC decimal(18,4) DEFAULT NULL
,SPTotalRefund decimal(18,4) default null
,SPTotalRefundBC decimal(18,4) default null
,SPCashRefund decimal(18,4) DEFAULT NULL
,SPCashRefundBC decimal(18,4) DEFAULT NULL
,SPBonusBalanceRefund decimal(18,4) DEFAULT NULL
,SPBonusBalanceRefundBC decimal(18,4) DEFAULT NULL
,SPTokenRefund decimal(18,4) DEFAULT NULL
,SPTokenRefundBC decimal(18,4) DEFAULT NULL
,SPCashOutStake decimal(18,4) DEFAULT NULL
,SPCashOutStakeBC decimal(18,4) DEFAULT NULL
,SPCashOutWin decimal(18,4) DEFAULT NULL
,SPCashOutWinBC decimal(18,4) DEFAULT NULL
,EGBet decimal(18,4) DEFAULT NULL
,EGCashBet decimal(18,4) DEFAULT NULL
,EGBonusBet decimal(18,4) DEFAULT NULL
,EGWin decimal(18,4) DEFAULT NULL
,EGCashWin decimal(18,4) DEFAULT NULL
,EGBonusWin decimal(18,4) DEFAULT NULL
,EGBonusFreeGamesCount decimal(18,4) DEFAULT NULL
,EGFreeGamesCount decimal(18,4) DEFAULT NULL
,EGJackpotBet decimal(18,4) DEFAULT NULL
,EGJackpotWin decimal(18,4) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\SettledBets\\sd_cv_daily_player_summary.csv'
INTO TABLE romaniamain.sd_cv_daily_player_summary
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 
PlayerId,
Username,
SummaryDate,
SUM(StakeAmt) as StakeAmt,
SUM(StakeAmtBC) as StakeAmtBC,
SUM(CashStakeAmt) as CashStakeAmt,
SUM(CashStakeAmtBC) as CashStakeAmtBC,
SUM(BonusStakeAmt) as BonusStakeAmt,
SUM(BonusStakeAmtBC) as BonusStakeAmtBC,
SUM(BonusBalanceStake) as BonusBalanceStake,
SUM(BonusBalanceStakeBC) as BonusBalanceStakeBC
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\sd_gv_sp_daily_player_summary.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from romaniamain.fd_gv_placed_bets_simple
where SummaryDate = '2016-01-10'
group by PlayerId,Username,SummaryDate;


#use romaniamain;
#drop table sd_gv_sp_daily_player_summary;
create table `sd_gv_sp_daily_player_summary` (
 PlayerId bigint(20) DEFAULT NULL
,UserName varchar(100) DEFAULT NULL
,SummaryDate date DEFAULT NULL
,StakeAmt decimal(18,4) DEFAULT NULL
,StakeAmtBC decimal(18,4) DEFAULT NULL
,CashStakeAmt decimal(18,4) DEFAULT NULL
,CashStakeAmtBC decimal(18,4) DEFAULT NULL
,BonusStakeAmt decimal(18,4) DEFAULT NULL
,BonusStakeAmtBC decimal(18,4) DEFAULT NULL
,BonusBalanceStake decimal(18,4) DEFAULT NULL
,BonusBalanceStakeBC decimal(18,4) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\sd_gv_sp_daily_player_summary.csv'
INTO TABLE romaniamain.sd_gv_sp_daily_player_summary
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


use romaniamain;
select temp.*
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\sd_gv_daily_player_summary.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from
(select
 spdps.PlayerId
,spdps.SummaryDate
,coalesce(spdps.StakeAmt,0)
,coalesce(spdps.StakeAmtBC,0)
,coalesce(spdps.CashStakeAmt,0)
,coalesce(spdps.CashStakeAmtBC,0)
,coalesce(spdps.BonusStakeAmt,0)
,coalesce(spdps.BonusStakeAmtBC,0)
,coalesce(spdps.BonusBalanceStake,0)
,coalesce(spdps.BonusBalanceStakeBC,0)
,coalesce(egdps.Bet,0)
,coalesce(egdps.CashBet,0)
,coalesce(egdps.BonusBet,0)
,coalesce(egdps.Win,0)
,coalesce(egdps.CashWin,0)
,coalesce(egdps.BonusWin,0)
,coalesce(egdps.BonusFreeGamesCount,0)
,coalesce(egdps.FreeGamesCount,0)
,coalesce(egdps.JackpotBet,0)
,coalesce(egdps.JackpotWin,0)
from romaniamain.sd_gv_sp_daily_player_summary as spdps
left outer join romaniamain.sd_eg_daily_player_summary as egdps
on spdps.PlayerId = egdps.PlayerId and spdps.SummaryDate = egdps.SummaryDate
where spdps.SummaryDate = '2016-01-10'
UNION
select
 egdps.PlayerId
,egdps.SummaryDate
,coalesce(spdps.StakeAmt,0)
,coalesce(spdps.StakeAmtBC,0)
,coalesce(spdps.CashStakeAmt,0)
,coalesce(spdps.CashStakeAmtBC,0)
,coalesce(spdps.BonusStakeAmt,0)
,coalesce(spdps.BonusStakeAmtBC,0)
,coalesce(spdps.BonusBalanceStake,0)
,coalesce(spdps.BonusBalanceStakeBC,0)
,coalesce(egdps.Bet,0)
,coalesce(egdps.CashBet,0)
,coalesce(egdps.BonusBet,0)
,coalesce(egdps.Win,0)
,coalesce(egdps.CashWin,0)
,coalesce(egdps.BonusWin,0)
,coalesce(egdps.BonusFreeGamesCount,0)
,coalesce(egdps.FreeGamesCount,0)
,coalesce(egdps.JackpotBet,0)
,coalesce(egdps.JackpotWin,0)
from romaniamain.sd_gv_sp_daily_player_summary as spdps
right outer join romaniamain.sd_eg_daily_player_summary as egdps
on spdps.PlayerId = egdps.PlayerId and spdps.SummaryDate = egdps.SummaryDate
where egdps.SummaryDate = '2016-01-10'
) as temp;

#use romaniamain;
#drop table sd_gv_daily_player_summary;
create table `sd_gv_daily_player_summary` ( 
 PlayerId bigint(20) DEFAULT NULL
,SummaryDate date DEFAULT NULL
,SPStakeAmt decimal(18,4) DEFAULT NULL
,SPStakeAmtBC decimal(18,4) DEFAULT NULL
,SPCashStakeAmt decimal(18,4) DEFAULT NULL
,SPCashStakeAmtBC decimal(18,4) DEFAULT NULL
,SPBonusStakeAmt decimal(18,4) DEFAULT NULL
,SPBonusStakeAmtBC decimal(18,4) DEFAULT NULL
,SPBonusBalanceStake decimal(18,4) DEFAULT NULL
,SPBonusBalanceStakeBC decimal(18,4) DEFAULT NULL
,EGBet decimal(18,4) DEFAULT NULL
,EGCashBet decimal(18,4) DEFAULT NULL
,EGBonusBet decimal(18,4) DEFAULT NULL
,EGWin decimal(18,4) DEFAULT NULL
,EGCashWin decimal(18,4) DEFAULT NULL
,EGBonusWin decimal(18,4) DEFAULT NULL
,EGBonusFreeGamesCount decimal(18,4) DEFAULT NULL
,EGFreeGamesCount decimal(18,4) DEFAULT NULL
,EGJackpotBet decimal(18,4) DEFAULT NULL
,EGJackpotWin decimal(18,4) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\PlacedBets\\sd_gv_daily_player_summary.csv'
INTO TABLE romaniamain.sd_gv_daily_player_summary
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';
