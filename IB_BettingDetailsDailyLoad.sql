select SummaryDate, LiveYN,BetType,SportCode,SportName, ClassId, ClassName, TypeId, TypeName
,sum(CashStake+CashOutStake) TotalStake
,sum(CashWin  + CashOutWin) TotalWin from (
select date(SettledDate) SummaryDate, betid,LiveYN,(case BetType when 'SGL' then 'S' else 'C' end) BetType,
SportCode,SportName, ClassId, ClassName, TypeId, TypeName,PlayerID,
cast(CashStakeAmt*StakePerLineMtplr/100 as decimal(18,6)) CashStake,
cast(CashOutStake*StakePerLineMtplr/100 as decimal(18,6)) CashOutStake,
cast(CashReturn*StakePerLineMtplr/100 as decimal(18,6)) CashWin,
cast(CashOutWin*StakePerLineMtplr/100 as decimal(18,6)) CashOutWin
from fd_settled_bets_ext) ab
group by 1,2,3,4,5,6,7,8,9
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\BettingDetailsDaily.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ;  

drop table romaniastg.BettingDetailsDaily;
Create table romaniastg.BettingDetailsDaily (
SummaryDate date, 
LiveYN varchar(10), 
BetType varchar(10), 
SportCode varchar(10), 
SportName varchar(100), 
ClassId varchar(10), 
ClassName varchar(100), 
TypeId varchar(10), 
TypeName varchar(100), 
TotalBet decimal(18,6), 
TotalWin decimal(18,6)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\BettingDetailsDaily.csv'
INTO TABLE romaniastg.BettingDetailsDaily
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


#validation queries
select date_format(SettledDate,'%Y-%m-01') Mon, 
sum(CashStakeAmt) CashStakeAmt, sum(CashOutStake) CashOutStake,
sum(CashReturn) CashReturn, sum(CashOutWin) CashOutWin from (
select SettledDate,BetId,
avg(CashStakeAmt) CashStakeAmt, avg(CashOutStake) CashOutStake, 
avg(CashReturn) CashReturn, avg(CashOutWin) CashOutWin
from romaniamain.fd_settled_bets
group by 1,2) ab group by 1;

select mon, 
sum(CashStake+CashOutStake) TotalStake,
sum(CashWin  + CashOutWin) TotalWin from (
select date_format(SettledDate,'%Y-%m-01') Mon, betid,
cast(CashStakeAmt*StakePerLineMtplr/100 as decimal(18,6)) CashStake,
cast(CashOutStake*StakePerLineMtplr/100 as decimal(18,6)) CashOutStake,
cast(CashReturn*StakePerLineMtplr/100 as decimal(18,6)) CashWin,
cast(CashOutWin*StakePerLineMtplr/100 as decimal(18,6)) CashOutWin
from fd_settled_bets_ext) ab group by 1;

select date_format(SummaryDate,'%Y-%m-01') mon,sum(TotalBet) TotalBet, sum(TotalWin) TotalWin 
from romaniastg.BettingDetailsDaily
group by 1;

select * from sd_cv_sp_daily_player_summary;
