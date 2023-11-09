function E = buildEigen(pt)

org=mean(pt')';
pt_size = size(pt,1);
descriptor_dim = size(pt,2);
resz = repmat(org,1,descriptor_dim)
ptsub = pt - resz;

% covar matrix
C = (ptsub*ptsub') ./ pt_size
[U V]= eig(C);

% sort eigenvectors and eigenvalues by eigenvalue size (desc)
linV=V*ones(size(V,2),1);
S=[linV U'];
S=flipud(sortrows(S,1));
U=S(:,2:end)';
V=S(:,1);

E.org = org;
E.vct = U;
E.val = V;

end

