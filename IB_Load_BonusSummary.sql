#date change 2016-02-05
# place file "CURL_PendingBonuses2016-02-05.csv"
# check for lines 
#Full Run
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

LOAD DATA INFILE 'C:\\Users\\CSQ-MARK5-REP-LAYER\\Desktop\\RomaniaDataDump\\CURL_PendingBonuses\\CURL_PendingBonuses2016-02-05.csv' 
INTO TABLE romaniastg.stg_pending_bonus
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n'; 

select str_to_date('2016-02-05','%Y-%m-%d') asof,sb.* from romaniastg.stg_pending_bonus sb where code <> 'CODE'
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
and asof = '2016-02-05'
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


/*
DROP TABLE romaniastg.stg_search_bonuses;
CREATE TABLE romaniastg.stg_search_bonuses (
Bonus_ID varchar(200) DEFAULT NULL,
Campaign_Name varchar(200) DEFAULT NULL,
Username varchar(200) DEFAULT NULL,
Cust_Ccy_Code varchar(200) DEFAULT NULL,
Operator_Code varchar(200) DEFAULT NULL,
Casino varchar(200) DEFAULT NULL,
Bonus_Type varchar(200) DEFAULT NULL,
Status varchar(200) DEFAULT NULL,
Date_Started_Triggers varchar(200) DEFAULT NULL,
Date_Awarded varchar(200) DEFAULT NULL,
Amount_Awarded varchar(200) DEFAULT NULL,
Remaining_Credit varchar(200) DEFAULT NULL,
Opt_In_Amount varchar(200) DEFAULT NULL,
Opt_In_Date varchar(200) DEFAULT NULL,
Total_Wagered varchar(200) DEFAULT NULL,
Wagering_Target varchar(200) DEFAULT NULL,
Contributing_Bets varchar(20) DEFAULT NULL,
Amount_Redeemed varchar(200) DEFAULT NULL,
Completed_Date varchar(200) DEFAULT NULL,
Amount_Expired varchar(200) DEFAULT NULL,
Expiry_Date varchar(200) DEFAULT NULL
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

drop table romaniamain.search_bonuses;
CREATE TABLE romaniamain.search_bonuses (
   AsOf date, 
   Bonus_ID int DEFAULT NULL,
   Campaign_Name varchar(200) DEFAULT NULL,
   Username varchar(200) DEFAULT NULL,
   Cust_Ccy_Code varchar(200) DEFAULT NULL,
   Operator_Code varchar(200) DEFAULT NULL,
   Casino varchar(200) DEFAULT NULL,
   Bonus_Type varchar(200) DEFAULT NULL,
   Status varchar(200) DEFAULT NULL,
   Date_Started_Triggers datetime DEFAULT NULL,
   Date_Awarded datetime DEFAULT NULL,
   Amount_Awarded decimal(18,6) DEFAULT NULL,
   Remaining_Credit varchar(200) DEFAULT NULL,
   opt_In_Amount decimal(18,6) DEFAULT NULL,
   Opt_In_Date datetime DEFAULT NULL,
   Total_Wagered decimal(18,6) DEFAULT NULL,
   Wagering_Target decimal(18,6) DEFAULT NULL,
   Contributing_Bets varchar(20) DEFAULT NULL,
   Amount_Redeemed decimal(18,6) DEFAULT NULL,
   Completed_Date datetime DEFAULT NULL,
   Amount_Expired decimal(18,6) DEFAULT NULL,
   Expiry_Date datetime DEFAULT NULL
 ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;
 
LOAD DATA INFILE 'D:\\2016\\Feb-2016\\2016-Feb-04\\Dump\\Search_Bonuses_Report.csv' 
INTO TABLE romaniastg.stg_search_bonuses
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


select 
str_to_date('2016-02-05','%Y-%m-%d') asof,
Bonus_ID, Campaign_Name, Username, Cust_Ccy_Code, Operator_Code, Casino, Bonus_Type, Status, 
str_to_date(Date_Started_Triggers,'%Y-%m-%d %H:%i') Date_Started_Triggers,
str_to_date(Date_Awarded,'%Y-%m-%d %H:%i') Date_Awarded, Amount_Awarded, Remaining_Credit, Opt_In_Amount, 
case when Opt_In_Date ='' then null else str_to_date(Opt_In_Date,'%Y-%m-%d %H:%i') end Opt_In_Date, Total_Wagered, Wagering_Target, Contributing_Bets, Amount_Redeemed, 
case when Completed_Date ='' then null else str_to_date(Completed_Date,'%Y-%m-%d %H:%i') end Completed_Date, Amount_Expired, 
case when Expiry_Date ='' then null else str_to_date(Expiry_Date,'%Y-%m-%d %H:%i') end Expiry_Date
from romaniastg.stg_search_bonuses
where Campaign_Name<>'Campaign Name'
INTO OUTFILE 'D:\\2016\\Feb-2016\\2016-Feb-04\\Dump\\out_stg_search_bonuses.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'D:\\2016\\Feb-2016\\2016-Feb-04\\Dump\\out_stg_search_bonuses.csv' 
INTO TABLE romaniamain.search_bonuses
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n'; 

select * from romaniamain.search_bonuses;

select date(Date_Awarded),
sum(Amount_Awarded) Amount_Awarded,
sum(case when status = 'Active' then Amount_Awarded else 0 end) Active,
sum(case when status = 'Redeemed' then Amount_Awarded else 0 end) Redeemed,
sum(case when status = 'Expired' then Amount_Awarded else 0 end) Expired,
sum(case when status = 'Cancelled' then Amount_Awarded else 0 end) Cancelled
from romaniamain.search_bonuses sb  join romaniamain.dim_player p on sb.Username = p.Username
where Date_Awarded>='2015-11-26'
and asof = '2016-02-05'
and p.signupdate >= '2015-11-26'
group by date(Date_Awarded);
INTO OUTFILE 'D:\\2016\\Feb-2016\\2016-Feb-01\\BonusExtractsSB.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY 'NULL' LINES TERMINATED BY '\n';

Drop table `romaniamain`.`Bonus_Details`;
Create table `romaniamain`.`Bonus_Details`
(
asof date,
Awarded_Date date,
active decimal(18,6),
redeemed decimal(18,6),
expired decimal(18,6),
cancelled decimal(18,6)
) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8;

LOAD DATA INFILE 'D:\\2016\\Feb-2016\\2016-Feb-01\\BonusExtractsSB.csv' 
INTO TABLE `romaniamain`.`Bonus_Details`
FIELDS TERMINATED BY ';' ENCLOSED BY 'NULL' LINES TERMINATED BY '\n';

select date(RequestDate) summarydate,
sum(amount) offored,
sum(case when status in ('approved','waiting') then amount else 0 end) active,
sum(case when status ='removed' and Removalreason in (1,2,9,10) then amount else 0 end) redeemed,
sum(case when status ='removed' and Removalreason in (4,5,6,7,13) then amount else 0 end) expired,
0 cancelled
from romaniamain.pending_bonus pb join romaniamain.dim_player p on pb.playercode = p.playerId
where RequestDate>='2015-11-26'
and asof = '2016-02-05'
and p.signupdate >= '2015-11-26'
group by date(RequestDate);

*/