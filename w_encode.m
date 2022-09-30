function I = w_encode(cover, message, bitpos)  
message = double(message); 
message = round(message./256); 
message = uint8(message); 
Mc = size(cover, 1);  
Nc = size(cover, 2); 
I = cover; 
  
for i = 1 : Mc 
for j = 1 : Nc 
 I(i, j) = bitset(I(i, j), bitpos, message(i, j));
end 
end