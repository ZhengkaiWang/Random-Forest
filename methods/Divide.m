function [ XTrain,YTrain,XTest,YTest ] = Divide( X,Y,n )
%DIVIDE Summary of this function goes here
%   Detailed explanation goes here
    Smp=size(X,1);
    RandSort=randperm(Smp);
    XTest=X(RandSort(1:ceil(Smp/n)),:);
    XTrain=X(RandSort(ceil(Smp/n)+1:Smp),:);
    YTest=Y(RandSort(1:ceil(Smp/n)),:);
    YTrain=Y(RandSort(ceil(Smp/n)+1:Smp),:);

end

