function [acc]=TestK(X_test,Y_test,CART_tree_set)
    learner_num = 51;
    pre_bagging = zeros(size(Y_test,1),learner_num+2);
    
        % predict on test set
    for j = 1:learner_num
        pre_bagging(:,j) = PredictK(CART_tree_set{j,1},X_test);
    end

 
    % vote
    for k = 1:size(pre_bagging,1)
        pre_bagging(k,learner_num+1) = sum(pre_bagging(k,:));
        if pre_bagging(k,learner_num+1) > 0
            pre_bagging(k,learner_num+2) = 1;
        else
            pre_bagging(k,learner_num+2) = -1;
       end
    end
    Y_pre = pre_bagging(:,learner_num+2);

    err = size(find(Y_test - Y_pre~=0),1);
    acc = (size(Y_test,1)-err)/size(Y_test,1);

end