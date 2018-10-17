function spm_setorigin2center(file)
st.vol = spm_vol(file);
vs = st.vol{1}.mat\eye(4);
vs(1:3,4) = (st.vol{1}.dim+1)/2;
spm_get_space(st.vol{1}.fname,inv(vs));
