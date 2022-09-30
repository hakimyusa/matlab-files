function [P, Alphabet] = probs(X);

% Determine alphabet
Alphabet = unique(X);

Frequency = zeros(size(Alphabet));

% Calculate frequencies
for symbol = 1:length(Alphabet)
    Frequency(symbol) = sum(X == Alphabet(symbol));
end

% Estimate probabilities
P = Frequency / sum(Frequency);
