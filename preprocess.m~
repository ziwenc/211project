clear;
clc;
info = mha_read_header('1000085970.mha');
V = mha_read_volume(info);
[x,y,z]=size(V);
Imagearray=[];
Imagesize=[];
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
        Imagesize(k) 
        k=k+1;
        %Imagearray[:,:,1]=C
        
        %figure,imshow(C,[min(Y(:)) max(Y(:))]);
    end
end
s=nonzeros(Imagearray);
Imagemean=mean(s);
Imagemedian=median(s);
Imagestd2=std2(s);
Imagestd=std(s);


    
    