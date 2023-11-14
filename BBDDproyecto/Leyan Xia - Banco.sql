Drop database if exists BancoXia;
Create database BancoXia;
use BancoXia;

Create Table Transacciones (
idTransaccion int auto_increment primary key,
fecha date,
Cantidad decimal
);

Create Table Movimientos (
idMovimiento int auto_increment primary key,
fechaMovimiento date,
cantidad decimal

);

Create table Cuentas (
idCuenta int auto_increment,
iban varchar(60),
idTransaccion int,
idMovimiento int,
primary key (idCuenta,idTransaccion,idMovimiento),
foreign key (idTransaccion) references Transacciones (idTransaccion),
foreign key (idMovimiento) references movimientos (idMovimiento) 
);

Create table Clientes (
idCliente int auto_increment,
idCuenta int,
idMovimiento int,
primary key (idCliente,idCuenta,idMovimiento),
foreign key (idCuenta) references Cuentas (idCuenta),
foreign key (idMovimiento) references Movimientos (idMovimiento)

);

Create table Empleados (
idEmpleado int auto_increment,
idCliente int,
Primary key (idEmpleado,idCliente),
foreign key (idCliente) references Clientes (idCliente)

);

Create table Persona (
Dni varchar(12) unique,
Nombre Varchar (60),
Apellido Varchar (60),
Direccion Varchar (60),
idCliente int,
idEmpleado int,
primary key (DNi,idCliente,idEmpleado),
foreign key (idCliente) references Clientes (idCliente),
foreign key (idEmpleado) references Empleados (idEmpleado)

);

Create Table Sucursales (
idSucursal int auto_increment,
telefono varchar (9),
idCuenta int,
idEmpleado int,
primary key (idSurcusal,idCuenta,idEmpleado),
foreign key (idCuenta) references Cuentas (idCuenta),
foreign key (idEmpleado) references Empleados (idEmpleado)

);

Create Table Banco (
CIF varchar(9) unique,
nombre varchar(30),
idSucursal int,
primary key (Cif,idSucursal),
foreign key (idSucursal) references Sucursales (idSucursal)
);