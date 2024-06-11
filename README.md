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
