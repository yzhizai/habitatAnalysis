function cfg = habitat_cfg_master

spvox                  = cfg_repeat; % A repeat collects a variable number of items from its .values field in its .val field
spvox.name         = 'Supvervoxels';
spvox.tag            = 'spvox';
spvox.values        = {cfg_supervoxels}; % Reference the config files for both spvox modules
spvox.forcestruct = true; % There is a speciality in cfg_repeat harvest behaviour that makes a difference depending on the number of elements in values. forcestruct == true forces the repeat to behave as if there are more than one distinct values, even if there is only one.
spvox.help           = {'The module used to supervoxels segmentation'};

%%
habit                  = cfg_repeat; % A repeat collects a variable number of items from its .values field in its .val field
habit.name         = 'Habitat';
habit.tag            = 'habit';
habit.values        = {cfg_habitat}; % Reference the config files for both spvox modules
habit.forcestruct = true; % There is a speciality in cfg_repeat harvest behaviour that makes a difference depending on the number of elements in values. forcestruct == true forces the repeat to behave as if there are more than one distinct values, even if there is only one.
habit.help           = {'The module used to identify the habitat'};

%% Collect above Collections and the Div Module
cfg        = cfg_repeat;
cfg.name   = 'habitat analysis';
cfg.tag    = 'cfg_habitat';
cfg.values = {spvox, habit}; % Values in a cfg_repeat can be any cfg_item objects
cfg.forcestruct = true;
cfg.help   = {'The module to do habitat analysis'};