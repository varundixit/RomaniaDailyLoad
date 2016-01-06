drop table STG_GIT_CUSTOMER;
CREATE TABLE STG_GIT_CUSTOMER (
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
  CreationDateSP datetime
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_Players\\Customer.csv' 
INTO TABLE  romaniastage.stg_daily_logins FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@vPlayerSPId, @vUsername, @vFirstName, @vLastName, @vPlayerSPSegName, @vAllowBonus, @vPlayerCurrency, @vPlayerSPRating, @vPlayerSPRatingLive, 
 @vPlayerSPStakeLimit,@vPlayerSPStakeLimitLive, @vOperatorSP, @vAdvertiserSP, @vCasinoNameSp, @vTestYNSP, @vCreationDateSP)
SET
PlayerSPId = nullif(@vPlayerSPId, ''),
Username = nullif(@vUsername, ''),
FirstName = nullif(@vFirstName, ''),
LastName = nullif(@vLastName, ''),
PlayerSPSegName = nullif(@vPlayerSPSegName, ''),
AllowBonus = nullif(@vAllowBonus, ''),
PlayerCurrency = nullif(@vPlayerCurrency, ''),
PlayerSPRating = nullif(@vPlayerSPRating, ''),
PlayerSPRatingLive = nullif(@vPlayerSPRatingLive, ''),
PlayerSPStakeLimit = nullif(@vPlayerSPStakeLimit, ''),
PlayerSPStakeLimitLive = nullif(@vPlayerSPStakeLimitLive, ''),
OperatorSP = nullif(@vOperatorSP, ''),
AdvertiserSP = nullif(@vAdvertiserSP, ''),
CasinoNameSp = nullif(@vCasinoNameSp, ''),
TestYNSP = nullif(@vTestYNSP, ''),
CreationDateSP = nullif(@vCreationDateSP, '');
