function class = use_tree(X_test, index, tree)
class = zeros(1, size(X_test,2));
%µ½´ïÊ÷Ä©¶Ë
if (tree.dim == 0)
    class(index) = tree.child;
    return
end
%Î´µ½´ïÊ÷Ä©¶Ë
dim = tree.dim;
dims= 1:size(X_test,1);
in = index(find(X_test(dim, index) <= tree.split_loc));
class	= class + use_tree(X_test(dims, :), in, tree.child(1));
in = index(find(X_test(dim, index) >  tree.split_loc));
class = class + use_tree(X_test(dims, :), in, tree.child(2));