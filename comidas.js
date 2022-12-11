//USE comidas;
SELECT SUM(pd.cantidad) AS "Bebidas vendidas en Barcelona" FROM pedidos_detalles pd JOIN productos p ON pd.id_producto = p.id JOIN cat_productos cp ON cp.id = p.id_cat_productos JOIN pedidos ped ON ped.id_pedido = pd.id_pedido JOIN direcciones d ON d.id = ped.id_direccion WHERE cp.categoria = "Bebidas"  AND d.localidad = "Barcelona";
SELECT * FROM pedidos WHERE id_empleado = 1;