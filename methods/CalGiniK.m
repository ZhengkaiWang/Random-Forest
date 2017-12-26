function [ i_feature_min,val_i_feature_min,val_i_feature_tshd_min,Gini_min ] = CalGiniK( Xset,Yset )


    [~, num_feature] = size(Xset);
    %%PT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sample_margin = 1;
    Gini_min = inf;
    val_i_feature_tshd_min = inf;
    i_feature_min = -1;
    
    %%PT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    size_RF = ceil(num_feature/5);
    %size_RF = ceil(log(num_feature)/log(2));

    %feature_set = 1:num_feature;
    
    rand_sort = randperm(num_feature);
    feature_set = rand_sort(1:size_RF);
    
    for i_feature = feature_set
        val_i_feature    = Xset(:,i_feature)';  % 样本在此维度下的投影取值  转置为行 易于处理
        val_i_feature_uq      = unique(val_i_feature);   
        num_val_i_feature_uq   = length(val_i_feature_uq);
      
        
        [val_i_feature_sort, ~] = sort(val_i_feature_uq);

        
        val_i_feature_tshd_index = 1:sample_margin:num_val_i_feature_uq; 
        
        val_i_feature_tshd_set = val_i_feature_sort(val_i_feature_tshd_index);
        
        for val_i_feature_tshd = val_i_feature_tshd_set
            left_part = Yset(find(val_i_feature <= val_i_feature_tshd));
            right_part = Yset(find(val_i_feature > val_i_feature_tshd));
            a1 = length(find(left_part == 1));
            a2 = length(find(left_part == -1));
            b1 = length(find(right_part == 1));
            b2 = length(find(right_part == -1));
            % avoid x/0
            if a1+a2 == 0
                pa = 0;
            else
                pa = 2*(a1*a2)/(a1+a2);
            end
            if b1+b2 == 0
                pb = 0;
            else
                pb = 2*(b1*b2)/(b1+b2);
            end
            Gini_this =( ( pa+pb )/(a1+a2+b1+b2) );
            if Gini_this < Gini_min
                Gini_min = Gini_this;
                val_i_feature_tshd_min = val_i_feature_tshd;
                i_feature_min = i_feature;
                val_i_feature_min = val_i_feature;
            end
        end  
    end 
