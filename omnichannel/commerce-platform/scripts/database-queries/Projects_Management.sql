select * from epub_project where workspace in
(select name from avm_devline where id in
(select workspace_id from avm_asset_lock))

select * from epub_ind_workflow
where process_id =
(select process_id from epub_process where project = 'prj143000');


select * from epub_project where status = 0order by creation_date desc



-- Removing locks of the project if any
select * from avm_asset_lock where workspace_id in
(select id from avm_devline where name in
--(select workspace from epub_project where project_id = 'prj149002'))
--(select workspace from epub_project where creation_date >= to_date('2019-09-17', 'YYYY-MM-DD')))
(SELECT project_id FROM EPUB_DEPLOY_PROJ))

-- delete history of the project
select * from EPUB_PR_HISTORY where project_id in
--(select project_id from epub_project where project_id = 'prj149002');
--(select project_id from epub_project where creation_date >= to_date('2019-09-17', 'YYYY-MM-DD'))
(SELECT project_id FROM EPUB_DEPLOY_PROJ)

-- delete user history of the projects
select * from EPUB_INT_PRJ_HIST where project_id in
--select * from EPUB_INT_PRJ_HIST where project_id not in
--(select project_id from epub_project)
(SELECT project_id FROM EPUB_DEPLOY_PROJ)

-- delete the project
select * from epub_project where project_id in
--select * from epub_project where creation_date >= to_date('2019-09-17', 'YYYY-MM-DD')
(SELECT project_id FROM EPUB_DEPLOY_PROJ)

-- delete history of the process
select * from EPUB_PROC_HISTORY where process_id in
--(select process_id from epub_process where project = 'prj149002');
--(select process_id from epub_process where creation_date >= to_date('2019-09-17', 'YYYY-MM-DD'));
(select process_id from epub_process where project in
(SELECT project_id FROM EPUB_DEPLOY_PROJ))

-- delete task information of process
select * from EPUB_PROC_TASKINFO where id in
--(select process_id from epub_process where project = 'prj149002');
--(select process_id from epub_process where creation_date >= to_date('2019-09-17', 'YYYY-MM-DD'));
(select process_id from epub_process where project in
(SELECT project_id FROM EPUB_DEPLOY_PROJ))

-- delete states of project (if any)
select * from EPUB_IND_WORKFLOW where process_id in
--(select process_id from epub_process where project = 'prj149002');
--(select process_id from epub_process where creation_date >= to_date('2019-09-17', 'YYYY-MM-DD'));
(select process_id from epub_process where project in
(SELECT project_id FROM EPUB_DEPLOY_PROJ))

-- finally delete the process
--select * from epub_process where project = 'prj149002';
--select * from epub_process where creation_date >= to_date('2019-09-17', 'YYYY-MM-DD');
select * from epub_process where project in
(SELECT project_id FROM EPUB_DEPLOY_PROJ)


--extra delete deployments
select * from EPUB_DEPLOYMENT
select * from EPUB_DEPLOY_PROJ


select  epub_target.display_name as Target,
        epub_prj_tg_snsht.snapshot_id as Snapshot,
        epub_project.display_name as Project,
        epub_project.checkin_date as Fecha
from    epub_target, epub_project, epub_prj_tg_snsht
where   epub_prj_tg_snsht.project_id in (
        select  project_id 
        from    epub_project 
        where   workspace is not null 
            and checked_in = 1
        ) 
    and epub_target.target_id = epub_prj_tg_snsht.target_id 
    and epub_prj_tg_snsht.project_id = epub_project.project_id
order by epub_project.checkin_date desc


