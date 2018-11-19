function qc_write(qcdir,subject,img,overlay,contrast,command)
if iscell(qcdir),   qcdir   = qcdir{1}; end
if iscell(img),     img     = img{1}; end
if iscell(overlay), overlay = overlay{1}; end
if isnumeric(command), command = num2str(command); end
if isnumeric(contrast), contrast = num2str(contrast); end
Nslices  = 6;

if ~exist(qcdir,'dir'), mkdir(qcdir); end
jsonfname = fullfile(qcdir, 'qc_results.json');
if exist(jsonfname,'file')
    qcjson = loadjson(jsonfname);    
    while iscell(qcjson)
        qcjson = cat(1,qcjson{:});
    end
else
    qcjson = [];
end


qcjson(end+1).moddate        = date;
if ~exist(fullfile(qcdir,subject),'dir')
    mkdir(fullfile(qcdir,subject))
end
if ishandle(overlay)
    print(overlay,fullfile(qcdir,subject,'overlay_img.png'),'-dpng','-r0')
    qcjson(end).overlay_img    = strrep(fullfile(subject,'overlay_img.png'),'\','/');
elseif exist(overlay,'file') && (strcmp(overlay(max(1,end-3):end),'.nii') || strcmp(overlay(max(1,end-6):end),'.nii.gz'))
    overlay_dat = load_untouch_nii(overlay);
    overlay_dat = overlay_dat.img;
    [~,~,z]=find3d(overlay_dat);
    [zmin, zmax] = range_outlier(z,.5);
    z = round(linspace(zmin,zmax,Nslices));
    segpng = makeimagestack(overlay_dat(:,:,z),[],[],[Nslices/2 2],0);
    segpngrgb = ind2rgb(uint8(segpng),jet(5));
    imwrite(segpngrgb,jet(5),fullfile(qcdir,subject,'overlay_img.png'),'Alpha',double(segpng>0))
    qcjson(end).overlay_img    = strrep(fullfile(subject,'overlay_img.png'),'\','/');
elseif exist(overlay,'file')
    copyfile(overlay,fullfile(qcdir,subject,'overlay_img.png'))
    qcjson(end).overlay_img    = strrep(fullfile(subject,'overlay_img.png'),'\','/');
end
if ishandle(img)
    print(img,fullfile(qcdir,subject,'bkg_img.png'),'-dpng','-r0')
elseif exist(img,'file')  && (strcmp(img(max(1,end-3):end),'.nii') || strcmp(img(max(1,end-6):end),'.nii.gz'))
    img = load_untouch_nii(img);
    img = img.img;
    if ~exist('z','var'), z = round(linspace(1,size(img,3),min(6,size(img,3)))); end
    img2D = makeimagestack(img(:,:,z),-3,[],[Nslices/2 2],0);
    imwrite(img2D,fullfile(qcdir,subject,'bkg_img.png'))
else
    copyfile(img,fullfile(qcdir,subject,'bkg_img.png'))
end
qcjson(end).background_img = strrep(fullfile(subject,'bkg_img.png'),'\','/');
qcjson(end).contrast       = contrast;
qcjson(end).command        = command;
qcjson(end).subject        = subject;

% delete duplicated lines
[~,ia] = unique({qcjson.background_img},'last');
savejson([],qcjson(ia),jsonfname);

% read json
fid = fopen(jsonfname,'r');
txt = '';
while ~feof(fid)
    txt = [txt fgetl(fid)];
end
fclose(fid);
txt = regexp(txt,'{.+}','match');
txt = txt{1};

% append to html replace
fid = fopen(fullfile(fileparts(mfilename('fullpath')),'htmltemplate','index.html'),'r');
f = fread(fid,'*char')';
fclose(fid);

if strcmp(txt(1),'['), txt(1)=[]; txt(end)=[]; end
f = regexprep(f,'var sct_data =.*;</script>',['var sct_data = [' txt '];</script>']);
fid = fopen(fullfile(qcdir,'index.html'),'w');
fprintf(fid,'%s',f);
fclose(fid);

copyfile(fullfile(fileparts(mfilename('fullpath')),'htmltemplate','_assets'),fullfile(qcdir,'_assets'))

