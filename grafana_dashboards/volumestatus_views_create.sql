create or replace view view_project_phase_stats as select *, case when position('_' in database)>0 then split_part(database,'_',1) else 'none'  end as project, case when position('_' in substring(database,position('_' in database)+1))>0 then split_part(substring(database,position('_' in database)+1),'_',1) else 'none'  end as phase from view_stats;

create or replace view db_project_phase_stats as select *, case when position('_' in database)>0 then split_part(database,'_',1) else 'none'  end as project, case when position('_' in substring(database,position('_' in database)+1))>0 then split_part(substring(database,position('_' in database)+1),'_',1) else 'none'  end as phase from db_stats;