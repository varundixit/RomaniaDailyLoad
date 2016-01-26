##Full Run
use romaniastage;
drop table stg_daily_logins;
CREATE TABLE `stg_daily_logins` (
  `ClientType` varchar(200) DEFAULT NULL,
  `LoginId` int(9) DEFAULT NULL,
  `EndBalance` decimal(18,6) DEFAULT NULL,
  `EndBonusBalance` decimal(18,6) DEFAULT NULL,
  `FunPlayerCode` int(9) DEFAULT NULL,
  `HwSerial` int(9) DEFAULT NULL,
  `IP` varchar(200) DEFAULT NULL,
  `KioskCode` int(9) DEFAULT NULL,
  `LoginDate` datetime DEFAULT NULL,
  `LogoutDate` datetime DEFAULT NULL,
  `PlayerCode` int(9) DEFAULT NULL,
  `PlayerType` varchar(200) DEFAULT NULL,
  `SerialCode` varchar(200) DEFAULT NULL,
  `ServerCode` varchar(200) DEFAULT NULL,
  `SessionId` varchar(200) DEFAULT NULL,
  `Startbalance` decimal(18,6) DEFAULT NULL,
  `Startbonusbalance` decimal(18,6) DEFAULT NULL,
  `Version` varchar(200) DEFAULT NULL,
  `ClientPlatform` varchar(200) DEFAULT NULL,
  `LoginDeviceTypeCode` int(9) DEFAULT NULL,
  `LoginVenueCode` int(9) DEFAULT NULL
) ENGINE=innodb DEFAULT CHARSET=utf8;

commit;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\mysql_stg_daily_player_logins.csv' 
INTO TABLE  romaniastage.stg_daily_logins
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
#IGNORE 1 LINES
(@vClientType, @vLoginId, @vEndBalance, @vEndBonusBalance, @vFunPlayerCode, @vHwSerial, @vIP, @vKioskCode, @vLoginDate, @vLogoutDate, @vPlayerCode, @vPlayerType, @vSerialCode, @vServerCode, @vSessionId, @vStartbalance, @vStartbonusbalance, @vVersion, @vClientPlatform, @vLoginDeviceTypeCode, @vLoginVenueCode)
SET
ClientType = nullif(@vClientType, ''),
LoginId = nullif(@vLoginId, ''),
EndBalance = nullif(@vEndBalance, ''),
EndBonusBalance = nullif(@vEndBonusBalance, ''),
FunPlayerCode = nullif(@vFunPlayerCode, ''),
HwSerial = nullif(@vHwSerial, ''),
IP = nullif(@vIP, ''),
KioskCode = nullif(@vKioskCode, ''),
LoginDate = nullif(@vLoginDate, ''),
LogoutDate = nullif(@vLogoutDate, ''),
PlayerCode = nullif(@vPlayerCode, ''),
PlayerType = nullif(@vPlayerType, ''),
SerialCode = nullif(@vSerialCode, ''),
ServerCode = nullif(@vServerCode, ''),
SessionId = nullif(@vSessionId, ''),
Startbalance = nullif(@vStartbalance, ''),
Startbonusbalance = nullif(@vStartbonusbalance, ''),
Version = nullif(@vVersion, ''),
ClientPlatform = nullif(@vClientPlatform, ''),
LoginDeviceTypeCode = nullif(@vLoginDeviceTypeCode, ''),
LoginVenueCode = nullif(@vLoginVenueCode, '');

commit;

#select count(*) from romaniastage.stg_daily_logins where LogoutDate is null;


######################################################### Open Logins ################################################################

use romaniamain;
drop table fd_daily_logins_open;
CREATE TABLE `fd_daily_logins_open` (
  `Product` varchar(200) DEFAULT NULL,
  `SummaryDate` date,
  `LoginId` int(9) DEFAULT NULL,
  `EndBalance` decimal(18,6) DEFAULT NULL,
  `EndBonusBalance` decimal(18,6) DEFAULT NULL,
  `FunPlayerCode` int(9) DEFAULT NULL,
  `HwSerial` int(9) DEFAULT NULL,
  `IP` varchar(200) DEFAULT NULL,
  `KioskCode` int(9) DEFAULT NULL,
  `LoginDate` datetime DEFAULT NULL,
  `LogoutDate` datetime DEFAULT NULL,
  `PlayerId` int(9) DEFAULT NULL,
  `PlayerType` varchar(200) DEFAULT NULL,
  `SerialCode` varchar(200) DEFAULT NULL,
  `ServerCode` varchar(200) DEFAULT NULL,
  `SessionId` varchar(200) DEFAULT NULL,
  `Startbalance` decimal(18,6) DEFAULT NULL,
  `Startbonusbalance` decimal(18,6) DEFAULT NULL,
  `Version` varchar(200) DEFAULT NULL,
  `LoginChannel` varchar(200) DEFAULT NULL,
  `LoginDeviceTypeCode` int(9) DEFAULT NULL,
  `LoginVenueCode` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


insert into  romaniamain.fd_daily_logins_open
(
 Product
,SummaryDate
,LoginId
,EndBalance
,EndBonusBalance
,FunPlayerCode
,HwSerial
,IP
,KioskCode
,LoginDate
,LogoutDate
,PlayerId
,PlayerType
,SerialCode
,ServerCode
,SessionId
,Startbalance
,Startbonusbalance
,Version
,LoginChannel
,LoginDeviceTypeCode
,LoginVenueCode
)
select 
 ClientType
,date(LoginDate)
,LoginId
,EndBalance
,EndBonusBalance
,FunPlayerCode
,HwSerial
,IP
,KioskCode
,LoginDate
,LogoutDate
,PlayerCode
,PlayerType
,SerialCode
,ServerCode
,SessionId
,Startbalance
,Startbonusbalance
,Version
,ClientPlatform
,LoginDeviceTypeCode
,LoginVenueCode
from
romaniastage.stg_daily_logins where LogoutDate is null;

commit;


######################################################### Completed Logins ################################################################

use romaniamain;
drop table fd_daily_logins_completed;
CREATE TABLE `fd_daily_logins_completed` (
  `Product` varchar(200) DEFAULT NULL,
  `SummaryDate` date,
  `LoginId` int(9) DEFAULT NULL,
  `EndCashBalance` decimal(18,6) DEFAULT NULL,
  `EndBonusBalance` decimal(18,6) DEFAULT NULL,
  `FunPlayerCode` int(9) DEFAULT NULL,
  `HwSerial` int(9) DEFAULT NULL,
  `IP` varchar(200) DEFAULT NULL,
  `KioskCode` int(9) DEFAULT NULL,
  `LoginDate` datetime DEFAULT NULL,
  `LogoutDate` datetime DEFAULT NULL,
  `PlayerId` int(9) DEFAULT NULL,
  `PlayerType` varchar(200) DEFAULT NULL,
  `SerialCode` varchar(200) DEFAULT NULL,
  `ServerCode` varchar(200) DEFAULT NULL,
  `SessionId` varchar(200) DEFAULT NULL,
  `StartCashbalance` decimal(18,6) DEFAULT NULL,
  `Startbonusbalance` decimal(18,6) DEFAULT NULL,
  `Version` varchar(200) DEFAULT NULL,
  `LoginChannel` varchar(200) DEFAULT NULL,
  `LoginDeviceTypeCode` int(9) DEFAULT NULL,
  `LoginVenueCode` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


insert into  romaniamain.fd_daily_logins_completed
(
 Product
,SummaryDate
,LoginId
,EndCashBalance
,EndBonusBalance
,FunPlayerCode
,HwSerial
,IP
,KioskCode
,LoginDate
,LogoutDate
,PlayerId
,PlayerType
,SerialCode
,ServerCode
,SessionId
,StartCashbalance
,Startbonusbalance
,Version
,LoginChannel
,LoginDeviceTypeCode
,LoginVenueCode
)
select 
 ClientType
,date(LoginDate)
,LoginId
,EndBalance
,EndBonusBalance
,FunPlayerCode
,HwSerial
,IP
,KioskCode
,LoginDate
,LogoutDate
,PlayerCode
,PlayerType
,SerialCode
,ServerCode
,SessionId
,Startbalance
,Startbonusbalance
,Version
,ClientPlatform
,LoginDeviceTypeCode
,LoginVenueCode
from
romaniastage.stg_daily_logins where LogoutDate is not null;

commit;

############################################################ Player First Last ##################################################################
#select * from romaniamain.fd_daily_logins_completed;

use romaniamain;
drop table daily_player_login_first_last;
CREATE TABLE daily_player_login_first_last (
   PlayerId bigint(20),
   SummaryDate date,
   PlayerType varchar(50) DEFAULT NULL,
   FirstLoginTime datetime DEFAULT NULL,
   LastLogoutTime datetime DEFAULT NULL,
   FirstCashBalance decimal(18,6) DEFAULT NULL,
   FirstBonusBalance decimal(18,6) DEFAULT NULL,
   LastCashBalance decimal(18,6) DEFAULT NULL,
   LastBonusBalance decimal(18,6) DEFAULT NULL,
   LoginCounts int,
   PRIMARY KEY (`PlayerId`,`SummaryDate`)
 ) ENGINE=Innodb DEFAULT CHARSET=utf8;
 

insert into romaniamain.daily_player_login_first_last(
	 PlayerId
	,SummaryDate
	,PlayerType
	,FirstLoginTime
	,LastLogoutTime
	,FirstCashBalance
	,FirstBonusBalance
	,LastCashBalance
	,LastBonusBalance
    ,LoginCounts
)
select 
PlayerId,
SummaryDate,
PlayerType,
LoginDate,
LogoutDate,
StartCashBalance,
StartBonusBalance,
EndCashBalance,
EndBonusBalance,
1
from romaniamain.fd_daily_logins_completed as src 

on duplicate key update 

  FirstCashBalance = IF((src.LoginDate < FirstLoginTime OR FirstLoginTime is null),src.StartCashBalance,FirstCashBalance)
, FirstBonusBalance = IF((src.LoginDate < FirstLoginTime OR FirstLoginTime is null),src.StartBonusBalance,FirstBonusBalance)

, LastCashBalance = IF(((src.LogoutDate > LastLogoutTime OR LastLogoutTime is null) AND year(src.LogoutDate) <> 3000 AND src.EndCashBalance is not null),src.EndCashBalance,LastCashBalance)
, LastBonusBalance = IF(((src.LogoutDate > LastLogoutTime OR LastLogoutTime is null) AND year(src.LogoutDate) <>3000 AND src.EndBonusBalance is not null),src.EndBonusBalance,LastBonusBalance)

, FirstLoginTime = IF((src.LoginDate < FirstLoginTime OR FirstLoginTime is null),src.LoginDate,FirstLoginTime)
, LastLogoutTime = IF(((src.LogoutDate > LastLogoutTime OR LastLogoutTime is null) AND year(src.LogoutDate) <> 3000),src.LogoutDate,LastLogoutTime)

, PlayerType = src.PlayerType
, LoginCounts = LoginCounts + 1
;

commit;


############################################### Player Lifetime First Last ###############################################################


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
PlayerId,
PlayerType,
LoginDate,
LoginDate,
LogoutDate,
LogoutDate,
StartCashBalance,
StartBonusBalance,
EndCashBalance,
EndBonusBalance
from romaniamain.fd_daily_logins_completed as src 

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