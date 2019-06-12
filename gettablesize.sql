/***************************************
**  Script to list Table sizes        **
**  courtesy of sqlservercentral.com  **
**      Don't forget to change        **
**       the database name            **
**                                    **
***************************************/

use OnCall2
set nocount on
go

declare 
    @TableName varchar(128),
    @RID int,
    @MaxRID int

declare @loopSrc table
(
    RID int identity(1,1) primary key clustered,
    TableName varchar(128)
)

if object_id('tempdb.dbo.#Tabs') is not null drop table #Tabs
create table #Tabs
(
    TableName varchar(128),
    nRows int,
    nReserved as cast(replace(sReserved, ' KB', '') as int),
    nData as cast(replace(sData, ' KB', '') as int),
    nIndexSize as cast(replace(sIndexSize, ' KB', '') as int),
    nUnused as cast(replace(sUnused, ' KB', '') as int),
    sReserved varchar(30),
    sData varchar(30),
    sIndexSize varchar(30),
    sUnused varchar(30)

)
/*****************************
*** INSERT LOOP ITEMS HERE ***
*****************************/
insert into @loopSrc
(
    TableName
)
select name
from sys.tables

select 
    @RID = 1,
    @MaxRID = @@rowcount
/**********************
*** LOOP STRUCTURE  ***
**********************/
while @RID <= @MaxRID
    begin

        select @TableName = TableName
        from @loopSrc
        where RID = @RID

        begin try
            insert into #Tabs
            exec sp_spaceused @tableName
        end try 
        begin catch
        end catch

        select @RID += 1
    
    end


select *
from #Tabs
order by nRows desc
