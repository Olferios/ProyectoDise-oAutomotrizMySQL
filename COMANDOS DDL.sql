create database proyecto3;
use proyecto3;

create table tipoIdentificacion(
	id int auto_increment,
    tipoIdentificacion varchar(45),
    constraint pk_id_identificacion primary key(id)
);
create table cliente(
	id int auto_increment,
    fkTipoIdentificacion int,
    NIdentificacion varchar(15),
    nombre varchar(45),
    apellido varchar(45),
    direccion varchar(100),
    email varchar(50),
    constraint pk_id_cliente primary key(id),
    constraint fk_tipoIdentificacion_cliente foreign key (fkTipoIdentificacion) references tipoIdentificacion(id)
);

create table marca(
	id int auto_increment,
    marca varchar(45),
    constraint pk_id_marca primary key(id)
);

create table modelo(
	id int auto_increment,
    modelo varchar(45),
    fkMarca int,
    constraint pk_id_modelo primary key(id),
    constraint fk_marca_modelo foreign key(fkMarca) references marca(id)
);
create table vehiculo(
id int auto_increment,
placa varchar(6),
fkModelo int,
año year,
fkIdCliente int,
constraint pk_id_vehiculo primary key(id),
constraint fk_modelo_vehiculo foreign key(fkModelo) references modelo(id),
constraint fk_cliente_vehiculo foreign key(fkIdCliente) references cliente(id)
);

create table servicios(
	id int auto_increment,
    nombre varchar(45),
    descripcion varchar(50),
    costo float(8),
    constraint pk_id_servicios primary key(id)
);

create table citas(
id int auto_increment,
fecha datetime,
fkVehiculo int,
fkServicio int,
constraint pk_id_citas primary key(id),
constraint fk_vehiculo_cita foreign key(fkVehiculo) references vehiculo(id),
constraint fk_servicio_cita foreign key(fkServicio) references servicios(id)
);
create table cargo(
id int auto_increment,
cargo varchar(45),
constraint pk_id_cargo primary key(id)
);
create table empleado(
id int auto_increment,
NIdentificacion varchar(45),
fkTipoIdentificacion int,
nombre varchar(45),
apellido varchar(45),
fkIdCargo int,
constraint pk_id_empleado primary key(id),
constraint fk_tipoIdentificacion_empleado foreign key(fkTipoIdentificacion) references tipoIdentificacion(id),
constraint fk_cargo_empleado foreign key(fkIdCargo) references cargo(id)
);
create table reparacion(
id int auto_increment,
fecha datetime,
fkIdVehiculo int,
fkIdEmpleado int,
fkServicio int,
costoTotal float(15,2),
descripcion text,
duracion float,
constraint pk_id_reparacion primary key(id),
constraint fk_vehiculo_reparacion foreign key(fkIdVehiculo) references vehiculo(id),
constraint fk_empleado_reparacion foreign key(fkIdEmpleado) references empleado(id),
constraint fk_servicio_reparacion foreign key(fkServicio) references servicios(id)
);


create table tipoTelefono(
id int auto_increment,
tipoTelefono varchar(45),
constraint pk_id_tipoTelefono primary key(id)
);
create table telefonoEmpleado(
id int auto_increment,
fkIdTipoTelefono int,
numeroTelefono varchar(10),
fkIdEmpleado int,
constraint pk_id_telefonoEmpleado primary key(id),
constraint fk_tipoTelefono_telefonoEmpleado foreign key(fkIdTipoTelefono) references tipoTelefono(id),
constraint fk_empleado_telefonoEmpleado foreign key(fkIdEmpleado) references empleado(id)
);
create table proveedor (
id int auto_increment,
fkTipoIdentificacion int,
nIdentificacion varchar(45),
nombre varchar(45),
contacto varchar(45),
email varchar(45),
constraint pk_id_proveedor primary key(id),
constraint fk_tipoidentificacion_proveedor foreign key(fkTipoIdentificacion) references tipoIdentificacion(id)
);
create table telefonoProveedor(
id int auto_increment,
fkIdTipoTelefono int,
numeroTelefono varchar(10),
fkIdProveedor int,
constraint pk_id_telefonoProveedor primary key(id),
constraint fk_tipoTelefono_telefonoProveedor foreign key(fkIdTipoTelefono) references tipoTelefono(id),
constraint fk_empleado_telefonoProveedor foreign key(fkIdProveedor) references proveedor(id)
);
create table ubicacion(
id int auto_increment,
zona varchar(45),
constraint pk_id_ubicacion primary key(id)
);
create table piezas(
id int auto_increment,
nombre varchar(45),
descripcion text,
constraint pk_id_piezas primary key(id)
);
create table inventarios (
id int auto_increment,
fkIdPieza int,
cantidad varchar(5),
fkIdUbicacion int,
constraint pk_id_inventarios primary key(id),
constraint pk_pieza_inventario foreign key(fkIdPieza) references piezas(id),
constraint pk_ubicacion_inventario foreign key(fkIdUbicacion) references ubicacion(id)
);
create table reparacionPiezas(
id int auto_increment,
fkIdPieza int,
cantidad int,
fkIdReparacion int,
costoTotal float(15,2),
constraint pk_id_reparacionPiezas primary key(id),
constraint pk_pieza_reparacionPieza foreign key(fkIdPieza) references piezas(id),
constraint fk_reparacion_repaPieza foreign key(fkIdReparacion) references reparacion(id)
);

create table ordenDetalles(
id int auto_increment,
fkIdPieza int,
cantidad int(5),
precio float(10,2),
constraint pk_id_OrdenDetalle primary key(id),
constraint pk_pieza_odenDetalle foreign key(fkIdPieza) references piezas(id)
);

create table ordenCompra(
fkIdOrden int,
fecha date,
fkIdProveedor int,
fkEmpleado int,
constraint pk_id_OrdenCompra primary key(fkIdOrden),
constraint fk_idorden_ordencompra foreign key(fkIdOrden) references ordenDetalles(id),
constraint fk_proveedor_odenCompra foreign key(fkIdProveedor) references proveedor(id),
constraint fk_empleado_odenCompra foreign key(fkEmpleado) references empleado(id)
);
create table facturaDetalles (
id int auto_increment,
fkIdReparacion int,
cantidad int(6),
precio float(10,2),
constraint pk_id_facturaDetalles primary key(id),
constraint fk_idReparacion_facturaDetalles foreign key(fkIdReparacion) references reparacion(id)
);
create table facturacionI(
fkIdFacturacion int,
fecha datetime,
fkCliente int,
total float(10,2),
constraint pk_id_facturacion primary key(fkIdFacturacion),
constraint fk_idFactura_facturacion foreign key(fkIdFacturacion) references facturaDetalles(id),
constraint fk_cliente_facturacion foreign key(fkCliente) references cliente(id)
);
