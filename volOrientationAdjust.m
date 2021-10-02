% Volume orientation adjustment
% ver 1 (10202021, by LY)
% MATLAB 2021a
%
% Requirement:
%   ImageJ/Fiji and Miji are require the visualization
%
% Note:
%   1. There is a choice to reload the image due to some images are pretty
%   big, and it took time to read it
%   2. Recommend to scale down the volume if the volume is too big, because
%   output to the volume need to output to ImageJ/FIJI

% Settings
% Information of transformation -------------------------------------------
% Rotation for xyz-axis (unit: degree)
xAngle = 2;
yAngle = -2;
zAngle = -5;

% Scaling for xyz-axis
xScale = 1.1;
yScale = 1;
zScale = 1;

% Translation for xyz-axis (unit: pixel)
xTranslation = 0;
yTranslation = 4;
zTranslation = 0;

% Information of image to be adjusted -------------------------------------
% Image directory
imageDirectory = 'H:\';

% Image name
imageName = 'test.tif';

% reload the image
% True: reload; False: dont reload;
reloadIm = false;

% (Optional) Information of reference image -------------------------------
% Reference directory, leave it empty: []
refDirectory = 'H:\';

% Reference name, leave it empty: []
refName = 'ref.tif';

% reload the reference image
% True: reload; False: dont reload;
reloadRef = false;

% Output size -------------------------------------------------------------
% (default) Same size as original input, leave it empty: []
sz = [];

%% Script
% Get transformation matrix -----------------------------------------------

% Transformaiton matrix for roation
rotTform = rotx(yAngle)*roty(yAngle)*rotz(zAngle);
rotTform(4,4) = 1;

% Transformation matrix for scaling & translation
stTform = eye(4);
stTform(1,1) = xScale;
stTform(2,2) = yScale;
stTform(3,3) = zScale;
stTform(4,1:3) = [xTranslation,yTranslation,zTranslation];

% Combine rotation and scaling-translation
tform = rotTform*stTform;
tform = affine3d(tform);

% Get image ---------------------------------------------------------------
if ~exist('im') || reloadIm
    cd(imageDirectory);
    im = getStack(imageName,[]);
end

% Get output image size
if isempty(sz)
    sz = size(im);
end
R = imref3d(sz);

% (Optional) Get reference image ------------------------------------------
if ~exist('ref') && ~isempty(refName) || reloadRef
    cd(refDirectory);
    ref = getStack(refName,[]);
end

% Transform image ---------------------------------------------------------
tfIm = imwarp(im,tform,'OutputView',R);

% Visualize in ImageJ -----------------------------------------------------
if ~exist('ref')
    % Visualize withotu reference
    MIJ.createImage(tfIm);
    
else % Visualize with reference image
    
    % Adjust reference size to the same same as transformed image
    tformRef = affine3d(eye(4));    
    ref2 = imwarp(ref,tformRef,'OutputView',R);
    
    % Output to imageJ
    MIJ.createImage(cat(3,tfIm,ref2));
    
    % Get Z number for hyperstack
    nZ = sz(3);
    str = strcat("order=xyzct channels=2 slices=",num2str(nZ),...
        " frames=1 display=Composite");
    % Do hyperstack in imageJ
    MIJ.run("Stack to Hyperstack...", str);
end

%% Function:    rotz/roty/rotx
% Discription:  Rotation matrix for rotations around z/y/x-axis
% Input:    ang, num, angle
function R = rotz(ang)
R = eye(3);
R(1,1) = cosd(ang); R(1,2) = sind(ang);
R(2,1) = -sind(ang); R(2,2) = cosd(ang);
end

function R = roty(ang)
R = eye(3);
R(1,1) = cosd(ang); R(1,3) = -sind(ang);
R(3,1) = sind(ang); R(3,3) = cosd(ang);
end

function R = rotx(ang)
R = eye(3);
R(2,2) = cosd(ang); R(2,3) = sind(ang);
R(3,2) = -sind(ang); R(3,3) = cosd(ang);
end

%% Function:    getStack
% Discription:  Get stacks of an image
function stack = getStack(fileName,stackNumber)
% Input:        fileName, string
%               chNum, num/mat, specific stack number
% Output:       stack, M*N*O matrix

% This will have error for large tif file
if isempty(stackNumber)
    info = imfinfo(fileName);
    stackNumber = 1:size(info,1);
end

for iStack = 1:length(stackNumber)
    stack(:,:,iStack)=imread(fileName,stackNumber(iStack));
end
end
