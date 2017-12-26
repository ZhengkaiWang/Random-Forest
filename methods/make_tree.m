function tree = make_tree(X,Y,base)
[train_features, train_num] = size(X);
Y_uniqued = unique(Y);
tree.dim = 0;
tree.split_loc = inf;

%当训练样本或类别只剩一个时无需继续分枝 停止
if ((train_num == 1) || (length(Y_uniqued) == 1))
    H = hist(Y, length(Y_uniqued));
    [~, largest] 	= max(H);
    tree.Nf         = [];
    tree.split_loc  = [];
    tree.child	 	= Y_uniqued(largest);    
    return
end


%遍历类别的数目&计算现有的信息量 
for i = 1:1:length(Y_uniqued)
    Pnode(i) = length(find(Y == Y_uniqued(i))) / train_num;
end
%计算当前的信息熵
Inode = -sum(Pnode.*log(Pnode)/log(2));

delta_Ib    = zeros(1, train_features);
split_loc	= ones(1, train_features)*inf;

for i = 1:train_features
    data = X(i,:);
    data_uniqued = unique(data);
    data_uniqued_len = length(data_uniqued);
    
    if (data_uniqued_len==1)
        delta_Ib(i)=-2000;
        continue;
    end
     P	= zeros(length(Y_uniqued), 2);
     [sorted_data, indices] = sort(data);
     sorted_class = Y(indices);
     
     %以信息增益为标准
     I	= zeros(1, data_uniqued_len - 1);
     temp_split=zeros(1,data_uniqued_len - 1);
     for j = 1:data_uniqued_len-1
         temp=(data_uniqued(j)+data_uniqued(j+1))/2;
         temp_split(j)=temp;
         i1=find(sorted_data<temp);
         ii=length(i1);
         for k =1:length(Y_uniqued)
             P(k,1) = length(find(sorted_class(1:ii) == Y_uniqued(k)));
             P(k,2) = length(find(sorted_class(ii+1:end) == Y_uniqued(k)));
         end    
         Ps  = sum(P);
         P   = P./(eps+repmat(Ps,size(P,1),1));  
         Ps  = Ps/sum(Ps); 
         info = sum(-P.*log(eps+P));
         I(j) = (Inode - sum(info.*Ps));  
     end
        [delta_Ib(i), s] = max(I);
        split_loc(i) = temp_split(s);


% %以信息增益率为标准
%            I = zeros(1,data_uniqued_len);  
%            delta_Ib_inter    = zeros(1, data_uniqued_len);  
%            for j = 1:data_uniqued_len-1  
%                P(:, 1) = hist(sorted_class(find(sorted_data <= data_uniqued(j))) , Y_uniqued);  
%                P(:, 2) = hist(sorted_class(find(sorted_data > data_uniqued(j))) , Y_uniqued);  
%                Ps = sum(P)/train_num;    
%                P  = P/train_num;    
%                Pk = sum(P);      
%                P1 = repmat(Pk, length(Y_uniqued), 1);    
%                P1 = P1 + eps*(P1==0);    
%                info = sum(-P./P1.*log(eps+P./P1)/log(2));    
%                I(j) = Inode - sum(info.*Ps); 
%                delta_Ib_inter(j) =  I(j)/(-sum(Ps.*log(eps+Ps)/log(2)));   
%             end     
%             [~, s] = max(I);  
%             delta_Ib(i) = delta_Ib_inter(s); 
%             [~, s] = max(delta_Ib);
%             split_loc(i) = data_uniqued(s);
end
    
if delta_Ib==ones(1,train_features)*-2000
    H				= hist(Y, length(Y_uniqued));
    [~, largest] 	= max(H);
    tree.dim        =0;
    tree.Nf         = [];
    tree.split_loc  = [];
    tree.child	 	= Y_uniqued(largest);
    return
end

[~, dim]    = max(delta_Ib);
dims        = 1:train_features;
tree.dim    = dim;
Nf	= unique(X(dim,:));
data_uniqued_len = length(Nf);
tree.Nf = Nf;
tree.split_loc = split_loc(dim);

if (data_uniqued_len == 1)
    H = hist(Y, length(Y_uniqued));
    [~, largest] 	= max(H);
    tree.dim        =0;
    tree.Nf         = [];
    tree.split_loc  = [];
    tree.child	 	= Y_uniqued(largest);
    return
end

indices1 = find(X(dim,:) <= split_loc(dim));
indices2 = find(X(dim,:) > split_loc(dim));
if ~(isempty(indices1) || isempty(indices2))
    tree.child(1) = make_tree(X(dims, indices1), Y(indices1),base+1);
    tree.child(2) = make_tree(X(dims, indices2), Y(indices2),base+1);
else
    H = hist(Y, length(Y_uniqued));
    [~, largest] = max(H);
    tree.child = Y_uniqued(largest);
    tree.dim = 0;
end