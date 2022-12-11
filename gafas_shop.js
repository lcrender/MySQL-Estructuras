//USE gafas_shop;
SELECT nombre, id_gafa, fecha FROM ventas JOIN clientes ON ventas.id_cliente = clientes.id WHERE id_cliente = 1;
SELECT * FROM ventas WHERE fecha BETWEEN "2022-01-01" AND "2022-12-31" AND id_cliente = 1;
SELECT DISTINCT p.nombre FROM ventas v JOIN gafas g ON v.id_gafa = g.id JOIN gafas_marca m ON g.id_marca = m.id JOIN proveedores p ON m.id_proveedor = p.id;