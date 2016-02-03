###date change 2016-02-02
### place files "New_signups_2016-02-02.csv", "AdvertisersReport_2016-02-02.csv", "Players_search_by_parameters_2016-02-02.csv" and "Currency_conversion_rates_2016-02-02.csv"
###Full run

#####exchange load
drop table romaniastg.STG_Exchange_Rate;
CREATE TABLE romaniastg.`STG_Exchange_Rate` (
  `EffectiveTimestamp` varchar(100) DEFAULT NULL,
  `LastUpdTimestamp` varchar(100) DEFAULT NULL,
  `CurrencyCode` varchar(100) DEFAULT NULL,
  `XchangeRate` varchar(100) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\Currency_conversion_rates_2016-02-02.csv'
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
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\DD_Exchange_Rate_2016-02-02.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

#use romaniamain;
#drop table DD_Exchange_Rate;
CREATE TABLE `DD_Exchange_Rate` (
  `SummaryDate` date DEFAULT NULL,
  `EffectiveTimestamp` datetime DEFAULT NULL,
  `LastUpdTimestamp` datetime DEFAULT NULL,
  `CurrencyCode` varchar(20) DEFAULT NULL,
  `ExchangeRate` double(24,18) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\DD_Exchange_Rate_2016-02-02.csv'
into table romaniamain.DD_Exchange_Rate
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n';



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

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\New_signups_2016-02-02.csv'
into table romaniaStg.IMS_newSignup
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

/*
---------------------------old definitions
#if advertisers are more than 1199
CREATE TABLE `advertisers` (
   `ADDRESS` varchar(100) DEFAULT NULL,
   `ADVANCEDVIEW` int(11) DEFAULT NULL,
   `ADVERTISERS_TS` date DEFAULT NULL,
   `ADVERTISERTYPE` varchar(50) DEFAULT NULL,
   `ADVSELECTEDFIELDS` varchar(500) DEFAULT NULL,
   `ADVSYSTEMCODE` int(11) DEFAULT NULL,
   `AUTOMATICREVENUEWRITEOFF` int(11) DEFAULT NULL,
   `AVAILABLEBALANCE` int(11) DEFAULT NULL,
   `BALANCE` int(11) DEFAULT NULL,
   `BANNERID` varchar(50) DEFAULT NULL,
   `BIRTHDATE` date DEFAULT NULL,
   `CASHIERLIMIT` int(11) DEFAULT NULL,
   `CITY` varchar(50) DEFAULT NULL,
   `CODE` int(11) DEFAULT NULL,
   `COMMENTS` varchar(50) DEFAULT NULL,
   `COMPANY` varchar(50) DEFAULT NULL,
   `CONTROLEXIT` int(11) DEFAULT NULL,
   `COUNTRYCODE` varchar(50) DEFAULT NULL,
   `CURRENCYCODE` varchar(10) DEFAULT NULL,
   `DEFAULTVIPLEVEL` int(11) DEFAULT NULL,
   `EMAIL` varchar(50) DEFAULT NULL,
   `ENABLEDREPORTS` varchar(200) DEFAULT NULL,
   `EXITURL` varchar(50) DEFAULT NULL,
   `FAX` varchar(50) DEFAULT NULL,
   `FIRSTNAME` varchar(50) DEFAULT NULL,
   `FROZEN` int(11) DEFAULT NULL,
   `GENDER` varchar(10) DEFAULT NULL,
   `GROUPCODE` int(11) DEFAULT NULL,
   `INACTIVE` int(11) DEFAULT NULL,
   `INTERNALACCOUNT` int(11) DEFAULT NULL,
   `ISCASHIER` int(11) DEFAULT NULL,
   `ISSPAMMER` int(11) DEFAULT NULL,
   `LANGUAGECODE` varchar(10) DEFAULT NULL,
   `LASTLOGINDATE` date DEFAULT NULL,
   `LASTNAME` varchar(50) DEFAULT NULL,
   `LOGINCOUNT` int(11) DEFAULT NULL,
   `MIGRATION_DATE` date DEFAULT NULL,
   `MINPAYOUT` int(11) DEFAULT NULL,
   `MOBILE` varchar(50) DEFAULT NULL,
   `NOPAYMENTFEES` int(11) DEFAULT NULL,
   `OCCUPATION` varchar(50) DEFAULT NULL,
   `PAGETOPMENUITEMS` varchar(50) DEFAULT NULL,
   `PASSWORD` varchar(50) DEFAULT NULL,
   `PAYMENTPROGRAM` varchar(50) DEFAULT NULL,
   `PAYMENTSTAMP` int(11) DEFAULT NULL,
   `PERCENTTYPECODE` int(11) DEFAULT NULL,
   `PHONE` int(11) DEFAULT NULL,
   `PLAYERNAMESINSTATS` int(11) DEFAULT NULL,
   `PPFIRSTDEPOSIT` int(11) DEFAULT NULL,
   `PPREVENUE` varchar(50) DEFAULT NULL,
   `PRIMARYPAYMENTMETHODCODE` int(11) DEFAULT NULL,
   `PROFILEID` varchar(50) DEFAULT NULL,
   `REFERERURL` varchar(50) DEFAULT NULL,
   `REMOTECREATE` int(11) DEFAULT NULL,
   `REVENUECALCTYPE` varchar(50) DEFAULT NULL,
   `RISKPROFILE` int(11) DEFAULT NULL,
   `SALESMAN` int(11) DEFAULT NULL,
   `SALESMANCODE` varchar(50) DEFAULT NULL,
   `SALESMANCOEFF` varchar(50) DEFAULT NULL,
   `SHOWFIELDS` varchar(500) DEFAULT NULL,
   `SHOWGETTINGSTARTED` int(11) DEFAULT NULL,
   `SHOWINSTATS` int(11) DEFAULT NULL,
   `SIGNUPDATE` datetime DEFAULT NULL,
   `STATE` varchar(50) DEFAULT NULL,
   `UNCHECKED` int(11) DEFAULT NULL,
   `UNSUBSCRIBEDATE` date DEFAULT NULL,
   `USERNAME` varchar(50) DEFAULT NULL,
   `WANTMAIL` int(11) DEFAULT NULL,
   `WEBSITE` varchar(50) DEFAULT NULL,
   `ZIP` int(11) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\CURL_Advertisers_2016-02-02.csv'
into table romaniaStg.Advertisers
fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

 --------------------

---------------------------new definition 
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

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\AdvertisersReport_2016-02-02.csv'
into table romaniaStg.Advertisers
fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';


*/

#Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\AdvertisersReport_2016-02-02.csv'
#into table romaniaStg.Advertisers
#fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

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
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\Players_search_by_parameters_2016-02-02.csv'
into table romaniastg.PlayerParameters
fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

select p.PlayerID,p.username,adv.email advEmail,advUsername,advcode,
case when lower(adv.email) = 'agentii@efortuna.ro' then 'RETAIL'
when lower(adv.email) like 'iulian.dumitru@efortuna.ro' or lower(adv.email) like 'superpont1x2@gmail.com' then 'DIGITAL'
when lower(adv.email) like 'defaulte8' then 'Generic'
else 'AFFILIATE' end advChannel,
pp.AgeVerificationResult,pp.InternalAccount,pp.Frozen,pp.SendPromotionalEMail,
pp.SendPromotionalSms,pp.DoNotCallPlayer,pp.BonusSeeker,pp.PlayerIsAdvertiser,
pp.RegistrationChecked,pp.FraudChecked,pp.AllowedToTransferMoneyToPlayers,
pp.AllowedToReceiveMoneyFromPlayers,pp.IPProxyPlayerFromNonRestrictedCountries,
pp.Suspended,pp.TaggedBy
from romaniastg.stg_ims_player p
left outer join romaniastg.PlayerParameters pp on p.username = pp.username
left outer join (select ns.username,coalesce(ad.email,affiliate) email, ad.username advUsername,ad.advertiserid advcode
from romaniastg.IMS_newSignup ns
left outer join romaniastg.advertisers ad on ns.affiliate = ad.username) adv on (adv.username = p.username)
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\DimPlayerPropertyAndChannel.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

Drop table romaniafl.Dim_Player_Channel;
Create table romaniafl.Dim_Player_Channel(
PlayerId integer,
Username varchar(50),
AdvEmail varchar(100),
AdvUsername  varchar(200),
AdvCode varchar(50) default null,
AdvChannel varchar(50),
AgeVerificationResult Varchar(100),
InternalAccount Varchar(20),
Frozen Varchar(20),
SendPromotionalEmail Varchar(20),
SendPromotionalSms Varchar(20),
DoNotCallPlayer Varchar(20),
BonusSeeker Varchar(20),
PlayerIsAdvertiser Varchar(20),
RegistrationChecked Varchar(20),
FraudChecked Varchar(20),
AllowedToTransferMoneyToPlayers Varchar(20),
AllowedToReceiveMoneyFromPlayers Varchar(20),
IpProxyPlayerFromNonRestrictedCountries Varchar(20),
Suspended Varchar(20),
TaggedBy Varchar(1000)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\Public\\Downloads\\DimPlayerPropertyAndChannel.csv'
into table romaniafl.Dim_Player_Channel
fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';