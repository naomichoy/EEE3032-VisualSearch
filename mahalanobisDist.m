function dst = mahalanobisDist(x,E)
%MAHALANOBISDIST Summary of this function goes here
% input: x=candidate
%   Detailed explanation goes here

xsub = x-E.org;
V = diag(E.val);
U = E.vct;
mdist_squared = xsub' * U * inv(V) * U' * xsub;

dst = sqrt(mdist_squared)


end

