function [Acc]=TestF(X_test,Y_test,classifiers)
correct = 0;
test_size = size(X_test,1);
test_class = ismember(Y_test,1);
classifiers_size = size(classifiers,2);
for i = 1:1:classifiers_size  
    classes(:,i) = use_tree(X_test', 1:size(X_test',2), classifiers{i});
end
for i = 1:1:test_size
    predict = mean(classes(i,:));
    if predict >= 0.45 && test_class(i)==1
        correct = correct + 1;
    end
    if predict <= 0.55 && test_class(i)==0
        correct = correct + 1;
    end
end
Acc = correct/test_size;
end