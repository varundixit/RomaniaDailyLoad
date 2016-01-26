##Full Run
Drop table romaniamain.eg_LT_player_points;
Create table romaniamain.eg_LT_player_points(
PlayerId integer,
LTEGPoint decimal(18,6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\TotalEGPoints.csv'
INTO TABLE romaniamain.eg_LT_player_points
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';


Drop table romaniamain.sp_cv_player_volatility;
Create table romaniamain.sp_cv_player_volatility
(
PlayerId integer,
LTSpPoint  decimal(18,6), 
SGLAvgOdds decimal(18,6), 
SGLSTDOdds decimal(18,6), 
SGLCovOdds decimal(18,6), 
CMBAvgOdds decimal(18,6), 
CMBSTDOdds decimal(18,6), 
CMBCovOdds decimal(18,6), 
SGLTotalWinninStake decimal(18,6), 
SGLTotalStake decimal(18,6), 
SGLTotalReturn decimal(18,6), 
SGLTotalWinningBetCount decimal(18,6), 
SGLTotalBetCount decimal(18,6), 
CMBTotalWinninStake decimal(18,6), 
CMBTotalStake decimal(18,6), 
CMBTotalReturn decimal(18,6), 
CMBTotalWinningBetCount decimal(18,6), 
CMBTotalBetCount decimal(18,6), 
SGLWinningRatioBetCounts decimal(18,6), 
SGLWinningRatioStake decimal(18,6), 
CMBWinningRatioBetCounts decimal(18,6), 
CMBWinningRatioStake decimal(18,6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\sp_cv_player_volatility.csv'
INTO TABLE romaniamain.sp_cv_player_volatility
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

Drop table romaniamain.cashier_extreme_deposits;
Create table romaniamain.cashier_extreme_deposits
(
PlayerId integer,
AvgDeposit decimal(18,6),
StdDevDeposit decimal(18,6),
ExtremeDeposit decimal(18,6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\ExtremeDeposit.csv'
INTO TABLE romaniamain.cashier_extreme_deposits
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

Drop table romaniamain.eg_player_extreme_bets;
Create table romaniamain.eg_player_extreme_bets(
PlayerId integer,
AvgGrossProfit decimal(18,6),
StdGrossProfit decimal(18,6),
ExtremeLoss decimal(18,6),
ExtremeWin decimal(18,6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\FL_Backup\\ExtremeWinLoss.csv'
INTO TABLE romaniamain.eg_player_extreme_bets
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

commit;