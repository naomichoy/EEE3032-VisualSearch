function dst = l1_norm(F1, F2)
%L1_NORM Summary of this function goes here
%   Detailed explanation goes here

% l1 dist
x=F1-F2;
x=abs(x);
dst=sum(x);

end

