use romaniamain;
select 
cast((spl/leg_cnt)*(prt_cnt/pp) as decimal(18,6)) StakePerLine,
cast((wpl/leg_cnt)*(prt_cnt/pp) as decimal(18,6)) WinPerLine,
sb.* 
from fd_settled_bets sb
join (select BetId,(TotalStakeAmt/(max(NumPart)+1)) spl,(TotalReturn/(max(NumPart)+1)) wpl, max(NumLeg)+1 leg_cnt,max(NumPart)+1 prt_cnt 
from fd_settled_bets 
#where BetId=20334928
group by BetId,TotalStakeAmt,TotalReturn) bt on sb.BetId= bt.BetId
join (select BetId,NumLeg,count(NumPart) pp from fd_settled_bets 
#where BetId=20334928
group by BetId,NumLeg) lg on sb.BetId= lg.BetId and sb.NumLeg = lg.NumLeg
INTO OUTFILE 'C:\\Users\\Public\\Downloads\\test\\fd_settled_bets_distribBetId.csv'
FIELDS TERMINATED BY ';' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
#1866904 row(s) affected