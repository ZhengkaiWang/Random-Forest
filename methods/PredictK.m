function Y_predict = PredictK( tree,X_test )

    Y_predict = zeros(size(X_test,1),1);
    for i = 1:size(X_test,1)
        Y_predict(i) = PredictTreeK(tree,X_test(i,:));
    end

end

