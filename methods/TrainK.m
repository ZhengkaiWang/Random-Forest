function [Acc,CART_tree_set] = TrainK(X,Y,~)
   
    %Acc = 0.5;
    %CART_tree_set = 0;
    %return;

    if size(X,1)<1000 || size(X,2)<50
        indices = crossvalind('Kfold',Y,10);
        fprintf('Use 5-fold-cross-validation \n');
        Acc_cv = zeros(5,1);
        for i = 1:5
            test = (indices == i);
            train = ~test;
            fprintf('Training on %.0f /5 set... \n',i);
            CART_tree_set = PureTrainK(X(train,:),Y(train,:));
            Acc_cv(i) = TestK(X(test,:),Y(test,:),CART_tree_set);
            fprintf('Acc on %.0f set is %.6f \n',i,Acc_cv(i));
        end
        Acc = sum(Acc_cv)/5;
    else
        fprintf('Divide 3/2 train 3/1 test \n');
        [X_train,Y_train,X_test,Y_test] = Divide(X,Y,3);
        fprintf('Training... \n');
        CART_tree_set = PureTrainK(X_train,Y_train);
        [Acc] = TestK(X_test,Y_test,CART_tree_set);	      
    end
    CART_tree_set = PureTrainK(X,Y);
end