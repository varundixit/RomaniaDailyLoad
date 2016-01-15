#IB Load into Main Tables

#####Exchange Rates
Load data infile 'D:\\RomData\\dump\\DD_Exchange_Rate.csv'
into table romaniamain.DD_Exchange_Rate
fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

#######IB_LoadSequence_Main

###IB_Balance_Load.sql
Load data infile 'D:\\RomData\\dump\\STG_DAILY_PLAYER_BALANCE.csv'
into table romaniamain.FD_DAILY_PLAYER_BALANCE
fields terminated by ',' OPTIONALLY enclosed by '"' lines terminated by '\r\n';

###IB_Payments_load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\sd_daily_cashier_summary.csv'  
INTO TABLE romaniamain.sd_daily_cashier_summary 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Games_load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM.csv' 
INTO TABLE romaniamain.FD_EXD_EG_PLAYER_PRODUCT_INFO_SUMM
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Games_Load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM.csv' 
INTO TABLE romaniamain.FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
PlayerId,
SummaryDate,
CurrencyCode,
SUM(Bet),
SUM(CashBet),
SUM(BonusBet),
SUM(Win),
SUM(CashWin),
SUM(BonusWin),
SUM(BonusFreeGamesCount),
SUM(FreeGamesCount),
SUM(JackpotBet),
SUM(JackpotWin)
from romaniamain.FD_CSC_EG_PLAYER_PRODUCT_INFO_SUMM
where SummaryDate = date(date_add(Current_Date, interval -1 day))
group by PlayerId,SummaryDate,CurrencyCode
INTO OUTFILE 'D:\\RomData\\dump\\sd_cv_eg_daily_player_summary.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select
 PlayerId
,SummaryDate
,GameDate
,coalesce(Bet,0)
,coalesce(CashBet,0)
,coalesce(BonusBet,0)
,coalesce(Win,0)
,coalesce(CashWin,0)
,coalesce(BonusWin,0)
,coalesce(BonusFreeGamesCount,0)
,coalesce(FreeGamesCount,0)
,coalesce(JackpotBet,0)
,coalesce(JackpotWin,0)
,ClientPlatform
,ClientType
,CasinoType
,GameType
,GameName
,RomDummy 
from  romaniamain.fd_csc_eg_player_product_info_summ 
where SummaryDate = date(date_add(Current_Date, interval -1 day))
INTO OUTFILE 'D:\\RomData\\dump\\mysql_fd_csc_eg_player_product_info_summ.csv' 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ;

LOAD DATA INFILE 'D:\\RomData\\dump\\sd_cv_eg_daily_player_summary.csv' 
INTO TABLE romaniamain.sd_eg_daily_player_summary
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Placed_Bets_Load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\stg_placed_bets.csv' 
INTO TABLE  romaniamain.fd_placed_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Settled_Bets_Load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\fd_settled_bets.csv' 
INTO TABLE  romaniamain.fd_settled_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Rejected_Bets_Load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\fd_rejected_bets.csv' 
INTO TABLE  romaniamain.fd_rejected_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Voided_Bets_Load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\fd_voided_bets.csv' 
INTO TABLE  romaniamain.fd_voided_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

###IB_Open_Bets_Load.sql
LOAD DATA INFILE 'D:\\RomData\\dump\\fd_open_bets.csv' 
INTO TABLE romaniamain.fd_open_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


###IB_Temp_DPS.sql#############################################################################################
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
INTO OUTFILE 'D:\\RomData\\dump\\fd_gv_placed_bets_simple_single.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from fd_placed_bets
where BetType = 'SGL' and BetDate = date_add(current_Date, interval -1 day)
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21;


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
from fd_placed_bets
where BetType <> 'SGL' and BetDate = date_add(current_Date, interval -1 day)
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
INTO OUTFILE 'D:\\RomData\\dump\\fd_gv_placed_bets_simple_combi.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


LOAD DATA INFILE 'D:\\RomData\\dump\\fd_gv_placed_bets_simple_single.csv'
INTO TABLE romaniamain.fd_gv_placed_bets_simple
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'D:\\RomData\\dump\\fd_gv_placed_bets_simple_combi.csv'
INTO TABLE romaniamain.fd_gv_placed_bets_simple
FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

#select SummaryDate, count(distinct PlayerId) from romaniamain.fd_gv_placed_bets_simple group by 1 order by 1 desc;

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
from fd_settled_bets
where BetType = 'SGL' and SettledDate = date_add(current_Date, interval -1 day)
group by 
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
INTO OUTFILE 'D:\\RomData\\dump\\fd_cv_settled_bets_simple_single.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

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
from fd_settled_bets
where BetType <> 'SGL' and SettledDate = date_add(current_Date, interval -1 day)
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
INTO OUTFILE 'D:\\RomData\\dump\\fd_cv_settled_bets_simple_combi.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'D:\\RomData\\dump\\fd_cv_settled_bets_simple_single.csv'
INTO TABLE romaniamain.fd_cv_settled_bets_simple
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'D:\\RomData\\dump\\fd_cv_settled_bets_simple_combi.csv'
INTO TABLE romaniamain.fd_cv_settled_bets_simple
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

#select SummaryDate, count(distinct PlayerId) from fd_cv_settled_bets_simple group by 1 order by 1 desc;

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
from romaniamain.fd_cv_settled_bets_simple
where SummaryDate = date_add(current_Date, interval -1 day)
group by PlayerId,Username,SummaryDate
INTO OUTFILE 'D:\\RomData\\dump\\sd_cv_sp_daily_player_summary.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'D:\\RomData\\dump\\sd_cv_sp_daily_player_summary.csv'
INTO TABLE romaniamain.sd_cv_sp_daily_player_summary
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


use romaniamain;
select temp.* from
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
where spdps.SummaryDate = date_add(current_Date, interval -1 day)
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
where egdps.SummaryDate = date_add(current_Date, interval -1 day) 
) as temp
INTO OUTFILE 'D:\\RomData\\dump\\sd_cv_daily_player_summary.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


LOAD DATA INFILE 'D:\\RomData\\dump\\sd_cv_daily_player_summary.csv'
INTO TABLE romaniamain.sd_cv_daily_player_summary
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

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
from romaniamain.fd_gv_placed_bets_simple
where SummaryDate = date_add(current_Date, interval -1 day)
group by PlayerId,Username,SummaryDate
INTO OUTFILE 'D:\\RomData\\dump\\sd_gv_sp_daily_player_summary.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


/*
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
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;*/

LOAD DATA INFILE 'D:\\RomData\\dump\\sd_gv_sp_daily_player_summary.csv'
INTO TABLE romaniamain.sd_gv_sp_daily_player_summary
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


use romaniamain;
select temp.*
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
where spdps.SummaryDate = date_add(current_Date, interval -1 day)
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
where egdps.SummaryDate = date_add(current_Date, interval -1 day)
) as temp
INTO OUTFILE 'D:\\RomData\\dump\\sd_gv_daily_player_summary.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'D:\\RomData\\dump\\sd_gv_daily_player_summary.csv'
INTO TABLE romaniamain.sd_gv_daily_player_summary
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

####IB_Daily_Sumary_Merged.sql##################################################################################################
##################################################### DayLevelSummary.csv ######################################################

select 	'SummaryDate','FirstTimeDepositors','UniqueSignUps','TotalDepAttemptAmt','TotalDepAttemptCnt','TotalDepDeclineAmt',
		'TotalDepDeclineCnt','TotalDepApproveAmt','TotalDepApproveCnt','TotalUniqueAttemptDepositors',
		'TotalUniqueDeclinedDepositors','TotalUniqueApprovedDepositors','TotalWithdAttemptAmt','TotalWithdAttemptCnt',
		'TotalWithdDeclineAmt','TotalWithdDeclineCnt','TotalWithdApproveAmt','TotalWithdApproveCnt','TotalUniqueAttempWithdrawers',
		'TotalUniqueDeclinedWithdrawers','TotalUniqueApprovedWithdrawers','TotalStakeAmt','TotalCashStakeAmt','TotalBonusStakeAmt',
		'TotalReturnAmt','TotalCashReturnAmt','GrossWinAmt','NetGrossWinAmt','TotalBonusCost','NetGamingRevenue','SPTotalStakeAmt',
		'SPCashStakeAmt','SPBonusStakeAmt','SPBonusBalanceStake','SPTotalReturnAmt','SPCashReturnAmt','SPBonusBalanceReturnAmt',
		'SPTotalRefundAmt','SPCashRefundAmt','SPBonusBalanceRefundAmt','SPTokenRefundAmt','SPCashOutStakeAmt','SPCashOutWinAmt',
		'SPGrossWinAmt','SPNetGrossWinAmt','SPBonusCost','SPNetGamingRevenue','EGTotalStakeAmt','EGCashStakeAmt','EGBonusStakeAmt',
		'EGTotalReturnAmt','EGCashReturnAmt','EGBonusReturnAmt','EGBonusFreeGamesCount','EGFreeGamesCount','EGJackpotStakeAmt',
		'EGJackpotReturnAmt','EGGrossWinAmt','EGNetGrossWinAmt','EGamingBonusCost','EGNetGamingRevenue','SystemAPD','SportsAPD',
		'EGamingAPD','CumulativeSystemUAP','CumulativeSportsUAP','CumulativeEGamingUAP','TotalBalance','TotalBonusBalance'
INTO OUTFILE 'D:\\RomData\\dump\\DayLevelSummaryHeader.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
  cal.calendar_date as SummaryDate
, FTD.FirstTimeDepositors as FirstTimeDepositors
, SignUp.UniqueSignUps as UniqueSignUps
, Cashier.TotalDepAttemptAmt
, Cashier.TotalDepAttemptCnt
, Cashier.TotalDepDeclineAmt
, Cashier.TotalDepDeclineCnt
, Cashier.TotalDepApproveAmt
, Cashier.TotalDepApproveCnt
, Cashier.TotalUniqueAttemptDepositors
, Cashier.TotalUniqueDeclinedDepositors
, Cashier.TotalUniqueApprovedDepositors
, Cashier.TotalWithdAttemptAmt
, Cashier.TotalWithdAttemptCnt
, Cashier.TotalWithdDeclineAmt
, Cashier.TotalWithdDeclineCnt
, Cashier.TotalWithdApproveAmt
, Cashier.TotalWithdApproveCnt
, Cashier.TotalUniqueAttempWithdrawers
, Cashier.TotalUniqueDeclinedWithdrawers
, Cashier.TotalUniqueApprovedWithdrawers
, CashView.TotalStakeAmt
, CashView.TotalCashStakeAmt
, CashView.TotalBonusStakeAmt
, CashView.TotalReturnAmt
, CashView.TotalCashReturnAmt
, ((CashView.SPTotalStakeAmt - CashView.SPTotalReturnAmt) + (CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotStakeAmt))) as GrossWinAmt
, (((CashView.SPTotalStakeAmt - CashView.SPTotalReturnAmt) + (CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotStakeAmt)))*0.84) as NetGrossWinAmt
, (CashView.TotalBonusStakeAmt - (CashView.TotalReturnAmt - CashView.TotalCashReturnAmt)) as TotalBonusCost
, ((((CashView.SPTotalStakeAmt - CashView.SPTotalReturnAmt) + (CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotStakeAmt)))*0.84) - (CashView.TotalBonusStakeAmt - (CashView.TotalReturnAmt - CashView.TotalCashReturnAmt))) as NetGamingRevenue
, CashView.SPTotalStakeAmt
, CashView.SPCashStakeAmt
, CashView.SPBonusStakeAmt
, CashView.SPBonusBalanceStake
, CashView.SPTotalReturnAmt
, CashView.SPCashReturnAmt
, CashView.SPBonusBalanceReturnAmt
, CashView.SPTotalRefundAmt
, CashView.SPCashRefundAmt
, CashView.SPBonusBalanceRefundAmt
, CashView.SPTokenRefundAmt
, CashView.SPCashOutStakeAmt
, CashView.SPCashOutWinAmt
, (CashView.SPTotalStakeAmt - CashView.SPTotalReturnAmt) as SPGrossWinAmt
, ((CashView.SPTotalStakeAmt - CashView.SPTotalReturnAmt)*0.84) as SPNetGrossWinAmt
, (CashView.SPBonusStakeAmt - (CashView.SPTotalReturnAmt - CashView.SPCashReturnAmt)) as SPBonusCost
, (((CashView.SPTotalStakeAmt - CashView.SPTotalReturnAmt)*0.84) - (CashView.SPBonusStakeAmt - (CashView.SPTotalReturnAmt - CashView.SPCashReturnAmt))) as SPNetGamingRevenue
, CashView.EGTotalStakeAmt 
, CashView.EGCashStakeAmt
, CashView.EGBonusStakeAmt
, CashView.EGTotalReturnAmt
, CashView.EGCashReturnAmt
, CashView.EGBonusReturnAmt
, CashView.EGBonusFreeGamesCount
, CashView.EGFreeGamesCount
, CashView.EGJackpotStakeAmt
, CashView.EGJackpotReturnAmt
, (CashView.EGTotalStakeAmt - (CashView.EGTotalReturnAmt + CashView.EGJackpotStakeAmt)) as EGGrossWinAmt
, ((CashView.EGTotalStakeAmt - CashView.EGTotalReturnAmt)*0.84) as EGNetGrossWinAmt
, (CashView.EGBonusStakeAmt - CashView.EGBonusReturnAmt) as EGamingBonusCost
, (((CashView.EGTotalStakeAmt - CashView.EGTotalReturnAmt)*0.84) - (CashView.EGBonusStakeAmt - CashView.EGBonusReturnAmt)) as EGNetGamingRevenue
, GameView.SystemAPD
, GameView.SportsAPD
, GameView.EGamingAPD
, Cumulative.CumulativeSystemUAP
, Cumulative.CumulativeSportsUAP
, Cumulative.CumulativeEGamingUAP
, Balance.TotalBalance
, Balance.TotalBonusBalance
from 
romaniamain.dim_calendar as cal
left outer join 
(select 
cal.calendar_date as SummaryDate,
count(distinct PlayerId) as FirstTimeDepositors
from romaniamain.dim_calendar as cal
left outer join romaniamain.dim_player as p on cal.calendar_date = date(p.GlobalFirstDepositDate)
where cal.calendar_date >= '2015-11-26' and cal.calendar_date <= date_add(current_Date, interval -1 day)
group by 1
) as FTD on cal.calendar_date = FTD.SummaryDate
left outer join 
(select 
cal.calendar_date as SummaryDate,
count(distinct PlayerId) as UniqueSignUps
from romaniamain.dim_calendar as cal
left outer join romaniamain.dim_player as p on cal.calendar_date = date(p.SignupDate)
where cal.calendar_date >= '2015-11-26' and cal.calendar_date <= date_add(current_Date, interval -1 day)
group by 1
) as SignUp on cal.calendar_date = SignUp.SummaryDate
left outer join 
(select
dcs.SummaryDate,
SUM(dcs.TotalDepAttemptAmt) as TotalDepAttemptAmt,
SUM(dcs.TotalDepAttemptCnt) as TotalDepAttemptCnt,
SUM(dcs.TotalDepDeclineAmt) as TotalDepDeclineAmt,
SUM(dcs.TotalDepDeclineCnt) as TotalDepDeclineCnt,
SUM(dcs.TotalDepApproveAmt) as TotalDepApproveAmt,
SUM(dcs.TotalDepApproveCnt) as TotalDepApproveCnt,
COUNT(distinct case when dcs.TotalDepAttemptAmt > 0 then dcs.PlayerId end) as TotalUniqueAttemptDepositors,
COUNT(distinct case when dcs.TotalDepDeclineAmt > 0 then dcs.PlayerId end) as TotalUniqueDeclinedDepositors,
COUNT(distinct case when dcs.TotalDepApproveAmt > 0 then dcs.PlayerId end) as TotalUniqueApprovedDepositors,
SUM(dcs.TotalWithdAttemptAmt) as TotalWithdAttemptAmt,
SUM(dcs.TotalWithdAttemptCnt) as TotalWithdAttemptCnt,
SUM(dcs.TotalWithdDeclineAmt) as TotalWithdDeclineAmt,
SUM(dcs.TotalWithdDeclineCnt) as TotalWithdDeclineCnt,
SUM(dcs.TotalWithdApproveAmt) as TotalWithdApproveAmt,
SUM(dcs.TotalWithdApproveCnt) as TotalWithdApproveCnt,
COUNT(distinct case when dcs.TotalWithdAttemptAmt > 0 then dcs.PlayerId end) as TotalUniqueAttempWithdrawers,
COUNT(distinct case when dcs.TotalWithdDeclineAmt > 0 then dcs.PlayerId end) as TotalUniqueDeclinedWithdrawers,
COUNT(distinct case when dcs.TotalWithdApproveAmt > 0 then dcs.PlayerId end) as TotalUniqueApprovedWithdrawers
from romaniamain.sd_daily_cashier_summary AS dcs
join romaniamain.dim_player as p ON dcs.PlayerId = p.PlayerId
where p.SignupDate >= '2015-11-26'
group by
SummaryDate) as Cashier on cal.calendar_date = Cashier.SummaryDate
left outer join 
(
SELECT 
 dps.SummaryDate
,COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.PlayerId end) as SystemAPD
,COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.PlayerId end) as SportsAPD
,COUNT(distinct case when (dps.EGBet) > 0 then dps.PlayerId end) as EGamingAPD
FROM 
romaniamain.sd_gv_daily_player_summary as dps
join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId
where p.SignupDate >= '2015-11-26'
group by SummaryDate
) as GameView  on cal.calendar_date = GameView.SummaryDate
left outer join
(SELECT 
 dps.SummaryDate
,SUM(dps.SPTotalStakeAmt+dps.EGBet) as TotalStakeAmt
,SUM(dps.SPCashStakeAmt+dps.EGCashBet) as TotalCashStakeAmt
,SUM(dps.SPBonusStakeAmt+dps.EGBonusBet) as TotalBonusStakeAmt
,SUM(dps.SPTotalReturn+dps.EGWin) as TotalReturnAmt
,SUM(dps.SPCashReturn+dps.EGCashWin) as TotalCashReturnAmt
,SUM(dps.SPTotalStakeAmt) as SPTotalStakeAmt
,SUM(dps.SPCashStakeAmt) as SPCashStakeAmt
,SUM(dps.SPBonusStakeAmt) as SPBonusStakeAmt
,SUM(dps.SPBonusBalanceStake) as SPBonusBalanceStake
,SUM(dps.SPTotalReturn) as SPTotalReturnAmt
,SUM(dps.SPCashReturn) as SPCashReturnAmt
,SUM(dps.SPBonusBalanceReturn) as SPBonusBalanceReturnAmt
,SUM(dps.SPTotalRefund) as SPTotalRefundAmt
,SUM(dps.SPCashRefund) as SPCashRefundAmt
,SUM(dps.SPBonusBalanceRefund) as SPBonusBalanceRefundAmt
,SUM(dps.SPTokenRefund) as SPTokenRefundAmt
,SUM(dps.SPCashOutStake) as SPCashOutStakeAmt
,SUM(dps.SPCashOutWin) as SPCashOutWinAmt
,SUM(dps.EGBet) as EGTotalStakeAmt
,SUM(dps.EGCashBet) as EGCashStakeAmt
,SUM(dps.EGBonusBet) as EGBonusStakeAmt
,SUM(dps.EGWin) as EGTotalReturnAmt
,SUM(dps.EGCashWin) as EGCashReturnAmt
,SUM(dps.EGBonusWin) as EGBonusReturnAmt
,SUM(dps.EGBonusFreeGamesCount) as EGBonusFreeGamesCount
,SUM(dps.EGFreeGamesCount) as EGFreeGamesCount
,SUM(dps.EGJackpotBet) as EGJackpotStakeAmt
,SUM(dps.EGJackpotWin) as EGJackpotReturnAmt
FROM 
romaniamain.sd_cv_daily_player_summary as dps
join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId
where p.SignupDate >= '2015-11-26'
group by SummaryDate
) as CashView  on cal.calendar_date = CashView.SummaryDate
left outer join
(
SELECT 
 cal.calendar_date as SummaryDate
,COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.PlayerId end) as CumulativeSystemUAP
,COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.PlayerId end) as CumulativeSportsUAP
,COUNT(distinct case when (dps.EGBet) > 0 then dps.PlayerId end) as CumulativeEGamingUAP
FROM 
romaniamain.dim_calendar as cal
left outer join romaniamain.sd_gv_daily_player_summary as dps on dps.SummaryDate <= cal.calendar_date 
and cal.calendar_date >= '2015-11-26' and cal.calendar_date <= date_add(current_Date, interval -1 day) 
and dps.SummaryDate >= '2015-11-26'
left outer join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId
where p.SignupDate >= '2015-11-26'
group by cal.calendar_date
) as Cumulative on cal.calendar_date = Cumulative.SummaryDate
left outer join
(
select 
SummaryDate, 
SUM(Balance) as TotalBalance, 
SUM(BonusBalance) as TotalBonusBalance,  
count(distinct PlayerId) 
from romaniamain.FD_DAILY_PLAYER_BALANCE
where SignupDate >= '2015-11-26'
group by SummaryDate
) as Balance on cal.calendar_date = Balance.SummaryDate
where 
cal.calendar_date >= '2015-11-26' and cal.calendar_date <= date_add(current_Date, interval -1 day)
INTO OUTFILE 'D:\\RomData\\dump\\DayLevelSummary.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';



####IB_Load_MySQL_Sports_Daily_GV_FL.sql#########################################################################

use romaniamain;

select 
PlayerId as PlayerId,
BetTime as BetTime,
Channel as Channel,
'Combi' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
'C' as LiveYN,
'Combi' as SelectionName,
'Combi' as MarketName,
'Combi' as EventName,
'Combi' as TypeName,
'Combi' as ClassName,
'Combi' as Sport,
'C' as Odds,
coalesce(AVG(StakeAmt),0) as StakeAmt,
coalesce(AVG(CashStakeAmt),0) as CashStakeAmt,
coalesce(AVG(BonusStakeAmt),0) as BonusStakeAmt,
coalesce(AVG(BonusBalanceStake),0) as BonusBalanceStake
from fd_placed_bets
where BetType <> 'SGL' and BetDate = date_add(current_Date, interval -1 day)
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\mysql_fd_gv_placed_bets_simple_combi.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
PlayerId as PlayerId,
BetTime as BetTime,
Channel as Channel,
'Single' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
LiveYN as LiveYN,
SelectionName as SelectionName,
MarketName as MarketName,
EventName as EventName,
TypeName as TypeName,
ClassName as ClassName,
SportName as Sport,
Odds as Odds,
coalesce(StakeAmt,0) as StakeAmt,
coalesce(CashStakeAmt,0) as CashStakeAmt,
coalesce(BonusStakeAmt,0) as BonusStakeAmt,
coalesce(BonusBalanceStake,0) as BonusBalanceStake
from fd_placed_bets
where BetType = 'SGL' and BetDate = date_add(current_Date, interval -1 day)
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\mysql_fd_gv_placed_bets_simple_sgl.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
PlayerId as PlayerId,
BetTime as BetTime,
Channel as Channel,
'Combi' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
'C' as LiveYN,
'Combi' as SelectionName,
'Combi' as MarketName,
'Combi' as EventName,
'Combi' as TypeName,
'Combi' as ClassName,
'Combi' as Sport,
'C' as Odds,
coalesce(AVG(TotalStakeAmt),0) as StakeAmt,
coalesce(AVG(CashStakeAmt),0) as CashStakeAmt,
coalesce(AVG(BonusStakeAmt),0) as BonusStakeAmt,
coalesce(AVG(BonusBalanceStake),0) as BonusBalanceStake,
coalesce(AVG(TotalReturn),0) as TotalReturn,
coalesce(AVG(CashReturn),0) as CashReturn,
coalesce(AVG(BonusBalanceReturn),0) as BonusBalanceReturn,
coalesce(AVG(CashRefund),0) as CashRefund,
coalesce(AVG(BonusBalanceRefund),0) as BonusBalanceRefund,
coalesce(AVG(TokenRefund),0) as TokenRefund,
coalesce(AVG(CashOutStake),0) as CashOutStake,
coalesce(AVG(CashOutWin),0) as CashOutWin
from fd_settled_bets
where BetType <> 'SGL' and SettledDate = date_add(current_Date, interval -1 day)
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\mysql_fd_cv_placed_bets_simple_combi.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
PlayerId as PlayerId,
BetTime as BetTime,
Channel as Channel,
'Single' as BetClass,
BetType as BetType,
BetslipId as BetslipId,
BetId as BetId,
BetslipStatus as BetSlipStatus,
LiveYN as LiveYN,
SelectionName as SelectionName,
MarketName as MarketName,
EventName as EventName,
TypeName as TypeName,
ClassName as ClassName,
SportName as Sport,
Odds as Odds,
coalesce(TotalStakeAmt,0) as StakeAmt,
coalesce(CashStakeAmt,0) as CashStakeAmt,
coalesce(BonusStakeAmt,0) as BonusStakeAmt,
coalesce(BonusBalanceStake,0) as BonusBalanceStake,
coalesce(TotalReturn,0) as TotalReturn,
coalesce(CashReturn,0) as CashReturn,
coalesce(BonusBalanceReturn,0) as BonusBalanceReturn,
coalesce(CashRefund,0) as CashRefund,
coalesce(BonusBalanceRefund,0) as BonusBalanceRefund,
coalesce(TokenRefund,0) as TokenRefund,
coalesce(CashOutStake,0) as CashOutStake,
coalesce(CashOutWin,0) as CashOutWin
from fd_settled_bets
where BetType = 'SGL' and SettledDate = date_add(current_Date, interval -1 day)
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\mysql_fd_cv_placed_bets_simple_sgl.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


select 
PlayerID,
trim(Username),
trim(Gender),
coalesce(Balance,0),
case when GlobalFirstDepositDate is null then '3000-01-01 00:00:00' else GlobalFirstDepositDate end,
case when SignupDate is null then '3000-01-01 00:00:00' else SignupDate end,
1
from dim_player
where PlayerID is not null
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\mysql_dim_player.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';


SELECT 
 dps.PlayerID
,coalesce(COUNT(distinct case when (dps.SPStakeAmt+dps.EGBet) > 0 then dps.SummaryDate end),0) as SystemAPD
,coalesce(COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.SummaryDate end),0) as SportsAPD
,coalesce(COUNT(distinct case when (dps.EGBet) > 0 then dps.SummaryDate end),0) as EGamingAPD
FROM 
romaniamain.sd_gv_daily_player_summary as dps
join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId
where dps.SummaryDate = date_add(current_Date, interval -1 day)
group by dps.PlayerID
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\PlayerAPD_Daily.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
p.PlayerId,
coalesce(sports.SportsBetCount,0),
coalesce(eg.EgBetCount,0)
from 
romaniamain.dim_player as p
left outer join
(select PlayerId, count(BetSlipId) as SportsBetCount from romaniamain.fd_cv_settled_bets_simple where SummaryDate = date_add(current_Date, interval -1 day) group by 1) as sports
on p.PlayerId = sports.PlayerId
left outer join
(select PlayerId, count(Bet) as EgBetCount from romaniamain.fd_csc_eg_player_product_info_summ where SummaryDate = date_add(current_Date, interval -1 day) group by 1) as eg
on p.PlayerId = eg.PlayerId
where p.PlayerId is not null and (sports.SportsBetCount > 0 OR eg.EgBetCount > 0)
group by p.PlayerId
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\PlayerBetCounts_Daily.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


select
PlayerId, CAST(coalesce(SUM(egPoints),0.0) as decimal(18,6)) as TotalEgPoints
from ( select eg.PlayerId,IF((eg.Bet*egm.Margins) > eg.Bet,eg.Bet,(eg.Bet*egm.Margins)) as egPoints
from romaniamain.fd_csc_eg_player_product_info_summ as eg
join (select CasinoType, (TotalGrossProfit/TotalBet) as Margins
from ( select CasinoType,SUM(Bet) as TotalBet,SUM(Win) as TotalWin,SUM(Bet-Win) as TotalGrossProfit
from romaniamain.fd_csc_eg_player_product_info_summ
group by 1) as temp) as egm on eg.CasinoType = egm.CasinoType) as EgPoints
group by 1
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\TotalEGPoints.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';



###IB_PlayerPreferences.sql##########################################################################################
use romaniamain;
select PlayerId, SportName,ClassName,SelectionName, count(*) as BetCount from romaniamain.fd_placed_bets group by 1,2,3,4 order by PlayerId,  count(*) desc
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\PlayerPrefSports.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select PlayerId, CasinoType, GameType, sum(bet) from romaniamain.fd_csc_eg_player_product_info_summ group by PlayerId,CasinoType,GameType order by PlayerId, sum(bet) desc
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\PlayerPrefCasino.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select
PlayerId,
case when temp.SPInternetBetCnt = (SPTotalBetCnt/2) then 'Hybrid'
        when temp.SPInternetBetCnt > (SPTotalBetCnt/2) then 'Internet'
else 'Mobile' end as ChannelPreference
from
(
select 
PlayerId, 
count(case when Channel = 'FTNWEB' then 1 end) as SPInternetBetCnt,
count(case when Channel = 'FTNMOB' then 1 end) as SPMobileBetCnt,
count(*) as SPTotalBetCnt
from romaniamain.fd_placed_bets group by 1
) as temp
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\PlayerChannelPrefSP.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';



select
PlayerId,
case when EGMobileStkAmt > TotalStake/3 then 'Mobile'
when EGInternetStkAmt > TotalStake/3 then 'Internet'
when EGCasDownStkAmt > TotalStake/3 then 'CasinoDownload'
when TotalStake > 0 then 'Hybrid'
else 'Unclassified' end as ChannelPreference
from
(
select 
PlayerId, 
SUM(case when ClientPlatform = 'mobile' then Bet else 0 end) as EGMobileStkAmt,
SUM(case when ClientPlatform = 'flash' then Bet else 0 end) as EGInternetStkAmt,
SUM(case when ClientPlatform = 'download' then Bet else 0 end) as EGCasDownStkAmt,
Sum(Bet) as TotalStake
from fd_csc_eg_player_product_info_summ
group by 1
) as temp
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\PlayerChannelPrefEG.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';




###IB_SP_CV_Player_Volatility.sql###################################
use romaniamain;
select PlayerId, SportName,ClassName,SelectionName, count(*) as BetCount 
from romaniamain.fd_placed_bets group by 1,2,3,4 order by PlayerId,  count(*) desc
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\PlayerPrefSports.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select PlayerId, CasinoType, GameType, sum(bet) from romaniamain.fd_csc_eg_player_product_info_summ 
group by PlayerId,CasinoType,GameType order by PlayerId, sum(bet) desc
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\PlayerPrefCasino.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select
PlayerId,
case when temp.SPInternetBetCnt = (SPTotalBetCnt/2) then 'Hybrid'
        when temp.SPInternetBetCnt > (SPTotalBetCnt/2) then 'Internet'
else 'Mobile' end as ChannelPreference
from
(
select 
PlayerId, 
count(case when Channel = 'FTNWEB' then 1 end) as SPInternetBetCnt,
count(case when Channel = 'FTNMOB' then 1 end) as SPMobileBetCnt,
count(*) as SPTotalBetCnt
from romaniamain.fd_placed_bets group by 1
) as temp
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\PlayerChannelPrefSP.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';



select
PlayerId,
case when EGMobileStkAmt > TotalStake/3 then 'Mobile'
when EGInternetStkAmt > TotalStake/3 then 'Internet'
when EGCasDownStkAmt > TotalStake/3 then 'CasinoDownload'
when TotalStake > 0 then 'Hybrid'
else 'Unclassified' end as ChannelPreference
from
(
select 
PlayerId, 
SUM(case when ClientPlatform = 'mobile' then Bet else 0 end) as EGMobileStkAmt,
SUM(case when ClientPlatform = 'flash' then Bet else 0 end) as EGInternetStkAmt,
SUM(case when ClientPlatform = 'download' then Bet else 0 end) as EGCasDownStkAmt,
Sum(Bet) as TotalStake
from fd_csc_eg_player_product_info_summ
group by 1
) as temp
INTO OUTFILE 'D:\\RomData\\dump\\FL_Backup\\PlayerChannelPrefEG.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
