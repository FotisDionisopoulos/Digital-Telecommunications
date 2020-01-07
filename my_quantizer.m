function [ x_q ] = my_quantizer( x, N, min_value, max_value )

if (x > max_value)
        x = max_value;
elseif (x < min_value)
        x = min_value;
end

levels = 2^N;

D = ( max_value - min_value )/levels; 
x_q = D * floor((x/D) + 0.5);


%disp('Quantized!')

end %End of Function

