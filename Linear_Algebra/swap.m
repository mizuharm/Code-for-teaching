%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Performs interchange row operation on a matrix
%
%  Input: A - matrix (array)
%         row1 - first row number which will be swapped (integer)
%         row2 - second row number whicih will be swapped (integer)
%         
%  Output: matrix A with row1 and row2 swapped
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function out = swap(A, row1, row2)
        temp = A(row1,:);
        A(row1,:) = A(row2,:);
        A(row2,:) = temp;
        out = A;
end
