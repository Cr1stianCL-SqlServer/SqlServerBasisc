EXECUTE sp_lock


select  
    object_name(P.object_id) as TableName,    
    resource_type, resource_description,request_session_id
from
    sys.dm_tran_locks L
    join sys.partitions P on L.resource_associated_entity_id = p.hobt_id

