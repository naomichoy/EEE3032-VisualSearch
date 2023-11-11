function dst = mahalanobisDist(c,q,E)
%MAHALANOBISDIST Summary of this function goes here
% input: x=candidate
%   Detailed explanation goes here

% Euclidean dist
x=c-q;
x=x.^2;
x=x./E.val; 
x=sum(x);
dst=sqrt(x);

end

