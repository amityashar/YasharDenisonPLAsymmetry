function [h1,h12] = linePlot4pannels2(sigsall, mdall, mdata, edata)
% sigs: the sigma values of the signal and templated 
% md = model data
% mdatat = mean real data
% edata = err real data
%%

sigs1 = sigsall(1:4,:); % the sigma values over sessions
md1 = mdall(1:2,:);
%sigs2 = sigsall(9:end,:);
%md2 = mdall(3:end,:);

% some plots parameters
x = repmat([1:6 7.5],4,1);
axisColor=[0.1 0.1 0.1];
lWidth=[2];
cCar=[205 169 204]/255;
cObl=[0 132 163]/255
c0= [60 60 204]/255;
l0=':';
c1=[25 25 127]/255;
l1 = '-';
l1w = 4;
c2=[178, 223, 138]/255;
l2 = ':o';
c3 = [51, 160, 44]/255;
l3 = '-o';
c4 =[166, 206, 227]/255;
l4 = ':';
c2=[31 , 120, 180]/255;
l5 = ':';

ax1= [0.5 8 0 3.25]; % top panel axis
ymin = min(sigs1(:))-1;
ymax = max(sigs1(:))+1;
ax2= [0.5 8 ymin ymax]; % bottom panel axis
yhigh = min([0.5 (ymax-ymin)/100]); % limit to 0.5
yposA=0.65;
yposB = yposA-yhigh-0.01
font='Helvetica';
fontsize = 24;

%% set the canvas
f1=figure;
hold on;
set(f1,'Position',[680 558 1400 1333])
f.PaperSize = [25.5 11];

%% A cardianl
subplot('Position',[0.1 yposA 0.2 0.2]);

axis(ax1);
%fig 1 80 deg

hold on;
%draw training point
errBarPlot(x(1,:),mdata(1,:),edata(1,:),3,2,2,0,cCar)

hold on;
h2=plot(x(1,:),md1(1,:),l1,'Color',cCar,'LineWidth',l1w,'MarkerSize',12,'MarkerFaceColor',[1 1 1])
h1=plot(x(1,:),mdata(1,:),'d','Color',cCar,'LineWidth',l1w,'MarkerSize',12,'MarkerFaceColor',[1 1 1])

 

leg1=legend([h1 h2],'Data','Model');
leg1.Box='off';
leg1.Location='northwest';
h1(1).Parent.TickDir='out';

set(gca,'Box','Off','YTick',[0 0.5 1 1.5 2 2.5 3 3.5],'YTickLabel',{'0', '0.5','1','1.5','2','2.5','3','3.5'}...
    ,'XTick',[1 2 3 4 5 6 7.5 8.5],'FontName',font,'FontSize',fontsize,'XTickLabel',{'', '','','','','',''}...
    ,'FontName',font,'FontSize',fontsize,'LineWidth',lWidth,'XColor',axisColor,'YColor',axisColor);
ylabel('Sensitivity (d)','FontName',font,'FontSize',fontsize,'Color',axisColor);


%% B oblique
subplot('Position',[0.31 yposA 0.2 0.2]);

axis(ax1);
%fig 1 80 deg

hold on;
%draw training point
errBarPlot(x(1,:),mdata(2,:),edata(2,:),3,2,2,0,cObl)

hold on;
h3=plot(x(1,:),md1(2,:),l1,'Color',cObl,'LineWidth',l1w,'MarkerSize',12,'MarkerFaceColor',[1 1 1])
h4=plot(x(1,:),mdata(2,:),'d','Color',cObl,'LineWidth',l1w,'MarkerSize',12,'MarkerFaceColor',[1 1 1])

h3(1).Parent.TickDir='out';

set(gca,'Box','Off','YTick',[0 0.5 1 1.5 2 2.5 3 3.5],'YTickLabel',{'', '','','','','','',''}...
    ,'XTick',[1 2 3 4 5 6 7.5 8.5],'FontName','Helvetica Neue','FontSize',fontsize,'XTickLabel',{'', '','','','','',''}...
    ,'FontName',font,'FontSize',fontsize,'LineWidth',lWidth,'XColor',axisColor,'YColor',axisColor);
title('Fig 3 - Reliability-and-Learning (RL)','Position',[0 3.5])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% C oblique signal sigma
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot('Position',[0.1 yposB 0.2 yhigh]);

axis(ax2);
%fig 1 80 deg

hold on;
h5=plot(x(1,7),sigs1(1,7),l2,'Color',c3,'LineWidth',3,'MarkerSize',8,'MarkerFaceColor',[1 1 1])
h6=plot(x(2,7),sigs1(2,7),l3,'Color',c2,'LineWidth',3,'MarkerSize',8,'MarkerFaceColor',c2)

h7=plot(x(1,[1:6]),sigs1(1,[1:6]),l2,'Color',c2,'LineWidth',3,'MarkerSize',8,'MarkerFaceColor',[1 1 1])
h8=plot(x(2,[1:6]),sigs1(2,[1:6]),l3,'Color',c3,'LineWidth',3,'MarkerSize',8,'MarkerFaceColor',c3)


leg1=legend([h7 h8],'Target','Distractor');
leg1.Box='off';
leg1.FontName = font;
%l1.Orientation='H';
h7.Parent.TickDir='out';

set(gca,'Box','Off','YTick',[5 10 15 20],'YTickLabel',{}...
    ,'XTick',[1 2 3 4 5 6 7.5 8.5],'FontName','Helvetica Neue','FontSize',fontsize,'XTickLabel',{'1', '2','3','4','5','6','Test'}...
    ,'FontName',font,'LineWidth',lWidth,'XColor',axisColor,'YColor',axisColor);

xlabel('Training day','FontName',font,'FontSize',fontsize,'Color',axisColor);

%% D cardinal signal sigma
subplot('Position',[0.31 yposB 0.2 yhigh]);

axis(ax2);
%fig 1 80 deg

hold on;

h9=plot(x(1,7),sigs1(3,7),l2,'Color',c2,'LineWidth',3,'MarkerSize',8,'MarkerFaceColor',[1 1 1])
h10=plot(x(2,7),sigs1(4,7),l3,'Color',c3,'LineWidth',3,'MarkerSize',8,'MarkerFaceColor',c3)

h11=plot(x(1,[1:6]),sigs1(3,[1:6]),l2,'Color',c3,'LineWidth',3,'MarkerSize',8,'MarkerFaceColor',[1 1 1]);
h12=plot(x(2,[1:6]),sigs1(4,[1:6]),l3,'Color',c2,'LineWidth',3,'MarkerSize',8,'MarkerFaceColor',c2);

%l1.Orientation='H';
h11.Parent.TickDir='out';

h12.Parent.YAxisLocation='Right'
% set(gca,'Box','Off','YTick',[5 10 15],'YTickLabel',{'5','10','15'}...
%     ,'XTick',[1 2 3 4 5 6 7.5 8.5],'FontName','Helvetica Neue','FontSize',fontsize,'XTickLabel',{'1', '2','3','4','5','6','Test'}...
%     ,'FontSize',fontsize,'LineWidth',lWidth,'XColor',axisColor,'YColor',axisColor);
set(gca,'Box','Off','YTick',[5 10 15 20],'YTickLabel',{'5','10','15','20'}...
    ,'XTick',[1 2 3 4 5 6 7.5 8.5],'FontName',font,'FontSize',fontsize,'XTickLabel',{'1', '2','3','4','5','6','Test'}...
    ,'FontSize',fontsize,'LineWidth',lWidth,'XColor',axisColor,'YColor',axisColor);

ylabel({'Inverese'; 'reliability (deg)'},'FontName',font,'FontSize',fontsize,'Color',axisColor);
xlabel('Training day','FontSize',fontsize,'Color',axisColor);


end
