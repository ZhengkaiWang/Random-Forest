clc; clear; close all

addpath ./methods								%%%%%%%% TODO

%% Initialize
parameters = 2;

%% Load data
load ./data/problem4_train.mat;
load ./data/problem4_test.mat;

%% Train the classifier
train_begin = tic;
[Acc_train,classifer] = train(X,Y,0);			%%%%%%%%%%% Todo
train_time = toc(train_begin);

%% Evaluation
[Acc_test] = test(X_test,Y_test,classifer);				%%%%%%%%%%% Todo

fprintf('The training procedure takes %.6f s.\n',train_time);
fprintf('The accuracy is %.6f.\n',Acc_test);
