function [h1,h12] = linePlot2pannels2( mdall, mdata, edata)
% sigs: the sigma values of the signal and templated 
% md = model data
% mdatat = mean real data
% edata = err real data
%%

md1 = mdall(1:3,:);
md2 = mdall(4:6,:);
md1 = [md1;mdata(1,:); ];
md2 = [ md2;mdata(2,:)];

x = repmat([1:6 7.5],size(md1,1),1);
axisColor=[0.1 0.1 0.1];
ax1= [0.5 8 0 3.25]; % top panel axis
lWidth=[2];

%Lines
%line color
cCar=[204 169 44]/255;
cObl=[0 132 163]/255
c0= [60 60 204]/255;
c1=[25 25 127]/255;
c2=[178, 223, 138]/255;
c3 = [51, 160, 44]/255;
c4 =[166, 206, 227]/255;
c2=[31 , 120, 180]/255;
%line style
l_type = {':','--','-.','none'}
l_marker='+X*.';
l_markersize=[12 12 12 14];
%withd
l1w = 4;



%yhigh = min([0.5 (ymax-ymin)/100]); % limit to 0.5
yposA=0.65;
font='Helvetica';
fontsize = 24;

%% set the canvas
f1=figure;
hold on;
set(f1,'Position',[680 558 1400 1333])
f.PaperSize = [25.5 11];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% A cardianl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot('Position',[0.1 yposA 0.2 0.2]);

axis(ax1);
%fig 1 80 deg

hold on;
%draw training point

hold on;
h0=plot(x',md1','Color',cCar,'LineWidth',l1w,'MarkerSize',12,'MarkerFaceColor',[1 1 1])
%h1=plot(x(1,:),mdata(1,:),'d','Color',cCar,'LineWidth',l1w,'MarkerSize',12,'MarkerFaceColor',[1 1 1])

for i=1:size(md1,1)
    h0(i).LineStyle=l_type{i};
    h0(i).Marker = l_marker(i);
    h0(i).MarkerSize = l_markersize(i);
end
h0(4).Color=axisColor;
leg1=legend(h0,'R','L','RLG','Data')
leg1.Box='off';
leg1.Location = 'northwest'
%l1.Orientation='H';
h0(1).Parent.TickDir='out';
errBarPlot(x(1,:),mdata(1,:),edata(1,:),3,2,2,0,axisColor)

set(gca,'Box','Off','YTick',[0 0.5 1 1.5 2 2.5 3 3.5],'YTickLabel',{'0', '0.5','1','1.5','2','2.5','3','3.5'}...
    ,'XTick',[1 2 3 4 5 6 7.5 8.5],'FontName',font,'FontSize',fontsize,'XTickLabel',{'1', '2','3','4','5','6','Test'}...
    ,'FontName',font,'FontSize',fontsize,'LineWidth',lWidth,'XColor',axisColor,'YColor',axisColor);
ylabel('Sensitivity (d)','FontName',font,'FontSize',fontsize,'Color',axisColor);
% xlabel('Training day','FontName',font,'FontSize',fontsize,'Color',axisColor);
xlabel({'Training day','Session'},'FontName',font,'FontSize',fontsize,'Color',axisColor);

%% B oblique
subplot('Position',[0.31 yposA 0.2 0.2]);

axis(ax1);
%fig 1 80 deg

hold on;
%draw training point

hold on;

hold on;
h0=plot(x',md2','Color',cObl,'LineWidth',l1w,'MarkerSize',12,'MarkerFaceColor',[1 1 1])
%h1=plot(x(1,:),mdata(1,:),'d','Color',cCar,'LineWidth',l1w,'MarkerSize',12,'MarkerFaceColor',[1 1 1])

for i=1:size(md1,1)
    h0(i).LineStyle=l_type{i};
    h0(i).Marker = l_marker(i);
    h0(i).MarkerSize = l_markersize(i);
end

h0(4).Color=axisColor;
h0(1).Parent.TickDir='out';
errBarPlot(x(1,:),mdata(2,:),edata(2,:),3,2,2,0,axisColor)

set(gca,'Box','Off','YTick',[0 0.5 1 1.5 2 2.5 3 3.5],'YTickLabel',{'', '','','','','','',''}...
    ,'XTick',[1 2 3 4 5 6 7.5 8.5],'FontSize',fontsize,'XTickLabel',{'1', '2','3','4','5','6','Test'}...
    ,'FontName',font,'FontSize',fontsize,'LineWidth',lWidth,'XColor',axisColor,'YColor',axisColor);

xlabel('Training day','FontName',font,'FontSize',fontsize,'Color',axisColor);
title('Fig S1','Position',[0 3.5])
end
