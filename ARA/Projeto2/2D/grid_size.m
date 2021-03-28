y=   [4.774130647
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

x = [6 7 8 9 10 11 12 13 14 15 16];

plot(x,y);

xlabel("Grid Size");
ylabel("Speedup");
set(gca,'XTick',x)
xticklabels({'64','128','256','512','1024','2048','4096','8192','16384','32768','65536'});

title ("Speedup on grid Y & Z = 0 & block Y & Z = 0");
