function [Acc,classifier] = train(X,Y,parameters)
    if parameters==0
        fprintf('Choose CART+Bagging \n');
        [acc_k,classifier_k] = TrainK(X,Y,parameters);
        fprintf('acc_k:%.6f \n',acc_k);
        Acc = acc_k;
        classifier = classifier_k;
        return
    elseif parameters==1
        fprintf('Choose C4.5+Bagging \n');
        [acc_f,classifier_f] = TrainF(X,Y,parameters);
        fprintf('acc_f:%.6f \n',acc_f);
        Acc = acc_f;
        classifier = classifier_f;
        return
    else
        [acc_k,classifier_k] = TrainK(X,Y,parameters);
        [acc_f,classifier_f] = TrainF(X,Y,parameters);
        fprintf('acc_k:%.6f \nacc_f:%.6f \n',acc_k,acc_f);
        if  acc_k>acc_f
            fprintf('Use CART+Bagging \n');
            Acc = acc_k;
            classifier = classifier_k;
        elseif acc_k<=acc_f 
            fprintf('Use C4.5+Bagging \n');
            Acc = acc_f;
            classifier = classifier_f;
        end
    end
end