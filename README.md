# PROYECTO MYSQL DISEÑO AUTOMOTRIZ
## CONSULTAS
### 1.  Obtener el historial de reparaciones de un vehículo específico
    
    select v.placa,r.fecha, r.descripcion,r.duracion,r.costoTotal from reparacion r
    join vehiculo v on r.fkIdVehiculo=v.id
    where v.id=1;
2. Calcular el costo total de todas las reparaciones realizadas por un empleado
específico en un período de tiempo
3. Listar todos los clientes y los vehículos que poseen
4. 4. Obtener la cantidad de piezas en inventario para cada pieza
5. Obtener las citas programadas para un día específico
6. Generar una factura para un cliente específico en una fecha determinada
7. Listar todas las órdenes de compra y sus detalles
8. Obtener el costo total de piezas utilizadas en una reparación específica
9. Obtener el inventario de piezas que necesitan ser reabastecidas (cantidad
menor que un umbral)
10. Obtener la lista de servicios más solicitados en un período específico
11. Obtener el costo total de reparaciones para cada cliente en un período
específico
12. Listar los empleados con mayor cantidad de reparaciones realizadas en un
período específico
13. Obtener las piezas más utilizadas en reparaciones durante un período
específico
14. Calcular el promedio de costo de reparaciones por vehículo
15. Obtener el inventario de piezas por proveedor
16. Listar los clientes que no han realizado reparaciones en el último año
17. Obtener las ganancias totales del taller en un período específico
18. Listar los empleados y el total de horas trabajadas en reparaciones en un
período específico (asumiendo que se registra la duración de cada reparación)
19. Obtener el listado de servicios prestados por cada empleado en un período
específico
