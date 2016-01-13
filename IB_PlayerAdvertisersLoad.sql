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

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\DailyDump\\New_signups.csv'
into table romaniaStg.IMS_newSignup
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n';


/*
#if advertisers are more than 1187
drop table romaniaStg.Advertisers;
Create table romaniaStg.Advertisers(
ADDRESS	varchar(100)	DEFAULT NULL,
ADVANCEDVIEW	integer	DEFAULT NULL,
ADVERTISERS_TS	date	DEFAULT NULL,
ADVERTISERTYPE	varchar(50)	DEFAULT NULL,
ADVSELECTEDFIELDS	varchar(500)	DEFAULT NULL,
ADVSYSTEMCODE	integer	DEFAULT NULL,
AUTOMATICREVENUEWRITEOFF	integer	DEFAULT NULL,
AVAILABLEBALANCE	integer	DEFAULT NULL,
BALANCE	integer	DEFAULT NULL,
BANNERID	varchar(50)	DEFAULT NULL,
BIRTHDATE	date	DEFAULT NULL,
CASHIERLIMIT	integer	DEFAULT NULL,
CITY	varchar(50)	DEFAULT NULL,
CODE	integer	DEFAULT NULL,
COMMENTS	varchar(50)	DEFAULT NULL,
COMPANY	varchar(50)	DEFAULT NULL,
CONTROLEXIT	integer	DEFAULT NULL,
COUNTRYCODE	varchar(50)	DEFAULT NULL,
CURRENCYCODE	varchar(10)	DEFAULT NULL,
DEFAULTVIPLEVEL	integer	DEFAULT NULL,
EMAIL	varchar(50)	DEFAULT NULL,
ENABLEDREPORTS	varchar(200)	DEFAULT NULL,
EXITURL	varchar(50)	DEFAULT NULL,
FAX	varchar(50)	DEFAULT NULL,
FIRSTNAME	varchar(50)	DEFAULT NULL,
FROZEN	integer	DEFAULT NULL,
GENDER	varchar(10)	DEFAULT NULL,
GROUPCODE	integer	DEFAULT NULL,
INACTIVE	integer	DEFAULT NULL,
INTERNALACCOUNT	integer	DEFAULT NULL,
ISCASHIER	integer	DEFAULT NULL,
ISSPAMMER	integer	DEFAULT NULL,
LANGUAGECODE	varchar(10)	DEFAULT NULL,
LASTLOGINDATE	date	DEFAULT NULL,
LASTNAME	varchar(50)	DEFAULT NULL,
LOGINCOUNT	integer	DEFAULT NULL,
MIGRATION_DATE	date	DEFAULT NULL,
MINPAYOUT	integer	DEFAULT NULL,
MOBILE	varchar(50)	DEFAULT NULL,
NOPAYMENTFEES	integer	DEFAULT NULL,
OCCUPATION	varchar(50)	DEFAULT NULL,
PAGETOPMENUITEMS	varchar(50)	DEFAULT NULL,
PASSWORD	varchar(50)	DEFAULT NULL,
PAYMENTPROGRAM	varchar(50)	DEFAULT NULL,
PAYMENTSTAMP	integer	DEFAULT NULL,
PERCENTTYPECODE	integer	DEFAULT NULL,
PHONE	integer	DEFAULT NULL,
PLAYERNAMESINSTATS	integer	DEFAULT NULL,
PPFIRSTDEPOSIT	integer	DEFAULT NULL,
PPREVENUE	varchar(50)	DEFAULT NULL,
PRIMARYPAYMENTMETHODCODE	integer	DEFAULT NULL,
PROFILEID	varchar(50)	DEFAULT NULL,
REFERERURL	varchar(50)	DEFAULT NULL,
REMOTECREATE	integer	DEFAULT NULL,
REVENUECALCTYPE	varchar(50)	DEFAULT NULL,
RISKPROFILE	integer	DEFAULT NULL,
SALESMAN	integer	DEFAULT NULL,
SALESMANCODE	varchar(50)	DEFAULT NULL,
SALESMANCOEFF	varchar(50)	DEFAULT NULL,
SHOWFIELDS	varchar(500)	DEFAULT NULL,
SHOWGETTINGSTARTED	integer	DEFAULT NULL,
SHOWINSTATS	integer	DEFAULT NULL,
SIGNUPDATE	datetime	DEFAULT NULL,
STATE	varchar(50)	DEFAULT NULL,
UNCHECKED	integer	DEFAULT NULL,
UNSUBSCRIBEDATE	date	DEFAULT NULL,
USERNAME	varchar(50)	DEFAULT NULL,
WANTMAIL	integer	DEFAULT NULL,
WEBSITE	varchar(50)	DEFAULT NULL,
ZIP	integer	DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\CURL_Advertisers.csv'
into table romaniaStg.Advertisers
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n';*/


select p.PlayerID,p.username,adv.email advEmail,advUsername,
case when lower(adv.email) = 'agentii@efortuna.ro' then 'RETAIL'
when lower(adv.email) like 'iulian.dumitru@efortuna.ro' or lower(adv.email) like 'superpont1x2@gmail.com' then 'DIGITAL'
when lower(adv.email) like 'defaulte8' then 'Generic'
else 'AFFILIATE' end advChannel 
from romaniastg.stg_ims_player p
left outer join (select ns.username,coalesce(ad.email,affiliate) email, ad.username advUsername
from romaniastg.IMS_newSignup ns
left outer join romaniastg.advertisers ad on ns.affiliate = ad.username) adv on (adv.username = p.username)
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\DimPlayerChannel.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';