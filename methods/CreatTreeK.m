function tree = CreatTreeK( Xset,Yset )
    % threshold for end
    %%stablePT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tshd =1;
    
    [num_sample, ~] = size(Xset);
    lbl = unique(Yset); %(-1,1)
    tree.split_feature = 0;
    tree.split_value = inf;
    tree.child = 0;
    
    % µİ¹é½áÊøÌõ¼ş
    if ((num_sample <= tshd) || (length(lbl) == 1))
        tree.split_value  = [];    
        tree.child = sign(sum(Yset)+0.1); %trick when Y=+-1
        return    
    end   
   
    
    [ i_feature_min,val_i_feature_min,val_i_feature_tshd_min,Gini_min] = CalGiniK( Xset,Yset );
    
    if Gini_min <= 0.005
        tree.child = sign(sum(Yset)+0.1);
        return
    end
    
    tree.split_feature = i_feature_min;
    tree.split_value = val_i_feature_tshd_min;
    
    % one feature value means on-information || Ginimini means high purity
    if length(unique(val_i_feature_min)) == 1
        tree.child = sign(sum(Yset)+0.1); %trick when Y=+-1
        return
    end
    
    tree.left_child = CreatTreeK(Xset(find(val_i_feature_min <= val_i_feature_tshd_min),:),Yset(find(val_i_feature_min <= val_i_feature_tshd_min)));
    tree.right_child = CreatTreeK(Xset(find(val_i_feature_min > val_i_feature_tshd_min),:),Yset(find(val_i_feature_min > val_i_feature_tshd_min)));

        
end


