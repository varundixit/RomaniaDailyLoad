select advCode AdvertiserCode,AdvEmail AdvertiserEmail,AdvChannel AdvertiserChannel,advUsername AdvertiserUsername, 
count(PlayerID) AllPlayersCnt,sum(ftds) PlayersWithFtdCnt, sum(CountablePlyrs) ConvertedPlayerCnt,
case when sum(CountablePlyrs) < 6 then 0
	 when sum(CountablePlyrs) > 6 then 50 + (sum(CountablePlyrs)-6)*10
     end commission
from (
select date_format(p.SignupDate,'%Y-%m') mon,p.PlayerID,p.username,adv.AdvEmail,advUsername,AdvChannel,advCode, 
cas.TotalDepApproveAmt, b.TotalCashStake,
case when p.GlobalFirstDepositDate is not null then 1 else 0 end ftds,
case when cas.TotalDepApproveAmt >= 50 and b.TotalCashStake >= 150 then 1 else 0 end CountablePlyrs
from romaniamain.dim_player p
left outer join romaniafl.dim_player_channel adv on adv.PlayerId = p.playerid 
left outer join (SELECT PlayerId,sum(TotalDepApproveAmt) TotalDepApproveAmt FROM romaniamain.sd_daily_cashier_summary group by PlayerId) as cas on cas.PlayerId = p.playerid 
left outer join (select PlayerId,sum(SPCashStakeAmt) TotalCashStake from romaniamain.sd_cv_daily_player_summary group by PlayerId) as b on b.PlayerId = p.playerid
where p.SignupDate >= '2016-01-01' and p.SignupDate < '2016-02-01') ba
group by advCode,AdvEmail,AdvChannel,advUsername
order by ConvertedPlayerCnt desc;