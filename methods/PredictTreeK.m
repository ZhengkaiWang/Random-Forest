function Y_i_predict = PredictTreeK(tree, X_i)

    if tree.child ~= 0
        Y_i_predict = tree.child;
        return
    end

    if X_i(tree.split_feature) <= tree.split_value
        Y_i_predict = PredictTreeK(tree.left_child,X_i);
    else
        Y_i_predict = PredictTreeK(tree.right_child,X_i);
    end


end

