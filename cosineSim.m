function dst = cosineSim(c, q)
%COSINESIM Summary of this function goes here
%   Detailed explanation goes here
similarity = dot(c, q) / (norm(c) * norm(q));
dst = 1 - similarity; % Convert to distance
end

