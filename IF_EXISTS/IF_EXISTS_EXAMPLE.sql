
if exists(
select dc_mail from tb_filtro_mail where dc_mail ='enviodte@servifactura.cl')
begin select dn_tipo from tb_filtro_mail where dc_mail='enviodte@servifactura.cl' 
end

if exists(select dc_mail from tb_filtro_mail where dc_mail = 'enviodte@servifactura.cl')
begin select dn_tipo from tb_filtro_mail where dc_mail ='enviodte@servifactura.cl'
end


