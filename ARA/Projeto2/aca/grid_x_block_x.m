z=   [4.774130647
  8.692033294
  15.11217949
  30.76113275
  58.29698858
  113.0747701
  120.9063702
  119.7947841
  120.931226
  113.2554392
  119.5901639
];

x = [16 15 14 13 12 11 10 9 8 7 6];
y = [0 1 2 3 4 5 6 7 8 9 10];
#[X,Y]=meshgrid(x,y);
#surfc(X,Y,z);
plot3(x,y,z);

xlabel("Grid Size");
ylabel("Block Size");
zlabel("Speedup");
set(gca,'XTick',x)
xticklabels({'65536','32768','16384','8192','4096','2048','1024','512','256','128','64'});
set(gca,'YTick',y)
yticklabels({'1','2','4','8','16','32','64','128','256','512','1024'});

title ("Speedup on grid Y & Z = 1 & block Y & Z = 1");