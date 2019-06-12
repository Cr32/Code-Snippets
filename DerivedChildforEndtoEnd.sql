   SELECT  
DerivedRecord.MDS_ID  childMDS,  
ParentMDS.MDS_ID  parentMDS, 
DerivedRecord.* ,  
ParentMDS.*  ,
APR.* , 
DerivedWorkInfo.*, 
ParentRecord.*
       FROM App_WorkRequest APR
       LEFT JOIN MDS ChildMDS ON APR.MDS_ID = ChildMDS.MDS_ID
       LEFT JOIN App_MyWork ParentRecord ON ParentRecord.raise_a_follow_on_action_link = APR.FulcrumID
       LEFT JOIN MDS ParentMDS ON ParentRecord.MDS_ID = ParentMDS.MDS_ID
       LEFT JOIN MDS DerivedRecord ON APR.Linked_MDS_ID = DerivedRecord.MDS_ID
       LEFT JOIN App_MyWork DerivedWorkInfo ON DerivedRecord.MDS_ID = DerivedWorkInfo.MDS_ID
       where ParentMDS.ActionID = 84595 