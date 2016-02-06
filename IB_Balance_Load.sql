#date change 2016-02-05
##Selective run

use romaniastg;

/*
drop table `STG_IMS_CSV_PLAYER`;
CREATE TABLE `STG_IMS_CSV_PLAYER` (
  `AccumulatedBetRefund` decimal(18,6) DEFAULT NULL,
  `ActivationCode` bigint default null ,
  `ActivationCodeRetryCount` int DEFAULT NULL,
  `ActivationCodeVerified` int DEFAULT NULL,
  `ActiveBonusCode` varchar(100) DEFAULT NULL,
  `ActivePendingBonusCode` varchar(100) DEFAULT NULL,
  `Address` varchar(500) DEFAULT NULL,
  `AddressTranslate` varchar(500) DEFAULT NULL,
  `AddressUpper` varchar(500) DEFAULT NULL,
  `Advertiser` int DEFAULT NULL,
  `AdvertiserCode` bigint DEFAULT NULL,
  `AgeVerification` varchar(100) DEFAULT NULL,
  `AgeVerificationDate` varchar(100) DEFAULT NULL,
  `AllBetsIncluded` int DEFAULT NULL,
  `OBAuthenticationPhone` varchar(100) DEFAULT NULL,
  `OBAuthenticationPhonePIN` varchar(100) DEFAULT NULL,
  `Balance` decimal(18,6) DEFAULT NULL,
  `BalanceVersion` int DEFAULT NULL,
  `BannerID` varchar(100) DEFAULT NULL,
  `OBBCBalance` varchar(50) DEFAULT NULL,
  `OBBCBonusBalance` varchar(50) DEFAULT NULL,
  `OBBCCurrentBet` varchar(50) DEFAULT NULL,
  `OBBCPendingBonusBalance` varchar(50) DEFAULT NULL,
  `BellaConnectAccount` int DEFAULT NULL,
  `BetFairCompPoints` decimal(18,6) DEFAULT NULL,
  `BillingSettingGroupCode` varchar(100) DEFAULT NULL,
  `BingoCustom1` varchar(100) DEFAULT NULL,
  `BingoCustom2` decimal(18,6) DEFAULT NULL,
  `OBBingoFrozen` char(1) DEFAULT NULL,
  `OBBingoNickname` varchar(100) DEFAULT NULL,
  `BirthCity` varchar(100) DEFAULT NULL,
  `BirthCountryCode` varchar(100) DEFAULT NULL,
  `BirthDate` varchar(50) DEFAULT NULL,
  `BirthDepartment` varchar(100) DEFAULT NULL,
  `BirthProvince` varchar(100) DEFAULT NULL,
  `BirthProvinceCode` varchar(100) DEFAULT NULL,
  `BlacklistCheckDate` varchar(50) DEFAULT NULL,
  `Blacklisted` int DEFAULT NULL,
  `BonusBalance` decimal(18,6) DEFAULT NULL,
  `BonusBalanceVersion` int DEFAULT NULL,
  `BonusExcludedGameWin` int DEFAULT NULL,
  `BonusExcludedGameWinResetDate` varchar(50) DEFAULT NULL,
  `BonusGroup` varchar(100) DEFAULT NULL,
  `BonusSeeker` int DEFAULT NULL,
  `OBCantDeposit` char(1) DEFAULT NULL,
  `OBCantDepositAll` char(1) DEFAULT NULL,
  `CasinoCode` int DEFAULT NULL,
  `Cellphone` varchar(20) DEFAULT NULL,
  `ChangePokerPlayerCode` varchar(100) DEFAULT NULL,
  `OBChatAdminCode` varchar(100) DEFAULT NULL,
  `OBChatKickPeriod` varchar(100) DEFAULT NULL,
  `OBChatKickTime` varchar(100) DEFAULT NULL,
  `OBChatMutePeriod` varchar(100) DEFAULT NULL,
  `OBChatMuteTime` varchar(100) DEFAULT NULL,
  `Citizenship` varchar(10) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `OBClientParameterCode` varchar(100) DEFAULT NULL,
  `OBClientVersion` varchar(100) DEFAULT NULL,
  `Code` bigint DEFAULT NULL,
  `Comments` varchar(500) DEFAULT NULL,
  `CompPoints` decimal(18,6) DEFAULT NULL,
  `CountryCode` varchar(100) DEFAULT NULL,
  `CouponName` varchar(100) DEFAULT NULL,
  `CurrencyCode` varchar(50) DEFAULT NULL,
  `CurrencyConversionRemainder` decimal(18,6) DEFAULT NULL,
  `CurrentBet` decimal(18,6) DEFAULT NULL,
  `CurrentBonusBet` decimal(18,6) DEFAULT NULL,
  `Custom01` varchar(100) DEFAULT NULL,
  `Custom02` varchar(100) DEFAULT NULL,
  `Custom03` varchar(50) DEFAULT NULL,
  `Custom04` varchar(50) DEFAULT NULL,
  `Custom05` varchar(100) DEFAULT NULL,
  `Custom06` varchar(100) DEFAULT NULL,
  `OBCustom07` varchar(50) DEFAULT NULL,
  `Custom08` varchar(50) DEFAULT NULL,
  `CustomClient01` varchar(100) DEFAULT NULL,
  `CustomClient02` varchar(100) DEFAULT NULL,
  `DepositGroupCode` int DEFAULT NULL,
  `DepositLimitAmount` decimal(18,6) DEFAULT NULL,
  `DepositLimitSetDate` varchar(50) DEFAULT NULL,
  `DepositLimitTimePeriod` varchar(100) DEFAULT NULL,
  `DepositRestrictions` int DEFAULT NULL,
  `DisableAllDeposits` int DEFAULT NULL,
  `DisableGaming` int DEFAULT NULL,
  `DisableHeldFunds` int DEFAULT NULL,
  `DonotCall` char(10) DEFAULT NULL,
  `DonotProcessWithdrawals` int DEFAULT NULL,
  `DriverLicenseNo` varchar(100) DEFAULT NULL,
  `DupSearchExclude` int DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `EmailVerified` int DEFAULT NULL,
  `EncryptionKeyVersion` varchar(100) DEFAULT NULL,
  `ExternalCreateType` varchar(100) DEFAULT NULL,
  `ExternalID` varchar(100) DEFAULT NULL,
  `FAX` varchar(100) DEFAULT NULL,
  `FirstDepositClientParameter` int DEFAULT NULL,
  `FirstLoginDate` varchar(50) DEFAULT NULL,
  `FirstName` varchar(100) DEFAULT NULL,
  `FirstNameSoundEx` varchar(100) DEFAULT NULL,
  `FraudAdminCode` int DEFAULT NULL,
  `FraudCheckDate` varchar(50) DEFAULT NULL,
  `FreezeChat` char(1) DEFAULT NULL,
  `Frozen` int DEFAULT NULL,
  `Gender` char(1) DEFAULT NULL,
  `GlobalFirstDepositDate` varchar(50) DEFAULT NULL,
  `GroupParentCode` int DEFAULT NULL,
  `HaveIDCopyFAX` int DEFAULT NULL,
  `HeardFrom` varchar(100) DEFAULT NULL,
  `Iban` varchar(100) DEFAULT NULL,
  `IDCardNo` varchar(100) DEFAULT NULL,
  `IncludeFirstDeposit` int DEFAULT NULL,
  `IncludeSignup` int DEFAULT NULL,
  `InternalAccount` int DEFAULT NULL,
  `OBIPProxyAllowed` varchar(100) DEFAULT NULL,
  `OBKickOut` varchar(100) DEFAULT NULL,
  `KioskAdminCode` int DEFAULT NULL,
  `KioskCode` int DEFAULT NULL,
  `OBLanguageCode` varchar(100) DEFAULT NULL,
  `OBLastFailedLogin` varchar(50) DEFAULT NULL,
  `OBLastLoginClientType` varchar(100) DEFAULT NULL,
  `OBLastLoginDate` varchar(50) DEFAULT NULL,
  `OBLastLoginKioskCode` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  `LastNameSoundEx` varchar(100) DEFAULT NULL,
  `LastNameUpper` varchar(100) DEFAULT NULL,
  `OBLastSupportChatSessionTime` varchar(100) DEFAULT NULL,
  `LoginCount` varchar(50) DEFAULT NULL,
  `LogMessages` int DEFAULT NULL,
  `MaxBalance` decimal(18,6) DEFAULT NULL,
  `MaxTotalBalance` decimal(18,6) DEFAULT NULL,
  `MobileGameRequestEmail` char(100) DEFAULT NULL,
  `MoneyReceiving` int DEFAULT NULL,
  `MoneySending` int DEFAULT NULL,
  `MoneyToRisk` decimal(18,6) DEFAULT NULL,
  `NoBonus` int DEFAULT NULL,
  `OBNtries` varchar(100) DEFAULT NULL,
  `Occupation` varchar(100) DEFAULT NULL,
  `OrigAdvertiserCode` int DEFAULT NULL,
  `OrigBannerID` varchar(100) DEFAULT NULL,
  `OrigProfileID` varchar(100) DEFAULT NULL,
  `OrigRefererURL` varchar(500) DEFAULT NULL,
  `PassportID` varchar(100) DEFAULT NULL,
  `OBPasswordChange` char(1) DEFAULT NULL,
  `OBPasswordChangeDate` varchar(50) DEFAULT NULL,
  `PendingBonusBalance` decimal(18,6) DEFAULT NULL,
  `PersonalID` varchar(100) DEFAULT NULL,
  `Phone` varchar(100) DEFAULT NULL,
  `PhoneTranslate` varchar(100) DEFAULT NULL,
  `PhoneUpper` varchar(100) DEFAULT NULL,
  `OBPINDisabled` varchar(100) DEFAULT NULL,
  `OBPINNumber` varchar(100) DEFAULT NULL,
  `OBPINRetryCount` varchar(50) DEFAULT NULL,
  `PlayerRiskProfileChangeDate` varchar(50) DEFAULT NULL,
  `PlayerRiskProfileCode` int DEFAULT NULL,
  `PlayersTS` varchar(100) DEFAULT NULL,
  `PlayerType` int DEFAULT NULL,
  `PokerBlocked` int DEFAULT NULL,
  `PokerCustom1` varchar(100) DEFAULT NULL,
  `PokerCustom2` decimal(18,6) DEFAULT NULL,
  `PokerFrozen` int DEFAULT NULL,
  `PokerNickname` varchar(100) DEFAULT NULL,
  `PokerVIPLevel` int DEFAULT NULL,
  `PostOfficeBOX` varchar(100) DEFAULT NULL,
  `ProfileID` varchar(100) DEFAULT NULL,
  `Province` varchar(100) DEFAULT NULL,
  `ProvinceCode` int DEFAULT NULL,
  `RefererURL` varchar(500) DEFAULT NULL,
  `RegionCode` int DEFAULT NULL,
  `RegistrationCheckDate` varchar(50) DEFAULT NULL,
  `RegulatorApproval` int DEFAULT NULL,
  `RemainingBonuses` decimal(18,6) DEFAULT NULL,
  `RemindAfterTimePeriod` int DEFAULT NULL,
  `RemindOnFirstBet` int DEFAULT NULL,
  `RemoteChangeTimestamp` varchar(50) DEFAULT NULL,
  `RemoteSync` int DEFAULT NULL,
  `ReservedBalance` decimal(18,6) DEFAULT NULL,
  `Serial` varchar(100) DEFAULT NULL,
  `SignupClientType` varchar(50) DEFAULT NULL,
  `SignupAdvertiserCode` int DEFAULT NULL,
  `SignupChannelCode` int DEFAULT NULL,
  `SignupClientParameterCode` int DEFAULT NULL,
  `SignupClientSkinCode` int DEFAULT NULL,
  `SignupDate` varchar(50) DEFAULT NULL,
  `SignupRemoteIP` varchar(20) DEFAULT NULL,
  `SignupVersion` varchar(100) DEFAULT NULL,
  `State` varchar(100) DEFAULT NULL,
  `SyncBetFairCompPoints` int DEFAULT NULL,
  `TempApproveDeposit` int DEFAULT NULL,
  `Title` varchar(100) DEFAULT NULL,
  `OBTokenStatus` varchar(100) DEFAULT NULL,
  `TotalCompPoints` decimal(18,6) DEFAULT NULL,
  `TrackingID1` varchar(100) DEFAULT NULL,
  `TrackingID2` varchar(100) DEFAULT NULL,
  `TrackingID3` decimal(18,6) DEFAULT NULL,
  `TrackingID4` varchar(100) DEFAULT NULL,
  `TrackingID5` varchar(100) DEFAULT NULL,
  `TrackingID6` varchar(100) DEFAULT NULL,
  `TrackingID7` varchar(100) DEFAULT NULL,
  `TrackingID8` varchar(100) DEFAULT NULL,
  `UnsubscribeDate` varchar(50) DEFAULT NULL,
  `Username` varchar(100) DEFAULT NULL,
  `OBVerificationAnswer` varchar(100) DEFAULT NULL,
  `OBVerificationQuestion` varchar(100) DEFAULT NULL,
  `VideoBet` int DEFAULT NULL,
  `VIPLevel` int DEFAULT NULL,
  `VIPLevelUPDate` varchar(50) DEFAULT NULL,
  `Wagering` decimal(18,6) DEFAULT NULL,
  `WageringRealLoss` decimal(18,6) DEFAULT NULL,
  `OBWantMail` char(1) DEFAULT NULL,
  `OBWantSMS` char(1) DEFAULT NULL,
  `WithdrawVerifyCode` varchar(100) DEFAULT NULL,
  `WorkPhone` varchar(100) DEFAULT NULL,
  `ZIP` varchar(100) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\Curl_Player.csv'
into table STG_IMS_CSV_PLAYER
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'; 

*/

select
  Code as Playerid
, STR_TO_DATE('2016-02-05', '%Y-%m-%d %H:%i:%s') AS SummaryDate
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

select 
SummaryDate, 
SUM(Balance) as TotalBalance, 
SUM(BonusBalance) as TotalBonusBalance,  
count(distinct PlayerId) 
from romaniamain.FD_DAILY_PLAYER_BALANCE
where SignupDate >= '2015-11-26'
group by SummaryDate;


/*
select * 
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\STG_DAILY_PLAYER_BALANCE_bkp.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
from romaniamain.FD_DAILY_PLAYER_BALANCE where SummaryDate <= '2015-12-11';
Load data infile 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\STG_DAILY_PLAYER_BALANCE_bkp.csv'
into table romaniamain.FD_DAILY_PLAYER_BALANCE
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n';
*/