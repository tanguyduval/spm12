function qc_write(qcdir,subject,img,overlay,contrast,command, z)
if iscell(qcdir),   qcdir   = qcdir{1}; end
if iscell(overlay), overlay = overlay{1}; end
if isnumeric(command), command = num2str(command); end
if isnumeric(contrast), contrast = num2str(contrast); end
if exist('z','var'), z(z==0) = []; if isempty(z), delete(z); Nslices=6; else, Nslices=length(z); end; end
if length(img)==1, div=min(Nslices,4);
elseif length(img)==2, div=min(Nslices,2);
else, div=1;
end

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


qcjson(end+1).moddate        = datestr(now,'yyyy-mm-dd');
if ~exist(fullfile(qcdir,subject),'dir')
    mkdir(fullfile(qcdir,subject))
end
if ishandle(overlay)
    print(overlay,fullfile(qcdir,subject,'overlay_img.png'),'-dpng','-r0')
    qcjson(end).overlay_img    = strrep(fullfile(subject,'overlay_img.png'),'\','/');
elseif exist(overlay,'file') && (strcmp(overlay(max(1,end-3):end),'.nii') || strcmp(overlay(max(1,end-6):end),'.nii.gz'))
    overlay_dat = load_untouch_nii(overlay);
    overlay_dat = overlay_dat.img;
    if ~exist('z','var')
        [~,~,z]=find3d(overlay_dat);
        [zmin, zmax] = range_outlier(z,.5);
        z = round(linspace(zmin,zmax,Nslices));
    end
    segpng = makeimagestack(overlay_dat(:,:,z),[],[],[Nslices/div div],0);
    segpng = repmat(segpng,[1 length(img)]);
    segpng = imresize(segpng, 1000/size(segpng,2),'nearest');
    segpngrgb = ind2rgb(uint8(segpng),jet(5));
    imwrite(segpngrgb,fullfile(qcdir,subject,'overlay_img.png'),'Alpha',double(segpng>0))
    qcjson(end).overlay_img    = strrep(fullfile(subject,'overlay_img.png'),'\','/');
elseif exist(overlay,'file')
    copyfile(overlay,fullfile(qcdir,subject,'overlay_img.png'))
    qcjson(end).overlay_img    = strrep(fullfile(subject,'overlay_img.png'),'\','/');
end
if ishandle(img)
    print(img,fullfile(qcdir,subject,'bkg_img.png'),'-dpng','-r0')
elseif exist(img{1},'file')  && (strcmp(img{1}(max(1,end-3):end),'.nii') || strcmp(img{1}(max(1,end-6):end),'.nii.gz'))
    for iim = 1:length(img)
        tmpimg = load_untouch_nii(img{iim});
        tmpimg = tmpimg.img;
        if ~exist('z','var'), z = round(linspace(1,size(tmpimg,3),min(6,size(tmpimg,3)))); end
        if iim == 1
            img2D = makeimagestack(tmpimg(:,:,z),-3,[],[Nslices/div div],0);
        else
            img2D = cat(2,makeimagestack(tmpimg(:,:,z),-3,[],[Nslices/div div],0),img2D);
        end
    end
    imwrite(imresize(img2D,1000/size(img2D,2)),fullfile(qcdir,subject,'bkg_img.png'))
else
    copyfile(img{1},fullfile(qcdir,subject,'bkg_img.png'))
end
qcjson(end).background_img = strrep(fullfile(subject,'bkg_img.png'),'\','/');
qcjson(end).contrast       = contrast;
qcjson(end).command        = command;
qcjson(end).subject        = subject;

% delete duplicated lines
[~,ia] = unique({qcjson.background_img},'last');
savejson([],qcjson(ia),jsonfname);

% Load json and add to html
qc_reload(qcdir)