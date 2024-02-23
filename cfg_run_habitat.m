function cfg_run_habitat(job)

clustFile = job.clustFile{1};

cluster_res = readtable(clustFile);
id_cell = unique(cluster_res.ID);

for i_a = 1:numel(id_cell)
    id = id_cell{i_a};
    V = niftiread(id);
    V(V == 1) = 0;
    cluster_res_id = cluster_res(strcmp(cluster_res.ID, id),  1:end);
    for i_label = 1:size(cluster_res_id, 1)
        V(V == cluster_res_id.Label(i_label)) = cluster_res_id.Group(i_label);
    end
    
    niftiwrite(V, strrep(id, 'supervoxel', 'habitat'));
end
