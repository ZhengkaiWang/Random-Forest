function [T,InBag] = BootstrapK(Z,m)
    InBag = zeros(m,1);
    for i = 1:m
        randi(size(Z,1));
        InBag(i,1) = randi(size(Z,1));        
        T(i,:) = Z(InBag(i,1),:);
    end
end