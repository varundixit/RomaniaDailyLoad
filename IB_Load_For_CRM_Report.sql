use romaniafl;

drop table `stg_dim_player`;
CREATE TABLE `stg_dim_player` (
   `PlayerID` bigint(20) DEFAULT NULL,
   `Username` varchar(100) DEFAULT NULL,
   `Gender` varchar(5) DEFAULT NULL,
   `Balance` decimal(18,6) DEFAULT NULL,
   `GlobalFirstDepositDate` datetime DEFAULT NULL,
   `SignupDate` datetime DEFAULT NULL,
   `RomDummy` int(11) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table `user_dep_with_first_last`; 
CREATE TABLE `user_dep_with_first_last` (
   `PlayerId` bigint(20) NOT NULL,
   `FirstDepositTime` datetime DEFAULT NULL,
   `FirstDepositAmount` decimal(18,6) DEFAULT NULL,
   `LastDepositTime` datetime DEFAULT NULL,
   `LastDepositAmount` decimal(18,6) DEFAULT NULL,
   `FirstWithdrawalTime` datetime DEFAULT NULL,
   `FirstWithdrawalAmount` decimal(18,6) DEFAULT NULL,
   `LastWithdrawalTime` datetime DEFAULT NULL,
   `LastWithdrawalAmount` decimal(18,6) DEFAULT NULL,
   `FirstAttemptDepositTime` datetime DEFAULT NULL,
   `FirstAttemptDepositAmount` decimal(18,6) DEFAULT NULL,
   `LastAttemptDepositTime` datetime DEFAULT NULL,
   `LastAttemptDepositAmount` decimal(18,6) DEFAULT NULL,
   `FirstAttemptWithdrawalTime` datetime DEFAULT NULL,
   `FirstAttemptWithdrawalAmount` decimal(18,6) DEFAULT NULL,
   `LastAttemptWithdrawalTime` datetime DEFAULT NULL,
   `LastAttemptWithdrawalAmount` decimal(18,6) DEFAULT NULL,
   `TotalSuccDepAmt` decimal(18,6) DEFAULT NULL,
   `TotalSuccDepCnt` int(11) DEFAULT NULL,
   `TotalDecDepAmt` decimal(18,6) DEFAULT NULL,
   `TotalDecDepCnt` int(11) DEFAULT NULL,
   `TotalAttemptedDepAmt` decimal(18,6) DEFAULT NULL,
   `TotalAttemptedDepCnt` int(11) DEFAULT NULL,
   `TotalSuccWithdAmt` decimal(18,6) DEFAULT NULL,
   `TotalSuccWithdCnt` int(11) DEFAULT NULL,
   `TotalDecWithdAmt` decimal(18,6) DEFAULT NULL,
   `TotalDecWithdCnt` int(11) DEFAULT NULL,
   `TotalAttemptedWithdAmt` decimal(18,6) DEFAULT NULL,
   `TotalAttemptedWithdCnt` int(11) DEFAULT NULL,
   `LastDepTxnStatus` varchar(50) DEFAULT NULL,
   `LastDepTxnMethod` varchar(50) DEFAULT NULL,
   `LastDepTxnMerchant` varchar(100) DEFAULT NULL,
   `LastDepTxnReason` varchar(200) DEFAULT NULL,
   `LastDepTxnReasonGrp` varchar(200) DEFAULT NULL,
   `LastDepTxnRiskProfile` varchar(200) DEFAULT NULL,
   `LastWithdTxnStatus` varchar(50) DEFAULT NULL,
   `LastWithdTxnMethod` varchar(50) DEFAULT NULL,
   `LastWithdTxnMerchant` varchar(100) DEFAULT NULL,
   `LastWithdTxnReason` varchar(200) DEFAULT NULL,
   `LastWithdTxnReasonGrp` varchar(200) DEFAULT NULL,
   `LastWithdTxnRiskProfile` varchar(200) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
drop table `sp_gv_player_first_last`; 
 CREATE TABLE `sp_gv_player_first_last` (
   `PlayerId` bigint(20) NOT NULL,
   `SglLvFirstBetTime` datetime DEFAULT NULL,
   `SglLvFirstChannel` varchar(20) DEFAULT NULL,
   `SglLvFirstSelectionName` varchar(500) DEFAULT NULL,
   `SglLvFirstMarketName` varchar(500) DEFAULT NULL,
   `SglLvFirstEventName` varchar(500) DEFAULT NULL,
   `SglLvFirstTypeName` varchar(500) DEFAULT NULL,
   `SglLvFirstClassName` varchar(500) DEFAULT NULL,
   `SglLvFirstSport` varchar(500) DEFAULT NULL,
   `SglLvFirstCashStkAmt` decimal(18,6) DEFAULT NULL,
   `SglLvFirstBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `SglLvFirstBonusBalStkAmt` decimal(18,6) DEFAULT NULL,
   `SglPmFirstBetTime` datetime DEFAULT NULL,
   `SglPmFirstChannel` varchar(20) DEFAULT NULL,
   `SglPmFirstSelectionName` varchar(500) DEFAULT NULL,
   `SglPmFirstMarketName` varchar(500) DEFAULT NULL,
   `SglPmFirstEventName` varchar(500) DEFAULT NULL,
   `SglPmFirstTypeName` varchar(500) DEFAULT NULL,
   `SglPmFirstClassName` varchar(500) DEFAULT NULL,
   `SglPmFirstSport` varchar(500) DEFAULT NULL,
   `SglPmFirstCashStkAmt` decimal(18,6) DEFAULT NULL,
   `SglPmFirstBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `SglPmFirstBonusBalStkAmt` decimal(18,6) DEFAULT NULL,
   `CmbFirstBetTime` datetime DEFAULT NULL,
   `CmbFirstChannel` varchar(20) DEFAULT NULL,
   `CmbFirstSelectionName` varchar(500) DEFAULT NULL,
   `CmbFirstMarketName` varchar(500) DEFAULT NULL,
   `CmbFirstEventName` varchar(500) DEFAULT NULL,
   `CmbFirstTypeName` varchar(500) DEFAULT NULL,
   `CmbFirstClassName` varchar(500) DEFAULT NULL,
   `CmbFirstSport` varchar(500) DEFAULT NULL,
   `CmbFirstCashStkAmt` decimal(18,6) DEFAULT NULL,
   `CmbFirstBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `CmbFirstBonusBalStkAmt` decimal(18,6) DEFAULT NULL,
   `SglLvLastBetTime` datetime DEFAULT NULL,
   `SglLvLastChannel` varchar(20) DEFAULT NULL,
   `SglLvLastSelectionName` varchar(500) DEFAULT NULL,
   `SglLvLastMarketName` varchar(500) DEFAULT NULL,
   `SglLvLastEventName` varchar(500) DEFAULT NULL,
   `SglLvLastTypeName` varchar(500) DEFAULT NULL,
   `SglLvLastClassName` varchar(500) DEFAULT NULL,
   `SglLvLastSport` varchar(500) DEFAULT NULL,
   `SglLvLastCashStkAmt` decimal(18,6) DEFAULT NULL,
   `SglLvLastBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `SglLvLastBonusBalStkAmt` decimal(18,6) DEFAULT NULL,
   `SglPmLastBetTime` datetime DEFAULT NULL,
   `SglPmLastChannel` varchar(20) DEFAULT NULL,
   `SglPmLastSelectionName` varchar(500) DEFAULT NULL,
   `SglPmLastMarketName` varchar(500) DEFAULT NULL,
   `SglPmLastEventName` varchar(500) DEFAULT NULL,
   `SglPmLastTypeName` varchar(500) DEFAULT NULL,
   `SglPmLastClassName` varchar(500) DEFAULT NULL,
   `SglPmLastSport` varchar(500) DEFAULT NULL,
   `SglPmLastCashStkAmt` decimal(18,6) DEFAULT NULL,
   `SglPmLastBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `SglPmLastBonusBalStkAmt` decimal(18,6) DEFAULT NULL,
   `CmbLastBetTime` datetime DEFAULT NULL,
   `CmbLastChannel` varchar(20) DEFAULT NULL,
   `CmbLastSelectionName` varchar(500) DEFAULT NULL,
   `CmbLastMarketName` varchar(500) DEFAULT NULL,
   `CmbLastEventName` varchar(500) DEFAULT NULL,
   `CmbLastTypeName` varchar(500) DEFAULT NULL,
   `CmbLastClassName` varchar(500) DEFAULT NULL,
   `CmbLastSport` varchar(500) DEFAULT NULL,
   `CmbLastCashStkAmt` decimal(18,6) DEFAULT NULL,
   `CmbLastBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `CmbLastBonusBalStkAmt` decimal(18,6) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
drop TABLE `sp_cv_player_first_last_totals`; 
 CREATE TABLE `sp_cv_player_first_last_totals` (
   `PlayerId` bigint(20) NOT NULL,
   `SglLvFirstBetTime` datetime DEFAULT NULL,
   `SglLvFirstChannel` varchar(20) DEFAULT NULL,
   `SglLvFirstSelectionName` varchar(500) DEFAULT NULL,
   `SglLvFirstMarketName` varchar(500) DEFAULT NULL,
   `SglLvFirstEventName` varchar(500) DEFAULT NULL,
   `SglLvFirstTypeName` varchar(500) DEFAULT NULL,
   `SglLvFirstClassName` varchar(500) DEFAULT NULL,
   `SglLvFirstSport` varchar(500) DEFAULT NULL,
   `SglLvFirstCashStkAmt` decimal(18,6) DEFAULT NULL,
   `SglLvFirstBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `SglLvFirstBonusBalStkAmt` decimal(18,6) DEFAULT NULL,
   `SglLvFirstCashReturn` decimal(18,6) DEFAULT NULL,
   `SglLvFirstBonusBalReturn` decimal(18,6) DEFAULT NULL,
   `SglLvFirstCashRefund` decimal(18,6) DEFAULT NULL,
   `SglLvFirstBonusBalRefund` decimal(18,6) DEFAULT NULL,
   `SglLvFirstTokenRefund` decimal(18,6) DEFAULT NULL,
   `SglLvFirstCashOutStk` decimal(18,6) DEFAULT NULL,
   `SglLvFirstCashOutWin` decimal(18,6) DEFAULT NULL,
   `SglPmFirstBetTime` datetime DEFAULT NULL,
   `SglPmFirstChannel` varchar(20) DEFAULT NULL,
   `SglPmFirstSelectionName` varchar(500) DEFAULT NULL,
   `SglPmFirstMarketName` varchar(500) DEFAULT NULL,
   `SglPmFirstEventName` varchar(500) DEFAULT NULL,
   `SglPmFirstTypeName` varchar(500) DEFAULT NULL,
   `SglPmFirstClassName` varchar(500) DEFAULT NULL,
   `SglPmFirstSport` varchar(500) DEFAULT NULL,
   `SglPmFirstCashStkAmt` decimal(18,6) DEFAULT NULL,
   `SglPmFirstBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `SglPmFirstBonusBalStkAmt` decimal(18,6) DEFAULT NULL,
   `SglPmFirstCashReturn` decimal(18,6) DEFAULT NULL,
   `SglPmFirstBonusBalReturn` decimal(18,6) DEFAULT NULL,
   `SglPmFirstCashRefund` decimal(18,6) DEFAULT NULL,
   `SglPmFirstBonusBalRefund` decimal(18,6) DEFAULT NULL,
   `SglPmFirstTokenRefund` decimal(18,6) DEFAULT NULL,
   `SglPmFirstCashOutStk` decimal(18,6) DEFAULT NULL,
   `SglPmFirstCashOutWin` decimal(18,6) DEFAULT NULL,
   `CmbFirstBetTime` datetime DEFAULT NULL,
   `CmbFirstChannel` varchar(20) DEFAULT NULL,
   `CmbFirstSelectionName` varchar(500) DEFAULT NULL,
   `CmbFirstMarketName` varchar(500) DEFAULT NULL,
   `CmbFirstEventName` varchar(500) DEFAULT NULL,
   `CmbFirstTypeName` varchar(500) DEFAULT NULL,
   `CmbFirstClassName` varchar(500) DEFAULT NULL,
   `CmbFirstSport` varchar(500) DEFAULT NULL,
   `CmbFirstCashStkAmt` decimal(18,6) DEFAULT NULL,
   `CmbFirstBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `CmbFirstBonusBalStkAmt` decimal(18,6) DEFAULT NULL,
   `CmbFirstCashReturn` decimal(18,6) DEFAULT NULL,
   `CmbFirstBonusBalReturn` decimal(18,6) DEFAULT NULL,
   `CmbFirstCashRefund` decimal(18,6) DEFAULT NULL,
   `CmbFirstBonusBalRefund` decimal(18,6) DEFAULT NULL,
   `CmbFirstTokenRefund` decimal(18,6) DEFAULT NULL,
   `CmbFirstCashOutStk` decimal(18,6) DEFAULT NULL,
   `CmbFirstCashOutWin` decimal(18,6) DEFAULT NULL,
   `SglLvLastBetTime` datetime DEFAULT NULL,
   `SglLvLastChannel` varchar(20) DEFAULT NULL,
   `SglLvLastSelectionName` varchar(500) DEFAULT NULL,
   `SglLvLastMarketName` varchar(500) DEFAULT NULL,
   `SglLvLastEventName` varchar(500) DEFAULT NULL,
   `SglLvLastTypeName` varchar(500) DEFAULT NULL,
   `SglLvLastClassName` varchar(500) DEFAULT NULL,
   `SglLvLastSport` varchar(500) DEFAULT NULL,
   `SglLvLastCashStkAmt` decimal(18,6) DEFAULT NULL,
   `SglLvLastBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `SglLvLastBonusBalStkAmt` decimal(18,6) DEFAULT NULL,
   `SglLvLastCashReturn` decimal(18,6) DEFAULT NULL,
   `SglLvLastBonusBalReturn` decimal(18,6) DEFAULT NULL,
   `SglLvLastCashRefund` decimal(18,6) DEFAULT NULL,
   `SglLvLastBonusBalRefund` decimal(18,6) DEFAULT NULL,
   `SglLvLastTokenRefund` decimal(18,6) DEFAULT NULL,
   `SglLvLastCashOutStk` decimal(18,6) DEFAULT NULL,
   `SglLvLastCashOutWin` decimal(18,6) DEFAULT NULL,
   `SglPmLastBetTime` datetime DEFAULT NULL,
   `SglPmLastChannel` varchar(20) DEFAULT NULL,
   `SglPmLastSelectionName` varchar(500) DEFAULT NULL,
   `SglPmLastMarketName` varchar(500) DEFAULT NULL,
   `SglPmLastEventName` varchar(500) DEFAULT NULL,
   `SglPmLastTypeName` varchar(500) DEFAULT NULL,
   `SglPmLastClassName` varchar(500) DEFAULT NULL,
   `SglPmLastSport` varchar(500) DEFAULT NULL,
   `SglPmLastCashStkAmt` decimal(18,6) DEFAULT NULL,
   `SglPmLastBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `SglPmLastBonusBalStkAmt` decimal(18,6) DEFAULT NULL,
   `SglPmLastCashReturn` decimal(18,6) DEFAULT NULL,
   `SglPmLastBonusBalReturn` decimal(18,6) DEFAULT NULL,
   `SglPmLastCashRefund` decimal(18,6) DEFAULT NULL,
   `SglPmLastBonusBalRefund` decimal(18,6) DEFAULT NULL,
   `SglPmLastTokenRefund` decimal(18,6) DEFAULT NULL,
   `SglPmLastCashOutStk` decimal(18,6) DEFAULT NULL,
   `SglPmLastCashOutWin` decimal(18,6) DEFAULT NULL,
   `CmbLastBetTime` datetime DEFAULT NULL,
   `CmbLastChannel` varchar(20) DEFAULT NULL,
   `CmbLastSelectionName` varchar(500) DEFAULT NULL,
   `CmbLastMarketName` varchar(500) DEFAULT NULL,
   `CmbLastEventName` varchar(500) DEFAULT NULL,
   `CmbLastTypeName` varchar(500) DEFAULT NULL,
   `CmbLastClassName` varchar(500) DEFAULT NULL,
   `CmbLastSport` varchar(500) DEFAULT NULL,
   `CmbLastCashStkAmt` decimal(18,6) DEFAULT NULL,
   `CmbLastBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `CmbLastBonusBalStkAmt` decimal(18,6) DEFAULT NULL,
   `CmbLastCashReturn` decimal(18,6) DEFAULT NULL,
   `CmbLastBonusBalReturn` decimal(18,6) DEFAULT NULL,
   `CmbLastCashRefund` decimal(18,6) DEFAULT NULL,
   `CmbLastBonusBalRefund` decimal(18,6) DEFAULT NULL,
   `CmbLastTokenRefund` decimal(18,6) DEFAULT NULL,
   `CmbLastCashOutStk` decimal(18,6) DEFAULT NULL,
   `CmbLastCashOutWin` decimal(18,6) DEFAULT NULL,
   `TotalCashStkAmt` decimal(18,6) DEFAULT NULL,
   `TotalBonusStkAmt` decimal(18,6) DEFAULT NULL,
   `TotalBonusBalStkAmt` decimal(18,6) DEFAULT NULL,
   `TotalCashReturn` decimal(18,6) DEFAULT NULL,
   `TotalBonusBalReturn` decimal(18,6) DEFAULT NULL,
   `TotalCashRefund` decimal(18,6) DEFAULT NULL,
   `TotalBonusBalRefund` decimal(18,6) DEFAULT NULL,
   `TotalTokenRefund` decimal(18,6) DEFAULT NULL,
   `TotalCashOutStk` decimal(18,6) DEFAULT NULL,
   `TotalCashOutWin` decimal(18,6) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop TABLE `eg_player_first_last_totals`; 
 CREATE TABLE `eg_player_first_last_totals` (
   `PlayerId` bigint(20) NOT NULL,
   `FirstCashBetDate` datetime DEFAULT NULL,
   `FirstCashBetAmt` decimal(18,4) DEFAULT NULL,
   `FirstCashBetChannel` varchar(20) DEFAULT NULL,
   `FirstBonusBetDate` datetime DEFAULT NULL,
   `FirstBonusBetAmt` decimal(18,4) DEFAULT NULL,
   `FirstBonusBetChannel` varchar(20) DEFAULT NULL,
   `FirstCashWinDate` datetime DEFAULT NULL,
   `FirstCashWinAmt` decimal(18,4) DEFAULT NULL,
   `FirstCashWinChannel` varchar(20) DEFAULT NULL,
   `FirstBonusWinDate` datetime DEFAULT NULL,
   `FirstBonusWinAmt` decimal(18,4) DEFAULT NULL,
   `FirstBonusWinChannel` varchar(20) DEFAULT NULL,
   `LastCashBetDate` datetime DEFAULT NULL,
   `LastCashBetAmt` decimal(18,4) DEFAULT NULL,
   `LastCashBetChannel` varchar(20) DEFAULT NULL,
   `LastBonusBetDate` datetime DEFAULT NULL,
   `LastBonusBetAmt` decimal(18,4) DEFAULT NULL,
   `LastBonusBetChannel` varchar(20) DEFAULT NULL,
   `LastCashWinDate` datetime DEFAULT NULL,
   `LastCashWinAmt` decimal(18,4) DEFAULT NULL,
   `LastCashWinChannel` varchar(20) DEFAULT NULL,
   `LastBonusWinDate` datetime DEFAULT NULL,
   `LastBonusWinAmt` decimal(18,4) DEFAULT NULL,
   `LastBonusWinChannel` varchar(20) DEFAULT NULL,
   `TotalBetAmt` decimal(18,4) DEFAULT NULL,
   `TotalCashBetAmount` decimal(18,4) DEFAULT NULL,
   `TotalBonusBetAmount` decimal(18,4) DEFAULT NULL,
   `TotalWinAmt` decimal(18,4) DEFAULT NULL,
   `TotalCashWinAmount` decimal(18,4) DEFAULT NULL,
   `TotalBonusWinAmount` decimal(18,4) DEFAULT NULL,
   `LastChannel` varchar(20) DEFAULT NULL,
   `LastGamePlayDate` datetime DEFAULT NULL,
   `LastPlayedCasinoType` varchar(100) DEFAULT NULL,
   `LastPlayedGameType` varchar(100) DEFAULT NULL,
   `LastPlayedGameName` varchar(100) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
drop  TABLE `player_login_first_last`; 
 CREATE TABLE `player_login_first_last` (
   `PlayerId` bigint(20) NOT NULL,
   `PlayerType` varchar(50) DEFAULT NULL,
   `FirstLoginDate` datetime DEFAULT NULL,
   `LastLoginDate` datetime DEFAULT NULL,
   `FirstLogoutDate` datetime DEFAULT NULL,
   `LastLogoutDate` datetime DEFAULT NULL,
   `FirstCashBalance` decimal(18,6) DEFAULT NULL,
   `FirstBonusBalance` decimal(18,6) DEFAULT NULL,
   `CurrentCashBalance` decimal(18,6) DEFAULT NULL,
   `CurrentBonusBalance` decimal(18,6) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
drop TABLE `cashier_extreme_deposits`; 
 CREATE TABLE `cashier_extreme_deposits` (
   `PlayerId` int(11) DEFAULT NULL,
   `AvgDeposit` decimal(18,6) DEFAULT NULL,
   `StdDevDeposit` decimal(18,6) DEFAULT NULL,
   `ExtremeDeposit` decimal(18,6) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
drop TABLE `eg_player_extreme_bets`; 
 CREATE TABLE `eg_player_extreme_bets` (
   `PlayerId` int(11) DEFAULT NULL,
   `AvgGrossProfit` decimal(18,6) DEFAULT NULL,
   `StdGrossProfit` decimal(18,6) DEFAULT NULL,
   `ExtremeLoss` decimal(18,6) DEFAULT NULL,
   `ExtremeWin` decimal(18,6) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop TABLE `sportspreferedproduct`; 
 CREATE TABLE `sportspreferedproduct` (
   `PlayerId` int(11) DEFAULT NULL,
   `PreferredSport` varchar(200) DEFAULT NULL,
   `PreferredLeague` varchar(200) DEFAULT NULL,
   `PreferredTeam` varchar(200) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop TABLE `egpreferedproduct`; 
 CREATE TABLE `egpreferedproduct` (
   `PlayerId` int(11) DEFAULT NULL,
   `CategoryPref` varchar(200) DEFAULT NULL,
   `MarketPref` varchar(200) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table `stg_sports_channel_pref` ;
 CREATE TABLE `stg_sports_channel_pref` (
   `PlayerId` int(11) DEFAULT NULL,
   `Channel` varchar(200) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table `stg_eg_channel_pref`; 
 CREATE TABLE `stg_eg_channel_pref` (
   `PlayerId` int(11) DEFAULT NULL,
   `Channel` varchar(200) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

/*drop table `playervalue`; 
CREATE TABLE `playervalue` (
	`SummaryDate` date DEFAULT NULL,
   `PlayerId` int(11) DEFAULT NULL,
   `LTSystemAPD` int(11) DEFAULT NULL,
   `TotalStake` decimal(18,6) DEFAULT NULL,
   `TotalReturns` decimal(18,6) DEFAULT NULL,
   `TotalGrossProfit` decimal(18,6) DEFAULT NULL,
   `TotalBetCnt` int(11) DEFAULT NULL,
   `TotalAPD` int(11) DEFAULT NULL,
   `YeildPerAPD` decimal(18,6) DEFAULT NULL,
   `BetsPerAPD` decimal(18,6) DEFAULT NULL,
   `StakePerBet` decimal(18,6) DEFAULT NULL,
   `Margins` decimal(18,6) DEFAULT NULL,
   `Frequeny` decimal(18,6) DEFAULT NULL,
   `PlayerValue` decimal(18,6) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;*/

drop TABLE `f_player_lifetime_apd`; 
 CREATE TABLE `f_player_lifetime_apd` (
   `PlayerID` bigint(20) NOT NULL,
   `LTSystemAPD` int(11) DEFAULT NULL,
   `LTSportsAPD` int(11) DEFAULT NULL,
   `LTEGamingAPD` int(11) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table `sp_cv_player_volatility`; 
 CREATE TABLE `sp_cv_player_volatility` (
   `PlayerId` int(11) DEFAULT NULL,
   `LTSpPoint` decimal(18,6) DEFAULT NULL,
   `SGLAvgOdds` decimal(18,6) DEFAULT NULL,
   `SGLSTDOdds` decimal(18,6) DEFAULT NULL,
   `SGLCovOdds` decimal(18,6) DEFAULT NULL,
   `CMBAvgOdds` decimal(18,6) DEFAULT NULL,
   `CMBSTDOdds` decimal(18,6) DEFAULT NULL,
   `CMBCovOdds` decimal(18,6) DEFAULT NULL,
   `SGLTotalWinninStake` decimal(18,6) DEFAULT NULL,
   `SGLTotalStake` decimal(18,6) DEFAULT NULL,
   `SGLTotalReturn` decimal(18,6) DEFAULT NULL,
   `SGLTotalWinningBetCount` decimal(18,6) DEFAULT NULL,
   `SGLTotalBetCount` decimal(18,6) DEFAULT NULL,
   `CMBTotalWinninStake` decimal(18,6) DEFAULT NULL,
   `CMBTotalStake` decimal(18,6) DEFAULT NULL,
   `CMBTotalReturn` decimal(18,6) DEFAULT NULL,
   `CMBTotalWinningBetCount` decimal(18,6) DEFAULT NULL,
   `CMBTotalBetCount` decimal(18,6) DEFAULT NULL,
   `SGLWinningRatioBetCounts` decimal(18,6) DEFAULT NULL,
   `SGLWinningRatioStake` decimal(18,6) DEFAULT NULL,
   `CMBWinningRatioBetCounts` decimal(18,6) DEFAULT NULL,
   `CMBWinningRatioStake` decimal(18,6) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table `eg_lt_player_points`; 
 CREATE TABLE `eg_lt_player_points` (
   `PlayerId` int(11) DEFAULT NULL,
   `LTEGPoint` decimal(18,6) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
 
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\stg_dim_player.csv'
INTO TABLE romaniafl.stg_dim_player
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'; 
 
LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\user_dep_with_first_last.csv'
INTO TABLE romaniafl.user_dep_with_first_last
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\sp_gv_player_first_last.csv'
INTO TABLE romaniafl.sp_gv_player_first_last
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\sp_cv_player_first_last_totals.csv'
INTO TABLE romaniafl.sp_cv_player_first_last_totals
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\eg_player_first_last_totals.csv'
INTO TABLE romaniafl.eg_player_first_last_totals
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\player_login_first_last.csv'
INTO TABLE romaniafl.player_login_first_last
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\cashier_extreme_deposits.csv'
INTO TABLE romaniafl.cashier_extreme_deposits
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\eg_player_extreme_bets.csv'
INTO TABLE romaniafl.eg_player_extreme_bets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\SportsPreferedProduct.csv'
INTO TABLE romaniafl.SportsPreferedProduct
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\EGPreferedProduct.csv'
INTO TABLE romaniafl.EGPreferedProduct
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\stg_sports_channel_pref.csv'
INTO TABLE romaniafl.stg_sports_channel_pref
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\stg_eg_channel_pref.csv'
INTO TABLE romaniafl.stg_eg_channel_pref
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\PlayerValue.csv'
INTO TABLE romaniafl.PlayerValue
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\f_player_lifetime_apd.csv'
INTO TABLE romaniafl.f_player_lifetime_apd
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\sp_cv_player_volatility.csv'
INTO TABLE romaniafl.sp_cv_player_volatility
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\CRM\\eg_LT_player_points.csv'
INTO TABLE romaniafl.eg_LT_player_points
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
 