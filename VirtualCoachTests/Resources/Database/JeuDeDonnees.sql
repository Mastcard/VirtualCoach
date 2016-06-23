insert into Coach values (null,"Romain","DUBREUCQ","1","rdubreucq","mdpromain");

insert into Player values (null,"LESUR","Adrien","0","Intermediaire");
insert into Player values (null,"ZORO","Jean-Daniel","0","Intermediaire");
insert into Player values (null,"RAK","Lala","0","Intermediaire");

insert into CoachPlayer values 
(null,(select idCoach from Coach where login ="rdubreucq"),(select idPlayer from Player where firstname ="LESUR"));
insert into CoachPlayer values 
(null,(select idCoach from Coach where login ="rdubreucq"),(select idPlayer from Player where firstname ="ZORO"));
insert into CoachPlayer values 
(null,(select idCoach from Coach where login ="rdubreucq"),(select idPlayer from Player where firstname ="RAK"));

insert into Video values (null,"2016-06-06_19.19.40","1","1","06","06","2016");
insert into Video values (null,"2016-06-06_19.19.41","1","1","06","06","2016");
insert into Video values (null,"2016-06-06_19.19.42","1","1","06","06","2016");
insert into Video values (null,"2016-06-06_19.19.43","1","1","06","06","2016");
insert into Video values (null,"2016-06-06_19.19.44","1","0","06","06","2016");

insert into Movement values (null,"forehand","1","0",0.30,(select idVideo from Video where name ="2016-06-06_19.19.40"));
insert into Movement values (null,"backhand","2","0",0.30,(select idVideo from Video where name ="2016-06-06_19.19.40"));
insert into Movement values (null,"service","0","1",0.10,(select idVideo from Video where name ="2016-06-06_19.19.40"));
insert into Movement values (null,"forehand","1","0",0.30,(select idVideo from Video where name ="2016-06-06_19.19.41"));
insert into Movement values (null,"backhand","2","0",0.50,(select idVideo from Video where name ="2016-06-06_19.19.41"));
insert into Movement values (null,"service","0","1",0.10,(select idVideo from Video where name ="2016-06-06_19.19.41"));
insert into Movement values (null,"forehand","1","0",0.30,(select idVideo from Video where name ="2016-06-06_19.19.42"));
insert into Movement values (null,"backhand","2","0",0.50,(select idVideo from Video where name ="2016-06-06_19.19.42"));
insert into Movement values (null,"service","0","1",0.10,(select idVideo from Video where name ="2016-06-06_19.19.42"));
insert into Movement values (null,"forehand","1","0",0.30,(select idVideo from Video where name ="2016-06-06_19.19.43"));
insert into Movement values (null,"backhand","2","0",0.50,(select idVideo from Video where name ="2016-06-06_19.19.43"));
insert into Movement values (null,"service","0","1",0.10,(select idVideo from Video where name ="2016-06-06_19.19.43"));

insert into VideoReference 
values (null,"2016-06-06_19.19.40_ref","1","1","06","06","2016",(select idCoach from Coach where login ="rdubreucq"));
insert into VideoReference 
values (null,"2016-06-06_19.19.41_ref","1","1","06","06","2016",(select idCoach from Coach where login ="rdubreucq"));
insert into VideoReference 
values (null,"2016-06-06_19.19.42_ref","1","1","06","06","2016",(select idCoach from Coach where login ="rdubreucq"));
insert into VideoReference 
values (null,"2016-06-06_19.19.43_ref","1","1","06","06","2016",(select idCoach from Coach where login ="rdubreucq"));

insert into MovementReference 
values (null,"forehand","2016-06-06_19.19.40_1",(select idVideoRef from VideoReference where name ="2016-06-06_19.19.40_ref"));
insert into MovementReference 
values (null,"backhand","2016-06-06_19.19.40_2",(select idVideoRef from VideoReference where name ="2016-06-06_19.19.40_ref"));
insert into MovementReference 
values (null,"service","2016-06-06_19.19.40_3",(select idVideoRef from VideoReference where name ="2016-06-06_19.19.40_ref"));
insert into MovementReference 
values (null,"forehand","2016-06-06_19.19.40_4",(select idVideoRef from VideoReference where name ="2016-06-06_19.19.41_ref"));
insert into MovementReference 
values (null,"backhand","2016-06-06_19.19.40_5",(select idVideoRef from VideoReference where name ="2016-06-06_19.19.41_ref"));
insert into MovementReference 
values (null,"service","2016-06-06_19.19.40_6",(select idVideoRef from VideoReference where name ="2016-06-06_19.19.41_ref"));
insert into MovementReference 
values (null,"forehand","2016-06-06_19.19.40_7",(select idVideoRef from VideoReference where name ="2016-06-06_19.19.42_ref"));
insert into MovementReference 
values (null,"backhand","2016-06-06_19.19.40_8",(select idVideoRef from VideoReference where name ="2016-06-06_19.19.42_ref"));
insert into MovementReference 
values (null,"service","2016-06-06_19.19.40_9",(select idVideoRef from VideoReference where name ="2016-06-06_19.19.42_ref"));
insert into MovementReference 
values (null,"forehand","2016-06-06_19.19.40_10",(select idVideoRef from VideoReference where name ="2016-06-06_19.19.43_ref"));
insert into MovementReference 
values (null,"backhand","2016-06-06_19.19.40_11",(select idVideoRef from VideoReference where name ="2016-06-06_19.19.43_ref"));
insert into MovementReference 
values (null,"service","2016-06-06_19.19.40_12",(select idVideoRef from VideoReference where name ="2016-06-06_19.19.43_ref"));