A = imread('Gimpy.png');

R = A(:,:,1); 
G = A(:,:,2); 
B = A(:,:,3);

%translate to integer
R = uint32(R); % float -> uint32
G = uint32(G);
B = uint32(B);

%shift bits and construct one Byte from 3 + 3 + 2 bits
G_shifted = bitshift(G, 8); % 8 << G (shift by 8 bits)
B_shifted = bitshift(B, 16); % 16 << B (shift by 16 bits)
 COLOR = R+G_shifted+B_shifted;   

fid = fopen('gimpy.hex', 'wt');
for i = 1:size(COLOR(:))-1 
    fprintf(fid, '%x\n', COLOR(i)); % COLOR (dec) -> print to file (hex)
end
disp('Text file write done');disp(' ');
fclose(fid);