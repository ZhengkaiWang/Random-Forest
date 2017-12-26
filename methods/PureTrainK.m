function [CART_tree_set] = PureTrainK(X,Y,~)

    %%PT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    bt_num = min(size(X,1),500);

    %%PT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    learner_num = 51;
    CART_tree_set = cell(learner_num,1);
    % learner_num times bootstrap, train them
    for i = 1:learner_num
        [T,~] = BootstrapK([X,Y],bt_num); 
        CART_tree = CreatTreeK(T(:,1:size(T,2)-1),T(:,size(T,2):size(T,2)));
        CART_tree_set{i,1} = CART_tree;
    end
