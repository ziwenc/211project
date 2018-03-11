clc;
clear;
load("matlab_pcc.mat")
data1=data';
for i = 1:size(data1)
    A=cell2mat(data1{i})';
    A
    dlmwrite('pcc.csv',A,'delimiter',',','-append');
end