drop table romaniastage.stg_sports_prod_pref;
create table romaniastage.stg_sports_prod_pref(
PlayerId integer default null,
PreferredSport varchar(500),
PreferredLeague varchar(500),
PreferredTeam varchar(500),
BetCount integer
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table romaniastage.stg_egaming_prod_pref;
create table romaniastage.stg_egaming_prod_pref(
PlayerId integer default null,
CategoryPref varchar(500),
MarketPref  varchar(500),
BetAmt decimal(18,6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*drop table romaniastage.stg_sports_channel_pref;
create table romaniastage.stg_sports_channel_pref(
PlayerId integer default null,
Channel varchar(500),
BetCount integer
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table romaniastage.stg_egaming_channel_pref;
create table romaniastage.stg_egaming_channel_pref(
PlayerId integer default null,
Channel varchar(500),
TotalStake decimal(18,6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;*/


LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefSports.csv'
INTO TABLE romaniastage.stg_sports_prod_pref FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefCasino.csv'
INTO TABLE romaniastage.stg_egaming_prod_pref FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

/*LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\ChannelPreferenceSports.csv'
INTO TABLE romaniastage.stg_sports_channel_pref FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\ChannelPreferenceGaming.csv'
INTO TABLE romaniastage.stg_egaming_channel_pref FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';*/

commit;

select temp.rank,temp.PlayerId, temp.CategoryPref, temp.MarketPref, temp.BetAmt from
( SELECT ( 
            CASE PlayerId 
            WHEN @curType 
            THEN @curRow := @curRow + 1 
            ELSE @curRow := 1 AND @curType := PlayerId END
          )  AS rank,
          PlayerId,
          CategoryPref,
          MarketPref,
          BetAmt
FROM      romaniastage.stg_egaming_prod_pref,
          (SELECT @curRow := 0, @curType := '') r
ORDER BY  PlayerId, BetAmt DESC
) as temp
where Rank < 5
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefferedCasino.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 0, playerid, 'OverAll', 'OverAll', Sum(BetAmt) from romaniastage.stg_egaming_prod_pref group by playerid
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefferedCasinoAll.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select temp.rank,temp.PlayerId, temp.PreferredSport, temp.PreferredLeague,temp.PreferredTeam, temp.BetCount from
( SELECT ( 
            CASE PlayerId 
            WHEN @curType 
            THEN @curRow := @curRow + 1 
            ELSE @curRow := 1 AND @curType := PlayerId END
          )  AS rank,
          PlayerId,
          PreferredSport,
          PreferredLeague,
          PreferredTeam,
          BetCount
FROM      romaniastage.stg_sports_prod_pref,
          (SELECT @curRow := 0, @curType := '') r
ORDER BY  PlayerId, BetCount DESC
) as temp
where Rank < 5
order by 2,1,6
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefferedSports.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select 0, playerid, 'OverAll', 'OverAll', 'OverAll', Sum(BetCount) from romaniastage.stg_sports_prod_pref group by playerid
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefferedSportsAll.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

drop table romaniastage.stg_sports_prod_pref_tf;
create table romaniastage.stg_sports_prod_pref_tf(
Rank integer default null,
PlayerId integer default null,
PreferredSport varchar(500),
PreferredLeague varchar(500),
PreferredTeam varchar(500),
BetCount integer
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table romaniastage.stg_egaming_prod_pref_tf;
create table romaniastage.stg_egaming_prod_pref_tf(
Rank integer default null,
PlayerId integer default null,
CategoryPref varchar(500),
MarketPref  varchar(500),
BetAmt decimal(18,6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefferedSports.csv'
INTO TABLE romaniastage.stg_sports_prod_pref_tf FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefferedSportsAll.csv'
INTO TABLE romaniastage.stg_sports_prod_pref_tf FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefferedCasino.csv'
INTO TABLE romaniastage.stg_egaming_prod_pref_tf FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefferedCasinoAll.csv'
INTO TABLE romaniastage.stg_egaming_prod_pref_tf FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
commit;

#####file to be saved as Sports Preferences
select PlayerId,
PreferredSport1,PreferredLeague1,PreferredTeam1,BetCount1,(BetCount1/OverallBet)*100 betPer,
PreferredSport2,PreferredLeague2,PreferredTeam2,BetCount2,(BetCount2/OverallBet)*100 betPer,
PreferredSport3,PreferredLeague3,PreferredTeam3,BetCount3,(BetCount3/OverallBet)*100 betPer,
PreferredSport4,PreferredLeague4,PreferredTeam4,BetCount4,(BetCount4/OverallBet)*100 betPer,OverallBet from 
(select PlayerId,
max(case rank when 1 then PreferredSport end) as PreferredSport1,
max(case rank when 1 then PreferredLeague end) as PreferredLeague1,
max(case rank when 1 then PreferredTeam end) as PreferredTeam1,
max(case rank when 1 then BetCount end) as BetCount1,

max(case rank when 2 then PreferredSport end) as PreferredSport2,
max(case rank when 2 then PreferredLeague end) as PreferredLeague2,
max(case rank when 2 then PreferredTeam end) as PreferredTeam2,
max(case rank when 2 then BetCount end) as BetCount2,

max(case rank when 3 then PreferredSport end) as PreferredSport3,
max(case rank when 3 then PreferredLeague end) as PreferredLeague3,
max(case rank when 3 then PreferredTeam end) as PreferredTeam3,
max(case rank when 3 then BetCount end) as BetCount3,

max(case rank when 4 then PreferredSport end) as PreferredSport4,
max(case rank when 4 then PreferredLeague end) as PreferredLeague4,
max(case rank when 4 then PreferredTeam end) as PreferredTeam4,
max(case rank when 4 then BetCount end) as BetCount4,

max(case rank when 0 then BetCount end) OverallBet

from romaniastage.stg_sports_prod_pref_tf
# where playerid = 10274175
group by PlayerId) ab;

#####file to be saved as Casino Preferences
select PlayerId,
CategoryPref1,MarketPref1,Betamt1,(Betamt1/OverallBet)*100 betPer1,
CategoryPref2,MarketPref2,Betamt2,(Betamt2/OverallBet)*100 betPer2,
CategoryPref3,MarketPref3,Betamt3,(Betamt3/OverallBet)*100 betPer3,
CategoryPref4,MarketPref4,Betamt4,(Betamt4/OverallBet)*100 betPer4,OverallBet from 
(select PlayerId,
max(case rank when 1 then CategoryPref end) as CategoryPref1,
max(case rank when 1 then MarketPref end) as MarketPref1,
max(case rank when 1 then BetAmt end) as BetAmt1,

max(case rank when 2 then CategoryPref end) as CategoryPref2,
max(case rank when 2 then MarketPref end) as MarketPref2,
max(case rank when 2 then BetAmt end) as BetAmt2,

max(case rank when 3 then CategoryPref end) as CategoryPref3,
max(case rank when 3 then MarketPref end) as MarketPref3,
max(case rank when 3 then BetAmt end) as BetAmt3,

max(case rank when 4 then CategoryPref end) as CategoryPref4,
max(case rank when 4 then MarketPref end) as MarketPref4,
max(case rank when 4 then BetAmt end) as BetAmt4,

max(case rank when 0 then BetAmt end) OverallBet

from romaniastage.stg_egaming_prod_pref_tf
# where playerid = 10274175
group by PlayerId) ab;


############channel prefferences Sports
drop table romaniastage.stg_sports_channel_pref;
create table romaniastage.stg_sports_channel_pref(
PlayerId integer default null,
Channel varchar(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerChannelPrefSP.csv'
into table romaniastage.stg_sports_channel_pref FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

############channel prefferences Casino
drop table romaniastage.stg_eg_channel_pref;
create table romaniastage.stg_eg_channel_pref(
PlayerId integer default null,
Channel varchar(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerChannelPrefEG.csv'
into table romaniastage.stg_eg_channel_pref FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';