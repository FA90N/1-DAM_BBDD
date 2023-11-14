#Nombre:Leyan Xia
#5.1 Muestra para cada planta el número de camas ocupadas o pacientes que hay.
select idPlanta,count(ss) as NumPacientes from plantas natural join habitaciones natural join pacientes group by idplanta;
#5.2 Muestra el número de pacientes que atiende cada enfermero.
select IdEnfermero,count(ss) as NumPacientes from enfermeros natural join cargo group by idenfermero;

#5.3 Muestra el número de pacientes que atiende cada enfermero en cada planta.
select idplanta,idenfermero,count(ss) as NumPaciente
from plantas left join trabaja using(idplanta) 
left join enfermeros using(idEnfermero) 
left join cargo using(idEnfermero)
group by idplanta,idenfermero;

#5.4 Muestra en una consulta el nombre del paciente, la habitación y planta, el nombre del médico y del
#enfermero y el tratamiento, además de la fecha de ingreso y de salida.
select p.nombre,idhabitacion,idplanta,m.nombre as medico,e.nombre as enfermero,tratamiento,fechaingreso,fechasalida from pacientes p left join medicos m using(Ncolegiado)
left join cargo using(ss) inner join enfermeros e using(idenfermero)
left join habitaciones h using(idhabitacion)
left join plantas pl using(idPlanta);

#5.5 Muestra los pacientes hospitalizados. Muestra la planta y especialidad, el nº de colegiado y nombre del
#médico, el nss y nombre del paciente que trata cada médico, la fecha de ingreso del paciente y el número de
#días que lleva ingresado. Los que tienen fecha de salida no hay que mostrarlos.
select p.nombre,idhabitacion,idplanta,m.nombre as medico,tratamiento,fechaingreso,fechaSalida,timestampdiff(day,fechaingreso,curdate())as diasIngresado from pacientes p left join medicos m using(Ncolegiado)
left join cargo using(ss) left join enfermeros e using(idenfermero)
left join habitaciones h using(idhabitacion)
left join plantas pl using(idPlanta) where FechaSalida is null group by nombre;


#6.1 Crea la vista vistaPaciente con los datos de la consulta 5.4
create view vistaPaciente as select p.nombre,idhabitacion,idplanta,m.nombre as medico,e.nombre as enfermero,tratamiento,fechaingreso,fechasalida from pacientes p left join medicos m using(Ncolegiado)
left join cargo using(ss) inner join enfermeros e using(idenfermero)
left join habitaciones h using(idhabitacion)
left join plantas pl using(idPlanta);
select *  from vistaPaciente;
#6.2 Crea la vista vistaPersonal con tres columnas, profesión, nombre y apellidos, uniendo en la vista a
#enfermeros y a médicos
create view vistaPersonal as
select "Medico" as Profesion, nombre from medicos
union all
select "Enfermero", nombre from enfermeros;
select * from vistaPersonal;

#6.3 Crea la vista vistaPacientesIngresados con los datos de la consulta 5.5
create view vistaPacientesIngresados as
select p.nombre,idhabitacion,idplanta,m.nombre as medico,tratamiento,fechaingreso,fechaSalida,timestampdiff(day,fechaingreso,curdate())as diasIngresado from pacientes p left join medicos m using(Ncolegiado)
left join cargo using(ss) left join enfermeros e using(idenfermero)
left join habitaciones h using(idhabitacion)
left join plantas pl using(idPlanta) where FechaSalida is null group by nombre;
select * from vistaPacientesIngresados;

#7. Crea tres usuarios locales. Entra con HeidiSQL para comprobar los permisos.
Drop user if Exists 'LeyanXia'@'localhost';
CREATE USER 'LeyanXia'@'localhost' IDENTIFIED BY '1234';

DROP USER IF EXISTS 'medico'@'localhost';
CREATE USER 'medico'@'localhost' IDENTIFIED BY '1234';

DROP USER IF EXISTS 'administrativo'@'localhost';
CREATE USER 'administrativo'@'localhost' IDENTIFIED BY '1234';

#7.1 El usuario nombreApellido con todos los permisos sobre la base de datos BDHospitalApelido.
#Comprueba que puede ejecutar select y update sobre dos tablas
GRANT ALL PRIVILEGES ON hospitalxia.* TO 'LeyanXia'@'localhost';
FLUSH PRIVILEGES;


#7.2 El usuario medico que podrá hacer select, update sobre la tabla pacientes. Comprueba que puede
#ejecutar select y update sobre la tabla pacientes y que no puede ejecutar select sobre otra tabla.
GRANT UPDATE,SELECT ON hospitalxia.pacientes TO 'medico'@'localhost';
FLUSH PRIVILEGES;

#7.3 El usuario administrativo que podrá hacer select, update, insert y delete sobre la tabla pacientes.
#Comprueba que puede ejecutar select y update sobre la tabla pacientes y que no puede ejecutar select
#sobre otra tabla.
GRANT UPDATE,SELECT,insert,delete ON hospitalxia.pacientes TO 'administrativo'@'localhost';
FLUSH PRIVILEGES;



