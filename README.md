# volOrientationAdjust
Volume orientation adjustment

## Discription
    For **mannually** finding parameter to adjust the 3D-volume orientation/scale/position; also can compare with a reference image.
    The result of adjustment can be quickly visualized using ImageJ/FIJI.
    The adjustment is an affine transformation.

## Requirement
    1. ImageJ/FIJI
        link for FIJI: https://imagej.net/software/fiji/
    2. Miji: a Java package for running ImageJ and Fiji within Matlab
        link: http://bigwww.epfl.ch/sage/soft/mij/
    

## Contents
    1. Script: volOrientationAdjust.m
    2. Example images: test image (test.tif); reference image (ref.tif)
                Example images are from Allen brian atlas CCFv3, nissl images 
                Ref: Wang et al., 2020, https://doi.org/10.1016/j.cell.2020.04.007

## Example
Before and after adjustment
(adjustment maked by mannually finding roation, scaling and translocation)

![image](https://user-images.githubusercontent.com/60980561/135733557-0ef587fc-1c82-4bda-a91c-cf2a989a8995.png)


## Inputs to be entered

![image](https://user-images.githubusercontent.com/60980561/135733335-ec0cc76f-19cc-4908-a4b1-61fce5bbc1ba.png)


## An example of how to use the code
1. Measure rotation on z-axis. 

   For mouse brains, it may be easier to do rotation on z & y-axis before x-axis. z & y-rotation adjustment is to make the left and right hemisphere symetric. And rotation on x-axis depended on the reference atlas you are using (for example CCF vs stereotaxic coordinates).
   
   ![image](https://user-images.githubusercontent.com/60980561/135735729-78d7db61-89cc-4b04-be11-16b202ff9e9e.png)

(to measure rotation, the 'Angle Tool' in ImageJ/FIJI is very helpful)
   
   
   
2. Measure rotation on y-axis.

![image](https://user-images.githubusercontent.com/60980561/135735787-c3f2c14d-7cc6-4be0-ab5c-08faa3666fe5.png)

(to measure rotation on y-axis, the 'Orthogonal Views' (Image > Stacks > Orthogonal Views) is very helpful. But you may need to copy or save the image to a new window to use the angle tool to measure the angle.)



3.  Combine with the reference map, measure scaling.

    (If translation is adjusted before scaling, it may need to be adjust again.)

![image](https://user-images.githubusercontent.com/60980561/135735914-afe74f74-4a97-4060-a593-9384fb73ac13.png)



4. Measure translation.

![image](https://user-images.githubusercontent.com/60980561/135735975-7d6b17f6-6d99-4c7c-b0cc-57236df3c249.png)


Note:
As you can see this method for adjust/alignment is not very accurate, it needs time for fine tune. But I hope this code can give you a quick answer for the transformation. The transformation matrix is MATLAB variable tform (affine3d object). The matrix can be seen in tform.T; tform can be directly used for imwarp in MATLAB for downstream applications.
