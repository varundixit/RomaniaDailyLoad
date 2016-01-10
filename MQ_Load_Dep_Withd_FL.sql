use romaniamain;
drop table User_Dep_With_First_Last;
CREATE TABLE `User_Dep_With_First_Last` (
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
  
  `TotalSuccDepAmt` decimal(18,6),
  `TotalSuccDepCnt` int DEFAULT NULL,
  `TotalDecDepAmt` decimal(18,6),
  `TotalDecDepCnt` int DEFAULT NULL,
  `TotalAttemptedDepAmt` decimal(18,6),
  `TotalAttemptedDepCnt` int DEFAULT NULL,
  
  `TotalSuccWithdAmt` decimal(18,6),
  `TotalSuccWithdCnt` int DEFAULT NULL,
  `TotalDecWithdAmt` decimal(18,6),
  `TotalDecWithdCnt` int DEFAULT NULL,
  `TotalAttemptedWithdAmt` decimal(18,6),
  `TotalAttemptedWithdCnt` int DEFAULT NULL,
  
  `LastDepTxnStatus` varchar(50),
  `LastDepTxnMethod`varchar(50),
  `LastDepTxnMerchant`varchar(100),
  `LastDepTxnReason` varchar(200),
  `LastDepTxnReasonGrp` varchar(200),
  `LastDepTxnRiskProfile` varchar(200),
  
  `LastWithdTxnStatus` varchar(50),
  `LastWithdTxnMethod`varchar(50),
  `LastWithdTxnMerchant`varchar(100),
  `LastWithdTxnReason` varchar(200),
  `LastWithdTxnReasonGrp` varchar(200),
  `LastWithdTxnRiskProfile` varchar(200),

  PRIMARY KEY (`PlayerId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

insert into romaniamain.User_Dep_With_First_Last (
     PlayerId
	,FirstDepositTime
	,FirstDepositAmount
	,LastDepositTime
	,LastDepositAmount
	,FirstWithdrawalTime
	,FirstWithdrawalAmount
	,LastWithdrawalTime
	,LastWithdrawalAmount
	,FirstAttemptDepositTime
	,FirstAttemptDepositAmount
	,LastAttemptDepositTime
	,LastAttemptDepositAmount
	,FirstAttemptWithdrawalTime
	,FirstAttemptWithdrawalAmount
	,LastAttemptWithdrawalTime
	,LastAttemptWithdrawalAmount
	,TotalSuccDepAmt
	,TotalSuccDepCnt
	,TotalDecDepAmt
	,TotalDecDepCnt
	,TotalAttemptedDepAmt
	,TotalAttemptedDepCnt
	,TotalSuccWithdAmt
	,TotalSuccWithdCnt
	,TotalDecWithdAmt
	,TotalDecWithdCnt
	,TotalAttemptedWithdAmt
	,TotalAttemptedWithdCnt
	,LastDepTxnStatus
	,LastDepTxnMethod
	,LastDepTxnMerchant
	,LastDepTxnReason
	,LastDepTxnReasonGrp
	,LastDepTxnRiskProfile
	,LastWithdTxnStatus
	,LastWithdTxnMethod
	,LastWithdTxnMerchant
	,LastWithdTxnReason
	,LastWithdTxnReasonGrp
	,LastWithdTxnRiskProfile
)
 
select 
 dim.PlayerId
,case when Type = 'deposit' and Status = 'approved' then AcceptTime end
,case when Type = 'deposit' and Status = 'approved' then Amount else 0 end
,case when Type = 'deposit' and Status = 'approved' then AcceptTime end
,case when Type = 'deposit' and Status = 'approved' then Amount else 0 end

,case when Type = 'withdraw' and Status = 'approved' then AcceptTime end
,case when Type = 'withdraw' and Status = 'approved' then Amount else 0 end
,case when Type = 'withdraw' and Status = 'approved' then AcceptTime end
,case when Type = 'withdraw' and Status = 'approved' then Amount else 0 end

,case when Type = 'deposit' then AcceptTime end
,case when Type = 'deposit' then Amount end
,case when Type = 'deposit' then AcceptTime end
,case when Type = 'deposit' then Amount end

,case when Type = 'withdraw' then AcceptTime end
,case when Type = 'withdraw' then Amount end
,case when Type = 'withdraw' then AcceptTime end
,case when Type = 'withdraw' then Amount end

,case when Type = 'deposit' and Status = 'approved' then Amount else 0 end
,case when Type = 'deposit' and Status = 'approved' then 1 else 0 end
,case when Type = 'deposit' and Status = 'declined' then Amount else 0 end
,case when Type = 'deposit' and Status = 'declined' then 1 else 0 end
,case when Type = 'deposit' then Amount else 0 end
,case when Type = 'deposit' then 1 else 0 end


,case when Type = 'withdraw' and Status = 'approved' then Amount else 0 end
,case when Type = 'withdraw' and Status = 'approved' then 1 else 0 end
,case when Type = 'withdraw' and Status = 'declined' then Amount else 0 end
,case when Type = 'withdraw' and Status = 'declined' then 1 else 0 end
,case when Type = 'withdraw' then Amount else 0 end
,case when Type = 'withdraw' then 1 else 0 end

,case when Type = 'deposit' then Status end
,case when Type = 'deposit' then Method end
,case when Type = 'deposit' then Merchant end
,case when Type = 'deposit' then Reason end
,case when Type = 'deposit' then ReasonGroup end
,case when Type = 'deposit' then RiskProfile end

,case when Type = 'withdraw' then Status end
,case when Type = 'withdraw' then Method end
,case when Type = 'withdraw' then Merchant end
,case when Type = 'withdraw' then Reason end
,case when Type = 'withdraw' then ReasonGroup end
,case when Type = 'withdraw' then RiskProfile end

from romaniamain.FACT_DAILY_PLAYER_TRANSACTIONS as src join romaniastage.stg_dim_player as dim on src.Username = dim.Username


on duplicate key update 
 
	FirstDepositAmount = IF((src.AcceptTime < FirstDepositTime OR FirstDepositTime is null) AND src.Status = 'approved' AND src.Type = 'deposit', src.Amount, FirstDepositAmount)
,	LastDepositAmount = IF((src.AcceptTime > LastDepositTime OR LastDepositTime is null) AND src.Status = 'approved' AND src.Type = 'deposit', src.Amount, LastDepositAmount)

,	FirstWithdrawalAmount = IF((src.AcceptTime < FirstWithdrawalTime OR FirstWithdrawalTime is null) AND src.Status = 'approved' AND src.Type = 'withdraw', src.Amount, FirstWithdrawalAmount)
,	LastWithdrawalAmount = IF((src.AcceptTime > LastWithdrawalTime OR LastWithdrawalTime is null) AND src.Status = 'approved' AND src.Type = 'withdraw', src.Amount, LastWithdrawalAmount)

,	FirstAttemptDepositAmount = IF((src.AcceptTime < FirstAttemptDepositTime OR FirstAttemptDepositTime is null) AND src.Type = 'deposit', src.Amount, FirstAttemptDepositAmount)
,	LastAttemptDepositAmount = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.Amount, LastAttemptDepositAmount)

,	FirstAttemptWithdrawalAmount = IF((src.AcceptTime < FirstAttemptWithdrawalTime OR FirstAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.Amount, FirstAttemptWithdrawalAmount)
,	LastAttemptWithdrawalAmount = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.Amount, LastAttemptWithdrawalAmount)

,	TotalSuccDepAmt = TotalSuccDepAmt + IF(src.Type = 'deposit' AND src.Status = 'approved',src.Amount,0)
,	TotalSuccDepCnt =  TotalSuccDepCnt + IF(src.Type = 'deposit' AND src.Status = 'approved',1,0)
,	TotalDecDepAmt = TotalDecDepAmt + IF(src.Type = 'deposit' AND src.Status = 'declined',src.Amount,0)
,	TotalDecDepCnt = TotalDecDepCnt + IF(src.Type = 'deposit' AND src.Status = 'declined',1,0)
,	TotalAttemptedDepAmt =  TotalAttemptedDepCnt + IF(src.Type = 'deposit',src.Amount,0)
,	TotalAttemptedDepCnt = TotalAttemptedDepCnt + IF(src.Type = 'deposit',1,0)

,	TotalSuccWithdAmt = TotalSuccWithdAmt + IF(src.Type = 'withdraw' AND src.Status = 'approved',src.Amount,0)
,	TotalSuccWithdCnt =  TotalSuccWithdCnt + IF(src.Type = 'withdraw' AND src.Status = 'approved',1,0)
,	TotalDecWithdAmt = TotalDecWithdAmt + IF(src.Type = 'withdraw' AND src.Status = 'declined',src.Amount,0)
,	TotalDecWithdCnt = TotalDecWithdCnt + IF(src.Type = 'withdraw' AND src.Status = 'declined',1,0)
,	TotalAttemptedWithdAmt =  TotalAttemptedWithdAmt + IF(src.Type = 'withdraw',src.Amount,0)
,	TotalAttemptedWithdCnt = TotalAttemptedWithdCnt + IF(src.Type = 'withdraw',1,0)

,	LastDepTxnStatus = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.Status, LastDepTxnStatus)
,	LastDepTxnMethod = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.Method, LastDepTxnMethod)
,	LastDepTxnMerchant = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.Merchant, LastDepTxnMerchant)
,	LastDepTxnReason = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.Reason, LastDepTxnReason)
,	LastDepTxnReasonGrp = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.ReasonGroup, LastDepTxnReasonGrp)
,	LastDepTxnRiskProfile = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.RiskProfile, LastDepTxnRiskProfile)

,	LastWithdTxnStatus = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.Status, LastWithdTxnStatus)
,	LastWithdTxnMethod = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.Method, LastWithdTxnMethod)
,	LastWithdTxnMerchant = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.Merchant, LastWithdTxnMerchant)
,	LastWithdTxnReason = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.Reason, LastWithdTxnReason)
,	LastWithdTxnReasonGrp = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.ReasonGroup, LastWithdTxnReasonGrp)
,	LastWithdTxnRiskProfile = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.RiskProfile, LastWithdTxnRiskProfile)

,	FirstDepositTime = if((src.AcceptTime < FirstDepositTime OR FirstDepositTime is null) AND src.Status = 'approved' AND src.Type = 'deposit',src.AcceptTime,FirstDepositTime)
,	LastDepositTime = IF((src.AcceptTime > LastDepositTime OR LastDepositTime is null) AND src.Status = 'approved' AND src.Type = 'deposit', src.AcceptTime, LastDepositTime)

,	FirstWithdrawalTime = if((src.AcceptTime < FirstWithdrawalTime OR FirstWithdrawalTime is null) AND src.Status = 'approved' AND src.Type = 'withdraw',src.AcceptTime,FirstWithdrawalTime)
,	LastWithdrawalTime = IF((src.AcceptTime > LastWithdrawalTime OR LastWithdrawalTime is null) AND src.Status = 'approved' AND src.Type = 'withdraw', src.AcceptTime, LastWithdrawalTime)

,	FirstAttemptDepositTime = if((src.AcceptTime < FirstAttemptDepositTime OR FirstAttemptDepositTime is null) AND src.Type = 'deposit',src.AcceptTime,FirstAttemptDepositTime)
,	LastAttemptDepositTime = IF((src.AcceptTime > LastAttemptDepositTime OR LastAttemptDepositTime is null) AND src.Type = 'deposit', src.AcceptTime, LastAttemptDepositTime)

,	FirstAttemptWithdrawalTime = if((src.AcceptTime < FirstAttemptWithdrawalTime OR FirstAttemptWithdrawalTime is null) AND src.Type = 'withdraw',src.AcceptTime,FirstAttemptWithdrawalTime)
,	LastAttemptWithdrawalTime = IF((src.AcceptTime > LastAttemptWithdrawalTime OR LastAttemptWithdrawalTime is null) AND src.Type = 'withdraw', src.AcceptTime, LastAttemptWithdrawalTime)

;
commit;

# to be exported
select * from romaniamain.User_Dep_With_First_Last;
