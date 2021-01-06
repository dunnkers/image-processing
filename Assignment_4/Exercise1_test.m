L = 40;
assert(rem(L*3, 3) == 0);
assert(rem(L, 4) == 0);
A_a = zeros(L, L);
A_b = ones(L, L);
A = logical([A_a A_b A_a; A_b A_b A_b; A_a A_b A_a;]);

B1 = true(L-1, L/4-1);
B2_a = zeros(L/4-1, L/4-1);
B2_b = ones(L/4-1, L/4-1);
B2 = logical([B2_a B2_b B2_a; B2_b B2_b B2_b; B2_a B2_b B2_a;]);
B3 = true(L/2-1, L/2-1);

% Circle (B4)
% https://www.mathworks.com/matlabcentral/answers/495387-how-to-create-a-filled-circle-within-a-matrix
imageSizeX = L-1;
imageSizeY = L-1;
[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
centerX = imageSizeX / 2;
centerY = imageSizeY / 2;
radius = L/2;
B4 = (rowsInImage - centerY).^2 ...
    + (columnsInImage - centerX).^2 <= radius.^2;

% (a)
figure;
subplot(231);
colormap(gray(256));
imagesc(IPerode(A, B4));
axis equal;
axis tight;
title({'(a)', '(A \o B^4)'});

subplot(234);
colormap(gray(256));
imagesc(IPdilate(IPerode(A, B4), B2));
axis equal;
axis tight;
title({'(a)', '(A \o B^4) \oplus B^2'});

% (b)
subplot(232);
colormap(gray(256));
imagesc(IPerode(A, B1));
axis equal;
axis tight;
title({'(b)', '(A \o B^1)'});

subplot(235);
colormap(gray(256));
imagesc(IPdilate(IPerode(A, B1), B3));
axis equal;
axis tight;
title({'(b)', '(A \o B^1) \oplus B^3'});

% (c)
subplot(233);
colormap(gray(256));
imagesc(IPdilate(A, B1));
axis equal;
axis tight;
title({'(c)', '(A \oplus B^1)'});

subplot(236);
colormap(gray(256));
imagesc(IPdilate(IPdilate(A, B1), B3));
axis equal;
axis tight;
title({'(c)', '(A \oplus B^1) \oplus B^3'});