Drop database if exists HospitalXia;
Create database HospitalXia;
use hospitalXia;


Create Table Plantas (
idPlanta int auto_increment primary key ,
especialidad varchar (60) unique
);
insert into plantas (especialidad)
value("Alergología"),("Inmunología"),("Cirugía Torácica"),("Cirugía Cardiovascular"),("Urgencias"),("Urología");

Create Table Enfermeros (
idEnfermero int auto_increment primary key,
nombre varchar(30)
);
insert into enfermeros(nombre)
value("Mario"),("Carlos"),("Pepe"),("Luis"),("Mariano"),("Alberto");

Create Table Trabaja(
idPlanta int ,
idEnfermero int , 
primary key(idPlanta,idEnfermero),
foreign key (idPlanta) references Plantas (idPlanta),
foreign key (idEnfermero) references Enfermeros (idEnfermero)
);
insert into trabaja(idPlanta,idEnfermero)
values(1,3),(6,3),(5,2),(4,1),(3,1),(2,6),(2,3),(6,5);

Create Table Habitaciones(
idHabitacion int auto_increment primary key,
numCamas int(2),
idplanta int,
foreign key (idplanta) references plantas (idplanta)
);
insert into habitaciones(numcamas,idplanta)
values(1,2),(3,1),(2,3),(2,4),(3,6),(1,5);

Create Table Medicos(
NColegiado int (6) primary key,
nombre varchar(30)
);
insert into medicos(Ncolegiado,nombre)
values(111111,"Carlos"),(222222,"Ramon"),(333333,"Jose"),(444444,"Patricio"),(555555,"Alan"),(666666,"Ignacio");

Create Table Pacientes(
Dni varchar(10) unique,
SS int(13),
Nombre varchar(30),
Direccion varchar(70),
Sexo enum("Macho","Hembra"),
FechaIngreso date,
FechaSalida date,
FechaTratamiento date,
Tratamiento varchar(60),
Diagnostica varchar(60),
idHabitacion int,
Ncolegiado int,
primary key(SS,idHabitacion,Ncolegiado),
foreign key (idHabitacion) references habitaciones (idHabitacion),
foreign key (Ncolegiado) references medicos (Ncolegiado)
);
insert into pacientes(DNI,SS,NOMBRE,DIRECCION,SEXO,FECHAINGRESO,FECHASALIDA,FECHATRATAMIENTO,TRATAMIENTO,DIAGNOSTICA,IDHABITACION,NCOLEGIADO)
values
("111111111K",0000000000001,"Maria","Fleta 60","Hembra","2023-02-16","2023-03-16","2023-02-22","Paracetamol","COVID-19",5,222222),
("222222222K",0000000000002,"Jose","Fleta 106","Macho","2023-01-16","2023-01-16","2023-01-22","Clotrimazol ","Infeccion Genital",6,111111),
("333333333K",0000000000003,"Carla","Fleta 59","Hembra","2023-03-11","2023-03-18","2023-03-15","Cetrizina","Alergia",1,222222),
("444444444K",0000000000004,"Pepito","Fleta 66","Macho","2023-02-10","2023-02-28","2023-02-12","Glipizida","Diabetico",2,333333),
("555555555K",0000000000005,"Marcos","Fleta 32","Macho","2023-02-16","2023-02-18","2023-02-27","Ibuprofeno","Enfermedad Comun",5,444444),
("666666666K",0000000000006,"Luisa","Fleta 98","Hembra","2023-02-16",null,"2023-02-23","Cirujia","Síndrome de salida torácica venosa",3,555555);

Create Table Cargo(
IdEnfermero int,
SS int,
primary key(IdEnfermero,SS),
foreign key (Idenfermero) references enfermeros (Idenfermero),
foreign key (SS) references Pacientes (SS)
);
insert into cargo (Idenfermero,ss)
values
(1,0000000000003),(2,0000000000001),(3,0000000000006),(4,0000000000006),
(6,0000000000002),(3,0000000000002),(4,0000000000001),(5,0000000000001),
(1,0000000000004),(2,0000000000006),(1,0000000000005),(5,0000000000004);







