clear;
clc;
info = mha_read_header("1000085970.mha")
V = mha_read_volume(info);

for i = 1:95
    temp=V(:,:,i);
    if any(temp(:))
        X = (squeeze(V(:,:,i)))';
        %figure,imshow(X,[]);
        %figure,imshow((V(:,:,i)),[]);
        idx=int2str(i);
        info = dicominfo(strcat(idx,".dcm"));
        Y = dicomread(info);
        figure,imshow(Y,[]);
        C = Y;
        for j = 1:512*512
            if (X(j)==0)
                C(j)=0;
            end
        end
        
        figure,imshow(C,[min(Y(:)) max(Y(:))]);
    end
end
