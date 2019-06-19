
create proc _GET_#TEMPtabellar
as

select 
 left(name, charindex('__',name)-1) 
 from 
 tempdb..sysobjects
 where 
 charindex('__',name) > 0and
 xtype='u'and
 not object_id('tempdb..'+name) is null