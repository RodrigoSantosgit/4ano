y=   [121.1024978 127.6797245 122.4419604 126.5174344 126.1261261 126.5719208 126.6149871 120.8781748 125.6774194];
y2 = [122.7526882 120.9802236 126.0439087 121.964822 126.0720412 120.7741935 127.5387263 121.0503659];
y3 =[127.2922944 121.0163652 127.116459 126.4718522 126.0291595 122.9875161 121.6680997];
y4 =[122.1554315 126.0832261 121.2692967 122.0171674 121.5081405 126.040326];
y5 =[121.6609589 126.0180026 120.2824134 126.0720412 125.0534416];
y6 =[126.4982877 125.0535332 126.0273973 120.3252033];
y7 =[125.748503 125.1820128 120.2910959];
y8 =[126.8669528 120.3339041];
y9 =[126.0813704
];
x = [0 1 2 3 4 5 6 7 8];
plot(x,y,x(1:8),y2,x(1:7),y3,x(1:6),y4,x(1:5),y5,x(1:4),y6,x(1:3),y7,x(1:2),y8,x(1:1),y9);
xlabel("Grid dim. X");
ylabel("Speedup");
ylim([110,140]);
set(gca,'XTick',x)
xticklabels({'1','2','4','8','16','32','64','128','256'});
title ("Speedup on block (64,2,2)");
text(6, 1 ,140,{"Max speedup: 127.6797245","grid (2,128,1)"});
lgd = legend({'1','2','4','8','16','32','64','128','256'},"Location","Northwest");
title(lgd,'Grid dim. Z');


