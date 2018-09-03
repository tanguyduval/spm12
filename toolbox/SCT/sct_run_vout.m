function dep = sct_run_vout(job)
dep = cfg_dep;
dep(1).sname      = sprintf('output file');
dep(1).src_output = substruct('.','o');
dep(1).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});
