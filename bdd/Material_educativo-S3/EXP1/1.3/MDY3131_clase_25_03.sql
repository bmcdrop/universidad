DECLARE
    v_nro_cliente credito_cliente.nro_cliente%TYPE;
    v_numrun_dvrun VARCHAR2(12);
    v_pnombre_appaterno VARCHAR2(100);
    v_cod_tipo_cliente cliente.cod_tipo_cliente%TYPE;
    v_desc_tipo_cliente VARCHAR2(100);
BEGIN
    SELECT
        c.nro_cliente,
        c.numrun||''||c.dvrun,
        c.pnombre||' '||c.appaterno,
        c.cod_tipo_cliente
 INTO
        v_nro_cliente,
        v_numrun_dvrun,
        v_pnombre_appaterno,
        v_cod_tipo_cliente
        
    FROM credito_cliente cc LEFT JOIN cliente c
        ON(cc.nro_cliente = c.nro_cliente)
    WHERE (cc.fecha_otorga_cred BETWEEN '01/01/2021' AND '31/12/2021')
        AND cc.nro_cliente = &buscar_cliente;
    BEGIN
        SELECT
            nombre_tipo_cliente
        INTO
            v_desc_tipo_cliente
        FROM tipo_cliente
        WHERE cod_tipo_cliente = v_cod_tipo_cliente;
    END;
        
    INSERT INTO cliente_todosuma VALUES (v_nro_cliente,v_numrun_dvrun,v_pnombre_appaterno,v_desc_tipo_cliente,5,6);
END;


