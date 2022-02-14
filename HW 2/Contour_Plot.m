x1 = -2:.25:2;
y = x1;
[X1,X2] = meshgrid(x1);
v = (0.75*(X1.^2)) - ((1/12)*(X1.^4)) + ((1/2)*(X1.*X2)) + ((1/2)*(X2.^2));
[M,c] = contour(X,Y,v,'ShowText','on')
colorbar
c.LineWidth = 2;

hold on
vm = -2:0.25:2;  % plotting range from -5 to 5
[p, q] = meshgrid(vm);  % get 2-D mesh for x and y
cond = v < (9/8);  % check conditions for these values
cond = double(cond);  % convert to double for plotting
cond(cond == 0) = NaN;  % set the 0s to NaN so they are not plotted
sur = surf(p,q,cond, 'FaceAlpha',0.3)
sur.EdgeColor = 'none';
view(0,90)    % change to top view

title('Level sets of lyapunov function')
xlabel('X1') 
ylabel('X2') 