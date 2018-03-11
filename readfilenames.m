clc;
clear;
num = xlsread('label.xlsx');
[~,txtData]  = xlsread('label.xlsx','A2:A162');

for i = 1:size(txtData)
    patient_name{i} = char(txtData(i));
end

Files=dir('/Users/shuangfeng/Documents/211/project_original');
count=1;

for k=1:length(Files)
   if startsWith(Files(k).name,patient_name(count))
       FileNames{count}=Files(k).name;%(1:10)
       Files(k).name
       if count<i
        count=count+1;
       end
   else
       continue
   end
end


for i=1:length(FileNames)
    i
%     cd;
    flag=0;
    patientdir=strcat('/Users/shuangfeng/Documents/211/project_original/',FileNames{i});
    phasenames=dir(patientdir);
 
    for j=1:length(phasenames)
        if endsWith(phasenames(j).name,'Nephrographic')
            phasename=phasenames(j).name;
            flag=1;
            break;
        end
    end
    if (flag == 0)
        continue;
    end
        phasefloder = strcat(patientdir,'/',phasename);
        cd(phasefloder);
        
        mhaf=dir('*.mha');
        
       mhafile=convertCharsToStrings(mhaf.name);
       data{i}=Featureextraction(mhafile);
    
%     info = mha_read_header(mhafile);
%     V = mha_read_volume(info);
%     figure,imshow((V(:,:,i)),[]);
    
    

end



