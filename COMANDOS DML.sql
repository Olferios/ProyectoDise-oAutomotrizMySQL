use proyecto3;

INSERT INTO marca (marca) VALUES 
('Mazda'),
('Chevrolet'),
('Fiat'),
('Ford'),
('Kia'),
('Honda');

INSERT INTO modelo (modelo,fkMarca) VALUES 
('Allegro',1),
('Dmax',2),
('Fiesta',4),
('CRV',4),
('HRV',6),
('Civic',6),
('Patrol',6),
('Aveo',2),
('Beat',2),
('Escape',4),
('Explorer',4),
('Mustang',4),
('Sportage',5);

INSERT INTO tipoIdentificacion (tipoIdentificacion) values
('cedula'),
('NIT'),
('RUT');

-- Inserciones para la tabla cliente
INSERT INTO cliente (fkTipoIdentificacion, NIdentificacion, nombre, apellido, direccion, email) VALUES 
(1, '123456789', 'Juan', 'Pérez', 'Calle 123', 'juan@example.com'),      
(1, '900123456', 'María', 'Gómez', 'Avenida 456', 'maria@example.com'),   
(1, 'ABC123456', 'Pedro', 'López', 'Carrera 789', 'pedro@example.com'),   
(1, '987654321', 'Laura', 'García', 'Avenida 789', 'laura@example.com'),    
(2, '800987654', 'Carlos', 'Martínez', 'Calle 456', 'carlos@example.com'),    
(1, '567890123', 'Ana', 'Rodríguez', 'Carrera 012', 'ana@example.com'),       
(1, 'DEF456789', 'Sofía', 'Hernández', 'Calle 789', 'sofia@example.com'),     
(1, '700654321', 'Diego', 'López', 'Avenida 123', 'diego@example.com'),     
(1, 'GHI789012', 'Pablo', 'Martín', 'Calle 678', 'pablo@example.com');        

INSERT INTO vehiculo (placa, fkModelo, año, fkIdCliente) VALUES 
('ABC123', 1, '2023', 1),    
('DEF456', 2, '2022', 2),    
('GHI789', 4, '2020', 3),    
('JKL012', 7, '2021', 4),    
('MNO345', 6, '2022', 5),    
('PQR678', 4, '2019', 6),    
('STU901', 3, '2020', 7),    
('YZA567', 5, '2021', 8),
('BDC234', 11, '2022', 9),    
('EFG567', 12, '2024', 9),    
('HIJ890', 4, '2021', 3),    
('KLM123', 10, '2023', 1),    
('NOP456', 6, '2020', 2);    


INSERT INTO servicios (nombre, descripcion, costo) VALUES 
('Cambio de aceite', 'Cambio de aceite y filtro', 50000),
('Revisión de frenos', 'Revisión y ajuste de frenos', 80000),
('Alineación y balanceo', 'Alineación y balanceo de ruedas', 100000),
('Cambio de bujías', 'Cambio de bujías y cables', 60000),
('Lavado exterior', 'Lavado exterior del vehículo', 20000);


-- Inserciones para la tabla citas
INSERT INTO citas (fecha, fkVehiculo, fkServicio) VALUES 
('2024-06-10 09:00:00', 1, 1),   
('2024-06-11 10:30:00', 2, 3),    
('2024-06-11 11:45:00', 3, 2),   
('2024-06-13 13:15:00', 4, 4),
('2023-06-12 11:45:00', 1, 2),   
('2023-06-13 13:15:00', 1, 4),     
('2024-06-14 14:30:00', 5, 5);    

INSERT INTO cargo (cargo) VALUES 
('Gerente'),
('Asistente de Gerencia'),
('Analista de Marketing'),
('Mecanico'),
('lavador'),
('Pintor');
INSERT INTO empleado (NIdentificacion, fkTipoIdentificacion, nombre, apellido, fkIdCargo) VALUES 
('123456789', 1, 'Juan', 'Pérez', 1),   
('987654321', 1, 'María', 'Gómez', 2),   
('456789012', 1, 'Pedro', 'López', 3),   
('654321987', 1, 'Laura', 'Hernández', 4),
('321987654', 1, 'Ana', 'Martínez', 5),
('313434882',1,'jhon','duarte',4);
INSERT INTO reparacion (fecha, fkIdVehiculo, fkIdEmpleado, descripcion, fkServicio, duracion, costoTotal) VALUES
('2023-06-10 10:00:01', 1, 4, 'Cambio llantas', 3, 1, 80000),
('2024-06-10 09:00:00', 1, 4, 'Reparación del motor', 1, 3.5, 100000),
('2024-06-11 10:30:00', 2, 4, 'Reemplazo de frenos', 2, 2.0, 30000),
('2024-06-12 11:45:00', 3, 6, 'Revisión del sistema eléctrico', 2, 1.5, 25000),
('2024-06-13 13:15:00', 4, 4, 'Reparación de la transmisión', 4, 4.0, 120000),
('2024-06-14 14:30:00', 5, 6, 'Cambio de aceite y filtro', 5, 0.5, 15000);


INSERT INTO tipoTelefono (tipoTelefono) VALUES 
('Celular'),
('Casa'),
('Trabajo');
INSERT INTO telefonoEmpleado (fkIdTipoTelefono, numeroTelefono, fkIdEmpleado) VALUES 
(1, '1234567890', 1),  
(2, '9876543210', 2),  
(1, '4567890123', 3),  
(3, '7890123456', 4), 
(2, '5678901234', 5),
(2, '56781234', 6);
INSERT INTO proveedor (fkTipoIdentificacion, nIdentificacion, nombre, contacto, email) VALUES 
(2, '123456789', 'Proveedor A', 'Juan Pérez', 'proveedora@example.com'),
(2, '9876543210', 'Proveedor B', 'María Gómez', 'proveedorb@example.com'),
(1, '456789012', 'Proveedor C', 'Pedro López', 'proveedorc@example.com'),
(3, '789012345', 'Proveedor D', 'Laura Hernández', 'proveedord@example.com'),
(2, '567890123', 'Proveedor E', 'Ana Martínez', 'proveedore@example.com');
INSERT INTO telefonoProveedor (fkIdTipoTelefono, numeroTelefono, fkIdProveedor) VALUES 
(1, '1234567890', 1),  
(2, '9876543210', 2),  
(1, '4567890123', 3),  
(3, '7890123456', 4), 
(2, '5678901234', 5);  
INSERT INTO ubicacion (zona) VALUES 
('Almacén principal'),
('Pasillo A'),
('Pasillo B'),
('Estantería 1'),
('Estantería 2'),
('Zona de carga'),
('Área de recepción');
INSERT INTO piezas (nombre, descripcion) VALUES 
('Tuerca', 'Pieza de metal en forma de hexágono que se utiliza para fijar dos o más objetos.'),
('Tornillo', 'Pieza roscada que se utiliza para unir dos o más objetos.'),
('Arandela', 'Disco delgado con un agujero en el centro que se utiliza para distribuir la carga de un tornillo o tuerca.'),
('Junta', 'Pieza de material flexible que se coloca entre dos superficies para evitar la fuga de fluidos.'),
('Resorte', 'Pieza elástica que se utiliza para almacenar energía mecánica.'),
('Engranaje', 'Rueda dentada que transmite movimiento de un eje a otro.');
INSERT INTO inventarios (fkIdPieza, cantidad, fkIdUbicacion) VALUES 
(1, '100', 1), 
(2, '150', 2),  
(3, '200', 3), 
(4, '50', 4),   
(5, '75', 5),   
(6, '120', 6); 
INSERT INTO reparacionPiezas (fkIdPieza, cantidad, fkIdReparacion, costoTotal) VALUES
(1, 5, 1, 25000.00),
(2, 10, 2, 37500.00),
(3, 8, 3, 41000.00),
(4, 3, 4, 60000.00),
(5, 6, 5, 32500.02);



INSERT INTO ordenDetalles (fkIdPieza, cantidad, precio) VALUES 
(1, 5, 25000.00),   
(2, 10, 37500.00), 
(3, 8, 41000.00),   
(4, 3, 60000.00),   
(5, 6, 32500.00);  
INSERT INTO ordenCompra (fkIdOrden, fecha, fkIdProveedor, fkEmpleado) VALUES 
(1, '2024-06-15', 1, 1),  
(2, '2024-06-16', 2, 2),  
(3, '2024-06-17', 3, 3),  
(4, '2024-06-18', 1, 4),   
(5, '2024-06-19', 2, 5);   
INSERT INTO facturaDetalles (fkIdReparacion, cantidad, precio) VALUES 
(1, 2, 250000.00),   
(2, 1, 150000.00),  
(3, 3, 300000.00),   
(4, 1, 100000.00),   
(5, 2, 200000.00);   

INSERT INTO facturacionI (fkIdFacturacion, fecha, fkCliente, total) VALUES 
(1, '2024-06-20 08:00:00', 1, 500000.00),   
(2, '2024-06-21 09:30:00', 2, 750000.00),   
(3, '2024-06-22 10:45:00', 3, 300000.00),   
(4, '2024-06-23 11:15:00', 1, 200000.00),   
(5, '2024-06-24 12:30:00', 2, 400000.00);  









