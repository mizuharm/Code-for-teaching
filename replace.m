%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Performs replacement row operation on a matrix
%
%  Input: A - matrix (array)
%         row1 - row number which will be scaled and added to another row
%         (integer)
%         scale - scaling factor for row1 (real number)
%         row2 - row number to be replaced (integer)
%         
%  Output: matrix A with row2 replaced by the sum of of itself
%          and scale*row1
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function out = replace(A, row1, scale, row2)
        A(row2,:) = A(row2,:) + scale*A(row1,:);        
        out = A;
end