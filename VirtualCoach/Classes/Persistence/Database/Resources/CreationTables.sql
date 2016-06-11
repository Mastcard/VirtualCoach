Drop table if exists CoachPlayer;
Drop table if exists PlayerTrainingVideo;
Drop table if exists Movement;
Drop table if exists MovementReference;
Drop table if exists VideoReference;
Drop table if exists PlayerTrophy;
Drop table if exists Statistical;
Drop table if exists Coach;
Drop table if exists Player;
Drop table if exists Training;
Drop table if exists Video;
Drop table if exists Trophy;

Create table Coach(
idCoach integer primary key autoincrement,
name varchar(45),
firstname varchar(45),
lefthanded integer,
login varchar(45),
password varchar(45)
);

Create table Player(
idPlayer integer primary key autoincrement,
name varchar(45),
firstname varchar(45),
lefthanded integer,
level varchar(45)
);

Create table CoachPlayer(
idCoachPlayer integer primary key autoincrement,
idcoach integer,
idplayer integer,
Foreign key (idcoach) references User(Coach),
Foreign key (idplayer) references User(Player)
);

Create table Trophy(
idTrophy integer primary key autoincrement,
name varchar(45),
description varchar(45)
);

Create table PlayerTrophy(
idPlayerTrophy integer primary key autoincrement,
idplayer integer,
idtrophy integer,
Foreign key (idplayer) references User(Player),
Foreign key (idtrophy) references User(Trophy)
);

Create table Statistical(
idStatistical integer primary key autoincrement,
cntforehand integer,
cntbackhand integer,
cntservice integer,
winningrun integer,
losingrun integer,
globalsuccessrateforehand double,
globalsuccessratebackhand double,
globalsuccessrateservice double,
day integer,
month integer,
year integer,
idplayer integer,
Foreign key (idplayer) references User(Player)
);

Create table Training(
idTraining integer primary key autoincrement,
date varchar(45),
name varchar(45),
place varchar(45)
);

Create Table Video(
idVideo integer primary key autoincrement,
name varchar(200),
processed integer,
removed integer,
day integer,
month integer,
year integer
);

Create table PlayerTrainingVideo(
idPlayerTrainingVideo integer primary key autoincrement,
idplayer integer,
idtraining integer,
idvideo integer,
Foreign key (idplayer) references User(Player),
Foreign key (idtraining) references User(Training),
Foreign key (idvideo) references User(Video)
);

Create table Movement(
idMovement integer primary key autoincrement,
type varchar(45),
winner integer,
losing integer,
successrate double,
idvideo integer,
Foreign key (idvideo) references User(Video)
);

Create Table VideoReference(
idVideoRef integer primary key autoincrement,
name varchar(200),
processed integer,
removed integer,
day integer,
month integer,
year integer,
idcoach integer,
Foreign key (idcoach) references User(Coach)
);

Create table MovementReference(
idMovementRef integer primary key autoincrement,
type varchar(45),
path varchar(200),
idvideoRef integer,
Foreign key (idvideoRef) references User(VideoReference)
);