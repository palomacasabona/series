drop database if exists series_turcas ;
create database series_turcas; 
use series_turcas; 
#series(#id,-id_nºcapítulos, nombre,temporadas,distribuidos,productor/a,año)
create table serie (
id int unsigned primary key auto_increment,
nombre varchar (15) not null,
temporadas int not null, 
anno int not null,#(?? el año es date o un int (en el caso de año como es solo un numero, ponemos un int). 
director varchar (40) not null,
distribuidora varchar (15) not null
);
#actores(#id,origen,filmografía, nombre, apellidos, fecha_nacimiento, altura, ojos, pelo, complexión)
create table actor (
id int unsigned primary key auto_increment,
nombre varchar (20) not null, 
apellidos varchar (20) not null, 
origen varchar (30) not null, 
altura float not null,
ojos enum ('claros', 'oscuros'),
pelo enum  ('oscuro', 'castano', 'calvo', 'rubio'),
complexion enum ('delgado', 'emdoformo', 'talla baja', 'atletico'),
fecha_nacimiento datetime not null,
filmografia varchar (40) not null
);
#trama(#id,-id_personajes, época,número, guionista,nº_ediciones,guión, género, giros).
create table trama (
id int unsigned primary key auto_increment,
epoca varchar (30) not null, 
guionista varchar (40)  not null,
genero enum ('drama', 'accion', 'ciencia ficcion', 'comedia') not null,
tipo_guion varchar (30),#no es importante
giros int not null,  
n_ediciones int not null#numero importante para no poner la primera que nos han pasado. 
);
#personajes(#id,-id_actores, -id_trama, nombre, apellidos, edad, rol, trabajo, físico, vida, relación respecto al protagonista)
create table personaje (
id int unsigned primary key auto_increment,
nombre varchar (40) not null, 
apellidos varchar (30) not null,
edad int not null,
rol varchar (30) not null ,
trabajo varchar(30) not null,
fisico varchar (500) not null, 
vida tinyint (1) not null,
relacion_respecto_protagonista varchar (20) not null, 
id_actor int unsigned,
foreign key (id_actor) references actor (id),
id_trama int unsigned,
foreign key (id_trama) references trama (id)# error en la clave ajena la restriccion no está correctamente formada. 
);
#capítulo(#id,nº, duración, pausas, share, subtítulos, cortado, nombre)
create table capitulo (
id int unsigned primary key auto_increment, 
nombre varchar (20),
duracion date not null,
pausas tinyint (1) not null,
share int not null,
subtitulos tinyint (1) not null,
cortado tinyint (1) not null, 
numero int not null
);
#banda_sonora(#id, compositor, intérprete, año, copyright, recibida, instrumento_cuerda, instrumento_viento, instrumento_cuerda_perc)
create table banda_sonora (
id int unsigned primary key auto_increment,
compositor varchar (40) not null,
interprete varchar (40) not null,
copyright char (10) not null,
anno int not null, 
recibida tinyint (1),
instrumento_cuerda tinyint (1),
instrumento_viento tinyint (1),
instrumento_cuerda_perc tinyint (1)
);
#villanos(#id,-id_personajes, hª personal, tipo, personalidad, valores)
create table villano(
id int unsigned primary key auto_increment , 
valores varchar (500),
poder_adquisitivo varchar (100) not null,
h_personal varchar (1000),
tipo enum ('empresario', 'mafioso') not null,
personalidad varchar(300), #para almacenar una serie de datos y no repetir el mismo tipo de serie
id_personaje int unsigned,
foreign key (id_personaje) references personaje (id)
);
#héroes(#id,-id_personajes, hª personal, tipo, personalidad, valores)
create table heroe (
id int unsigned primary key auto_increment,
tipo enum ('adulto', 'huérfano/adolescente',' mujer independiente') not null,
poder_adquisitivo varchar (100) not null,
valores varchar (500),
h_personal varchar (600),
personalidad varchar(300),
id_personaje int unsigned,
foreign key (id_personaje) references personaje (id) 
);
#filmografía(#id,-id_actores,-id_filmografía)
create table filmografia(
id int unsigned primary key auto_increment,
id_actor int unsigned,
foreign key(id_actor) references actor (id),
filmografia varchar (500) not null
);
#poder_adquisitivo(#id,poder_adquisitivo,-id_villanos) 
create table poder_adquisitivo (
id int unsigned primary key auto_increment,
id_villano int unsigned,
foreign key(id_villano) references villano (id),
poder_adquisitivo varchar (400) not null
);
#giro(#id,giro ,-id_trama)(
create table giro (
id int unsigned primary key auto_increment,
id_trama int unsigned,
foreign key(id_trama) references trama (id),
giros int not null
);
#actores_actores (#(-id_actor_enamorado,-id_actor_enamorador));
create table actor_se_enamora_actor(
id_actor_enamorado int unsigned,
foreign key(id_actor_enamorado) references actor (id),
id_actor_enamorador int unsigned,
foreign key(id_actor_enamorador) references actor (id),
primary key (id_actor_enamorado, id_actor_enamorador)
);
#personajes_capítulos(#(-id_personajes,-id_capítulos));
create table personaje_capitulo (
id_personaje int unsigned,
foreign key (id_personaje) references personaje (id),
id_capitulo int unsigned,
foreign key (id_capitulo) references capitulo (id),
primary key (id_personaje, id_capitulo) 
);
#heroes_villanos (#(-id_heroes, id_villanos));
create table heroe_villano (
id_heroe int unsigned,
foreign key (id_heroe) references heroe (id),
id_villano int unsigned,
foreign key (id_villano) references villano (id),
primary key (id_heroe, id_villano) 
);
#trama_serie(#(id_trama, id_serie));
create table trama_serie (
id_trama int unsigned,
foreign key (id_trama) references trama (id),
id_serie int unsigned,
foreign key (id_serie) references serie (id),
primary key (id_trama, id_serie) 
);




