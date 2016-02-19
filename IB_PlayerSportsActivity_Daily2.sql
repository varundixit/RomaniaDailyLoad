SELECT 
    LiveYN, BetType, PlayerID, calendar_date
FROM
    romaniamain.dim_gametype bt
        CROSS JOIN
    romaniamain.dim_bettype
        CROSS JOIN
    dim_player p on PlayerID is not null
        CROSS JOIN
    dim_calendar ON calendar_date BETWEEN '2015-11-26' AND current_date
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\DailyPlayerCrossMaps.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ; 

drop table Romaniastg.DailyPlayerCrossMaps;
create table Romaniastg.DailyPlayerCrossMaps (
	LiveYN varchar(10), 
	BetType varchar(10), 
	PlayerID varchar(10), 
	SummaryDate date
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\DailyPlayerCrossMaps.csv'
INTO TABLE Romaniastg.DailyPlayerCrossMaps
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

#select * from romaniamain.fd_settled_bets_ext where betid = 22449391;

select date(SettledDate) SummaryDate,LiveYN, (case gm.BetType when 'SGL' then 'S' else 'C' end) BetType, 
PlayerID,betId,StakePerLineMtplr, sum(CashStakeAmt+CashOutStake) TotalBet, sum(CashReturn+CashOutWin) TotalWin
from romaniamain.fd_settled_bets_ext gm 
group by 1,2,3,4,5,6
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDaily.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ;  

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

#SELECT SummaryDate,SUM(TotalStake),SUM(TotalReturn) FROM Romaniastg.stg_PlayerBetSummariesDaily GROUP BY 1;

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDaily.csv'
INTO TABLE Romaniastg.stg_PlayerBetSummariesDaily
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select SummaryDate, LiveYN, BetType, PlayerID, betId, 
cast(StakePerLineMtplr*TotalStake/100 as decimal(18,6)),cast(StakePerLineMtplr*TotalReturn/100 as decimal(18,6))
from Romaniastg.stg_PlayerBetSummariesDaily
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDaily1.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ;

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

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDaily1.csv'
INTO TABLE Romaniastg.stg_PlayerBetSummariesDaily1
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

#SELECT * FROM Romaniastg.stg_PlayerBetSummariesDaily1;

select SummaryDate, LiveYN, BetType, PlayerID, sum(TotalStake), sum(TotalReturn), count(distinct betId) slipCount
from Romaniastg.stg_PlayerBetSummariesDaily1
group by 1,2,3,4
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDaily2.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ;

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

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDaily2.csv'
INTO TABLE Romaniastg.stg_PlayerBetSummariesDaily2
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select * from Romaniastg.stg_PlayerBetSummariesDaily2;

select cr.SummaryDate,cr.LiveYN, case cr.BetType when 'Single' then 'S' else 'C' end , cr.PlayerID
, COALESCE(ab.TotalStake,0) 
, COALESCE(ab.TotalReturn,0)
, COALESCE(ab.SlipCount,0) 
from
Romaniastg.DailyPlayerCrossMaps cr
    left outer join Romaniastg.stg_PlayerBetSummariesDaily2 ab 
    on cr.LiveYN = ab.LiveYN and cr.PlayerID = ab.PlayerID 
    and case cr.BetType when 'Single' then 'S' else 'C' end = ab.betType and cr.SummaryDate = ab.SummaryDate
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDailyLoad.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' ;

select liveyn,case BetType when 'Single' then 'S' else 'C' end,playerid from Romaniastg.DailyPlayerCrossMaps group by 1;
select * /*SummaryDate,sum(TotalStake),sum(TotalReturn),sum(SlipCount)*/  from Romaniastg.stg_PlayerBetSummariesDaily2;

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

LOAD DATA INFILE 'C:\\Users\\Public\\Downloads\\test\\PlayerBetSummariesDailyLoad.csv'
INTO TABLE Romaniastg.DailyPlayerBetSummaries
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

select SummaryDate,sum(TotalStake),sum(TotalReturn),sum(SlipCount) from Romaniastg.DailyPlayerBetSummaries
group by 1;
