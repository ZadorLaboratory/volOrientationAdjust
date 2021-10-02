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
