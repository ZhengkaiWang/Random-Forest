function [Acc,classifiers] = TrainF(X,Y,~)
%fprintf('TrainingF\n');
cv_n = 5;
indices = crossvalind('Kfold',size(X,1),cv_n); 
%For large data
if size(X,1) >= 2000    
    [Acc,classifiers] = TrainF_max(X,Y);
%For normal data
else
    for cv = 1:cv_n
        fprintf('Working on %i / %i ...\n', cv,cv_n);
        test_in = (indices == cv); train_in = ~test_in;
        data = X(train_in,:);
        groups = ismember(Y(train_in,:),1); 
        data_size = size(data,1);
        
        sample_num = fix(data_size*0.7);
        bag_num = 25;
    %Train
    for i = 1:1:bag_num
        NO = randperm(data_size);
        for j = 1:1:sample_num
            k = NO(j);
            train(j,:) = data(k,:);
            class(j) = groups(k);
        end
        classifier = make_tree(train',class',0);
        classifiers{i} = classifier;
    end

    %Test
    classes = [];
    for i = 1:1:bag_num
        classes(:,i) = use_tree(X(test_in,:)', 1:size(X(test_in,:)',2), classifiers{i});
    end
    %Calculate the acc
    test_class = ismember(Y(test_in,:),1);
    correct = 0;
    test_size = size(Y(test_in,:),1);
    for i = 1:1:test_size
        predict = mean(classes(i,:));
        if predict >= 0.5 && test_class(i)==1
            correct = correct + 1;
        end
        if predict <= 0.5 && test_class(i)==0
            correct = correct + 1;
        end
    end
    acc(cv) = correct/test_size;
    end
    Acc = mean(acc);
end
end