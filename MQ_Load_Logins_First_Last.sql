use romaniastage;
drop table stg_daily_player_logins;
CREATE TABLE stg_daily_player_logins (
   SummaryDate date,
   PlayerCode int(10),
   PlayerType varchar(50) DEFAULT NULL,
   LoginDate datetime DEFAULT NULL,
   LogoutDate datetime DEFAULT NULL,
   StartCashBalance decimal(18,6) DEFAULT NULL,
   StartBonusBalance decimal(18,6) DEFAULT NULL,
   EndCashBalance decimal(18,6) DEFAULT NULL,
   EndBonusBalance decimal(18,6) DEFAULT NULL
 ) ENGINE=Innodb DEFAULT CHARSET=utf8;
 
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\mysql_stg_daily_player_logins.csv'  
INTO TABLE romaniastage.stg_daily_player_logins FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

use romaniamain;
drop table player_login_first_last;
CREATE TABLE player_login_first_last (
   PlayerId bigint(20),
   PlayerType varchar(50) DEFAULT NULL,
   FirstLoginDate datetime DEFAULT NULL,
   LastLoginDate datetime DEFAULT NULL,
   FirstLogoutDate datetime DEFAULT NULL,
   LastLogoutDate datetime DEFAULT NULL,
   FirstCashBalance decimal(18,6) DEFAULT NULL,
   FirstBonusBalance decimal(18,6) DEFAULT NULL,
   CurrentCashBalance decimal(18,6) DEFAULT NULL,
   CurrentBonusBalance decimal(18,6) DEFAULT NULL,
   PRIMARY KEY (`PlayerId`)
 ) ENGINE=Innodb DEFAULT CHARSET=utf8;
 

insert into romaniamain.player_login_first_last(
	 PlayerId
	,PlayerType
	,FirstLoginDate
	,LastLoginDate
	,FirstLogoutDate
	,LastLogoutDate
	,FirstCashBalance
	,FirstBonusBalance
	,CurrentCashBalance
	,CurrentBonusBalance
)
select 
PlayerCode,
PlayerType,
LoginDate,
LoginDate,
LogoutDate,
LogoutDate,
StartCashBalance,
StartBonusBalance,
EndCashBalance,
EndBonusBalance
from romaniastage.stg_daily_player_logins as src 

on duplicate key update 

  FirstCashBalance = IF((src.LoginDate < FirstLoginDate OR FirstLoginDate is null),src.StartCashBalance,FirstCashBalance)
, FirstBonusBalance = IF((src.LoginDate < FirstLoginDate OR FirstLoginDate is null),src.StartBonusBalance,FirstBonusBalance)

, CurrentCashBalance = IF(((src.LogoutDate > LastLogoutDate OR LastLogoutDate is null) AND year(src.LogoutDate) <> 3000 AND src.EndCashBalance is not null),src.EndCashBalance,CurrentCashBalance)
, CurrentBonusBalance = IF(((src.LogoutDate > LastLogoutDate OR LastLogoutDate is null) AND year(src.LogoutDate) <>3000 AND src.EndBonusBalance is not null),src.EndBonusBalance,CurrentBonusBalance)

, FirstLoginDate = IF((src.LoginDate < FirstLoginDate OR FirstLoginDate is null),src.LoginDate,FirstLoginDate)
, LastLoginDate = IF((src.LoginDate > LastLoginDate OR LastLoginDate is null),src.LoginDate,LastLoginDate)

, FirstLogoutDate = IF(((src.LogoutDate < FirstLogoutDate OR FirstLogoutDate is null) AND year(src.LogoutDate) <> 3000),src.LogoutDate,FirstLogoutDate)
, LastLogoutDate = IF(((src.LogoutDate > LastLoginDate OR LastLogoutDate is null) AND year(src.LogoutDate) <> 3000),src.LogoutDate,LastLogoutDate)

, PlayerType = src.PlayerType

;

commit;

select * from romaniamain.player_login_first_last where FirstCashBalance > 0;