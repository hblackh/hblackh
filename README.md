This code is in matlab and i have used a dataset which has 210 images in it. these images have 10 categoris.listed.
To understand my code u can follow the steps given below:
1)read all the images from the directory(current)
2)resize them to 128X128
3)then converting rgb to gray matrix
4)then the above matrix into graycomatrix,(the abive 2 steps is done with built in functions)
5)as we know we can extract texture feature using haralick feature function i have referenced to only 4 features in this project those are 
i)energy ii)correlation iii)homogenity iv)contrast
6)all these formula have been mentioned and calculated.
7)then storing into array and classifying it using K means clustering.
Dataset i have refereced is in this link
https://www.kaggle.com/zhouhq/classification-of-flowers-a-multiclass-problem/data
