##dates to be changed 2016-01-09

select
PlayerId,
SettledDate,
BetSlipId,
BetId,
BetType,
LiveYN,
TotalStake,
TotalReturn,
CashOutStk,
CashOutWin,
BetOdds,
case when TotalReturn > 0 then 'W' else 'L' end as WinLoss,
case when (CashOutStk > 0 or CashOutWin > 0) then 'Y' else 'N' end as CashOutYN,
IF((((1 - (1/BetOdds))*TotalStake)/5) > TotalStake,TotalStake, (((1 - (1/BetOdds))*TotalStake)/5)) as Points,
1
from
(select 
PlayerId,
SettledDate,
BetSlipId,
BetId,
BetType,
MAX(LiveYN) as LiveYN,
AVG(TotalStakeAmt) as TotalStake,
AVG(TotalReturn) as TotalReturn,
AVG(CashOutStake) as CashOutStk,
AVG(CashOutWin) as CashOutWin,
EXP(SUM(LOG(Odds))) as BetOdds
from fd_settled_bets
where SettledDate < '2016-01-09'
group by 1,2,3,4,5
) as temp
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\fd_bet_level_odds_wins.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


use romaniamain;
drop table fd_bet_level_odds_wins;
CREATE TABLE `fd_bet_level_odds_wins` (
  `PlayerId` bigint(20),
  `SettledDate` varchar(200) DEFAULT NULL,
  `BetSlipId` bigint(20),
  `BetId` bigint(20),
  `BetType` varchar(20) DEFAULT NULL,
  `LiveYN` varchar(2) DEFAULT NULL,
  `TotalStake` decimal(18,6) DEFAULT NULL,
  `TotalReturn` decimal(18,6) DEFAULT NULL,
  `CashOutStk` decimal(18,6) DEFAULT NULL,
  `CashOutWin` decimal(18,6) DEFAULT NULL,
  `BetOdds` decimal(18,6) DEFAULT NULL,
  `WinLoss` varchar(2) DEFAULT NULL,
  `CashOutYN` varchar(2) DEFAULT NULL,
  `SpPoints` decimal(18,6), 
  `RomDummy` int DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\fd_bet_level_odds_wins.csv'
INTO TABLE  fd_bet_level_odds_wins
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 
Player.PlayerId,
cast(COALESCE(SpPoints,0.0) as decimal(18,6)),
cast(COALESCE(SGLOdds.SGLAvgOdds,0.0) as decimal(18,6)),
cast(COALESCE(SGLOdds.SGLSTDOdds,0.0) as decimal(18,6)),
cast(COALESCE(SGLOdds.SGLCovOdds,0.0) as decimal(18,6)),
cast(COALESCE(IF((CMBOdds.CMBAvgOdds > 9999999),9999999,CMBOdds.CMBAvgOdds),0.0) as decimal(18,6)),
cast(COALESCE(CMBOdds.CMBSTDOdds,0.0) as decimal(18,6)),
cast(COALESCE(CMBOdds.CMBCovOdds,0.0) as decimal(18,6)),
cast(COALESCE(PlayerStake.SGLTotalWinninStake,0.0) as decimal(18,6)),
cast(COALESCE(PlayerStake.SGLTotalStake,0.0) as decimal(18,6)),
cast(COALESCE(PlayerStake.SGLTotalReturn,0.0) as decimal(18,6)),
cast(COALESCE(PlayerStake.SGLTotalWinningBetCount,0.0) as decimal(18,6)),
cast(COALESCE(PlayerStake.SGLTotalBetCount,0.0) as decimal(18,6)),
cast(COALESCE(PlayerStake.CMBTotalWinninStake,0.0) as decimal(18,6)),
cast(COALESCE(PlayerStake.CMBTotalStake,0.0) as decimal(18,6)),
cast(COALESCE(PlayerStake.CMBTotalReturn,0.0) as decimal(18,6)),
cast(COALESCE(PlayerStake.CMBTotalWinningBetCount,0.0) as decimal(18,6)),
cast(COALESCE(PlayerStake.CMBTotalBetCount,0.0) as decimal(18,6)),
cast(COALESCE((PlayerStake.SGLTotalWinningBetCount/PlayerStake.SGLTotalBetCount),0.0) as decimal(18,6)) as SGLWinningRatioBetCounts,
cast(COALESCE((PlayerStake.SGLTotalWinninStake/PlayerStake.SGLTotalStake),0.0) as decimal(18,6)) as SGLWinningRatioStake,
cast(COALESCE((PlayerStake.CMBTotalWinningBetCount/PlayerStake.CMBTotalBetCount),0.0) as decimal(18,6)) as CMBWinningRatioBetCounts,
cast(COALESCE((PlayerStake.CMBTotalWinninStake/PlayerStake.CMBTotalStake),0.0) as decimal(18,6)) as CMBWinningRatioStake
from
(select PlayerId from romaniamain.fd_bet_level_odds_wins group by 1) as Player
left outer join
(select 
PlayerId,
SpPoints,
AvgOdds as SGLAvgOdds,
STDOdds as SGLSTDOdds,
STDOdds/AvgOdds as SGLCovOdds
from
(select PlayerId,sum(SpPoints) SpPoints,AVG(BetOdds) as AvgOdds,STD(BetOdds) as STDOdds
from romaniamain.fd_bet_level_odds_wins where CashOutYN = 'N' and BetType = 'SGL'
group by 1) temp ) as SGLOdds on Player.PlayerId = SGLOdds.PlayerId
Left outer join
(select PlayerId,AvgOdds as CMBAvgOdds,STDOdds as CMBSTDOdds,STDOdds/AvgOdds as CMBCovOdds
from (
select  PlayerId,AVG(BetOdds) as AvgOdds,STD(BetOdds) as STDOdds
from romaniamain.fd_bet_level_odds_wins where CashOutYN = 'N' and BetType <> 'SGL'
group by 1) temp) as CMBOdds on Player.PlayerId = CMBOdds.PlayerId
left outer join
(select PlayerId,
SUM(case when BetType = 'SGL' and WinLoss = 'W' then TotalStake else 0 end) as SGLTotalWinninStake,
SUM(case when BetType = 'SGL' then TotalStake else 0 end) as SGLTotalStake,
SUM(case when BetType = 'SGL' then TotalReturn else 0 end) as SGLTotalReturn,
Count(case when BetType = 'SGL' and WinLoss = 'W' then 1 end) as SGLTotalWinningBetCount,
Count(case when BetType = 'SGL' then 1 end) as SGLTotalBetCount,
SUM(case when BetType <> 'SGL' and WinLoss = 'W' then TotalStake else 0 end) as CMBTotalWinninStake,
SUM(case when BetType <> 'SGL' then TotalStake else 0 end) as CMBTotalStake,
SUM(case when BetType <> 'SGL' then TotalReturn else 0 end) as CMBTotalReturn,
Count(case when BetType <> 'SGL' and WinLoss = 'W' then 1 end) as CMBTotalWinningBetCount,
Count(case when BetType <> 'SGL' then 1 end) as CMBTotalBetCount
from 
romaniamain.fd_bet_level_odds_wins
group by 1
) as PlayerStake on Player.PlayerId = PlayerStake.PlayerId
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\sp_cv_player_volatility.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select 
PlayerId, 
CAST(AvgGrossProfit AS DECIMAL(18,6)) AvgGrossProfit,
CAST(StdGrossProfit AS DECIMAL(18,6)) StdGrossProfit,
CAST((AvgGrossProfit + 2*StdGrossProfit) AS DECIMAL(18,6)) as ExtremeLoss, 
CAST((AvgGrossProfit - 2*StdGrossProfit) AS DECIMAL(18,6)) as ExtremeWin  
from (
select 
PlayerId,
AVG(Bet-Win) as AvgGrossProfit,
STD(Bet-Win) as StdGrossProfit
from fd_csc_eg_player_product_info_summ
group by 1 ) as temp
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\ExtremeWinLoss.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


select
PlayerId,
cast(AvgDeposit AS DECIMAL(18,6)) AvgDeposit,
cast(StdDevDeposit AS DECIMAL(18,6)) StdDevDeposit,
cast((AvgDeposit + 2*StdDevDeposit)  AS DECIMAL(18,6)) ExtremeDeposit
from
(
select 
PlayerCode as PlayerId,
AVG(Amount) as AvgDeposit,
STD(Amount) as StdDevDeposit
from romania.c_player_payment
where Status = 'approved' and Type = 'deposit'
group by 1
) as temp
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\ExtremeDeposit.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

