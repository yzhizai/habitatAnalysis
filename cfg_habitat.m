function exbr2 = cfg_habitat

clustFile = cfg_files;
clustFile.name = 'Choose clustering file';
clustFile.tag = 'clustFile';
clustFile.num = [0 1];
clustFile.help = {'Choose clustering file', 'All supervoxels belongs should be given. ', ...
    'The table should contained at least 3 columns, ID, Label, Group'};


exbr2 = cfg_exbranch;
exbr2.name = 'Habitat identification';
exbr2.tag = 'cfg_supervoxels';
exbr2.val = {clustFile};
exbr2.prog = @cfg_run_habitat;
exbr2.help = {'Identify the habitat'};