
--Cálculos de Comisión
SELECT	
t1.periodo,
t1.estado_reportes, 
t1.semaforo, 
t1.moneda, 
t1.fecha_apertura, 
t1.fecha_cierre, 
t1.fecha_cierre, 
t1.nivel_workflow, 
t1.estado_workflow, 
t1.fecha_workflow, 
t1.id_empresa, 
ISNULL((SELECT nombre + ' ' + apellido FROM usuarios WHERE id = t1.id_usuario_apertura),' ') AS usuario_apertura, 
ISNULL((SELECT nombre + ' ' + apellido FROM usuarios WHERE id = t1.id_usuario_cierre),' ') AS usuario_cierre, 
t2.estado, 
ISNULL((SELECT COUNT(distinct(id_vendedor)) FROM cms_periodo_comisionista WHERE id_periodo = t1.id),0) AS total_comisionistas, 
ISNULL((SELECT SUM(monto_comision) FROM cms_supervisor_detalle WHERE id_supervisor IN (SELECT id FROM cms_supervisor WHERE id_periodo = t1.id)),0) AS total_1,
ISNULL((SELECT SUM(monto_comision) FROM cms_comision_venta_propia WHERE periodo_comision = t1.periodo AND id_area = 0),0) AS total_2, 
ISNULL((SELECT SUM(monto_comision) FROM cms_meta_vendedor WHERE periodo_comision = t1.periodo),0) AS total_3, 
ISNULL((SELECT monto_comision FROM cms_operarios_planta WHERE id_periodo = t1.id),0) AS total_4, 
ISNULL((SELECT SUM(monto_comision) FROM cms_cliente_especial_detalle WHERE id_cliente_especial IN (SELECT id FROM cms_cliente_especial WHERE id_periodo = t1.id)),0) AS total_5, 
isnull((SELECT sum(comision_supervisor) FROM cms_supervisor_detalle_factura_v2 WHERE id_supervisor_detalle_v2 IN (SELECT id FROM cms_supervisor_detalle_v2 WHERE id_supervisor_v2 IN (SELECT id FROM cms_supervisor_v2 WHERE id_periodo = t1.id))),0) AS total_6,
ISNULL((SELECT SUM(monto_comision) FROM cms_producto_especial_detalle WHERE id_periodo = t1.id),0) AS total_7, 
ISNULL((SELECT COUNT(DISTINCT(id_esquema)) FROM cms_periodo_comisionista_esquema WHERE estado = 1 AND id_periodo_comisionista IN (SELECT id FROM cms_periodo_comisionista WHERE id_periodo = t1.id)),0) AS total_esquemas, 
t1.semaforo, 
ISNULL(t1.fecha_reportes,' ') AS fecha_reportes FROM cms_periodo_comision AS t1, cms_workflow_estado AS t2 WHERE t1.id = 291 AND t1.estado = t2.indice
	
	
	
	
	