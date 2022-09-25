q = linspace(0, 1);

H = -(q .* log2(q) + (1-q) .* log2(1 - q));

H(isnan(H)) = 0; % To avoid problems with log2(0)

figure(1); clf;

plot(q, H);
xlabel('Coin bias, q');
ylabel('Entropy (H), bits');
