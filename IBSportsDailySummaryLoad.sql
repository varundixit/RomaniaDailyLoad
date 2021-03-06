###date change : '2016-02-18'
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
    dim_calendar ON calendar_date = '2016-02-18'
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
where SettledDate = '2016-02-18'
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
where SummaryDate = '2016-02-18'
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
where SummaryDate= '2016-02-18'
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
where cr.SummaryDate= '2016-02-18'
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
select 'Month' agg,
overall.SummaryDate, TotalTurnOver, TotalWin, SportsAPD, PurePlayer SBPurePlayer, newPlayersCnt SBNewPlyrCnt,
FixedOpenBets, TotalBetFixed, TotalWinFixed, SingleTotalBetFixed, SingleTotalWinFixed, CombiTotalBetFixed, CombiTotalWinFixed, SlipCountFixed, AUFixed, PureFixed,
LiveOpenBets , TotalBetLive , TotalWinLive , SingleTotalBetLive , SingleTotalWinLive , CombiTotalBetLive , CombiTotalWinLive , SlipCountLive , AULive , PureLive , EventCnt
from 
(
	SELECT str_to_date(date_format(dps.SummaryDate,'%Y-%m-01'),'%Y-%m-%d') SummaryDate
	,SUM(dps.SPCashStakeAmt+dps.SPCashOutStake) as TotalTurnOver
	,SUM(dps.SPCashReturn+dps.SPCashOutWin) as TotalWin
	FROM romaniamain.sd_cv_daily_player_summary as dps
	join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId and p.SignupDate >= '2015-11-26'
	and date_format(dps.SummaryDate,'%Y-%m-01') >= date_format(DATE_ADD(current_date, INTERVAL -1 MONTH) ,'%Y-%m-01')
	group by 1
) overall
join (
	SELECT 
    str_to_date(date_format(dgps.SummaryDate,'%Y-%m-01'),'%Y-%m-%d') SummaryDate
	, COUNT(distinct case when (dgps.SPStakeAmt) > 0 then dgps.PlayerId end) as SportsAPD
	, COUNT(distinct case when dgps.EGBet=0 and (dgps.SPStakeAmt) > 0 then dgps.playerid end) PurePlayer 
	, COUNT(distinct case when flsp = str_to_date(date_format(SummaryDate,'%Y-%m-01'),'%Y-%m-%d') and (dgps.SPStakeAmt) > 0 then dgps.playerid end) newPlayersCnt
	FROM romaniamain.sd_gv_daily_player_summary as dgps
	join romaniamain.dim_player as p on dgps.PlayerId = p.PlayerId and p.signupdate >='2015-11-26'
	left outer join ( select playerid,str_to_date(date_format(LEAST(gfl.SglLvFirstBetTime,gfl.CmbFirstBetTime),'%Y-%m-01'),'%Y-%m-%d') flsp
			from romaniafl.sp_gv_player_first_last gfl group by 1
		) ab on ab.playerid = dgps.PlayerID
	where str_to_date(date_format(dgps.SummaryDate,'%Y-%m-01'),'%Y-%m-%d') >= date_format(DATE_ADD(current_date, INTERVAL -1 MONTH) ,'%Y-%m-01')	
	group by str_to_date(date_format(dgps.SummaryDate,'%Y-%m-01'),'%Y-%m-%d') 
) apd on overall.SummaryDate = apd.SummaryDate
join (
	select overall.SummaryDate, FixedOpenBets, TotalBetFixed, TotalWinFixed, SingleTotalBetFixed, SingleTotalWinFixed, CombiTotalBetFixed, CombiTotalWinFixed,SlipCountFixed,  
		  LiveOpenBets , TotalBetLive , TotalWinLive , SingleTotalBetLive , SingleTotalWinLive , CombiTotalBetLive , CombiTotalWinLive , SlipCountLive  
	from 
	(select str_to_date(date_format(SummaryDate,'%Y-%m-01'),'%Y-%m-%d') SummaryDate,
	sum(case when LiveYN = 'N'                   then TotalStake end) TotalBetFixed,
	sum(case when LiveYN = 'N'                   then TotalReturn end) TotalWinFixed,
	sum(case when LiveYN = 'N' and BetType = 'S' then TotalStake end) SingleTotalBetFixed,
	sum(case when LiveYN = 'N' and BetType = 'S' then TotalReturn end) SingleTotalWinFixed,
	sum(case when LiveYN = 'N' and BetType = 'C' then TotalStake end) CombiTotalBetFixed,
	sum(case when LiveYN = 'N' and BetType = 'C' then TotalReturn end) CombiTotalWinFixed,
	sum(case when LiveYN = 'Y'                   then TotalStake end) TotalBetLive,
	sum(case when LiveYN = 'Y'                   then TotalReturn end) TotalWinLive,
	sum(case when LiveYN = 'Y' and BetType = 'S' then TotalStake end) SingleTotalBetLive,
	sum(case when LiveYN = 'Y' and BetType = 'S' then TotalReturn end) SingleTotalWinLive,
	sum(case when LiveYN = 'Y' and BetType = 'C' then TotalStake end) CombiTotalBetLive,
	sum(case when LiveYN = 'Y' and BetType = 'C' then TotalReturn end) CombiTotalWinLive
	from Romaniastg.DailyPlayerBetSummaries ab
	where date_format(ab.SummaryDate,'%Y-%m-01') >= date_format(DATE_ADD(current_date, INTERVAL -1 MONTH) ,'%Y-%m-01')	
	group by 1) as overall
	join (select str_to_date(date_format(BetDate,'%Y-%m-01'),'%Y-%m-%d')  SummaryDate,
		count(distinct case when LiveYN ='N' then BetId end) SlipCountFixed, 
		count(distinct case when LiveYN ='Y' then BetId end) SlipCountLive 
		from romaniamain.fd_placed_bets gm 
		where date_format(gm.BetDate,'%Y-%m-01')  >= date_format(DATE_ADD(current_date, INTERVAL -1 MONTH) ,'%Y-%m-01')	
		group by 1) slp on overall.SummaryDate = slp.SummaryDate
	left outer join (
		select str_to_date(date_format(SummaryDate,'%Y-%m-01'),'%Y-%m-%d') SummaryDate,FixedOpenBets,LiveOpenBets from romaniafl.DayWiseOpenBetSummary 
		where date(SummaryDate) in (
		select maxda from (select str_to_date(date_format(SummaryDate,'%Y-%m-01'),'%Y-%m-%d')  mon,max(SummaryDate) maxda from romaniafl.DayWiseOpenBetSummary group by 1) ab)
	) op on overall.SummaryDate= op.SummaryDate 
) fixliv on overall.SummaryDate = fixliv.SummaryDate
join (
	select str_to_date(date_format(SummaryDate,'%Y-%m-01'),'%Y-%m-%d')  SummaryDate,
	count(distinct case when li > 0 then PlayerId end                  ) AULive,
	count(distinct case when EG=0 and fx=0 and li > 0 then PlayerId end) PureLive,
	count(distinct case when fx>0 then PlayerId end                    ) AUFixed,
	count(distinct case when EG=0 and fx>0 and li = 0 then PlayerId end) PureFixed from (
	select date(BetDate) SummaryDate, b.PlayerId,
	sum(case LiveYN when 'Y' then 1 else 0 end) Li,
	sum(case LiveYN when 'N' then 1 else 0 end) Fx,
	sum(EGBet) EG
	from romaniamain.fd_placed_bets b join romaniamain.sd_gv_daily_player_summary gps on b.PlayerId = gps.PlayerId and date(b.BetDate) = gps.SummaryDate
	where date_format(BetDate,'%Y-%m-01')  >= date_format(DATE_ADD(current_date, INTERVAL -1 MONTH) ,'%Y-%m-01')	
	group by 1,2) ab
	group by 1
) pl on overall.SummaryDate = pl.SummaryDate
left outer join (
	select str_to_date(date_format(BetDate,'%Y-%m-01'),'%Y-%m-%d')  SummaryDate, count(distinct case LiveYN when 'Y' then EventId end) EventCnt
	from romaniamain.fd_placed_bets b
	where date_format(BetDate,'%Y-%m-01')  >= date_format(DATE_ADD(current_date, INTERVAL -1 MONTH) ,'%Y-%m-01')	
	group by 1 
) eve on eve.SummaryDate = overall.SummaryDate 

union

select 'Day' agg,
overall.SummaryDate, TotalTurnOver, TotalWin, SportsAPD, PurePlayer, newPlayersCnt,
FixedOpenBets, TotalBetFixed, TotalWinFixed, SingleTotalBetFixed, SingleTotalWinFixed, CombiTotalBetFixed, CombiTotalWinFixed, SlipCountFixed, AUFixed, PureFixed,
LiveOpenBets , TotalBetLive , TotalWinLive , SingleTotalBetLive , SingleTotalWinLive , CombiTotalBetLive , CombiTotalWinLive , SlipCountLive , AULive , PureLive , EventCnt
from 
(
	SELECT date(dps.SummaryDate) SummaryDate
	,SUM(dps.SPCashStakeAmt+dps.SPCashOutStake) as TotalTurnOver
	,SUM(dps.SPCashReturn+dps.SPCashOutWin) as TotalWin
	FROM romaniamain.sd_cv_daily_player_summary as dps
	join romaniamain.dim_player as p on dps.PlayerId = p.PlayerId and p.SignupDate >= '2015-11-26'
	and date_format(dps.SummaryDate,'%Y-%m-01') = date_format(current_date ,'%Y-%m-01') 
	group by dps.SummaryDate
) overall
join (
	SELECT 
    date(dgps.SummaryDate) SummaryDate
	, COUNT(distinct case when (dgps.SPStakeAmt) > 0 then dgps.PlayerId end) as SportsAPD
	, count(distinct case when dgps.EGBet = 0 and (dgps.SPStakeAmt) > 0 then dgps.playerid end) PurePlayer 
	, count(distinct case when flsp = SummaryDate and (dgps.SPStakeAmt) > 0 then dgps.playerid end) newPlayersCnt
	FROM romaniamain.sd_gv_daily_player_summary as dgps
	join romaniamain.dim_player as p on dgps.PlayerId = p.PlayerId and p.signupdate >='2015-11-26'
	left outer join ( select playerid,date(LEAST(gfl.SglLvFirstBetTime,gfl.CmbFirstBetTime)) flsp
			from romaniafl.sp_gv_player_first_last gfl group by 1
		) ab on ab.playerid = dgps.PlayerID
	group by date(dgps.SummaryDate)
	) apd on overall.SummaryDate = apd.SummaryDate
join (
	select overall.SummaryDate, FixedOpenBets, TotalBetFixed, TotalWinFixed, SingleTotalBetFixed, SingleTotalWinFixed, CombiTotalBetFixed, CombiTotalWinFixed,SlipCountFixed,  
		  LiveOpenBets , TotalBetLive , TotalWinLive , SingleTotalBetLive , SingleTotalWinLive , CombiTotalBetLive , CombiTotalWinLive , SlipCountLive  
	from 
	(select date(SummaryDate) SummaryDate,
	sum(case when LiveYN = 'N'                   then TotalStake end) TotalBetFixed,
	sum(case when LiveYN = 'N'                   then TotalReturn end) TotalWinFixed,
	sum(case when LiveYN = 'N' and BetType = 'S' then TotalStake end) SingleTotalBetFixed,
	sum(case when LiveYN = 'N' and BetType = 'S' then TotalReturn end) SingleTotalWinFixed,
	sum(case when LiveYN = 'N' and BetType = 'C' then TotalStake end) CombiTotalBetFixed,
	sum(case when LiveYN = 'N' and BetType = 'C' then TotalReturn end) CombiTotalWinFixed,
	sum(case when LiveYN = 'Y'                   then TotalStake end) TotalBetLive,
	sum(case when LiveYN = 'Y'                   then TotalReturn end) TotalWinLive,
	sum(case when LiveYN = 'Y' and BetType = 'S' then TotalStake end) SingleTotalBetLive,
	sum(case when LiveYN = 'Y' and BetType = 'S' then TotalReturn end) SingleTotalWinLive,
	sum(case when LiveYN = 'Y' and BetType = 'C' then TotalStake end) CombiTotalBetLive,
	sum(case when LiveYN = 'Y' and BetType = 'C' then TotalReturn end) CombiTotalWinLive
	from Romaniastg.DailyPlayerBetSummaries ab
	where date_format(ab.SummaryDate,'%Y-%m-01') >= date_format(current_date ,'%Y-%m-01') 
	group by 1) as overall
	join (select date(BetDate) SummaryDate,
		count(distinct case when LiveYN ='N' then BetId end) SlipCountFixed, 
		count(distinct case when LiveYN ='Y' then BetId end) SlipCountLive 
		from romaniamain.fd_placed_bets gm 
		where date_format(gm.BetDate,'%Y-%m-01') >= date_format(current_date ,'%Y-%m-01') 
		group by 1) slp on overall.SummaryDate = slp.SummaryDate
	left outer join (
		select date(SummaryDate) SummaryDate,FixedOpenBets,LiveOpenBets from romaniafl.DayWiseOpenBetSummary 
		where date(SummaryDate) in (
			select maxda from (select date(SummaryDate)  mon,max(SummaryDate) maxda from romaniafl.DayWiseOpenBetSummary group by 1) ab)
		) op on overall.SummaryDate= op.SummaryDate 
) fixliv on overall.SummaryDate = fixliv.SummaryDate
join (
	select date(SummaryDate) SummaryDate,
	count(distinct case when li > 0 then PlayerId end                  ) AULive,
	count(distinct case when EG=0 and fx=0 and li > 0 then PlayerId end) PureLive,
	count(distinct case when fx>0 then PlayerId end                    ) AUFixed,
	count(distinct case when EG=0 and fx>0 and li = 0 then PlayerId end) PureFixed from (
	select date(BetDate) SummaryDate, b.PlayerId,
	sum(case LiveYN when 'Y' then 1 else 0 end) Li,
	sum(case LiveYN when 'N' then 1 else 0 end) Fx,
	sum(EGBet) EG
	from romaniamain.fd_placed_bets b join romaniamain.sd_gv_daily_player_summary gps on b.PlayerId = gps.PlayerId and date(b.BetDate) = gps.SummaryDate
	where date_format(BetDate,'%Y-%m-01') >= date_format(current_date ,'%Y-%m-01') 
	group by 1,2) ab
	group by 1
) pl on overall.SummaryDate = pl.SummaryDate
left outer join (
	select date(BetDate) SummaryDate, count(distinct case LiveYN when 'Y' then EventId end) EventCnt
	from romaniamain.fd_placed_bets b
	where date_format(BetDate,'%Y-%m-01') >= date_format(current_date ,'%Y-%m-01') 
	group by 1 
) eve on eve.SummaryDate = overall.SummaryDate ;