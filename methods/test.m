function [acc]=test(X_test,Y_test,classifier)
    if size(classifier,1)==51
        acc = TestK(X_test,Y_test,classifier);
    else
        acc = TestF(X_test,Y_test,classifier);
    end

end