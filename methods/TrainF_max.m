function [Acc,classifiers] = TrainF_max(X,Y)
data = X;
groups = ismember(Y,1); 
data_size = size(data,1);
bag_num = 25;
sample_num = fix(data_size*0.2);
for i = 1:1:bag_num
    fprintf('TrainF_max Working on %i / %i ...\n',i,bag_num);
    NO = randperm(data_size);
    for j = 1:1:sample_num
       k = NO(j);
       train(j,:) = data(k,:);
       class(j) = groups(k);
    end
    classifier = make_tree(train',class',0);
    classifiers{i} = classifier;
end

test_no = randperm(data_size);
test_size = data_size/10;
for j = 1:1:test_size
       k = test_no(j);
       test(j,:) = data(k,:);
       test_class(j) = groups(k);
end
correct = 0;
for i = 1:1:bag_num  
    classes(:,i) = use_tree(test', 1:size(test',2), classifiers{i});
end
for i = 1:1:test_size
    predict = mean(classes(i,:));
    if predict > 0.5 && test_class(i)==1
        correct = correct + 1;
    end
    if predict < 0.5 && test_class(i)==0
        correct = correct + 1;
    end
end
Acc = correct/test_size;
end