
   --------     select dc_rut_cliente, dc_rut_deudor,dc_tipo_documento,dn_numero_documento 
	  -------- from tb_documentos 
	  -------- where dn_numero_documento like '373'

	  ------------ resultado  10006618-1	96633780-K	FA	373


	  -------- select dc_rut_cliente, dc_rut_deudor,dc_tipo_documento,dn_numero_documento 
	  -------- from tb_documentos 
	  -------- where dn_numero_documento like '100%'

	  -------- --resultado 10006618-1	77071440-0	FA	100385

	  -------- select dc_rut_cliente, dc_rut_deudor,dc_tipo_documento,dn_numero_documento 
	  -------- from tb_documentos 
	  -------- where dn_numero_documento like '200%'

	  -------- --resultado 10028072-8	92765000-2	FA	2002036
	  --select * from tb_documentos


	  use BD_COBRANZA
	   
	   
	   --declare  @Strdc_rut_cliente varchar(1000),
	  
		declare	@dc_usuario varchar(10),
				@dg_resultado varchar(10),
				@dc_rut_deudor varchar(1000),
				@dc_tipo_documento varchar(1000),
				@dn_numero_documento varchar(1000),
				@dn_num_propuesto varchar(1000)
       SET NOCOUNT ON
       --set @Strdc_rut_cliente = '10006618-1'
	   set @dc_rut_deudor='77071440-0' 
	   set @dc_tipo_documento='FA'
	   set @dn_numero_documento='100385'
	   
       --Como la clave única en Smartem es Rut Deudor, Tipo Documento y número de documento,
       --se obtiene todos los documentos históricos asociados Rut Deudor y Tipo Documento
       CREATE TABLE #tmp_doc_por_cli
                    (dc_rut_cliente varchar(10) collate Modern_Spanish_CI_AS
                    ,dc_rut_deudor varchar(10) collate Modern_Spanish_CI_AS
                    ,dc_tipo_documento varchar(2) collate Modern_Spanish_CI_AS
                    ,dn_numero_documento integer)
       INSERT INTO #tmp_doc_por_cli
                    (dc_rut_cliente
                    ,dc_rut_deudor
                    ,dc_tipo_documento
                    ,dn_numero_documento)
       SELECT doc.dc_rut_cliente
                    ,doc.dc_rut_deudor
                    ,doc.dc_tipo_documento
                    ,doc.dn_numero_documento
       FROM   tb_documentos doc
       WHERE  doc.dc_rut_contrata = '99580240-6'
					AND doc.dc_rut_deudor = @dc_rut_deudor
					AND doc.dc_tipo_documento = @dc_tipo_documento
                    AND doc.dc_rut_cliente =@Strdc_rut_cliente
                    AND doc.dn_numero_documento =@dn_numero_documento

       declare		@dn_reg_total             integer
                    ,@dn_reg                   integer
                    ,@dc_rut_cli        varchar(10)
                    ,@dc_tipo_doc       varchar(2)
                    ,@dn_numero_doc            integer
                    ,@dc_rut_deu        varchar(10)
                    ,@dg_str_num_prop   integer -- número propuesto
					,@dg_numero_multi   integer
       --Verifica si los documentos existen previamente(comprados por ACF Capital)	   

       CREATE TABLE #tmp_doc_existentes
                    (dc_rut_cli         varchar(10) collate Modern_Spanish_CI_AS
                    ,dc_tipo_doc varchar(2) collate Modern_Spanish_CI_AS
                    ,dn_numero_doc      integer
                    ,dc_rut_deu         varchar(10) collate Modern_Spanish_CI_AS
                    ,dn_reg                    integer identity(1,1)
                    )
       INSERT INTO #tmp_doc_existentes 
                    (dc_rut_cli
                    ,dc_tipo_doc
                    ,dn_numero_doc
                    ,dc_rut_deu)
       SELECT tmp.dc_rut_cliente
                    ,tmp.dc_tipo_documento
                    ,tmp.dn_numero_documento
                    ,tmp.dc_rut_deudor
       FROM   #tmp_doc_por_cli tmp
       WHERE tmp.dn_numero_documento = @dn_numero_documento -----DUDA CON ESTE CAMPO IGUALADO A 0 --@dn_numero_documento
	   and  dc_rut_deudor = @dc_rut_deudor	  
	   and tmp.dc_tipo_documento = @dc_tipo_documento
	   and dn_numero_documento =@dn_numero_documento

	   SELECT	@dc_rut_deu = dc_rut_deu
				,@dc_tipo_doc = dc_tipo_doc
				,@dn_numero_doc = dn_numero_doc
				,@dc_rut_cli = dc_rut_cli
       FROM		#tmp_doc_existentes

       --Se crean los número antepuestos que serán utilizados para verificar la existencia previa
      CREATE TABLE #tmp_numeros
                    (dg_str_numero      varchar(10))
       SET @dn_reg_total = 10
       SET    @dn_reg = 1
       WHILE @dn_reg < = @dn_reg_total
       BEGIN  
             INSERT INTO #tmp_numeros
                           (dg_str_numero)
             SELECT 100 * @dn_reg
             SET @dn_reg = @dn_reg + 1
       END

       -- Obtiene la cantidad de registros
       SELECT @dn_reg_total = COUNT(1)
       FROM  #tmp_doc_existentes

             -- Obtiene el menor número, considerando el número antepuesto(100,200,300,....etc) al número real
             -- siempre y cuando no exista			
             SELECT @dg_str_num_prop = min( convert(integer, dg_str_numero + convert(varchar, @dn_numero_doc) ) )
             FROM   #tmp_numeros
             WHERE  Not Exists(	Select 1 From   #tmp_doc_por_cli Where  dc_rut_deudor = @dc_rut_deu
								AND dc_tipo_documento = @dc_tipo_doc
                                AND    dn_numero_documento =  dg_str_numero + convert(varchar, @dn_numero_doc) )
             --SET @dn_reg = @dn_reg + 1 


SELECT '@dg_str_num_prop' = @dg_str_num_prop

       DROP TABLE #tmp_doc_existentes
       DROP TABLE #tmp_numeros
       DROP TABLE #tmp_doc_por_cli



	   ------------CREATE TABLE #tmp_numeros
    ------------                (dg_str_numero      varchar(10))
    ------------   SET @dn_reg_total = 10
    ------------   SET    @dn_reg = 1	   
    ------------   WHILE @dn_reg < = @dn_reg_total
    ------------   BEGIN
			 
			 ------------set @dg_numero_multi = (100 * @dn_reg)
			 ------------IF @dn_numero_doc <> @dg_numero_multi
				------------BEGIN
				------------	 INSERT INTO #tmp_numeros(dg_str_numero)
				------------	 SELECT @dg_numero_multi
				------------	 SET @dn_reg = @dn_reg + 1
				------------END
    ------------   END

------------------------------------------------

--	  select * from  #tmp_doc_por_cli
--	   select * from  #tmp_doc_existentes
--	   select * from  #tmp_numeros

	   


	  -- declare  @Strdc_rut_cliente varchar(1000),
			--	@dc_usuario varchar(10),
			--	@dg_resultado varchar(10),
			--	@dc_rut_deudor varchar(1000),
			--	@dc_tipo_documento varchar(1000),
			--	@dn_numero_documento varchar(1000),
			--	@dn_num_propuesto varchar(1000)
   --    SET NOCOUNT ON
   --    set @Strdc_rut_cliente = '10006618-1'
	  -- set @dc_rut_deudor='77071440-0' 
	  -- set @dc_tipo_documento='FA'
	  -- set @dn_numero_documento='100385'
	  -- SELECT tmp.dc_rut_cliente
   --                 ,tmp.dc_tipo_documento
   --                 ,tmp.dn_numero_documento
   --                 ,tmp.dc_rut_deudor
   --    FROM   #tmp_doc_por_cli tmp
   --    WHERE tmp.dn_numero_documento = @dn_numero_documento -----DUDA CON ESTE CAMPO IGUALADO A 0 --@dn_numero_documento
	  -- and  dc_rut_deudor = @dc_rut_deudor	  
	  -- and tmp.dc_tipo_documento = @dc_tipo_documento
	  -- and dn_numero_documento =@dn_numero_documento


	  -- -----------------
	   
   --    declare		@dn_reg_total             integer
   --                 ,@dn_reg                   integer
   --                 ,@dc_rut_cli        varchar(10)
   --                 ,@dc_tipo_doc       varchar(2)
   --                 ,@dn_numero_doc            integer
   --                 ,@dc_rut_deu        varchar(10)
   --                 ,@dg_str_num_prop   integer -- número propuesto

	  --  CREATE TABLE #tmp_numeros
   --                 (dg_str_numero      varchar(10))
   --    SET @dn_reg_total = 10
   --    SET    @dn_reg = 1
   --    WHILE @dn_reg < = @dn_reg_total
   --    BEGIN  
   --          INSERT INTO #tmp_numeros
   --                        (dg_str_numero)
   --          SELECT 100 * @dn_reg
   --          SET @dn_reg = @dn_reg + 1
   --    END
   --    -- Obtiene la cantidad de registros
   --    SELECT @dn_reg_total = COUNT(1)
   --    FROM  #tmp_doc_existentes




	  -- -----------------------


	    --declare		@dn_reg_total             integer
     --               ,@dn_reg                   integer
     --               ,@dc_rut_cli        varchar(10)
     --               ,@dc_tipo_doc       varchar(2)
     --               ,@dn_numero_doc            integer
     --               ,@dc_rut_deu        varchar(10)
     --               ,@dg_str_num_prop   integer -- número propuesto

					--SELECT @dc_rut_deu         = dc_rut_deu
     --                      ,@dc_tipo_doc = dc_tipo_doc
     --                      ,@dn_numero_doc     = dn_numero_doc
     --                      ,@dc_rut_cli = dc_rut_cli
     --        FROM   #tmp_doc_existentes

					--SELECT @dg_str_num_prop = min( convert(integer, dg_str_numero + convert(varchar, @dn_numero_doc) ) )
     --        FROM   #tmp_numeros
     --        WHERE  Not Exists(	Select 1 From   #tmp_doc_por_cli Where  dc_rut_deudor = @dc_rut_deu
					--			AND dc_tipo_documento = @dc_tipo_doc
     --                           AND    dn_numero_documento =  dg_str_numero + convert(varchar, @dn_numero_doc) )

					--			SELECT @dg_str_num_prop
					--			select @dc_rut_deu
					--			select @dc_tipo_doc

					--			select * from  #tmp_doc_existentes
					--			select * from  #tmp_doc_por_cli
								
								 
			--					SELECT '@dg_str_num_prop' = @dg_str_num_prop
   --          --SET @dn_reg = @dn_reg + 1 


	  -- ----select top 10 * from tb_documentos 
	  -- SELECT doc.dc_rut_cliente
   --                 ,doc.dc_rut_deudor
   --                 ,doc.dc_tipo_documento
   --                 ,doc.dn_numero_documento
   --    FROM   tb_documentos doc             
   --    WHERE  doc.dc_rut_contrata = '99580240-6'


	    ------SELECT *
	    ------FROM   tb_documentos doc             
     ------  WHERE  doc.dc_rut_contrata = '99580240-6'



	  -- dc_rut_cliente='10006618-1'
	  -- dc_tipo_documento'FA'
	  -- dc_rut
	  -- 99580240-6	10006618-1	FA	373	N	96633780-K	5	00	2008-06-19 00:00:00.000	2008-09-17 00:00:00.000	2008-09-17 00:00:00.000	01	1,00	5575150,00		NULL	cvargas	NULL	NULL	D05	2008-08-11 23:59:00.000	Documento Pagado	NULL	S	5575150,00	17263	255479	2008-06-20 03:33:52.090	2008-06-19 00:00:00.000	2008-09-17 00:00:00.000	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	N

	  --set @Strdc_rut_cliente = '11111111-1'
	  -- set @dc_rut_deudor='78339850-8' 
	  -- set @dc_tipo_documento='FA'
	  -- set @dn_numero_documento='10



----SELECT ROUTINE_NAME, ROUTINE_DEFINITION
----FROM INFORMATION_SCHEMA.ROUTINES 
----WHERE ROUTINE_DEFINITION LIKE '%direcciones%' 
----AND ROUTINE_TYPE='PROCEDURE'

	  

	  select dc_tipo_documento  from tb_tipo_documento where dm_vigente='S'; 
	  select dc_tipo_documento  from tb_tipo_documento where dm_vigente='S' 
	  --select * from  tb_tipo_documento


	 
