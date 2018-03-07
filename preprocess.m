clear;
clc;
info = mha_read_header('1000085970.mha');
V = mha_read_volume(info);
[x,y,z]=size(V);
Imagearray=[];
Imagesize=[];
BoxImage={};
A=[];
k=1;
for i = 1:z
    temp=V(:,:,i);
    if any(temp(:))
%         i
        X = (squeeze(V(:,:,i)))';
        
  
        %figure,imshow(X,[]);
        %figure,imshow((V(:,:,i)),[]);
        idx=int2str(i);
        info = dicominfo(strcat(idx,'.dcm'));
        Y = dicomread(info);
         %figure,imshow(Y,[0 4095]);
         min(min(Y))
         max(max(Y))
        C = Y;
        for j = 1:512*512
            if (X(j)==0)
                C(j)=0;
            end
        end
        Imagearray(:,:,k)=C;
        Imagesize(k)=nnz(C);
        %Imagesize(k) 
        
        %Delete all the nonzero rows and columns for furthuer analysis
        BB=C(any(C,2),:);  
        CC=BB(:,any(BB,1));
        BoxImage{k}=CC;
        %Imagearray[:,:,1]=C
        %APPLY GLCMS
        
        glcms = graycomatrix(CC, 'NumLevels',100,'GrayLimits',[0 4095]);
        Contrast(k) = getfield(graycoprops(glcms),'Contrast');
        Correlation(k) = getfield(graycoprops(glcms),'Correlation');
        Energy(k) = getfield(graycoprops(glcms),'Energy');
        Homogeneity(k) = getfield(graycoprops(glcms),'Homogeneity');
        
        %APPLY GLRL
        glrls = grayrlmatrix(CC, 'NumLevels',100,'GrayLimits', [0,4095]);
       AA(:,:,k) =grayrlprops(glrls)
%         LRE(k) = getfield(graycoprops(glcms),'Correlation');
%         Energy(k) = getfield(graycoprops(glcms),'Energy');
%         Homogeneity(k) = getfield(graycoprops(glcms),'Homogeneity');
        
        
        %figure,imshow(CC,[]);
        k=k+1;
        %figure,imshow(C,[min(Y(:)) max(Y(:))]);
    end
end
s=nonzeros(Imagearray);
%Histogram features
Imagemean=mean(s);
Imagemedian=median(s);
Imagestd2=std2(s);
Imagestd=std(s);
%GLCM features
Imagecontrast=mean(Contrast);
Imagecorrelation=mean(Correlation);
Imageenergy=mean(Energy);
Imagehomogeneity=mean(Homogeneity);



    
    