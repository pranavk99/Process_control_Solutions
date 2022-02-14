[X1,X2] = meshgrid(-1.5:0.1875:1.5);
xs = arrayfun(@(x,y) {odeFun([],[x,y])}, X1, X2);
x1s = cellfun(@(x) x(1), xs);
x2s = cellfun(@(x) x(2), xs);
quiver(x1s, x2s, 'r')
xlabel('x_1')
ylabel('x_2')
axis tight equal;
function dxdt = odeFun(t,x)
    dxdt(1) = x(2);
    dxdt(2) = -x(1) + (1/3)*power(x(1), 3) - x(2);
end