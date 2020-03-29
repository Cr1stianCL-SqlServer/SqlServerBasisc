
alter procedure SPs_buscaLetra(
@dc_rut_cliente varchar(1000)
)as
BEGIN			
			SET NOCOUNT ON
			declare @dc_tipo_documento varchar(1000)
			set @dc_tipo_documento='LE'
			CREATE TABLE #tmp_le_por_cli
                    (dc_rut_deudor varchar(10) collate Modern_Spanish_CI_AS
                    ,dc_tipo_documento varchar(2) collate Modern_Spanish_CI_AS
                    ,dn_numero_documento integer)
			INSERT INTO #tmp_le_por_cli
                    (dc_rut_deudor
                    ,dc_tipo_documento
                    ,dn_numero_documento)
			SELECT	 doc.dc_rut_deudor
                    ,doc.dc_tipo_documento
                    ,doc.dn_numero_documento
			FROM   tb_documentos doc
			WHERE  doc.dc_rut_contrata = '99580240-6'
					AND doc.dc_rut_deudor = @dc_rut_cliente
					AND doc.dc_tipo_documento = @dc_tipo_documento 
			declare	 @dn_reg_incre		integer
                    ,@dn_reg			varchar(1000) 
					,@dn_reg_min		varchar(1000) 
					,@dn_reg_max		varchar(1000)
					,@dn_reg_max_num	integer                   				
			CREATE TABLE #tmp_num_letras(dg_str_numero varchar(100))
			--SET @dn_reg_bool = 0
			SET @dn_reg_incre = 1
			SET @dn_reg='1'
			SET @dn_reg_max=(select MAX(dn_numero_documento) from #tmp_le_por_cli)
			SET @dn_reg_max_num=(SELECT CONVERT(INT, @dn_reg_max))
			WHILE (@dn_reg_incre < @dn_reg_max_num)
			BEGIN  
				if not EXISTS(select dn_numero_documento from #tmp_le_por_cli where dn_numero_documento=@dn_reg)
				begin
					insert into #tmp_num_letras values(@dn_reg)
					set @dg_num_propuesto=@dn_reg
					set @dn_reg_bool=1
				end   				
				set  @dn_reg_incre=@dn_reg_incre+1   
				set  @dn_reg= CONVERT(varchar(1000), @dn_reg_incre)       
			END--end while
			select @dn_reg_min= (select top 1 dg_str_numero from #tmp_num_letras)				
			

			DROP TABLE #tmp_num_letras
			DROP TABLE #tmp_le_por_cli

			if (@dn_reg_min is null)
				begin
					select '@dn_reg_min' =''
				end
				if (@dn_reg_min is NOT null)
				begin					
					select '@dn_reg_min' = @dn_reg_min
				end


END
GO