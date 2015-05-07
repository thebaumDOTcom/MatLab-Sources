function x = e10090150(R, b, m)

x = zeros(m,1);

x(m) = b(m) / R(m,m);

for k = (m-1):-1:1
    epSum = 0;
    for j = k+1:m
        epSum = epSum + R(k,j) * x(j);
    end
    x(k) = (b(k) - epSum) / R(k,k);
end