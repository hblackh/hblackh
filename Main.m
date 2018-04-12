ppmFiles = dir('*.png');
numFiles = length(ppmFiles);
mydata = cell(1,numFiles);
i=1;
count = 0;
for k = 1:numFiles
    mydata{k} = imread(ppmFiles(k).name);
    mydata{k} = imresize(mydata{k},[128, 128]);
end
for k = 1:numFiles
    %figure;
    %imshow(mydata{k});
k1=rgb2gray(mydata{k});
r1 = graycomatrix(k1);
%NORMALIZZTION OF THE CO-OCCURANCE MATRIX
 coOcMat1 = r1./sum(r1(:));
%NORMALIZZTION OF THE CO-OCCURANCE MATRIX
 coOcMat1 = r1./sum(r1(:));
 sizecoOcMat = size(coOcMat1);
 [col,row] = meshgrid(1:sizecoOcMat(1),1:sizecoOcMat(2));
 rowMean =  sum( row(:).*coOcMat1(:) );
 colMean = sum( col(:).*coOcMat1(:) );
 rowStd = sqrt( sum( (row(:)-rowMean).^2 .* coOcMat1(:) ) );
 colStd = sqrt( sum( (col(:)-colMean).^2 .* coOcMat1(:) ) );   
%ENERGY
energyArray=zeros(210,1);
count = count+1;
energy = sum( coOcMat1(:).^2 );
energyArray(count, :) = energy;
%HOMOGENEITY/INVERSE DIFFERENCE MOMENT
 homogeneity = sum( coOcMat1(:) ./ ( 1+ (row(:)-col(:)).^2 ) );
 homogeneityArray(count, :) = homogeneity;
%contrast
matrix = ( abs(row - col).^2 ) .* coOcMat1;
            contrast = sum( matrix(:) );
 contrastArray(count, :) = contrast;
 %CORRELATION
x2 = sum ((row(:) - rowMean) .*...
                (col(:) - colMean) .*  coOcMat1(:));
            denominator = rowStd * colStd;
corelation = x2/denominator;
correlationArray(count, :) = corelation;
fprintf('the features of %d are :Energy:%6.02f, Correlation:%6.02f,Homogeneity:%6.02f, Contrast: %6.02f\n', i, energy,corelation,homogeneity,contrast')
i=i+1;
end

en=energyArray';
ho=homogeneityArray';
co=correlationArray';
con=contrastArray';

%disp("The dataset is ");
K=10;
%j=flowerlabels.VarName2;
temp = [en(:) co(:) ho(:) con(:) ];
%temp = table(en(:),co(:),ho(:),con(:),j)

%classification for texture features
max_iterations = 9;
centroids = initCentroids(temp, K);
%l=new.phlox

for i=1:max_iterations
indices = getClosestCentroids(temp, centroids);
centroids = computeCentroids(temp, indices, K);
end
%I=zeros(210,1);
Indices={'Phlox','rose','calendula','iris','leucanthenum_maximum','bellflower','viola','rudbeckia','peony','aquilegia'};
for i=1:210
switch (Indices{indices(i,:)})
    case ('Phlox')
        disp('Phlox');
     case ('rose')
        disp("Phlox");
     case 'calendula'
        disp("calendula");
     case 'iris'
        disp("iris");
     case 'leucanthenum'
        disp("leucanthenum");
     case 'bellflower'
        disp("bellflower");
     case 'viola'
        disp("viola");
     case 'rudbeckia'
        disp("rudbeckia");
     case 'peony'
        disp("peony");
     case 'aquilegia'
        disp("aquilegia");
        
end
end

%[s,h] = silhouette(temp,indices);
%sz=140;
%scatter3(indices,temp(:,2),temp(:,3),'filled');
scatter3(indices,temp(:,4),temp(:,3),'r');

x=xlabel('labels');
y=ylabel('contrast');
z=zlabel('homogeneity');
%cp = classperf(species,c);


%get(cp)
