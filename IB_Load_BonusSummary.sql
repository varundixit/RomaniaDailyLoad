#date change 2016-02-02
# place file "CURL_PendingBonuses2016-02-02.csv"

Drop table romaniastg.stg_pending_bonus;
CREATE TABLE romaniastg.stg_pending_bonus (
Code varchar(200) DEFAULT NULL,
RedeemDate varchar(50) DEFAULT NULL,
Amount varchar(50) DEFAULT NULL,
PlayerCode varchar(200) DEFAULT NULL,
StartDate varchar(50) DEFAULT NULL,
EndDate varchar(50) DEFAULT NULL,
RequestDate varchar(50) DEFAULT NULL,
AcceptDate varchar(50) DEFAULT NULL,
Status varchar(200) DEFAULT NULL,
Comments varchar(200) DEFAULT NULL,
Redeemed varchar(50) DEFAULT NULL,
WageringMethod varchar(200) DEFAULT NULL,
BonusWagering varchar(50) DEFAULT NULL,
DepositWagering varchar(50) DEFAULT NULL,
RedeemThreshold varchar(200) DEFAULT NULL,
DepositForRedemption varchar(200) DEFAULT NULL,
NonRedeemableWithWagering varchar(50) DEFAULT NULL,
KeepWinningSpending varchar(200) DEFAULT NULL,
ConfirmationStatus varchar(50) DEFAULT NULL,
RemotebonusID varchar(200) DEFAULT NULL,
PromotionalCode varchar(200) DEFAULT NULL,
WageringStartDate varchar(50) DEFAULT NULL,
AfterAccepteMailDesc varchar(200) DEFAULT NULL,
DonotSendDefaultMessage varchar(200) DEFAULT NULL,
Removalreason varchar(200) DEFAULT NULL,
WageringcompletionmessageID varchar(200) DEFAULT NULL,
WageringCompletiOnMsgThreshold varchar(200) DEFAULT NULL,
Amounttowager varchar(50) DEFAULT NULL,
Removefailed varchar(200) DEFAULT NULL,
InitWagerRequireAmt varchar(50) DEFAULT NULL,
TriggeringbonusCode varchar(200) DEFAULT NULL,
NextbonusCode varchar(200) DEFAULT NULL,
RewardText varchar(200) DEFAULT NULL,
DisplayBonusFundsSeparately varchar(50) DEFAULT NULL,
UseBonusMoneyFirst varchar(50) DEFAULT NULL,
WagerRequirementStatus varchar(200) DEFAULT NULL,
Freespinscount varchar(50) DEFAULT NULL,
Clienttype varchar(200) DEFAULT NULL,
Type varchar(200) DEFAULT NULL,
BonusCode varchar(200) DEFAULT NULL,
RingfencingAmount varchar(50) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

/*
Drop table romaniamain.pending_bonus;
CREATE TABLE romaniamain.pending_bonus (
   AsOf date,
   Code int DEFAULT NULL,
   RedeemDate datetime DEFAULT NULL,
   Amount decimal(18,6) DEFAULT NULL,
   PlayerCode bigint(20) DEFAULT NULL,
   StartDate datetime DEFAULT NULL,
   EndDate datetime DEFAULT NULL,
   RequestDate datetime DEFAULT NULL,
   AcceptDate datetime DEFAULT NULL,
   Status varchar(200) DEFAULT NULL,
   Comments varchar(200) DEFAULT NULL,
   Redeemed decimal(18,6) DEFAULT NULL,
   WageringMethod varchar(200) DEFAULT NULL,
   BonusWagering decimal(18,6) DEFAULT NULL,
   DepositWagering decimal(18,6) DEFAULT NULL,
   RedeemThreshold varchar(200) DEFAULT NULL,
   DepositForRedemption varchar(200) DEFAULT NULL,
   NonRedeemableWithWagering decimal(18,6) DEFAULT NULL,
   KeepWinningSpending varchar(200) DEFAULT NULL,
   ConfirmationStatus varchar(10) DEFAULT NULL,
   RemotebonusID int DEFAULT NULL,
   PromotionalCode varchar(200) DEFAULT NULL,
   WageringStartDate datetime DEFAULT NULL,
   AfterAccepteMailDesc varchar(200) DEFAULT NULL,
   DonotSendDefaultMessage varchar(200) DEFAULT NULL,
   Removalreason int DEFAULT NULL,
   WageringcompletionmessageID varchar(200) DEFAULT NULL,
   WageringCompletiOnMsgThreshold varchar(200) DEFAULT NULL,
   Amounttowager decimal(18,6) DEFAULT NULL,
   Removefailed varchar(200) DEFAULT NULL,
   InitWagerRequireAmt decimal(18,6) DEFAULT NULL,
   TriggeringbonusCode varchar(200) DEFAULT NULL,
   NextbonusCode varchar(200) DEFAULT NULL,
   RewardText varchar(200) DEFAULT NULL,
   DisplayBonusFundsSeparately varchar(1) DEFAULT NULL,
   UseBonusMoneyFirst varchar(1) DEFAULT NULL,
   WagerRequirementStatus int DEFAULT NULL,
   Freespinscount int(11) DEFAULT NULL,
   Clienttype varchar(200) DEFAULT NULL,
   Type varchar(200) DEFAULT NULL,
   BonusCode int DEFAULT NULL,
   RingfencingAmount decimal(18,6) DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
*/

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_PendingBonuses\\CURL_PendingBonuses2016-02-02.csv' 
INTO TABLE romaniastg.stg_pending_bonus
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n'; 

select str_to_date('2016-02-02','%Y-%m-%d') asof,sb.* from romaniastg.stg_pending_bonus sb where code <> 'CODE'
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_PendingBonuses\\out_pending_bonus.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_PendingBonuses\\out_pending_bonus.csv' 
INTO TABLE romaniamain.pending_bonus
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n'; 

#select * from romaniamain.pending_bonus;

#####################

select date(RequestDate) summarydate,
sum(case when status in ('approved','waiting') then amount else 0 end) active,
sum(case when status ='removed' and Removalreason in (1,2,9,10) then amount else 0 end) redeemed,
sum(case when status ='removed' and Removalreason in (4,5,6,7,13) then amount else 0 end) expired,
0 cancelled
from romaniamain.pending_bonus pb join romaniamain.dim_player p on pb.playercode = p.playerId
where RequestDate>='2015-11-26'
and asof = '2016-02-02'
and p.signupdate >= '2015-11-26'
group by asof,date(RequestDate)
INTO OUTFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_PendingBonuses\\BonusExtractsEG.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY 'NULL' LINES TERMINATED BY '\n';

Drop table `romaniastg`.`Bonus_Details`;
Create table `romaniastg`.`Bonus_Details`
(
Awarded_Date date,
active decimal(18,6),
redeemed decimal(18,6),
expired decimal(18,6),
cancelled decimal(18,6)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_PendingBonuses\\BonusExtractsEG.csv' 
INTO TABLE `romaniastg`.`Bonus_Details`
FIELDS TERMINATED BY ';' ENCLOSED BY 'NULL' LINES TERMINATED BY '\n';

#select * from `romaniamain`.`Bonus_Details`;