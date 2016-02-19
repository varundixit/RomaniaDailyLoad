###date change 2016-02-08
### place files "New_signups_2016-02-08.csv", "AdvertisersReport_2016-02-08.csv", 
###             "Players_search_by_parameters_2016-02-08.csv" and "Currency_conversion_rates_2016-02-08.csv"
#### Curl_Players-romaniadatadump folder name
### is based on advertiser report
#### run powershell for this file #Players_search_by_parameters_2016-02-08.csv# accessible /check for customer-bitzaone/
##### and remove headers 



#####Load balance
select
  Code as Playerid
, STR_TO_DATE('2016-02-08', '%Y-%m-%d %H:%i:%s') AS SummaryDate
, AdvertiserCode
, STR_TO_DATE(GlobalFirstDepositDate, '%Y-%m-%d %H:%i:%s') as FirstDepositDate
, Balance as Balance
, BonusBalance as BonusBalance
, STR_TO_DATE(SignupDate, '%Y-%m-%d %H:%i:%s') as SignUpDate
, 1
from romaniastg.STG_IMS_CSV_PLAYER
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\STG_DAILY_PLAYER_BALANCE.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


/*use romaniamain;
#drop table `FD_DAILY_PLAYER_BALANCE`;
CREATE TABLE `FD_DAILY_PLAYER_BALANCE` (
  `PlayerId` bigint(20) DEFAULT NULL,
  `SummaryDate` date DEFAULT NULL,
  `AdvertiserCode` bigint(20) DEFAULT NULL,
  `FirstDepositDate` date DEFAULT NULL,
  `Balance` decimal(18,6) DEFAULT NULL,
  `BonusBalance` decimal(18,6) DEFAULT NULL,
  `SignUpDate` date DEFAULT NULL,
  `RomDummy` int
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
*/

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\STG_DAILY_PLAYER_BALANCE.csv'
into table romaniamain.FD_DAILY_PLAYER_BALANCE
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';



#####exchange load
drop table romaniastg.STG_Exchange_Rate;
CREATE TABLE romaniastg.`STG_Exchange_Rate` (
  `EffectiveTimestamp` varchar(100) DEFAULT NULL,
  `LastUpdTimestamp` varchar(100) DEFAULT NULL,
  `CurrencyCode` varchar(100) DEFAULT NULL,
  `XchangeRate` varchar(100) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\Currency_conversion_rates_2016-02-08.csv'
into table romaniastg.STG_Exchange_Rate
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n';

select
date(EffectiveTimestamp),
EffectiveTimestamp,
LastUpdTimestamp,
CurrencyCode,
XchangeRate
from romaniastg.STG_Exchange_Rate
where EffectiveTimestamp <> 'Effective date'
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\DD_Exchange_Rate_2016-02-08.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

/*
use romaniamain;
drop table DD_Exchange_Rate;
CREATE TABLE `DD_Exchange_Rate` (
  `SummaryDate` date DEFAULT NULL,
  `EffectiveTimestamp` datetime DEFAULT NULL,
  `LastUpdTimestamp` datetime DEFAULT NULL,
  `CurrencyCode` varchar(20) DEFAULT NULL,
  `ExchangeRate` double(24,18) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
*/

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\DD_Exchange_Rate_2016-02-08.csv'
into table romaniamain.DD_Exchange_Rate
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n';

drop table romaniaStg.StgNewSignup;
CREATE TABLE romaniaStg.StgNewSignup(
Registration_DateTime varchar(100) DEFAULT NULL,
Username varchar(100) DEFAULT NULL,
Last_Login_Client_Type varchar(50) DEFAULT NULL,
Affiliate varchar(50) DEFAULT NULL,
Country varchar(50) DEFAULT NULL,
Language varchar(50) DEFAULT NULL,
Age varchar(100) DEFAULT NULL,
Fun_Player varchar(50) DEFAULT NULL,
Coupon varchar(100) DEFAULT NULL,
ProfileID varchar(100) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\New_signups_2016-02-08.csv'
into table romaniaStg.StgNewSignup
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select
Registration_DateTime,
Username,
Last_Login_Client_Type,
Affiliate,
Country,
Language,
Age,
Fun_Player,
Coupon,
ProfileID
from romaniastg.StgNewSignup
where Country <> 'Country'
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\NewSignups_2016-02-08.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

/*drop table romaniaStg.IMS_newSignup;
CREATE TABLE romaniaStg.IMS_newSignup(
Registration_DateTime datetime DEFAULT NULL,
Username varchar(100) DEFAULT NULL,
Last_Login_Client_Type varchar(50) DEFAULT NULL,
Affiliate varchar(50) DEFAULT NULL,
Country varchar(50) DEFAULT NULL,
Language varchar(50) DEFAULT NULL,
Age int DEFAULT NULL,
Fun_Player varchar(50) DEFAULT NULL,
Coupon varchar(100) DEFAULT NULL,
ProfileID bigint(20) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;*/

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\NewSignups_2016-02-08.csv'
into table romaniaStg.IMS_newSignup
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

/*
drop table romaniaStg.Advertisers;
CREATE TABLE romaniaStg.Advertisers
(
  username varchar(50) DEFAULT NULL,
  advertiserid bigint(20) DEFAULT NULL,
  advertisertype varchar(20) DEFAULT NULL,
  parentadvertiser varchar(20) DEFAULT NULL,
  signupdate date DEFAULT NULL,
  lastlogin varchar(20) DEFAULT NULL,
  totalpremiums varchar(20) DEFAULT NULL,
  totalpaid varchar(20) DEFAULT NULL,
  totalearned varchar(20) DEFAULT NULL,
  balance int DEFAULT NULL,
  funplayers int DEFAULT NULL,
  realplayers int DEFAULT NULL,
  offirstdeposits int DEFAULT NULL,
  firstdeposits decimal(18,6) DEFAULT NULL,
  firstname varchar(100) DEFAULT NULL,
  lastname varchar(50) DEFAULT NULL,
  email varchar(100) DEFAULT NULL,
  address varchar(200) DEFAULT NULL,
  city varchar(200) DEFAULT NULL,
  state varchar(20) DEFAULT NULL,
  zip int DEFAULT NULL,
  country varchar(20) DEFAULT NULL,
  fax varchar(20) DEFAULT NULL,
  phone bigint(20) DEFAULT NULL,
  paymentmethod varchar(20) DEFAULT NULL,
  wtaccountname varchar(20) DEFAULT NULL,
  wtaccountnumber varchar(20) DEFAULT NULL,
  wtnumber varchar(20) DEFAULT NULL,
  wttype varchar(20) DEFAULT NULL,
  bankname varchar(20) DEFAULT NULL,
  bankaddress varchar(20) DEFAULT NULL,
  bankcity varchar(20) DEFAULT NULL,
  bankstate varchar(20) DEFAULT NULL,
  bankzip varchar(20) DEFAULT NULL,
  bankcountry varchar(20) DEFAULT NULL,
  internetpaymentaccount varchar(20) DEFAULT NULL,
  paymentcomments varchar(20) DEFAULT NULL,
  revenuecalctype varchar(20) DEFAULT NULL,
  percenttype varchar(50) DEFAULT NULL,
  paycimp int DEFAULT NULL,
  paycclick int DEFAULT NULL,
  payperfunplayer int DEFAULT NULL,
  payperplayer int DEFAULT NULL,
  payperfirstdeposit int DEFAULT NULL,
  minpayout int DEFAULT NULL,
  frozen varchar(20) DEFAULT NULL,
  internal varchar(20) DEFAULT NULL,
  allowexitcontrol varchar(20) DEFAULT NULL,
  showinstats varchar(20) DEFAULT NULL,
  advancedview varchar(20) DEFAULT NULL,
  exiturl varchar(20) DEFAULT NULL,
  preferredlanguage varchar(20) DEFAULT NULL,
  website varchar(20) DEFAULT NULL,
  comments Varchar(300) DEFAULT NULL,
  wantmail varchar(20) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\AdvertisersReport_2016-02-08.csv'
into table romaniaStg.Advertisers
fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';


*/

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\AdvertisersReport_2016-02-08.csv'
into table romaniaStg.Advertisers
fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

Drop table romaniastg.PlayerParameters;
Create table romaniastg.PlayerParameters(
Username Varchar(200),
Firstname Varchar(200),
Lastname Varchar(200),
PokerNickname Varchar(200),
BingoNickname Varchar(200),
SbNickname Varchar(200),
CasinoNickname Varchar(200),
TvNickname Varchar(200),
Casino Varchar(200),
AgeVerificationResult Varchar(200),
Balance Decimal(18,6),
BonusBalance Decimal(18,6),
CompsBalance Decimal(18,6),
TotalComps Decimal(18,6),
InternalAccount Varchar(20),
Frozen Varchar(20),
SendPromotionalEMail Varchar(20),
SendPromotionalSms Varchar(20),
DoNotCallPlayer Varchar(20),
BingoFrozen Varchar(20),
PokerFrozen Varchar(20),
PokerBlocked Varchar(20),
AllDepositsDisabled Varchar(20),
BonusSeeker Varchar(20),
FirstDepositDate Datetime,
PlayerIsAdvertiser Varchar(20),
Chat Varchar(20),
AllBetsIncluded Varchar(20),
RegistrationChecked Varchar(20),
FraudChecked Varchar(20),
AllowedToTransferMoneyToPlayers Varchar(20),
AllowedToReceiveMoneyFromPlayers Varchar(20),
IPProxyPlayerFromNonRestrictedCountries Varchar(20),
Suspended Varchar(20),
TaggedBy Varchar(500),
AccountsCreatedInKiosks Varchar(20),
BonusAllowed Varchar(20),
Email Varchar(200),
Currency Varchar(20),
Language Varchar(200),
Country Varchar(200),
City Varchar(200),
Advertiser Varchar(200),
Profile Varchar(200),
VipLevel Integer,
PokerVipLevel Integer,
SignupClientTypePlatform Varchar(200),
LastLoginClientType Varchar(200),
LastLoginCountry Varchar(200),
PhoneNumber Varchar(200),
Cellphone Varchar(200),
Workphone Varchar(200),
Fax Varchar(200),
AuthentificationNumber Varchar(200),
ActivationCodeStatus Varchar(200),
Comments Varchar(1000),
Externalid Varchar(200),
IdIssuer Varchar(200),
IdDateOfIssue Varchar(200),
IdPlaceOfIssue Varchar(200),
DlIssuer Varchar(200),
DlDateOfIssue Varchar(200),
DlPlaceOfIssue Varchar(200),
HasCopyOfIdFaxed Varchar(20)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

/*Bitzaone*/
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\Players_search_by_parameters_2016-02-08.csv'
into table romaniastg.PlayerParameters
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select p.PlayerID,p.username,adv.email advEmail,advUsername,advcode,
case when lower(adv.email) = 'agentii@efortuna.ro' then 'RETAIL'
when lower(adv.email) like 'iulian.dumitru@efortuna.ro' or lower(adv.email) like 'superpont1x2@gmail.com' then 'DIGITAL'
when lower(adv.email) like 'defaulte8' then 'Generic'
else 'AFFILIATE' end advChannel,p.GlobalFirstDepositDate,p.SIGNUPDATE,
sig.ClientPlatform,sig.ClientType,
pp.AgeVerificationResult,pp.InternalAccount,pp.Frozen,pp.SendPromotionalEMail,
pp.SendPromotionalSms,pp.DoNotCallPlayer,pp.BonusSeeker,pp.PlayerIsAdvertiser,
pp.RegistrationChecked,pp.FraudChecked,pp.AllowedToTransferMoneyToPlayers,
pp.AllowedToReceiveMoneyFromPlayers,pp.IPProxyPlayerFromNonRestrictedCountries,
pp.Suspended,pp.TaggedBy
from romaniamain.dim_player p
left outer join romaniastg.PlayerParameters pp on p.username = pp.username
left outer join (select ns.username,coalesce(ad.email,affiliate) email, ad.username advUsername,ad.advertiserid advcode
from romaniastg.IMS_newSignup ns
left outer join romaniastg.advertisers ad on ns.affiliate = ad.username) adv on (adv.username = p.username)
left outer join romaniamain.dim_client_parameter sig on (p.SIGNUPCLIENTPARAMETERCODE = sig.ClientParameterCode)
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\DimPlayerPropertyAndChannel.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

Drop table romaniafl.Dim_Player_Channel;
Create table romaniafl.Dim_Player_Channel(
PlayerId integer,
Username varchar(50) default null,
AdvEmail varchar(100) default null,
AdvUsername  varchar(200) default null,
AdvCode varchar(50) default null,
AdvChannel varchar(50) default null,
GlobalFirstDepositDate datetime, 
SignupDate datetime,
SignupClientPlatform varchar(50) default null,
SignupClientType varchar(50) default null,
AgeVerificationResult Varchar(100) default null,
InternalAccount Varchar(20) default null,
Frozen Varchar(20) default null,
SendPromotionalEmail Varchar(20) default null,
SendPromotionalSms Varchar(20) default null,
DoNotCallPlayer Varchar(20) default null,
BonusSeeker Varchar(20) default null,
PlayerIsAdvertiser Varchar(20) default null,
RegistrationChecked Varchar(20) default null,
FraudChecked Varchar(20) default null,
AllowedToTransferMoneyToPlayers Varchar(20) default null,
AllowedToReceiveMoneyFromPlayers Varchar(20) default null,
IpProxyPlayerFromNonRestrictedCountries Varchar(20) default null,
Suspended Varchar(20) default null,
TaggedBy Varchar(1000)  default null
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\Public\\Downloads\\DimPlayerPropertyAndChannel.csv'
into table romaniafl.Dim_Player_Channel
fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';