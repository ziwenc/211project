clc;
clear;
load("matlab_pcc.mat")
data1=data';
for i = 1:size(data1)
    A=cell2mat(data1{i});
    xlswrite("pcc.xlsx",A)
end