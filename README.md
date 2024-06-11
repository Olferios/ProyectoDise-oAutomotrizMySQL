# PROYECTO MYSQL DISEÑO AUTOMOTRIZ
## CONSULTAS
### 1.  Obtener el historial de reparaciones de un vehículo específico
    
    select v.placa,r.fecha, r.descripcion,r.duracion,r.costoTotal from reparacion r
    join vehiculo v on r.fkIdVehiculo=v.id
    where v.id=1;
    
#### RESULTADO
| **PLACA** | **FECHA**            | **DESCRIPCION**       | **DURACION** | **COSTOTOTAL** |
|-----------|----------------------|-----------------------|--------------|----------------|
| ABC123    | 2024-06-10 10:00:01  | Cambio llantas        |          1   |     80000.00   |
| ABC123    | 2024-06-10 09:00:00  | Reparación del motor  |        3.5   |    100000.00   |
| ABC123    | 2024-06-10 14:36:26  | Reparación de frenos  |        2.5   |      1000.00   |


### 2. Calcular el costo total de todas las reparaciones realizadas por un empleado específico en un período de tiempo
    SELECT SUM(r.costoTotal) as costo_total, e.nombre as nombreEmpleado, e.apellido as apellidoEmpleado
    FROM reparacion r
    JOIN empleado e ON e.id = r.fkIdEmpleado
    WHERE e.id = 6 AND YEAR(r.fecha) = 2024
    GROUP BY e.id;
#### RESULTADO
| **COSTO_TOTAL** | **NOMBREEMPLEADO** | **APELLIDOEMPLEADO** |
|-----------------|--------------------|----------------------|
|       40000.00  | jhon               | duarte               |

### 3. Listar todos los clientes y los vehículos que poseen
    select c.nombre, c.apellido, v.placa,m.modelo from cliente c
    left join vehiculo v on v.fkIdCliente=c.id
    join modelo m on m.id=v.fkModelo;
#### RESULTADO   
| **COSTO_TOTAL** | **NOMBREEMPLEADO** | **APELLIDOEMPLEADO** |
|-----------------|--------------------|----------------------|
|       40000.00  | jhon               | duarte               |

### 4. Obtener la cantidad de piezas en inventario para cada pieza
    select p.nombre,i.cantidad from piezas p
    join inventarios i on i.fkIdPieza=p.id;
#### RESULTADO
| **NOMBRE**  | **CANTIDAD** |
|-------------|--------------|
| Tuerca      | 200          |
| Tornillo    | 300          |
| Arandela    | 30           |
| Junta       | 10           |
| Resorte     | 120          |
| Engranaje   | 200          |

### 5. Obtener las citas programadas para un día específico
    select v.placa, c.fecha from citas c
    join vehiculo v on v.id=c.fkVehiculo
    where date(c.fecha)='2024-06-10';}
#### RESULTADO

### 6. Generar una factura para un cliente específico en una fecha determinada
    SELECT fi.fecha, c.nombre, c.apellido, c.NIdentificacion, s.nombre, fi.total 
    FROM facturacioni fi
    JOIN cliente c ON fi.fkCliente = c.id
    JOIN facturadetalles fa ON fa.id = fi.fkIdFacturacion
    JOIN reparacion r ON r.id = fa.fkIdReparacion
    JOIN servicios s ON s.id = r.fkServicio
    WHERE c.id = 1 and date(fi.fecha)='2024-06-20';
#### RESULTADO
| **FECHA**            | **NOMBRE** | **APELLIDO** | **NIDENTIFICACION** | **NOMBRE DEL SERVICIO** | **TOTAL**    |
|----------------------|------------|--------------|---------------------|-------------------------|--------------|
| 2024-06-20 08:00:00  | Juan       | Pérez        | 123456789           | Alineación y balanceo   | 500000.00    |

### 7. Listar todas las órdenes de compra y sus detalles
    SELECT pi.nombre as nombrePieza,
       od.cantidad,
       od.precio,
       p.nombre as nombreProveedor,
       e.nombre as nombreEmpleado,
       e.apellido as apellidoEmpleado 
    FROM ordendetalles od
    JOIN ordencompra oc ON oc.fkIdOrden = od.id
    JOIN piezas pi ON pi.id = od.fkIdPieza
    JOIN empleado e ON e.id = oc.fkEmpleado
    JOIN proveedor p ON p.id = oc.fkIdProveedor;
#### RESULTADO
| **NOMBREPIEZA** | **CANTIDAD** | **PRECIO** | **NOMBREPROVEEDOR** | **NOMBREEMPLEADO** | **APELLIDOEMPLEADO** |
|-----------------|--------------|------------|---------------------|--------------------|----------------------|
| Tuerca          | 5            | 25000.00   | Proveedor A         | Juan               | Pérez                |
| Tornillo        | 10           | 37500.00   | Proveedor B         | María              | Gómez                |
| Arandela        | 8            | 41000.00   | Proveedor C         | Pedro              | López                |
| Junta           | 3            | 60000.00   | Proveedor A         | Laura              | Hernández            |
| Resorte         | 6            | 32500.00   | Proveedor B         | Ana                | Martínez             |

### 8. Obtener el costo total de piezas utilizadas en una reparación específica
    select costoTotal from reparacionPiezas
    where fkIdReparacion=1;
#### RESULTADO
| **COSTOTOTAL** |
|----------------|
|     25000.00   |

### 9. Obtener el inventario de piezas que necesitan ser reabastecidas (cantidad menor que un umbral)
```
SELECT p.nombre, i.cantidad
    FROM inventarios i
    JOIN piezas p ON p.id = i.fkIdPieza
    WHERE i.cantidad < 80;
```   
#### RESULTADO

| **COSTOTOTAL** |
|----------------|
|     25000.00   |

### 10. Obtener la lista de servicios más solicitados en un período específico
```
SELECT s.nombre, COUNT(r.fkServicio) AS cantidad
FROM reparacion r
JOIN servicios s ON s.id = r.fkServicio
WHERE DATE(r.fecha) LIKE '2024-06%'
GROUP BY s.nombre
ORDER BY cantidad DESC
LIMIT 1;
```
#### RESULTADO
| **NOMBRE**            | **CANTIDAD** |
|-----------------------|--------------|
| Revisión de frenos    | 2            |

### 11. Obtener el costo total de reparaciones para cada cliente en un período específico
```
select r.costoTotal, cl.nombre,cl.apellido, v.placa from reparacion r
join vehiculo v on v.id=r.fkIdVehiculo
join cliente cl on cl.id=v.fkIdCliente
where date(r.fecha) like '2024-06%';
```
#### RESULTADO
| **COSTOTOTAL** | **NOMBRE** | **APELLIDO** | **PLACA** |
|----------------|------------|--------------|-----------|
|     80000.00   | Juan       | Pérez        | ABC123    |
|    100000.00   | Juan       | Pérez        | ABC123    |
|     30000.00   | María      | Gómez        | DEF456    |
|     25000.00   | Pedro      | López        | GHI789    |
|    120000.00   | Olfer      | Olaya        | JKL012    |
|     15000.00   | Carlos     | Martínez     | MNO345    |
|      1000.00   | Juan       | Pérez        | ABC123    |

### 12. Listar los empleados con mayor cantidad de reparaciones realizadas en un período específico--
    SELECT e.nombre, e.apellido, COUNT(r.fkIdEmpleado) AS cantidad_reparaciones
    FROM reparacion r
    JOIN empleado e ON e.id = r.fkIdEmpleado
    WHERE DATE(r.fecha) LIKE '2024-06%'
    GROUP BY e.nombre, e.apellido
    ORDER BY cantidad_reparaciones DESC
    LIMIT 2;
### RESULTADO
| **NOMBRE** | **APELLIDO** | **CANTIDAD_REPARACIONES** |
|------------|--------------|---------------------------|
| Laura      | Hernández    | 4                         |
| jhon       | duarte       | 2                         |

### 13. Obtener las piezas más utilizadas en reparaciones durante un período específico--
    select p.nombre, count(rp.fkIdPieza) as cantidadPieza
    from reparacionPiezas rp
    join piezas p on p.id=rp.fkIdPieza
    join reparacion r on r.id=rp.fkIdReparacion
    where date (r.fecha) like '2024-06%'
    group by p.nombre
    order by cantidadPieza desc;
### RESULTADO
| nombre   | cantidadPieza |
|----------|---------------|
| Tuerca   |             2 |
| Tornillo |             1 |
| Arandela |             1 |
| Junta    |             1 |

### 14. Calcular el promedio de costo de reparaciones por vehículo
    SELECT v.id AS id_vehiculo, round(AVG(r.costoTotal)) AS promedio_costo_reparacion
    FROM reparacion r
    JOIN vehiculo v ON v.id = r.fkIdVehiculo
    GROUP BY v.id;
#### RESULTADO
| id_vehiculo | promedio_costo_reparacion |
|-------------|---------------------------|
|           1 |                     60333 |
|           2 |                     30000 |
|           3 |                     25000 |
|           4 |                    120000 |
|           5 |                     15000 |

### 15. Obtener el inventario de piezas por proveedor
    SELECT pr.nombre AS nombre_proveedor, SUM(i.cantidad) AS cantidad_total
    FROM proveedor pr
    left JOIN ordencompra oc ON pr.id = oc.fkIdProveedor
    left JOIN ordendetalles od ON od.id = oc.fkIdOrden AND oc.fkIdOrden IS NOT NULL
    left JOIN piezas p ON od.fkIdPieza = p.id
    left JOIN inventarios i ON p.id = i.fkIdPieza
    GROUP BY pr.nombre;

#### RESULTADO
| nombre_proveedor | cantidad_total |
|------------------|----------------|
| Proveedor A      |            210 |
| Proveedor B      |            420 |
| Proveedor C      |             30 |
| Proveedor D      |           NULL |
| Proveedor E      |           NULL |

### 16. Listar los clientes que no han realizado reparaciones en el último año
    select distinct(c.nombre), c.apellido from reparacion r
    right join vehiculo v on v.id=r.fkIdVehiculo
    join cliente c on c.id=v.fkIdCliente
    where r.id is null;
#### RESULTADO
| nombre | apellido  |
|--------|-----------|
| Juan   | Pérez     |
| María  | Gómez     |
| Pedro  | López     |
| Ana    | Rodríguez |
| Sofía  | Hernández |
| Diego  | López     |
| Pablo  | Martín    |

### 17. Obtener las ganancias totales del taller en un período específico
    select sum(total) from facturacioni;
#### RESULTADO
| sum(total) |
|------------|
| 2150000.00 |

### 18. Listar los empleados y el total de horas trabajadas en reparaciones en un período específico (asumiendo que se registra la duración de cada reparación)--
    select e.nombre, e.apellido, sum(r.duracion) as horasTrabajadas from reparacion r
    left join empleado e on e.id=r.fkIdEmpleado
    where date (r.fecha) like '2024-06%'
    group by e.nombre, e.apellido;
#### RESULTADO 
| nombre | apellido  | horasTrabajadas |
|--------|-----------|-----------------|
| Laura  | Hernández |            10.5 |
| jhon   | duarte    |               2 |
| María  | Gómez     |             2.5 |

### 19. Obtener el listado de servicios prestados por cada empleado en un período específico--
    select e.nombre, e.apellido,s.nombre from reparacion r
    left join empleado e on e.id=r.fkIdEmpleado
    join servicios s on s.id=r.fkServicio
    where date (r.fecha) like '2024-06%';
#### RESULTADO

| nombre | apellido  | nombre                |
|--------|-----------|-----------------------|
| Laura  | Hernández | Cambio de aceite      |
| Laura  | Hernández | Revisión de frenos    |
| jhon   | duarte    | Revisión de frenos    |
| Laura  | Hernández | Alineación y balanceo |
| María  | Gómez     | Alineación y balanceo |
| Laura  | Hernández | Cambio de bujías      |
| jhon   | duarte    | Lavado exterior       |

## ***SUBCONSULTAS**
### 1. Obtener el cliente que ha gastado más en reparaciones durante el último año.
    SELECT c.nombre AS nombreCliente,c.apellido as apellidoCliente, SUM(r.costoTotal)     AS totalGastado
    FROM cliente c
    JOIN vehiculo v ON c.id = v.fkIdCliente
    JOIN reparacion r ON v.id = r.fkIdVehiculo
    where date (r.fecha) like '2024-06%'
    GROUP BY nombreCliente,apellidoCliente
    ORDER BY totalGastado DESC
    LIMIT 1;
#### RESULTADO
| NOMBRECLIENTE | APELLIDOCLIENTE | TOTALGASTADO |
|---------------|-----------------|--------------|
| Juan          | Pérez           | 181000.00    |

### 2. Obtener la pieza más utilizada en reparaciones durante el último mes
    SELECT 
    p.nombre AS nombrePieza,
    (SELECT COUNT(rp.fkIdPieza) FROM reparacionPiezas rp
     WHERE rp.fkIdPieza = p.id AND rp.fkIdReparacion IN (
         SELECT r.id 
         FROM reparacion r 
         WHERE DATE(r.fecha) LIKE '2024-06%')) AS CantidadxServicio
    FROM piezas p;
#### RESULTADO
| NOMBREPIEZA | CANTIDADXSERVICIO |
|-------------|-------------------|
| Tuerca      |                 2 |
| Tornillo    |                 1 |
| Arandela    |                 1 |
| Junta       |                 1 |
| Resorte     |                 0 |
| Engranaje   |                 0 |

### 3. Obtener los proveedores que suministran las piezas más caras
    SELECT od.precio,(SELECT p.nombre FROM proveedor p
		WHERE p.id = oc.fkIdProveedor) AS nombreProveedor
    FROM  ordenDetalles od, ordenCompra oc
    WHERE od.id = oc.fkIdOrden
    ORDER BY od.precio DESC
    LIMIT 2;
#### RESULTADO
| PRECIO   | NOMBREPROVEEDOR |
|----------|-----------------|
| 60000.00 | Proveedor A     |
| 41000.00 | Proveedor C     |

### 4. Listar las reparaciones que no utilizaron piezas específicas durante el último año--
    SELECT rp.fkIdPieza,rp.cantidad, rp.fkIdReparacion from reparacionpiezas rp
    where rp.fkIdPieza is null;
#### RESULTADO
VACIO

### 5. Obtener las piezas que están en inventario por debajo del 10% del stock inicial
    select i.cantidad,(select p.nombre from piezas p
		where p.id=i.fkIdPieza) as nombrePieza
    from inventarios i 
    where i.cantidad <80;
#### RESULTADO
| CANTIDAD | NOMBREPIEZA |
|----------|-------------|
| 30       | Arandela    |
| 10       | Junta       |

## **PROCEDIMIENTOS ALMACENADOS**
### 1. Crear un procedimiento almacenado para insertar una nueva reparación.
PROCEDIMIENTO

    DELIMITER $$
    DROP PROCEDURE IF EXISTS insertNuevaReparacion $$
    CREATE PROCEDURE insertNuevaReparacion(
	    in fecha DATETIME,
        in fkIdVehiculo int,
        in fkIdEmpleado int,
        in fkServicio int,
        in costoTotal float(15,2),
        in descripcion text,
        in duracion float)
    BEGIN
	    INSERT INTO                     reparacion(fecha,fkIdVehiculo,fkIdEmpleado,fkServicio,costoTotal,descripcion,duracion) values
	(fecha,fkIdVehiculo,fkIdEmpleado,fkServicio,costoTotal,descripcion,duracion);
    END $$
    DELIMITER ;

Llamado:
```
   CALL insertNuevaReparacion('2024-06-10 14:36:26', 1, 2, 3, 1000.00, 'Reparación de frenos', 2.5);
```

### 2. Crear un procedimiento almacenado para actualizar el inventario de una pieza.--
```
DELIMITER $$

DROP PROCEDURE IF EXISTS actualizarInventario $$

CREATE PROCEDURE actualizarInventario(
    IN p_id INT,
    IN p_cantidad INT
)
BEGIN
    UPDATE inventarios
    SET cantidad = p_cantidad
    WHERE id = p_id;
END $$

DELIMITER ;
```
Llamado
```
CALL actualizarInventario(5, 120);
describe inventarios;
```
### 3. Crear un procedimiento almacenado para eliminar una cita--
Procedimiento
```
DELIMITER $$
DROP PROCEDURE IF EXISTS eliminarCita $$
CREATE procedure eliminarCita(
	in idCita int)
BEGIN 
	delete from citas where id=idCita;
END $$
DELIMITER ;
```
Llamado:
```
call eliminarCita(1);
```
### 4. Crear un procedimiento almacenado para generar una factura

Procedimiento
```

```
```
```
### 5. Crear un procedimiento almacenado para obtener el historial de reparaciones de un vehículo--
```
DELIMITER $$

DROP PROCEDURE IF EXISTS historialReparacion $$
CREATE procedure historialReparacion(
in pPlaca varchar(6)
)
BEGIN
	select v.placa, r.id, r.fecha from reparacion r
    left join vehiculo v on r.fkIdVehiculo=v.id
    where v.placa=pPlaca;
END $$

DELIMITER ;
```
Llamado
```
call historialReparacion('ABC123'); 
```
### 6. Crear un procedimiento almacenado para calcular el costo total de reparaciones de un cliente en un período--

Procedimiento

```
DELIMITER $$

DROP PROCEDURE IF EXISTS costoReparacionesPorCliente $$

CREATE PROCEDURE costoReparacionesPorCliente(
    IN fechaInicio DATE,
    IN fechaFin DATE,
    IN identificacionCliente VARCHAR(15),
    OUT totalCosto FLOAT(10,2)
)
BEGIN
    SELECT SUM(f.total) INTO totalCosto
    FROM facturacionI f
    LEFT JOIN cliente c ON c.id = f.fkCliente
    WHERE f.fecha BETWEEN fechaInicio AND fechaFin
    AND c.NIdentificacion = identificacionCliente;
END $$

DELIMITER ;
```
Llamado:
```
CALL costoReparacionesPorCliente('2024-01-01', '2024-12-31', '123456789', @totalCosto);
SELECT @totalCosto AS costo_total_reparaciones;
```
### 7. Crear un procedimiento almacenado para obtener la lista de vehículos que requieren mantenimiento basado en el kilometraje.--

Procedimiento:
```

```
Llamado:
```
```
### 8. Crear un procedimiento almacenado para insertar una nueva orden de compra
Procedimiento:
```

```
Llamado:
```

```
### 9. Crear un procedimiento almacenado para actualizar los datos de un cliente

Procedimiento:
```
DELIMITER $$

DROP PROCEDURE IF EXISTS ActualizarDatosCliente $$

CREATE PROCEDURE ActualizarDatosCliente(
    in inputNumero varchar(15),
    in tipoDocumento int,
    in inputNombre varchar(45),
    in inputApellido varchar(45),
    in inputDireccion varchar(100),
    in inputEmail varchar(50)
)
BEGIN
    UPDATE cliente
    SET fkTipoIdentificacion = tipoDocumento,
        nombre = inputNombre,
        apellido = inputApellido,
        direccion = inputDireccion,
        email = inputEmail 
    WHERE NIdentificacion = inputNumero;
END $$

DELIMITER ;
```
Llamado:
```
CALL ActualizarDatosCliente('987654321', 2, 'Olfer', 'Olaya', 'Calle Principal 123', 'olfer@example.com');
```
### 10. Crear un procedimiento almacenado para obtener los servicios más solicitados en un período-- 
Procedimiento:
```

DELIMITER $$

DROP PROCEDURE IF EXISTS servicioSolicitado $$

CREATE PROCEDURE servicioSolicitado(
    in fechaInicio DATE,
    in fechaFin DATE,
    out NombreServicio VARCHAR(100),
    out totalServicio INT
)
BEGIN
    SELECT s.nombre, COUNT(r.fkServicio) INTO NombreServicio, totalServicio
    FROM reparacion r
    JOIN servicios s ON s.id = r.fkServicio
    WHERE r.fecha BETWEEN fechaInicio AND fechaFin
    GROUP BY s.nombre;
END $$

DELIMITER ;
```
Llamado:
```
CALL servicioSolicitado('2024-01-01', '2024-12-31', @NombreServicio, @totalServicio);
```
