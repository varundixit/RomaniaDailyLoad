###date change : '2016-02-17'
#Full Run

SELECT 
    LiveYN, BetType, PlayerID, calendar_date
FROM
    romaniamain.dim_gametype bt
        CROSS JOIN
    romaniamain.dim_bettype
        CROSS JOIN
    dim_player p on PlayerID is not null
        CROSS JOIN
    dim_calendar ON calendar_date = '2016-02-17'
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\DailyPlayerCrossMaps.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ; 

/*
drop table Romaniastg.DailyPlayerCrossMaps;
create table Romaniastg.DailyPlayerCrossMaps (
	LiveYN varchar(10), 
	BetType varchar(10), 
	PlayerID varchar(10), 
	SummaryDate date
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
*/

#select SummaryDate,count(1) from Romaniastg.DailyPlayerCrossMaps where SummaryDate >= '2016-02-15' group by 1;

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\DailyPlayerCrossMaps.csv'
INTO TABLE Romaniastg.DailyPlayerCrossMaps
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select date(SettledDate) SummaryDate,LiveYN, (case gm.BetType when 'SGL' then 'S' else 'C' end) BetType, 
PlayerID,betId,StakePerLineMtplr, sum(CashStakeAmt+CashOutStake) TotalBet, sum(CashReturn+CashOutWin) TotalWin
from romaniamain.fd_settled_bets_ext gm 
where SettledDate = '2016-02-17'
group by 1,2,3,4,5,6
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDaily.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ;  


/*
drop table Romaniastg.stg_PlayerBetSummariesDaily;
create table Romaniastg.stg_PlayerBetSummariesDaily
(
	SummaryDate date, 
    LiveYN varchar(10), 
    BetType varchar(10), 
    PlayerID bigint(20), 
    betId bigint(20),
    StakePerLineMtplr decimal(18,6),
    TotalStake decimal(18,6),
    TotalReturn decimal(18,6)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
*/

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDaily.csv'
INTO TABLE Romaniastg.stg_PlayerBetSummariesDaily
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select SummaryDate, LiveYN, BetType, PlayerID, betId, 
cast(StakePerLineMtplr*TotalStake/100 as decimal(18,6)),cast(StakePerLineMtplr*TotalReturn/100 as decimal(18,6))
from Romaniastg.stg_PlayerBetSummariesDaily
where SummaryDate = '2016-02-17'
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDaily1.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ;

/*
drop table Romaniastg.stg_PlayerBetSummariesDaily1;
create table Romaniastg.stg_PlayerBetSummariesDaily1
(
	SummaryDate date, 
    LiveYN varchar(10), 
    BetType varchar(10), 
    PlayerID bigint(20), 
    betId bigint(20),
    TotalStake decimal(18,6),
    TotalReturn decimal(18,6)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
*/

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDaily1.csv'
INTO TABLE Romaniastg.stg_PlayerBetSummariesDaily1
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select SummaryDate, LiveYN, BetType, PlayerID, sum(TotalStake), sum(TotalReturn), count(distinct betId) slipCount
from Romaniastg.stg_PlayerBetSummariesDaily1
where SummaryDate= '2016-02-17'
group by 1,2,3,4
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDaily2.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ;

/*
drop table Romaniastg.stg_PlayerBetSummariesDaily2;
create table Romaniastg.stg_PlayerBetSummariesDaily2
(
	SummaryDate date, 
    LiveYN varchar(10), 
    BetType varchar(10), 
    PlayerID bigint(20), 
    TotalStake decimal(18,6),
    TotalReturn decimal(18,6),
    SlipCount integer
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
*/

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDaily2.csv'
INTO TABLE Romaniastg.stg_PlayerBetSummariesDaily2
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select cr.SummaryDate,cr.LiveYN, case cr.BetType when 'Single' then 'S' else 'C' end , cr.PlayerID
, COALESCE(ab.TotalStake,0) 
, COALESCE(ab.TotalReturn,0)
, COALESCE(ab.SlipCount,0) 
from
Romaniastg.DailyPlayerCrossMaps cr
    left outer join Romaniastg.stg_PlayerBetSummariesDaily2 ab 
    on cr.LiveYN = ab.LiveYN and cr.PlayerID = ab.PlayerID 
    and case cr.BetType when 'Single' then 'S' else 'C' end = ab.betType and cr.SummaryDate = ab.SummaryDate
where cr.SummaryDate= '2016-02-17'
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDailyLoad.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ;

/*
drop table Romaniastg.DailyPlayerBetSummaries;
create table Romaniastg.DailyPlayerBetSummaries
(
	SummaryDate date, 
    LiveYN varchar(10), 
    BetType varchar(10), 
    PlayerID bigint(20), 
    TotalStake decimal(18,6),
    TotalReturn decimal(18,6),
    SlipCount integer
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
*/

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDailyLoad.csv'
INTO TABLE Romaniastg.DailyPlayerBetSummaries
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


###Query 1:
select 'Month' agg,Overall.Mon,Overall.TotalTurnOver,Overall.TotalWin,Overall.SportsAPD,Overall.PurePlayer as SBPurePlayer,Overall.newPlayersCnt as SBNewPlyrCnt,
TotalBetFixed,TotalWinFixed,SingleTotalBetFixed,SingleTotalWinFixed,CombiTotalBetFixed,CombiTotalWinFixed,SlipCountFixed,AUFixed,PurePlayersFixed,
TotalBetLive ,TotalWinLive ,SingleTotalBetLive ,SingleTotalWinLive ,CombiTotalBetLive ,CombiTotalWinLive ,SlipCountLive ,AULive ,PurePlayersLive,EventCount
from
(select str_to_date(date_format(SummaryDate,'%Y-%m-01'),'%Y-%m-%d') Mon,
sum(SPCCStakeAmt) as TotalTurnOver,sum(SPCCWinAmt) TotalWin,SportsAPD,
count(distinct case egstake when 0 then ab.playerid end) PurePlayer,
count(distinct case when date_format(flsp,'%Y-%m-01') = date_format(SummaryDate,'%Y-%m-01') then ab.playerid end) newPlayersCnt
from (
SELECT 
 dps.SummaryDate
,dps.playerid
,flsp
,SUM(dps.SPCashStakeAmt+dps.SPCashOutStake) as SPCCStakeAmt
,SUM(dps.SPCashReturn+dps.SPCashOutWin) as SPCCWinAmt
FROM romaniamain.sd_cv_daily_player_summary as dps
join (select playerid,LEAST(gfl.SglLvFirstBetTime,gfl.CmbFirstBetTime) flsp 
	from romaniafl.sp_cv_player_first_last_totals gfl group by 1) a on dps.playerId = a.playerid
left outer join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId
where p.SignupDate >= '2015-11-26'
and date_format(dps.SummaryDate,'%Y-%m-01') >= date_format(DATE_ADD(current_date, INTERVAL -1 MONTH) ,'%Y-%m-01') 
group by dps.SummaryDate,dps.playerid,flsp) ab
join (select playerid,date_format(SummaryDate,'%Y-%m-01') mon,SUM(EGBet) egstake 
	from romaniamain.sd_cv_daily_player_summary dp
	where date_format(dp.SummaryDate,'%Y-%m-01') >= date_format(DATE_ADD(current_date, INTERVAL -1 MONTH) ,'%Y-%m-01') 
	group by 1,2) b on ab.playerId = b.playerId and date_format(SummaryDate,'%Y-%m-01') = b.mon
join (SELECT 
	date_format(dps.SummaryDate,'%Y-%m-01') mon
	,COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.PlayerId end) as SportsAPD
	FROM romaniamain.sd_gv_daily_player_summary as dps
	join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId
	where p.SignupDate >= '2015-11-26'
	group by date_format(dps.SummaryDate,'%Y-%m-01')
	) gview on gview.mon = date_format(ab.SummaryDate,'%Y-%m-01')
group by 1) as overall
join 
(
select str_to_date(date_format(SummaryDate,'%Y-%m-01'),'%Y-%m-%d') Mon,
sum(case when LiveYN = 'N'                   then TotalStake end) TotalBetFixed,
sum(case when LiveYN = 'N'                   then TotalReturn end) TotalWinFixed,
sum(case when LiveYN = 'N' and BetType = 'S' then TotalStake end) SingleTotalBetFixed,
sum(case when LiveYN = 'N' and BetType = 'S' then TotalReturn end) SingleTotalWinFixed,
sum(case when LiveYN = 'N' and BetType = 'C' then TotalStake end) CombiTotalBetFixed,
sum(case when LiveYN = 'N' and BetType = 'C' then TotalReturn end) CombiTotalWinFixed,
sum(case when LiveYN = 'N' then SlipCount end) SlipCountFixed,
count(distinct case when LiveYN = 'N' and TotalStake > 0 then ab.PlayerID END) as AUFixed,
count(case when egstake=0 and PureBetLive=0 and TotalStake > 0 then ab.PlayerID end) PurePlayersFixed,
sum(case when LiveYN = 'Y'                   then TotalStake end) TotalBetLive,
sum(case when LiveYN = 'Y'                   then TotalReturn end) TotalWinLive,
sum(case when LiveYN = 'Y' and BetType = 'S' then TotalStake end) SingleTotalBetLive,
sum(case when LiveYN = 'Y' and BetType = 'S' then TotalReturn end) SingleTotalWinLive,
sum(case when LiveYN = 'Y' and BetType = 'C' then TotalStake end) CombiTotalBetLive,
sum(case when LiveYN = 'Y' and BetType = 'C' then TotalReturn end) CombiTotalWinLive,
sum(case when LiveYN = 'Y' then SlipCount end) SlipCountLive,
count(distinct case when LiveYN = 'Y' and TotalStake > 0 then ab.PlayerID END) AULive,
count(case when egstake=0 and PureBetFixed=0 and TotalStake > 0 then ab.PlayerID end) PurePlayersLive
from Romaniastg.DailyPlayerBetSummaries ab
join (select playerid,date_format(SummaryDate,'%Y-%m-01') mon,SUM(EGBet) egstake 
	from romaniamain.sd_cv_daily_player_summary 
	group by 1,2) b on ab.playerId = b.playerId and date_format(SummaryDate,'%Y-%m-01') = b.mon
join (select playerid
	,date_format(SummaryDate,'%Y-%m-01') mon
	,sum(case LiveYN when 'N' then TotalStake end) PureBetFixed
    ,sum(case LiveYN when 'Y' then TotalStake end) PureBetLive
	from Romaniastg.DailyPlayerBetSummaries 
	group by 1,2) c on ab.playerId = c.playerId and date_format(SummaryDate,'%Y-%m-01') = c.mon
where date_format(ab.SummaryDate,'%Y-%m-01') >= date_format(DATE_ADD(current_date, INTERVAL -1 MONTH) ,'%Y-%m-01') 
group by 1) fixliv on overall.mon = fixliv.mon
join ( select date_format(SettledDate,'%Y-%m-01') mon, count(distinct case when LiveYN ='Y' then EventId end) EventCount 
	from romaniamain.fd_settled_bets_ext gm 
	group by 1) eve on overall.mon = eve.mon
union
select 'Day' seq,Overall.Mon,Overall.TotalTurnOver,Overall.TotalWin,Overall.SportsAPD,Overall.PurePlayer as SBPurePlayer,Overall.newPlayersCnt as SBNewPlyrCnt,
TotalBetFixed,TotalWinFixed,SingleTotalBetFixed,SingleTotalWinFixed,CombiTotalBetFixed,CombiTotalWinFixed,SlipCountFixed,AUFixed,PurePlayersFixed,
TotalBetLive ,TotalWinLive ,SingleTotalBetLive ,SingleTotalWinLive ,CombiTotalBetLive ,CombiTotalWinLive ,SlipCountLive ,AULive ,PurePlayersLive,EventCount
from
(select 'OverAll',date(SummaryDate) Mon,
sum(SPCCStakeAmt) as TotalTurnOver,sum(SPCCWinAmt) TotalWin,SportsAPD,
count(distinct case egstake when 0 then ab.playerid end) PurePlayer,
count(distinct case when date(flsp) = date(SummaryDate) then ab.playerid end) newPlayersCnt
from (
SELECT 
 dps.SummaryDate
,dps.playerid
,flsp
,SUM(dps.SPCashStakeAmt+dps.SPCashOutStake) as SPCCStakeAmt
,SUM(dps.SPCashReturn+dps.SPCashOutWin) as SPCCWinAmt
FROM romaniamain.sd_cv_daily_player_summary as dps
left outer join (select playerid,LEAST(gfl.SglLvFirstBetTime,gfl.CmbFirstBetTime) flsp 
	from romaniafl.sp_cv_player_first_last_totals gfl group by 1) a on dps.playerId = a.playerid
join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId
where p.SignupDate >= '2015-11-26'
and date(SummaryDate) >= date_format(DATE_ADD(current_date, INTERVAL -1 Day) ,'%Y-%m-01') 
group by dps.SummaryDate,dps.playerid,flsp) ab
join (select playerid,date(SummaryDate) mon,SUM(EGBet) egstake 
	from romaniamain.sd_cv_daily_player_summary dp
	where date(SummaryDate) >= date_format(DATE_ADD(current_date, INTERVAL -1 Day) ,'%Y-%m-01') 
	group by 1,2) b on ab.playerId = b.playerId and date(SummaryDate) = b.mon
join (SELECT 
	dps.SummaryDate mon
	,COUNT(distinct case when (dps.SPStakeAmt) > 0 then dps.PlayerId end) as SportsAPD
	FROM romaniamain.sd_gv_daily_player_summary as dps
	join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId
	where p.SignupDate >= '2015-11-26'
	group by dps.SummaryDate
	) gview on gview.mon = ab.SummaryDate	
group by date(SummaryDate)) as overall
join 
(
select date(SummaryDate) mon,
sum(case when LiveYN = 'N'                   then TotalStake end) TotalBetFixed,
sum(case when LiveYN = 'N'                   then TotalReturn end) TotalWinFixed,
sum(case when LiveYN = 'N' and BetType = 'S' then TotalStake end) SingleTotalBetFixed,
sum(case when LiveYN = 'N' and BetType = 'S' then TotalReturn end) SingleTotalWinFixed,
sum(case when LiveYN = 'N' and BetType = 'C' then TotalStake end) CombiTotalBetFixed,
sum(case when LiveYN = 'N' and BetType = 'C' then TotalReturn end) CombiTotalWinFixed,
sum(case when LiveYN = 'N' then SlipCount end) SlipCountFixed,
count(distinct case when LiveYN = 'N' and TotalStake > 0 then ab.PlayerID END) as AUFixed,
count(case when egstake=0 and PureBetLive=0 and TotalStake > 0 then ab.PlayerID end) PurePlayersFixed,
sum(case when LiveYN = 'Y'                   then TotalStake end) TotalBetLive,
sum(case when LiveYN = 'Y'                   then TotalReturn end) TotalWinLive,
sum(case when LiveYN = 'Y' and BetType = 'S' then TotalStake end) SingleTotalBetLive,
sum(case when LiveYN = 'Y' and BetType = 'S' then TotalReturn end) SingleTotalWinLive,
sum(case when LiveYN = 'Y' and BetType = 'C' then TotalStake end) CombiTotalBetLive,
sum(case when LiveYN = 'Y' and BetType = 'C' then TotalReturn end) CombiTotalWinLive,
sum(case when LiveYN = 'Y' then SlipCount end) SlipCountLive,
count(distinct case when LiveYN = 'Y' and TotalStake > 0 then ab.PlayerID END) AULive,
count(case when egstake=0 and PureBetFixed=0 and TotalStake > 0 then ab.PlayerID end) PurePlayersLive
from Romaniastg.DailyPlayerBetSummaries ab
join (select playerid,date(SummaryDate) mon,SUM(EGBet) egstake 
	from romaniamain.sd_cv_daily_player_summary 
	group by 1,2) b on ab.playerId = b.playerId and date(SummaryDate) = b.mon
join (select playerid
	,date(SummaryDate) mon
	,sum(case LiveYN when 'N' then TotalStake end) PureBetFixed
    ,sum(case LiveYN when 'Y' then TotalStake end) PureBetLive
	from Romaniastg.DailyPlayerBetSummaries 
	group by 1,2) c on ab.playerId = c.playerId and date(SummaryDate) = c.mon
where date(ab.SummaryDate) >= date_format(DATE_ADD(current_date, INTERVAL -1 Day) ,'%Y-%m-01') 
group by 1
) fixliv on overall.mon = fixliv.mon
join ( select date(SettledDate) mon, count(distinct case when LiveYN ='Y' then EventId end) EventCount 
	from romaniamain.fd_settled_bets_ext gm 
	group by 1) eve on overall.mon = eve.mon
order by 1 desc,2;

select * from romaniafl.DayWiseOpenBetSummary;


###Query 2:
select 'Month' Agg,LiveYN, Mon,SportName, CashStake+CashOutStake TotalStake, CashReturn+CashOutWin TotalWin,EventCount from (
select date_format(SettledDate,'%Y-%m-01') Mon,SportName,LiveYN
, sum(cast(CashStakeAmt*StakePerLineMtplr/100 as decimal(18,6))) CashStake
, sum(cast(CashOutStake*StakePerLineMtplr/100 as decimal(18,6))) CashOutStake
, sum(cast(CashReturn*StakePerLineMtplr/100 as decimal(18,6))) CashReturn
, sum(cast(CashOutWin*StakePerLineMtplr/100 as decimal(18,6))) CashOutWin,
count(distinct EventId) EventCount
from romaniamain.fd_settled_bets_ext
where date_format(SettledDate,'%Y-%m-01') >= date_format(DATE_ADD(current_date, INTERVAL -1 MONTH) ,'%Y-%m-01') 
group by 1,2,3) ab 
union
select 'Day' Agg,LiveYN, Mon,SportName, CashStake+CashOutStake TotalStake, CashReturn+CashOutWin TotalWin,EventCount from (
select date_format(SettledDate,'%Y-%m-%d') Mon,SportName,LiveYN
, sum(cast(CashStakeAmt*StakePerLineMtplr/100 as decimal(18,6))) CashStake
, sum(cast(CashOutStake*StakePerLineMtplr/100 as decimal(18,6))) CashOutStake
, sum(cast(CashReturn*StakePerLineMtplr/100 as decimal(18,6))) CashReturn
, sum(cast(CashOutWin*StakePerLineMtplr/100 as decimal(18,6))) CashOutWin,
count(distinct EventId) EventCount
from romaniamain.fd_settled_bets_ext
where date(SettledDate) >= date(DATE_ADD(current_date, INTERVAL -1 Day)) 
group by 1,2,3) ab order by LiveYN, Mon,TotalStake desc;

#select * from fd_settled_bets_ext