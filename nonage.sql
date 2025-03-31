select * from address;
select * from cart;
select * from member;
select * from order_detail;
select * from orders;
select * from product;
select * from qna;
select * from worker;

select * from member where id = ks123 and pwd = 123123;

select * from order_view order by odseq desc;

select * from order_view where id = 'ks123' and oseq = 22 and result = 1;

select * from qna where qseq = 21;

select  qseq, subject, id, rep, indate 
from ( select rownum rm,p1.* 
from (select * from qna order by indate desc) p1)p2 
where rm >= 1 and rm <= 5;

select * from product where pseq = 11;

select * from worker where id = null and pwd = null;

select * from order_view where pname like '힐';

