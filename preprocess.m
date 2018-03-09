clear;
clc;
info = mha_read_header("1000085970.mha");
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
        glrlstcs(:,:,k) =grayrlprops(glrls);
%         LRE(k) = getfield(graycoprops(glcms),'Correlation');
%         Energy(k) = getfield(graycoprops(glcms),'Energy');
%         Homogeneity(k) = getfield(graycoprops(glcms),'Homogeneity');
        
        %Gray-level gradient matrix
       [gradientmtx,dir] = imgradient(CC);
       
       grdtmean(k)=mean(gradientmtx(:));
       grdtvariance(k)=var(gradientmtx(:));
       grdtkurtosis(k)=kurtosis(gradientmtx(:));
       grdtskewness(k)=skewness(gradientmtx(:));
        
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
ImageContrast=mean(Contrast);
ImageCorrelation=mean(Correlation);
ImageEnergy=mean(Energy);
ImageHomogeneity=mean(Homogeneity);
        
%GLRL features
% 1. Short Run Emphasis (SRE)
    SRE = mean(mean(glrlstcs(:,1,:)));
    % 2. Long Run Emphasis (LRE)
    LRE = mean(mean(glrlstcs(:,2,:)));
    % 3. Gray-Level Nonuniformity (GLN)
    GLN = mean(mean(glrlstcs(:,3,:)));
    % 4. Run Length Nonuniformity (RLN)
    RLN = mean(mean(glrlstcs(:,4,:)));
    % 5. Run Percentage (RP)
    RP = mean(mean(glrlstcs(:,5,:)));
    % 6. Low Gray-Level Run Emphasis (LGRE)
    LGRE = mean(mean(glrlstcs(:,6,:)));
    % 7. High Gray-Level Run Emphasis (HGRE)
    HGRE = mean(mean(glrlstcs(:,7,:)));
    % 8. Short Run Low Gray-Level Emphasis (SRLGE)
    SGLGE =mean(mean(glrlstcs(:,8,:)));
    % 9. Short Run High Gray-Level Emphasis (SRHGE)
    SRHGE =mean(mean(glrlstcs(:,9,:)));
    % 10. Long Run Low Gray-Level Emphasis (LRLGE)
    LRLGE =mean(mean(glrlstcs(:,10,:)));
    % 11.Long Run High Gray-Level Emphasis (LRHGE
    LRHGE =mean(mean(glrlstcs(:,11,:)));
   

%grey level gradient features
Imagegrdtmean=mean(grdtmean);
Imagegrdtvar=mean(grdtvariance);
Imagegrdtkts=mean(grdtkurtosis);
Imagegrdtskw=mean(grdtskewness);

%output features
header = {'Mean';'Median';'std2';'std';'Contrast';'Correlation';'Energy';'Homogeneity';'SRE';'LRE';'GLN';'RLN';'RP';'LGRE';'HGRE';'SGLGE';'SRHGE';'LRLGE';'LRHGE';'grdtmean';'grdtvariance';'grdtkurtosis';'grdtskewness'};
data = {Imagemean;Imagemedian;Imagestd2;Imagestd;ImageContrast;ImageCorrelation;ImageEnergy;ImageHomogeneity;SRE;LRE;GLN;RLN;RP;LGRE;HGRE;SGLGE;SRHGE;LRLGE;LRHGE;Imagegrdtmean;Imagegrdtvar;Imagegrdtkts;Imagegrdtskw};
size(data)

 fid=fopen('MyFile.txt','w');
for i=1:size(header)
    fprintf(fid,'%s\t',header{i});
end
fprintf(fid,'\n');
for i=1:size(data)
    fprintf(fid,'%s\t',data{i});
end
%
fclose(fid);true
%     
    