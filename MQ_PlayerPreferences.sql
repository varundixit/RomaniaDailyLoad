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

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefSports.csv'
INTO TABLE romaniastage.stg_sports_prod_pref FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerPrefCasino.csv'
INTO TABLE romaniastage.stg_egaming_prod_pref FIELDS TERMINATED BY ';'  ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

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
case 
	when round(betper1) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper1 > 25 then PreferredSport1 
    when round(betper2) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper2 > 25 then PreferredSport2
    when round(betper3) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper3 > 25 then PreferredSport3 
    when round(betper4) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper4 > 25 then PreferredSport4     
    else 'Hybrid'
    end PreferredSport,
case 
	when round(betper1) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper1 > 25 then PreferredLeague1 
	when round(betper2) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper2 > 25 then PreferredLeague2     
	when round(betper3) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper3 > 25 then PreferredLeague3
  	when round(betper4) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper4 > 25 then PreferredLeague4
    else 'Hybrid'
    end PreferredLeague,
case 
	when round(betper1) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper1 > 25 then PreferredTeam1 
	when round(betper2) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper2 > 25 then PreferredTeam2 
	when round(betper3) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper3 > 25 then PreferredTeam3     
	when round(betper4) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper4 > 25 then PreferredTeam4         
    else 'Hybrid'
    end PreferredTeam
from (
select PlayerId,
PreferredSport1,PreferredLeague1,PreferredTeam1,BetCount1,coalesce((BetCount1/OverallBet)*100,0) betPer1,
PreferredSport2,PreferredLeague2,PreferredTeam2,BetCount2,coalesce((BetCount2/OverallBet)*100,0) betPer2,
PreferredSport3,PreferredLeague3,PreferredTeam3,BetCount3,coalesce((BetCount3/OverallBet)*100,0) betPer3,
PreferredSport4,PreferredLeague4,PreferredTeam4,BetCount4,coalesce((BetCount4/OverallBet)*100,0) betPer4,OverallBet from 
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
group by PlayerId) ab) cd
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\SportsPreferedProduct.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

drop table romaniamain.SportsPreferedProduct;
create table romaniamain.SportsPreferedProduct(
PlayerId integer,
PreferredSport varchar(200),
PreferredLeague varchar(200),
PreferredTeam varchar(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\SportsPreferedProduct.csv'
INTO TABLE romaniamain.SportsPreferedProduct
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


#####file to be saved as Casino Preferences
select PlayerId,
case 
	when round(betper1) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper1 > 25 then CategoryPref1 
    when round(betper2) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper2 > 25 then CategoryPref2
    when round(betper3) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper3 > 25 then CategoryPref3
    when round(betper4) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper4 > 25 then CategoryPref4     
    else 'Hybrid'
    end CategoryPref,
case 
	when round(betper1) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper1 > 25 then MarketPref1 
	when round(betper2) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper2 > 25 then MarketPref2
	when round(betper3) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper3 > 25 then MarketPref3
  	when round(betper4) = round(GREATEST(betper1,betper2,betper3,betper4)) and betper4 > 25 then MarketPref4
    else 'Hybrid'
    end MarketPref
from (select PlayerId,
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
group by PlayerId) ab) cd
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\EGPreferedProduct.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

drop table romaniamain.EGPreferedProduct;
create table romaniamain.EGPreferedProduct(
PlayerId integer,
CategoryPref varchar(200),
MarketPref varchar(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\EGPreferedProduct.csv'
INTO TABLE romaniamain.EGPreferedProduct
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

############channel prefferences Sports
drop table romaniamain.stg_sports_channel_pref;
create table romaniamain.stg_sports_channel_pref(
PlayerId integer default null,
Channel varchar(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerChannelPrefSP.csv'
into table romaniamain.stg_sports_channel_pref FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


select * from romaniamain.stg_sports_channel_pref; SportChannlePreferences

############channel prefferences Casino
drop table romaniamain.stg_eg_channel_pref;
create table romaniamain.stg_eg_channel_pref(
PlayerId integer default null,
Channel varchar(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\PlayerChannelPrefEG.csv'
into table romaniamain.stg_eg_channel_pref FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select * from romaniastage.stg_eg_channel_pref;