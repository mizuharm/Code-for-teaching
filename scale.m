%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Performs scaling row operation on a matrix
%
%  Input: A - matrix (array)
%         row1 - first row number which will be swapped (integer)
%         factor - scaling factor (real number)
%         
%  Output: matrix A with all entries in row1 multiplied by factor
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function out = scale(A, row1, factor)
        A(row1,:) = factor*A(row1,:);
        out = A;
end