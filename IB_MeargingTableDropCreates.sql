
drop table `testrostg`.`rw_logins`;
CREATE TABLE `testrostg`.`rw_logins` (
ClientType varchar(200) DEFAULT NULL,
Code varchar(200) DEFAULT NULL,
EndBalance varchar(200) DEFAULT NULL,
EndBonusBalance varchar(200) DEFAULT NULL,
FunPlayerCode varchar(200) DEFAULT NULL,
HwSerial varchar(200) DEFAULT NULL,
IP varchar(200) DEFAULT NULL,
KioskCode varchar(200) DEFAULT NULL,
LoginDate varchar(200) DEFAULT NULL,
LogoutDate varchar(200) DEFAULT NULL,
PlayerCode varchar(200) DEFAULT NULL,
PlayerType varchar(200) DEFAULT NULL,
Serial_ varchar(200) DEFAULT NULL,
ServerCode varchar(200) DEFAULT NULL,
SessionID varchar(200) DEFAULT NULL,
Startbalance varchar(200) DEFAULT NULL,
Startbonusbalance varchar(200) DEFAULT NULL,
Version varchar(200) DEFAULT NULL,
ClientPlatform varchar(200) DEFAULT NULL,
LoginDeviceTypeCode varchar(200) DEFAULT NULL,
LoginVenueCode varchar(200) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table `testrostg`.`c_logins`;
CREATE TABLE `testrostg`.`c_logins` (
   `ClientType` varchar(200) DEFAULT NULL,
   `Code` int(9) DEFAULT NULL,
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
   `Serial` int(9) DEFAULT NULL,
   `ServerCode` int(9) DEFAULT NULL,
   `SessionID` varchar(200) DEFAULT NULL,
   `Startbalance` decimal(18,6) DEFAULT NULL,
   `Startbonusbalance` decimal(18,6) DEFAULT NULL,
   `Version` varchar(200) DEFAULT NULL,
   `ClientPlatform` varchar(200) DEFAULT NULL,
   `LoginDeviceTypeCode` int(9) DEFAULT NULL,
   `LoginVenueCode` int(9) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
 
drop table `testrostg`.`stg_daily_player_logins`;
CREATE TABLE `testrostg`.`stg_daily_player_logins` (
   SummaryDate date,
   PlayerCode int(10),
   PlayerType varchar(50) DEFAULT NULL,
   LoginDate datetime DEFAULT NULL,
   LogoutDate datetime DEFAULT NULL,
   StartBalance decimal(18,6) DEFAULT NULL,
   StartBonusBalance decimal(18,6) DEFAULT NULL,
   EndBalance decimal(18,6) DEFAULT NULL,
   EndBonusBalance decimal(18,6) DEFAULT NULL,
   ClientType varchar(200) DEFAULT NULL,
   Code int(9) DEFAULT NULL,
   FunPlayerCode int(9) DEFAULT NULL,
   HwSerial int(9) DEFAULT NULL,
   IP varchar(200) DEFAULT NULL,
   KioskCode int(9) DEFAULT NULL,
   Serial int(9) DEFAULT NULL,
   ServerCode int(9) DEFAULT NULL,
   SessionID varchar(200) DEFAULT NULL,
   Version varchar(200) DEFAULT NULL,
   ClientPlatform varchar(200) DEFAULT NULL,
   LoginDeviceTypeCode int(9) DEFAULT NULL,
   LoginVenueCode int(9) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;


drop table `testrostg`.`STG_GIT_CSV_CUSTOMER`;
CREATE TABLE `testrostg`.`STG_GIT_CSV_CUSTOMER` (
  `PlayerSPId` bigint(20),
  `Username` varchar(200) DEFAULT NULL,
  `FirstName` varchar(200) DEFAULT NULL,
  `LastName` varchar(200) DEFAULT NULL,
  `PlayerSPSegName` varchar(200) DEFAULT NULL,
  `AllowBonus` varchar(10) DEFAULT NULL,
  `PlayerCurrency` varchar(10) DEFAULT NULL,
  `PlayerSPRating` decimal(18,6) DEFAULT NULL,
  `PlayerSPRatingLive` decimal(18,6) DEFAULT NULL,
  `PlayerSPStakeLimit` decimal(18,6) DEFAULT NULL,
  `PlayerSPStakeLimitLive` decimal(18,6) DEFAULT NULL,
  `Operator` varchar(200) DEFAULT NULL,
  `Advertiser` varchar(200) DEFAULT NULL,
  `CasinoName` varchar(200) DEFAULT NULL,
  `TestYN` varchar(5) DEFAULT NULL,
  `CreationDate` varchar(40) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table `testrostg`.`STG_GIT_CUSTOMER`;
CREATE TABLE `testrostg`.`STG_GIT_CUSTOMER` (
  PlayerSPId bigint,
  Username varchar(100) DEFAULT NULL,
  FirstName varchar(100) DEFAULT NULL,
  LastName varchar(100) DEFAULT NULL,
  PlayerSPSegName varchar(500) DEFAULT NULL,
  AllowBonus varchar(10) DEFAULT NULL,
  PlayerCurrency varchar(10) DEFAULT NULL,
  PlayerSPRating decimal(18,6) DEFAULT NULL,
  PlayerSPRatingLive decimal(18,6) DEFAULT NULL,
  PlayerSPStakeLimit decimal(18,6) DEFAULT NULL,
  PlayerSPStakeLimitLive decimal(18,6) DEFAULT NULL,
  OperatorSP varchar(200) DEFAULT NULL,
  AdvertiserSP varchar(200) DEFAULT NULL,
  CasinoNameSp varchar(200) DEFAULT NULL,
  TestYNSP varchar(5) DEFAULT NULL,
  CreationDateSP datetime,
  RomDummy int
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table `testrostg`.`STG_IMS_CSV_PLAYER`;
CREATE TABLE `testrostg`.`STG_IMS_CSV_PLAYER` (
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


drop table `testrostg`.STG_IMS_PLAYER;
CREATE TABLE `testrostg`.STG_IMS_PLAYER (
  AccumulatedBetRefund decimal(18,6) DEFAULT NULL,
  ActivationCode bigint default null ,
  ActivationCodeRetryCount int DEFAULT NULL,
  ActivationCodeVerified int DEFAULT NULL,
  ActiveBonusCode varchar(100) DEFAULT NULL,
  ActivePendingBonusCode varchar(100) DEFAULT NULL,
  Address varchar(500) DEFAULT NULL,
  AddressTranslate varchar(500) DEFAULT NULL,
  AddressUpper varchar(500) DEFAULT NULL,
  Advertiser int DEFAULT NULL,
  AdvertiserCode bigint DEFAULT NULL,
  AgeVerification varchar(100) DEFAULT NULL,
  AgeVerificationDate datetime DEFAULT NULL,
  AllBetsIncluded int DEFAULT NULL,
  Balance decimal(18,6) DEFAULT NULL,
  BalanceVersion int DEFAULT NULL,
  BannerID varchar(100) DEFAULT NULL,
  BellaConnectAccount int DEFAULT NULL,
  BetFairCompPoints decimal(18,6) DEFAULT NULL,
  BillingSettingGroupCode varchar(100) DEFAULT NULL,
  BingoCustom1 varchar(100) DEFAULT NULL,
  BingoCustom2 decimal(18,6) DEFAULT NULL,
  BirthCity varchar(100) DEFAULT NULL,
  BirthCountryCode varchar(100) DEFAULT NULL,
  BirthDate date DEFAULT NULL,
  BirthDepartment varchar(100) DEFAULT NULL,
  BirthProvince varchar(100) DEFAULT NULL,
  BirthProvinceCode varchar(100) DEFAULT NULL,
  BlacklistCheckDate datetime DEFAULT NULL,
  Blacklisted int DEFAULT NULL,
  BonusBalance decimal(18,6) DEFAULT NULL,
  BonusBalanceVersion int DEFAULT NULL,
  BonusExcludedGameWin int DEFAULT NULL,
  BonusExcludedGameWinResetDate datetime DEFAULT NULL,
  BonusGroup varchar(100) DEFAULT NULL,
  BonusSeeker int DEFAULT NULL,
  CasinoCode int DEFAULT NULL,
  Cellphone varchar(20) DEFAULT NULL,
  ChangePokerPlayerCode varchar(100) DEFAULT NULL,
  Citizenship varchar(10) DEFAULT NULL,
  City varchar(100) DEFAULT NULL,
  PlayerID bigint DEFAULT NULL,
  Comments varchar(500) DEFAULT NULL,
  CompPoints decimal(18,6) DEFAULT NULL,
  CountryCode varchar(100) DEFAULT NULL,
  CouponName varchar(100) DEFAULT NULL,
  CurrencyCode varchar(50) DEFAULT NULL,
  CurrencyConversionRemainder decimal(18,6) DEFAULT NULL,
  CurrentBet decimal(18,6) DEFAULT NULL,
  CurrentBonusBet decimal(18,6) DEFAULT NULL,
  Custom01 varchar(100) DEFAULT NULL,
  Custom02 varchar(100) DEFAULT NULL,
  Custom03 varchar(50) DEFAULT NULL,
  Custom04 varchar(50) DEFAULT NULL,
  Custom05 varchar(100) DEFAULT NULL,
  Custom06 varchar(100) DEFAULT NULL,
  Custom08 varchar(50) DEFAULT NULL,
  CustomClient01 varchar(100) DEFAULT NULL,
  CustomClient02 varchar(100) DEFAULT NULL,
  DepositGroupCode int DEFAULT NULL,
  DepositLimitAmount decimal(18,6) DEFAULT NULL,
  DepositLimitSetDate datetime DEFAULT NULL,
  DepositLimitTimePeriod varchar(100) DEFAULT NULL,
  DepositRestrictions int DEFAULT NULL,
  DisableAllDeposits int DEFAULT NULL,
  DisableGaming int DEFAULT NULL,
  DisableHeldFunds int DEFAULT NULL,
  DonotCall char(10) DEFAULT NULL,
  DonotProcessWithdrawals int DEFAULT NULL,
  DriverLicenseNo varchar(100) DEFAULT NULL,
  DupSearchExclude int DEFAULT NULL,
  Email varchar(100) DEFAULT NULL,
  EmailVerified int DEFAULT NULL,
  EncryptionKeyVersion varchar(100) DEFAULT NULL,
  ExternalCreateType varchar(100) DEFAULT NULL,
  ExternalID varchar(100) DEFAULT NULL,
  FAX varchar(100) DEFAULT NULL,
  FirstDepositClientParameter int DEFAULT NULL,
  FirstLoginDate datetime DEFAULT NULL,
  FirstName varchar(100) DEFAULT NULL,
  FirstNameSoundEx varchar(100) DEFAULT NULL,
  FraudAdminCode int DEFAULT NULL,
  FraudCheckDate datetime DEFAULT NULL,
  FreezeChat char(1) DEFAULT NULL,
  Frozen int DEFAULT NULL,
  Gender char(1) DEFAULT NULL,
  GlobalFirstDepositDate datetime DEFAULT NULL,
  GroupParentCode int DEFAULT NULL,
  HaveIDCopyFAX int DEFAULT NULL,
  HeardFrom varchar(100) DEFAULT NULL,
  Iban varchar(100) DEFAULT NULL,
  IDCardNo varchar(100) DEFAULT NULL,
  IncludeFirstDeposit int DEFAULT NULL,
  IncludeSignup int DEFAULT NULL,
  InternalAccount int DEFAULT NULL,
  KioskAdminCode int DEFAULT NULL,
  KioskCode int DEFAULT NULL,
  LastName varchar(100) DEFAULT NULL,
  LastNameSoundEx varchar(100) DEFAULT NULL,
  LastNameUpper varchar(100) DEFAULT NULL,
  LoginCount varchar(50) DEFAULT NULL,
  LogMessages int DEFAULT NULL,
  MaxBalance decimal(18,6) DEFAULT NULL,
  MaxTotalBalance decimal(18,6) DEFAULT NULL,
  MobileGameRequestEmail char(100) DEFAULT NULL,
  MoneyReceiving int DEFAULT NULL,
  MoneySending int DEFAULT NULL,
  MoneyToRisk decimal(18,6) DEFAULT NULL,
  NoBonus int DEFAULT NULL,
  Occupation varchar(100) DEFAULT NULL,
  OrigAdvertiserCode int DEFAULT NULL,
  OrigBannerID varchar(100) DEFAULT NULL,
  OrigProfileID varchar(100) DEFAULT NULL,
  OrigRefererURL varchar(500) DEFAULT NULL,
  PassportID varchar(100) DEFAULT NULL,
  PendingBonusBalance decimal(18,6) DEFAULT NULL,
  PersonalID varchar(100) DEFAULT NULL,
  Phone varchar(100) DEFAULT NULL,
  PhoneTranslate varchar(100) DEFAULT NULL,
  PhoneUpper varchar(100) DEFAULT NULL,
  PlayerRiskProfileChangeDate datetime DEFAULT NULL,
  PlayerRiskProfileCode int DEFAULT NULL,
  LastUpsTimestamp datetime DEFAULT NULL,
  PlayerType int DEFAULT NULL,
  PokerBlocked int DEFAULT NULL,
  PokerCustom1 varchar(100) DEFAULT NULL,
  PokerCustom2 decimal(18,6) DEFAULT NULL,
  PokerFrozen int DEFAULT NULL,
  PokerNickname varchar(100) DEFAULT NULL,
  PokerVIPLevel int DEFAULT NULL,
  PostOfficeBOX varchar(100) DEFAULT NULL,
  ProfileID varchar(100) DEFAULT NULL,
  Province varchar(100) DEFAULT NULL,
  ProvinceCode int DEFAULT NULL,
  RefererURL varchar(500) DEFAULT NULL,
  RegionCode int DEFAULT NULL,
  RegistrationCheckDate datetime DEFAULT NULL,
  RegulatorApproval int DEFAULT NULL,
  RemainingBonuses decimal(18,6) DEFAULT NULL,
  RemindAfterTimePeriod int DEFAULT NULL,
  RemindOnFirstBet int DEFAULT NULL,
  RemoteChangeTimestamp datetime DEFAULT NULL,
  RemoteSync int DEFAULT NULL,
  ReservedBalance decimal(18,6) DEFAULT NULL,
  Serial varchar(100) DEFAULT NULL,
  SignupClientType varchar(50) DEFAULT NULL,
  SignupAdvertiserCode int DEFAULT NULL,
  SignupChannelCode int DEFAULT NULL,
  SignupClientParameterCode int DEFAULT NULL,
  SignupClientSkinCode int DEFAULT NULL,
  SignupDate datetime DEFAULT NULL,
  SignupRemoteIP varchar(20) DEFAULT NULL,
  SignupVersion varchar(100) DEFAULT NULL,
  State varchar(100) DEFAULT NULL,
  SyncBetFairCompPoints int DEFAULT NULL,
  TempApproveDeposit int DEFAULT NULL,
  Title varchar(100) DEFAULT NULL,
  TotalCompPoints decimal(18,6) DEFAULT NULL,
  TrackingID1 varchar(100) DEFAULT NULL,
  TrackingID2 varchar(100) DEFAULT NULL,
  TrackingID3 decimal(18,6) DEFAULT NULL,
  TrackingID4 varchar(100) DEFAULT NULL,
  TrackingID5 varchar(100) DEFAULT NULL,
  TrackingID6 varchar(100) DEFAULT NULL,
  TrackingID7 varchar(100) DEFAULT NULL,
  TrackingID8 varchar(100) DEFAULT NULL,
  UnsubscribeDate datetime DEFAULT NULL,
  Username varchar(100) DEFAULT NULL,
  VideoBet int DEFAULT NULL,
  VIPLevel int DEFAULT NULL,
  VIPLevelUPDate datetime DEFAULT NULL,
  Wagering decimal(18,6) DEFAULT NULL,
  WageringRealLoss decimal(18,6) DEFAULT NULL,
  WithdrawVerifyCode varchar(100) DEFAULT NULL,
  WorkPhone varchar(100) DEFAULT NULL,
  ZIP varchar(100) DEFAULT NULL,
  RomDummy int
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
drop table `testromain`.`DIM_PLAYER`;
CREATE TABLE `testromain`.`DIM_PLAYER` (
  AccumulatedBetRefund decimal(18,6) DEFAULT NULL,
  ActivationCode bigint default null ,
  ActivationCodeRetryCount int DEFAULT NULL,
  ActivationCodeVerified int DEFAULT NULL,
  ActiveBonusCode varchar(100) DEFAULT NULL,
  ActivePendingBonusCode varchar(100) DEFAULT NULL,
  Address varchar(500) DEFAULT NULL,
  AddressTranslate varchar(500) DEFAULT NULL,
  AddressUpper varchar(500) DEFAULT NULL,
  Advertiser int DEFAULT NULL,
  AdvertiserCode bigint DEFAULT NULL,
  AgeVerification varchar(100) DEFAULT NULL,
  AgeVerificationDate datetime DEFAULT NULL,
  AllBetsIncluded int DEFAULT NULL,
  Balance decimal(18,6) DEFAULT NULL,
  BalanceVersion int DEFAULT NULL,
  BannerID varchar(100) DEFAULT NULL,
  BellaConnectAccount int DEFAULT NULL,
  BetFairCompPoints decimal(18,6) DEFAULT NULL,
  BillingSettingGroupCode varchar(100) DEFAULT NULL,
  BingoCustom1 varchar(100) DEFAULT NULL,
  BingoCustom2 decimal(18,6) DEFAULT NULL,
  BirthCity varchar(100) DEFAULT NULL,
  BirthCountryCode varchar(100) DEFAULT NULL,
  BirthDate date DEFAULT NULL,
  BirthDepartment varchar(100) DEFAULT NULL,
  BirthProvince varchar(100) DEFAULT NULL,
  BirthProvinceCode varchar(100) DEFAULT NULL,
  BlacklistCheckDate datetime DEFAULT NULL,
  Blacklisted int DEFAULT NULL,
  BonusBalance decimal(18,6) DEFAULT NULL,
  BonusBalanceVersion int DEFAULT NULL,
  BonusExcludedGameWin int DEFAULT NULL,
  BonusExcludedGameWinResetDate datetime DEFAULT NULL,
  BonusGroup varchar(100) DEFAULT NULL,
  BonusSeeker int DEFAULT NULL,
  CasinoCode int DEFAULT NULL,
  Cellphone varchar(20) DEFAULT NULL,
  ChangePokerPlayerCode varchar(100) DEFAULT NULL,
  Citizenship varchar(10) DEFAULT NULL,
  City varchar(100) DEFAULT NULL,
  PlayerID bigint DEFAULT NULL,
  Comments varchar(500) DEFAULT NULL,
  CompPoints decimal(18,6) DEFAULT NULL,
  CountryCode varchar(100) DEFAULT NULL,
  CouponName varchar(100) DEFAULT NULL,
  CurrencyCode varchar(50) DEFAULT NULL,
  CurrencyConversionRemainder decimal(18,6) DEFAULT NULL,
  CurrentBet decimal(18,6) DEFAULT NULL,
  CurrentBonusBet decimal(18,6) DEFAULT NULL,
  Custom01 varchar(100) DEFAULT NULL,
  Custom02 varchar(100) DEFAULT NULL,
  Custom03 varchar(50) DEFAULT NULL,
  Custom04 varchar(50) DEFAULT NULL,
  Custom05 varchar(100) DEFAULT NULL,
  Custom06 varchar(100) DEFAULT NULL,
  Custom08 varchar(50) DEFAULT NULL,
  CustomClient01 varchar(100) DEFAULT NULL,
  CustomClient02 varchar(100) DEFAULT NULL,
  DepositGroupCode int DEFAULT NULL,
  DepositLimitAmount decimal(18,6) DEFAULT NULL,
  DepositLimitSetDate datetime DEFAULT NULL,
  DepositLimitTimePeriod varchar(100) DEFAULT NULL,
  DepositRestrictions int DEFAULT NULL,
  DisableAllDeposits int DEFAULT NULL,
  DisableGaming int DEFAULT NULL,
  DisableHeldFunds int DEFAULT NULL,
  DonotCall char(10) DEFAULT NULL,
  DonotProcessWithdrawals int DEFAULT NULL,
  DriverLicenseNo varchar(100) DEFAULT NULL,
  DupSearchExclude int DEFAULT NULL,
  Email varchar(100) DEFAULT NULL,
  EmailVerified int DEFAULT NULL,
  EncryptionKeyVersion varchar(100) DEFAULT NULL,
  ExternalCreateType varchar(100) DEFAULT NULL,
  ExternalID varchar(100) DEFAULT NULL,
  FAX varchar(100) DEFAULT NULL,
  FirstDepositClientParameter int DEFAULT NULL,
  FirstLoginDate datetime DEFAULT NULL,
  FirstName varchar(100) DEFAULT NULL,
  FirstNameSoundEx varchar(100) DEFAULT NULL,
  FraudAdminCode int DEFAULT NULL,
  FraudCheckDate datetime DEFAULT NULL,
  FreezeChat char(1) DEFAULT NULL,
  Frozen int DEFAULT NULL,
  Gender char(1) DEFAULT NULL,
  GlobalFirstDepositDate datetime DEFAULT NULL,
  GroupParentCode int DEFAULT NULL,
  HaveIDCopyFAX int DEFAULT NULL,
  HeardFrom varchar(100) DEFAULT NULL,
  Iban varchar(100) DEFAULT NULL,
  IDCardNo varchar(100) DEFAULT NULL,
  IncludeFirstDeposit int DEFAULT NULL,
  IncludeSignup int DEFAULT NULL,
  InternalAccount int DEFAULT NULL,
  KioskAdminCode int DEFAULT NULL,
  KioskCode int DEFAULT NULL,
  LastName varchar(100) DEFAULT NULL,
  LastNameSoundEx varchar(100) DEFAULT NULL,
  LastNameUpper varchar(100) DEFAULT NULL,
  LoginCount varchar(50) DEFAULT NULL,
  LogMessages int DEFAULT NULL,
  MaxBalance decimal(18,6) DEFAULT NULL,
  MaxTotalBalance decimal(18,6) DEFAULT NULL,
  MobileGameRequestEmail char(100) DEFAULT NULL,
  MoneyReceiving int DEFAULT NULL,
  MoneySending int DEFAULT NULL,
  MoneyToRisk decimal(18,6) DEFAULT NULL,
  NoBonus int DEFAULT NULL,
  Occupation varchar(100) DEFAULT NULL,
  OrigAdvertiserCode int DEFAULT NULL,
  OrigBannerID varchar(100) DEFAULT NULL,
  OrigProfileID varchar(100) DEFAULT NULL,
  OrigRefererURL varchar(500) DEFAULT NULL,
  PassportID varchar(100) DEFAULT NULL,
  PendingBonusBalance decimal(18,6) DEFAULT NULL,
  PersonalID varchar(100) DEFAULT NULL,
  Phone varchar(100) DEFAULT NULL,
  PhoneTranslate varchar(100) DEFAULT NULL,
  PhoneUpper varchar(100) DEFAULT NULL,
  PlayerRiskProfileChangeDate datetime DEFAULT NULL,
  PlayerRiskProfileCode int DEFAULT NULL,
  LastUpsTimestamp datetime DEFAULT NULL,
  PlayerType int DEFAULT NULL,
  PokerBlocked int DEFAULT NULL,
  PokerCustom1 varchar(100) DEFAULT NULL,
  PokerCustom2 decimal(18,6) DEFAULT NULL,
  PokerFrozen int DEFAULT NULL,
  PokerNickname varchar(100) DEFAULT NULL,
  PokerVIPLevel int DEFAULT NULL,
  PostOfficeBOX varchar(100) DEFAULT NULL,
  ProfileID varchar(100) DEFAULT NULL,
  Province varchar(100) DEFAULT NULL,
  ProvinceCode int DEFAULT NULL,
  RefererURL varchar(500) DEFAULT NULL,
  RegionCode int DEFAULT NULL,
  RegistrationCheckDate datetime DEFAULT NULL,
  RegulatorApproval int DEFAULT NULL,
  RemainingBonuses decimal(18,6) DEFAULT NULL,
  RemindAfterTimePeriod int DEFAULT NULL,
  RemindOnFirstBet int DEFAULT NULL,
  RemoteChangeTimestamp datetime DEFAULT NULL,
  RemoteSync int DEFAULT NULL,
  ReservedBalance decimal(18,6) DEFAULT NULL,
  Serial varchar(100) DEFAULT NULL,
  SignupClientType varchar(50) DEFAULT NULL,
  SignupAdvertiserCode int DEFAULT NULL,
  SignupChannelCode int DEFAULT NULL,
  SignupClientParameterCode int DEFAULT NULL,
  SignupClientSkinCode int DEFAULT NULL,
  SignupDate datetime DEFAULT NULL,
  SignupRemoteIP varchar(20) DEFAULT NULL,
  SignupVersion varchar(100) DEFAULT NULL,
  State varchar(100) DEFAULT NULL,
  SyncBetFairCompPoints int DEFAULT NULL,
  TempApproveDeposit int DEFAULT NULL,
  Title varchar(100) DEFAULT NULL,
  TotalCompPoints decimal(18,6) DEFAULT NULL,
  TrackingID1 varchar(100) DEFAULT NULL,
  TrackingID2 varchar(100) DEFAULT NULL,
  TrackingID3 decimal(18,6) DEFAULT NULL,
  TrackingID4 varchar(100) DEFAULT NULL,
  TrackingID5 varchar(100) DEFAULT NULL,
  TrackingID6 varchar(100) DEFAULT NULL,
  TrackingID7 varchar(100) DEFAULT NULL,
  TrackingID8 varchar(100) DEFAULT NULL,
  UnsubscribeDate datetime DEFAULT NULL,
  Username varchar(100) DEFAULT NULL,
  VideoBet int DEFAULT NULL,
  VIPLevel int DEFAULT NULL,
  VIPLevelUPDate datetime DEFAULT NULL,
  Wagering decimal(18,6) DEFAULT NULL,
  WageringRealLoss decimal(18,6) DEFAULT NULL,
  WithdrawVerifyCode varchar(100) DEFAULT NULL,
  WorkPhone varchar(100) DEFAULT NULL,
  ZIP varchar(100) DEFAULT NULL,
  RomDummy int,
  PlayerSPId bigint default null,
  PlayerSPSegName varchar(200) DEFAULT NULL,
  AllowSPBonus varchar(10) DEFAULT NULL,
  PlayerSPCurrency varchar(10) DEFAULT NULL,
  PlayerSPRating decimal(18,6) DEFAULT NULL,
  PlayerSPRatingLive decimal(18,6) DEFAULT NULL,
  PlayerSPStakeLimit decimal(18,6) DEFAULT NULL,
  PlayerSPStakeLimitLive decimal(18,6) DEFAULT NULL,
  OperatorSP varchar(200) DEFAULT NULL,
  AdvertiserSP varchar(200) DEFAULT NULL,
  SPCasinoNameSP varchar(200) DEFAULT NULL,
  TestYNSP varchar(5) DEFAULT NULL,
  CreationDateSP datetime DEFAULT NULL
 )ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
drop table  `testrostg`.`STG_Exchange_Rate`;
CREATE TABLE `testrostg`.`STG_Exchange_Rate` (
  `EffectiveTimestamp` datetime DEFAULT NULL,
  `LastUpdTimestamp` datetime DEFAULT NULL,
  `CurrencyCode` varchar(20) DEFAULT NULL,
  `XchangeRate` double(24,18) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table  `testrostg`.`CSV_TO_STG`;
Create table `testrostg`.`CSV_TO_STG` (
  TxnTime varchar(200)
, AcceptTime varchar(200)
, Username varchar(200)
, Email varchar(200)
, Name varchar(200)
, OBSCCard varchar(200)
, OBSExpDate varchar(200)
, TxnID varchar(200)
, Type varchar(200)
, Method varchar(200)
, Merchant varchar(500)
, Bank varchar(200)
, PayoutOption varchar(200)
, Amount varchar(200)
, OBSPaymentTotal varchar(200)
, Status varchar(200)
, ExtTxnId varchar(200)
, Result varchar(200)
, Reason varchar(4000)
, BonusAdmin varchar(200)
, BDNumber varchar(200)
, CashierTxnID varchar(200)
, PTInfo varchar(500)
, ThreeDSecureProc varchar(10)
, ExtTxnAcc varchar(500)
, Casino varchar(50)
, Comments varchar(200)
, RiskProfile varchar(500)
, Kiosk varchar(200)
, KioskAdmin varchar(200)
, Agent varchar(200)
, Agency varchar(200)
, Currency varchar(10)
, AdjustmentStatus varchar(200)
, Credit varchar(200)
, CreditReverse varchar(200)
, Chargeback varchar(200) 
, ChargebackReverse varchar(200)
, ReturnTxt varchar(200)
, ReturnReverse varchar(200)
, PayMethRiskGrp varchar(200)
, PayMethConfCode varchar(200)
, Channel varchar(200)
, ConvertedAmt varchar(200)
, ConvertedCurrency varchar(10)
, ProcessorAmt varchar(200)
, ProcessorCurrency varchar(10)
)  ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table  `testrostg`.`STG_SCIMS_Data`;
Create table `testrostg`.`STG_SCIMS_Data` (
  TxnTime datetime default null
, AcceptTime datetime default null
, Username varchar(200) default null
, PlayerId bigint
, SignupDate date
, FirstDepositDate date
, Email varchar(200) default null
, Name varchar(200) default null
, OBSCCard varchar(200) default null
, OBSExpDate varchar(200) default null
, TxnID bigint(20) default null
, Type varchar(200) default null
, Method varchar(200) default null
, Merchant varchar(500) default null
, Bank varchar(200) default null
, PayoutOption varchar(200) default null
, Amount decimal(18,6) default null
, OBSPaymentTotal decimal(18,6) default null
, Status varchar(200) default null
, ExtTxnId varchar(200) default null
, Result bigint(20) default null
, Reason varchar(4000) default null
, BonusAdmin varchar(200) default null
, BDNumber varchar(200) default null
, CashierTxnID varchar(200) default null
, PTInfo varchar(500) default null
, ThreeDSecureProc varchar(10) default null
, ExtTxnAcc varchar(500) default null
, Casino varchar(50) default null
, Comments varchar(200) default null
, RiskProfile varchar(500) default null
, Kiosk varchar(200) default null
, KioskAdmin varchar(200) default null
, Agent varchar(200) default null
, Agency varchar(200) default null
, Currency varchar(10) default null
, AdjustmentStatus varchar(200) default null
, Credit varchar(200) default null
, CreditReverse varchar(200) default null
, Chargeback varchar(200)  default null
, ChargebackReverse varchar(200) default null
, ReturnTxt varchar(200) default null
, ReturnReverse varchar(200) default null
, PayMethRiskGrp varchar(200) default null
, PayMethConfCode bigint default null
, Channel varchar(200) default null
, ConvertedAmt decimal(18,6) default null
, ConvertedCurrency varchar(10) default null
, ProcessorAmt decimal(18,6) default null
, ProcessorCurrency varchar(10) default null
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table  `testrostg`.`stg_csv_player_payments`;
CREATE TABLE `testrostg`.`stg_csv_player_payments` (
  `AcceptDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Address` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `AdvertiserCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `AfterWager` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `AgencyCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `AgentCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Amount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `AuthCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Automaticrequest` char(1) COLLATE latin1_bin DEFAULT NULL,
  `AvsCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BAddress` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Balance` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BatchsettleDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BC_Amount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BC_CAmount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BC_CbAmount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BCity` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BCNumber` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BCountry` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BillingAutomatic` char(1) COLLATE latin1_bin DEFAULT NULL,
  `BName` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BonusAdminCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BonusBalance` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BonusBalanceAfterClose` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BonusCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BonusLastAction` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BonusWagering` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BState` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `BZip` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CardPin` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CashiertranID` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CbDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CCardBin` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CcardCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CCardSuffix` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ChannelCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `City` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ClientparameterCode` int ,
  `Clienttype` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Code` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Comments` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CompanyadvtransferBalance` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Comppoints` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ComppointsBalance` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Confirmation` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ConfirmDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ConvertedAmount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ConvertedcurrencyCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Country` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `CVV2` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `DepositForRedemption` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `DepositOver` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `DepositWagering` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ECI` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ExpDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ExtraMerchantInfo` varchar(300) COLLATE latin1_bin DEFAULT NULL,
  `FirstDeposit` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `FirstName` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `KeepWinningSpending` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `KioskadminCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `KioskCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `LastactivityDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `LastName` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `MerchantAnswer` varchar(2000) COLLATE latin1_bin DEFAULT NULL,
  `MerchantbatchrefCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `MerchantCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Method` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ModificationCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `NetworkCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `NetworktranID` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `NonRedeemableWithWagering` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ParentCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PaymentFee` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PaymentRequestCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PaymentTotal` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PaypalEmail` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PaypalTranID` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PaypalTranType` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PendingbonusCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PlayerCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PlayerPaydFee` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PlayerPMAccountCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PokerRounding` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ProcessingCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ProcessingDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ProcessorAmount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ProcessorcurrencyCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PromotionalCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `PTInfo` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Quickdeposit` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RedeemDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Redeemed` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RedeemedbonusAmount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RedeemThreshold` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `ReferralCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RefundCount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RefundedAmount` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RefundmadeDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RefunduponccmigrationCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RefunduponCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RemoteacceptDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RemoteAccountID` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RemoteIP` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RequestadminCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `RequestDate` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `State` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Status` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Submethod` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Type` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WageringMethod` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WaitingremotepaymentCode` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WinPayment` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WTAccName` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WTAccNumber` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WTIban` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WTNumber` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WTType` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WUFee` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WULocation` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `WUMtcn` varchar(200) COLLATE latin1_bin DEFAULT NULL,
  `Zip` varchar(200) COLLATE latin1_bin DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

drop table  `testrostg`.`stg_player_payments`;
CREATE TABLE `testrostg`.`stg_player_payments` (
 TxnDate date default null
,TxnTime datetime default null
,Address varchar(200) default null
,AdvertiserCode bigint(20) default null
,Amount decimal(18,6) default null
,AuthCode bigint(20) default null
,AvsCode int default null
,Balance decimal(18,6) default null
,CashiertranID varchar(200) default null
,CCardBin int default null
,CcardCode bigint(20) default null
,CCardSuffix int default null
,City varchar(200) default null
,ClientPlatform varchar(200) default null
,Clienttype varchar(200) default null
,Code bigint(20) default null
,Comppoints decimal(18,6) default null
,Confirmation varchar(200) default null
,Country varchar(200) default null
,DepositWagering int default null
,ExpiryDate datetime default null
,ExtraMerchantInfo varchar(1000) default null
,FirstDeposit int default null
,FirstName varchar(200) default null
,LastactivityDate datetime default null
,LastName varchar(200) default null
,MerchantCode int default null
,Method varchar(200) default null
,PaypalTranID varchar(200) default null
,PlayerCode bigint(20) default null
,PlayerPaydFee int default null
,PromotionalCode bigint(20) default null
,PaymentTxnInfo varchar(200) default null
,RedeemDate datetime default null
,Redeemed int default null
,RedeemedbonusAmount decimal(18,6) default null
,RedeemThreshold int default null
,RemoteIP varchar(200) default null
,RequestDate datetime default null
,Status varchar(200) default null
,Type varchar(200) default null
,WinPayment decimal(18,6) default null
,Zip varchar(200) default null
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

#################Curl Games

drop table  `testrostg`.`STG_GAMES_CSV`;
CREATE TABLE `testrostg`.`STG_GAMES_CSV` (
   `AccumulatedBetRefund` decimal(18,4) DEFAULT NULL,
   `Autoplay` decimal(18,4) DEFAULT NULL,
   `Balance` decimal(18,4) DEFAULT NULL,
   `Bet` decimal(18,4) DEFAULT NULL,
   `BetExcludingTie` decimal(18,4) DEFAULT NULL,
   `BetRefund` decimal(18,4) DEFAULT NULL,
   `BGType` varchar(200) DEFAULT NULL,
   `BonusBalance` decimal(18,4) DEFAULT NULL,
   `BonusBet` decimal(18,4) DEFAULT NULL,
   `BonusCode` int(11) DEFAULT NULL,
   `BonusFG` varchar(200) DEFAULT NULL,
   `BonusJackpotWin` decimal(18,4) DEFAULT NULL,
   `BonusType` varchar(200) DEFAULT NULL,
   `BonusWageringAmount` decimal(18,4) DEFAULT NULL,
   `BonusWin` decimal(18,4) DEFAULT NULL,
   `ChannelCode` int(11) DEFAULT NULL,
   `ClientParameterCode` int(11) DEFAULT NULL,
   `Code` int(11) DEFAULT NULL,
   `CoinSize` varchar(200) DEFAULT NULL,
   `CompPointsBalance` decimal(18,4) DEFAULT NULL,
   `CompsAmount` decimal(18,4) DEFAULT NULL,
   `CurrentBet` decimal(18,4) DEFAULT NULL,
   `CurrentBonusBet` decimal(18,4) DEFAULT NULL,
   `DealerCode` int(11) DEFAULT NULL,
   `DEVICEContextCode` int(11) DEFAULT NULL,
   `FGWinAmount` decimal(18,4) DEFAULT NULL,
   `GameDate` varchar(200) DEFAULT NULL,
   `GameID` varchar(200) DEFAULT NULL,
   `Info` varchar(2000) DEFAULT NULL,
   `InitialBet` decimal(18,4) DEFAULT NULL,
   `JackpotBet` decimal(18,4) DEFAULT NULL,
   `JackpotWin` decimal(18,4) DEFAULT NULL,
   `LiveGameTableCode` int(11) DEFAULT NULL,
   `LiveNetworkCode` int(11) DEFAULT NULL,
   `LPWin` decimal(18,4) DEFAULT NULL,
   `MPGameCode` int(11) DEFAULT NULL,
   `ParentGameCode` int(11) DEFAULT NULL,
   `ParentGameDate` varchar(200) DEFAULT NULL,
   `PendingBonusCode` int(11) DEFAULT NULL,
   `PlayerCode` int(11) DEFAULT NULL,
   `RecordID` varchar(200) DEFAULT NULL,
   `RemoteIP` varchar(200) DEFAULT NULL,
   `SessionID` varchar(200) DEFAULT NULL,
   `SlotLines` varchar(200) DEFAULT NULL,
   `SPWin` varchar(200) DEFAULT NULL,
   `TurnoverCommissionAllocation` decimal(18,4) DEFAULT NULL,
   `TurnoverCommissionType` varchar(200) DEFAULT NULL,
   `Type` varchar(200) DEFAULT NULL,
   `WageringBonusCode` int(11) DEFAULT NULL,
   `WageringPendingBonusCode` int(11) DEFAULT NULL,
   `Win` decimal(18,4) DEFAULT NULL,
   `WindowCode` int(11) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
drop table  `testrostg`.`STG_GAMES`;
CREATE TABLE `testrostg`.`STG_GAMES` (
   `AccumulatedBetRefund` decimal(18,4) DEFAULT NULL,
   `Autoplay` decimal(18,4) DEFAULT NULL,
   `Balance` decimal(18,4) DEFAULT NULL,
   `Bet` decimal(18,4) DEFAULT NULL,
   `CashBet` decimal(18,4) DEFAULT NULL,
   `BetExcludingTie` decimal(18,4) DEFAULT NULL,
   `BetRefund` decimal(18,4) DEFAULT NULL,
   `BGType` varchar(200) DEFAULT NULL,
   `BonusBalance` decimal(18,4) DEFAULT NULL,
   `BonusBet` decimal(18,4) DEFAULT NULL,
   `BonusCode` int(11) DEFAULT NULL,
   `BonusFG` varchar(200) DEFAULT NULL,
   `BonusJackpotWin` decimal(18,4) DEFAULT NULL,
   `BonusType` varchar(200) DEFAULT NULL,
   `BonusWageringAmount` decimal(18,4) DEFAULT NULL,
   `BonusWin` decimal(18,4) DEFAULT NULL,
   `ChannelCode` int(11) DEFAULT NULL,
   `ClientParameterCode` int(11) DEFAULT NULL,
   `Code` int(11) DEFAULT NULL,
   `CoinSize` varchar(200) DEFAULT NULL,
   `CompPointsBalance` decimal(18,4) DEFAULT NULL,
   `CompsAmount` decimal(18,4) DEFAULT NULL,
   `CurrentBet` decimal(18,4) DEFAULT NULL,
   `CurrentBonusBet` decimal(18,4) DEFAULT NULL,
   `DealerCode` int(11) DEFAULT NULL,
   `DEVICEContextCode` int(11) DEFAULT NULL,
   `FGWinAmount` decimal(18,4) DEFAULT NULL,
   `GameDate` datetime DEFAULT NULL,
   `GameID` varchar(200) DEFAULT NULL,
   `Info` varchar(2000) DEFAULT NULL,
   `InitialBet` decimal(18,4) DEFAULT NULL,
   `JackpotBet` decimal(18,4) DEFAULT NULL,
   `JackpotWin` decimal(18,4) DEFAULT NULL,
   `LiveGameTableCode` int(11) DEFAULT NULL,
   `LiveNetworkCode` int(11) DEFAULT NULL,
   `LPWin` decimal(18,4) DEFAULT NULL,
   `MPGameCode` int(11) DEFAULT NULL,
   `ParentGameCode` int(11) DEFAULT NULL,
   `ParentGameDate` varchar(200) DEFAULT NULL,
   `PendingBonusCode` int(11) DEFAULT NULL,
   `PlayerId` int(11) DEFAULT NULL,
   `RecordID` varchar(200) DEFAULT NULL,
   `RemoteIP` varchar(200) DEFAULT NULL,
   `SessionID` varchar(200) DEFAULT NULL,
   `SlotLines` varchar(200) DEFAULT NULL,
   `SPWin` varchar(200) DEFAULT NULL,
   `TurnoverCommissionAllocation` decimal(18,4) DEFAULT NULL,
   `TurnoverCommissionType` varchar(200) DEFAULT NULL,
   `Type` varchar(200) DEFAULT NULL,
   `WageringBonusCode` int(11) DEFAULT NULL,
   `WageringPendingBonusCode` int(11) DEFAULT NULL,
   `Win` decimal(18,4) DEFAULT NULL,
   `CashWin` decimal(18,4) DEFAULT NULL,
   `WindowCode` int(11) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
#########placed bets

drop table  `testrostg`.`stg_placed_bets_csv`;
CREATE TABLE `testrostg`.`stg_placed_bets_csv` (
  `BetslipId` bigint(20) DEFAULT NULL,
  `BetslipStatus` varchar(20) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `BetTime` varchar(50) DEFAULT NULL,
  `BetStatus` varchar(20) DEFAULT NULL,
  `ReferredYN` varchar(50) DEFAULT NULL,
  `CancelReason` varchar(500) DEFAULT NULL,
  `NumLegs` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` varchar(20) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `SelectionName` varchar(1000) DEFAULT NULL,
  `SelectionSort` varchar(20) DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000) DEFAULT NULL,
  `MarketSort` varchar(20) DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000) DEFAULT NULL,
  `EventStartTime` varchar(50) DEFAULT NULL,
  `MeetingName` varchar(1000) DEFAULT NULL,
  `RaceType` varchar(500) DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000) DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000) DEFAULT NULL,
  `SportCode` varchar(20) DEFAULT NULL,
  `SportName` varchar(100) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `CurrencyCode` varchar(20) DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `StakePerLine` decimal(18,6) DEFAULT NULL,
  `StakePerLineBC` decimal(18,6) DEFAULT NULL,
  `StakeAmt` decimal(18,6) DEFAULT NULL,
  `StakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusId` bigint(20) DEFAULT NULL,
  `CampaignId` bigint(20) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(5) DEFAULT NULL,
  `OddsType` varchar(5) DEFAULT NULL,
  `Odds` decimal(18,6) DEFAULT NULL,
  `EitherwaySort` varchar(5) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;


drop table `testrostg`.`stg_placed_bets`;
CREATE TABLE `testrostg`.`stg_placed_bets` (
  `BetslipId` bigint(20) DEFAULT NULL,
  `BetslipStatus` varchar(20) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `BetTime` datetime DEFAULT NULL,
  `BetDate` date DEFAULT NULL,
  `BetStatus` varchar(20) DEFAULT NULL,
  `ReferredYN` varchar(50) DEFAULT NULL,
  `CancelReason` varchar(500) DEFAULT NULL,
  `NumLegs` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` varchar(20) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `SelectionName` varchar(1000) DEFAULT NULL,
  `SelectionSort` varchar(20) DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000) DEFAULT NULL,
  `MarketSort` varchar(20) DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000) DEFAULT NULL,
  `EventStartTime` datetime DEFAULT NULL,
  `MeetingName` varchar(1000) DEFAULT NULL,
  `RaceType` varchar(500) DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000) DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000) DEFAULT NULL,
  `SportCode` varchar(20) DEFAULT NULL,
  `SportName` varchar(100) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `CurrencyCode` varchar(20) DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `StakePerLine` decimal(18,6) DEFAULT NULL,
  `StakePerLineBC` decimal(18,6) DEFAULT NULL,
  `StakeAmt` decimal(18,6) DEFAULT NULL,
  `StakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusId` bigint(20) DEFAULT NULL,
  `CampaignId` bigint(20) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(5) DEFAULT NULL,
  `OddsType` varchar(5) DEFAULT NULL,
  `Odds` decimal(18,6) DEFAULT NULL,
  `EitherwaySort` varchar(5) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

##################### Settled Bets ##################
drop table  `testrostg`.`stg_settled_bets_csv`;
CREATE TABLE `testrostg`.`stg_settled_bets_csv` (
  `BetId` bigint(20) DEFAULT NULL,
  `SettleTime` varchar(50) DEFAULT NULL,
  `BetStatus` varchar(20)  DEFAULT NULL,
  `NumLeg` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `SelectionName` varchar(1000)  DEFAULT NULL,
  `SelectionSort` varchar(20)  DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000)  DEFAULT NULL,
  `MarketSort` varchar(20)  DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000)  DEFAULT NULL,
  `EventStartTime` varchar(50) DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000)  DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000)  DEFAULT NULL,
  `SportCode` varchar(20)  DEFAULT NULL,
  `SportName` varchar(100)  DEFAULT NULL,
  `DecreasingOdds` decimal(18,6) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100)  DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `NumLinesWin` int(11) DEFAULT NULL,
  `NumLinesLose` int(11) DEFAULT NULL,
  `NumLinesVoid` int(11) DEFAULT NULL,
  `CurrencyCode` varchar(20)  DEFAULT NULL,
  `BonusId` bigint(20) DEFAULT NULL,
  `CampaignId` bigint(20) DEFAULT NULL,
  `TotalReturn` decimal(18,6) DEFAULT NULL,
  `TotalReturnBC` decimal(18,6) DEFAULT NULL,
  `CashReturn` decimal(18,6) DEFAULT NULL,
  `CashReturnBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceReturn` decimal(18,6) DEFAULT NULL,
  `BonusBalancereturnBC` decimal(18,6) DEFAULT NULL,
  `CashRefund` decimal(18,6) DEFAULT NULL,
  `CashRefundBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceRefund` decimal(18,6) DEFAULT NULL,
  `BonusBalanceRefundBC` decimal(18,6) DEFAULT NULL,
  `TokenRefund` decimal(18,6) DEFAULT NULL,
  `TokenRefundBC` decimal(18,6) DEFAULT NULL,
  `CashOutStake` decimal(18,6) DEFAULT NULL,
  `CashOutStakeBC` decimal(18,6) DEFAULT NULL,
  `CashOutWin` decimal(18,6) DEFAULT NULL,
  `CashOutWinBC` decimal(18,6) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20)  DEFAULT NULL,
  `Operator` varchar(20)  DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;


drop table  `testrostg`.`stg_settled_bets`;
CREATE TABLE `testrostg`.`stg_settled_bets` (
  `BetId` bigint(20) DEFAULT NULL,
  `SettleTime` datetime DEFAULT NULL,
  `SettledDate` date default null,
  `BetStatus` varchar(20)  DEFAULT NULL,
  `NumLeg` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `SelectionName` varchar(1000)  DEFAULT NULL,
  `SelectionSort` varchar(20)  DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000)  DEFAULT NULL,
  `MarketSort` varchar(20)  DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000)  DEFAULT NULL,
  `EventStartTime` datetime DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000)  DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000)  DEFAULT NULL,
  `SportCode` varchar(20)  DEFAULT NULL,
  `SportName` varchar(100)  DEFAULT NULL,
  `DecreasingOdds` decimal(18,6) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100)  DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `NumLinesWin` int(11) DEFAULT NULL,
  `NumLinesLose` int(11) DEFAULT NULL,
  `NumLinesVoid` int(11) DEFAULT NULL,
  `CurrencyCode` varchar(20)  DEFAULT NULL,
  `BonusId` bigint(20) DEFAULT NULL,
  `CampaignId` bigint(20) DEFAULT NULL,
  `TotalReturn` decimal(18,6) DEFAULT NULL,
  `TotalReturnBC` decimal(18,6) DEFAULT NULL,
  `CashReturn` decimal(18,6) DEFAULT NULL,
  `CashReturnBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceReturn` decimal(18,6) DEFAULT NULL,
  `BonusBalancereturnBC` decimal(18,6) DEFAULT NULL,
  `CashRefund` decimal(18,6) DEFAULT NULL,
  `CashRefundBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceRefund` decimal(18,6) DEFAULT NULL,
  `BonusBalanceRefundBC` decimal(18,6) DEFAULT NULL,
  `TokenRefund` decimal(18,6) DEFAULT NULL,
  `TokenRefundBC` decimal(18,6) DEFAULT NULL,
  `CashOutStake` decimal(18,6) DEFAULT NULL,
  `CashOutStakeBC` decimal(18,6) DEFAULT NULL,
  `CashOutWin` decimal(18,6) DEFAULT NULL,
  `CashOutWinBC` decimal(18,6) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20)  DEFAULT NULL,
  `Operator` varchar(20)  DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

##########################################Rejected Bets

drop table  `testrostg`.stg_rejected_bets_csv;
create table `testrostg`.`stg_rejected_bets_csv`(
 `BetslipId` bigint(20) DEFAULT NULL
,`BetId` bigint(20) DEFAULT NULL
,`TraderName` varchar(100) DEFAULT NULL
,`BetTime` varchar(200) DEFAULT NULL
,`Username` varchar(50) DEFAULT NULL
,`CustSegmentName` varchar(200) DEFAULT NULL
,`UnitStakeAmt` decimal(18,4) default null
,`BetType` varchar(20) DEFAULT NULL
,`CancelReason` varchar(200) DEFAULT NULL
,`SelectionDetail` varchar(4000) DEFAULT NULL
,`Odds` decimal(18,4) default null
,`PotentialReturns` decimal(18,4) default null
,`StakeAmt` decimal(18,4) default null
,`TokenStakeAmt` decimal(18,4) default null
,`PotentialReturnsBC` decimal(18,4) default null
,`StakeAmtBC` decimal(18,4) default null
,`BonusStakeAmtBC` decimal(18,4) default null
,`Channel` varchar(200) DEFAULT NULL
,`ViewName` varchar(200) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;


drop table  `testrostg`.stg_rejected_bets;
create table `testrostg`.`stg_rejected_bets`(
 `BetslipId` bigint(20) DEFAULT NULL
,`BetId` bigint(20) DEFAULT NULL
,`TraderName` varchar(100) DEFAULT NULL
,`BetTime` datetime DEFAULT NULL
,`BetDate` date DEFAULT NULL
,`Username` varchar(50) DEFAULT NULL
,`CustSegmentName` varchar(200) DEFAULT NULL
,`UnitStakeAmtBC` decimal(18,4) default null
,`BetType` varchar(20) DEFAULT NULL
,`CancelReason` varchar(200) DEFAULT NULL
,`SelectionDetail` varchar(4000) DEFAULT NULL
,`Odds` decimal(18,4) default null
,`PotentialReturns` decimal(18,4) default null
,`StakeAmt` decimal(18,4) default null
,`TokenStakeAmt` decimal(18,4) default null
,`PotentialReturnsBC` decimal(18,4) default null
,`StakeAmtBC` decimal(18,4) default null
,`BonusStakeAmtBC` decimal(18,4) default null
,`Channel` varchar(200) DEFAULT NULL
,`ViewName` varchar(200) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

###############################VoidedBets
drop table  `testrostg`.`stg_voided_bets_csv`;
create table `testrostg`.`stg_voided_bets_csv`(
 `CustName` varchar(200) DEFAULT NULL
,`BetTime` varchar(50) DEFAULT NULL
,`PlayerId` bigint(20) DEFAULT NULL
,`Username` varchar(50) DEFAULT NULL
,`BetId` bigint(20) DEFAULT NULL
,`BetslipId` bigint(20) DEFAULT NULL
,`UnitStakeBC` decimal(18,6) DEFAULT NULL
,`BetType` varchar(20) DEFAULT NULL
,`SelectionDetail` varchar(4000) DEFAULT NULL
,`Odds` decimal(18,4) default null
,`BonusStakeDesc` varchar(200) DEFAULT NULL
,`TotalStakeDesc` varchar(200) DEFAULT NULL
,`FirstSettledTime` varchar(200) DEFAULT NULL
,`BetResult` varchar(10) DEFAULT NULL
,`FirstSettlerUsername` varchar(50) DEFAULT NULL
,`VoidedTime` varchar(200) DEFAULT NULL
,`VoiderUsername` varchar(50) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table  `testrostg`.`stg_voided_bets`;
create table `testrostg`.`stg_voided_bets`(
 `CustName` varchar(200) DEFAULT NULL
,`BetTime` datetime DEFAULT NULL
,`BetDate` date DEFAULT NULL
,`PlayerId` bigint(20) DEFAULT NULL
,`Username` varchar(50) DEFAULT NULL
,`BetId` bigint(20) DEFAULT NULL
,`BetSlipId` bigint(20) DEFAULT NULL
,`UnitStakeBC` decimal(18,6) DEFAULT NULL
,`BetType` varchar(20) DEFAULT NULL
,`SelectionDetail` varchar(4000) DEFAULT NULL
,`Odds` decimal(18,4) default null
,`BonusStakeDesc` varchar(200) DEFAULT NULL
,`TotalStakeDesc` varchar(200) DEFAULT NULL
,`FirstSettledTime` datetime DEFAULT NULL
,`FirstSettledDate` date DEFAULT NULL
,`BetResult` varchar(10) DEFAULT NULL
,`FirstSettlerUsername` varchar(50) DEFAULT NULL
,`VoidedTime` datetime DEFAULT NULL
,`VoidedDate` date DEFAULT NULL
,`VoiderUsername` varchar(50) DEFAULT NULL
)ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

####################OpenBets
drop table  `testrostg`.stg_open_bets_csv;
CREATE TABLE `testrostg`.`stg_open_bets_csv` (
  `BetSlipId` bigint(20) DEFAULT NULL,
  `BetSlipStatus` varchar(50) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `Placedate` varchar(50) DEFAULT NULL,
  `BetStatus` varchar(20) DEFAULT NULL,
  `NumLeg` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` varchar(20) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `Selectionname` varchar(1000) DEFAULT NULL,
  `Selectionsort` varchar(20) DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000) DEFAULT NULL,
  `MarketSort` varchar(100) DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000) DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000) DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000) DEFAULT NULL,
  `SportCode` varchar(20) DEFAULT NULL,
  `SportName` varchar(100) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `CurrencyCode` varchar(20) DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `StakePerLine` decimal(18,6) DEFAULT NULL,
  `StakePerLineBC` decimal(18,6) DEFAULT NULL,
  `StakeAmt` decimal(18,6) DEFAULT NULL,
  `StakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(5) DEFAULT NULL,
  `OddsType` varchar(5) DEFAULT NULL,
  `DecreasingOdds` decimal(18,6) DEFAULT NULL,
  `EitherWaySort` varchar(50) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL,
  `PotentialReturn` decimal(18,6) DEFAULT NULL,
  `ViewName` varchar(100) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table  `testrostg`.`stg_open_bets`;
CREATE TABLE `testrostg`.`stg_open_bets` (
  `BetSlipId` bigint(20) DEFAULT NULL,
  `BetSlipStatus` varchar(50) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `PlaceTime` datetime DEFAULT NULL,
  `BetDate` date DEFAULT null,
  `BetStatus` varchar(20) DEFAULT NULL,
  `NumLeg` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` varchar(20) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `Selectionname` varchar(1000) DEFAULT NULL,
  `Selectionsort` varchar(20) DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000) DEFAULT NULL,
  `MarketSort` varchar(100) DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000) DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000) DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000) DEFAULT NULL,
  `SportCode` varchar(20) DEFAULT NULL,
  `SportName` varchar(100) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `CurrencyCode` varchar(20) DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `StakePerLine` decimal(18,6) DEFAULT NULL,
  `StakePerLineBC` decimal(18,6) DEFAULT NULL,
  `StakeAmt` decimal(18,6) DEFAULT NULL,
  `StakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(5) DEFAULT NULL,
  `OddsType` varchar(5) DEFAULT NULL,
  `DecreasingOdds` decimal(18,6) DEFAULT NULL,
  `EitherWaySort` varchar(50) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL,
  `PotentialReturn` decimal(18,6) DEFAULT NULL,
  `ViewName` varchar(100) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table  `testromain`.`fd_open_bets`;
CREATE TABLE `testromain`.`fd_open_bets` (
  `BetSlipId` bigint(20) DEFAULT NULL,
  `BetSlipStatus` varchar(50) DEFAULT NULL,
  `BetId` bigint(20) DEFAULT NULL,
  `BetType` varchar(20) DEFAULT NULL,
  `PlaceTime` datetime DEFAULT NULL,
  `BetDate` date DEFAULT null,
  `BetStatus` varchar(20) DEFAULT NULL,
  `NumLeg` int(11) DEFAULT NULL,
  `NumPart` int(11) DEFAULT NULL,
  `LegSort` varchar(20) DEFAULT NULL,
  `SelectionId` bigint(20) DEFAULT NULL,
  `Selectionname` varchar(1000) DEFAULT NULL,
  `Selectionsort` varchar(20) DEFAULT NULL,
  `MarketId` bigint(20) DEFAULT NULL,
  `MarketName` varchar(1000) DEFAULT NULL,
  `MarketSort` varchar(100) DEFAULT NULL,
  `EventId` bigint(20) DEFAULT NULL,
  `EventName` varchar(1000) DEFAULT NULL,
  `TypeId` bigint(20) DEFAULT NULL,
  `TypeName` varchar(1000) DEFAULT NULL,
  `ClassId` bigint(20) DEFAULT NULL,
  `ClassName` varchar(1000) DEFAULT NULL,
  `SportCode` varchar(20) DEFAULT NULL,
  `SportName` varchar(100) DEFAULT NULL,
  `PlayerId` bigint(20) DEFAULT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `CurrencyCode` varchar(20) DEFAULT NULL,
  `NumLines` int(11) DEFAULT NULL,
  `StakePerLine` decimal(18,6) DEFAULT NULL,
  `StakePerLineBC` decimal(18,6) DEFAULT NULL,
  `StakeAmt` decimal(18,6) DEFAULT NULL,
  `StakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmt` decimal(18,6) DEFAULT NULL,
  `BonusStakeAmtBC` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStake` decimal(18,6) DEFAULT NULL,
  `BonusBalanceStakeBC` decimal(18,6) DEFAULT NULL,
  `LiveYN` varchar(5) DEFAULT NULL,
  `OddsType` varchar(5) DEFAULT NULL,
  `DecreasingOdds` decimal(18,6) DEFAULT NULL,
  `EitherWaySort` varchar(50) DEFAULT NULL,
  `ViewId` int(11) DEFAULT NULL,
  `Channel` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL,
  `PotentialReturn` decimal(18,6) DEFAULT NULL,
  `ViewName` varchar(100) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;



