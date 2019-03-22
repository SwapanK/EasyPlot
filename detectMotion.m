function []= detectMotion(varargin)
S.XLM = get(gca,'xlim');
S.YLM = get(gca,'ylim');
set(gca,'Units','normalized');
S.AXP = get(gca,'Position');
S.DFX = diff(S.XLM);
S.DFY = diff(S.YLM);

set(gcf,'Units','normalized');
F = get(gcf,'currentpoint') ; % The current point w.r.t the figure.
% Figure out of the current point is over the axes or not -> logicals.
tf1 = S.AXP(1) <= F(1) && F(1) <= S.AXP(1) + S.AXP(3);
tf2 = S.AXP(2) <= F(2) && F(2) <= S.AXP(2) + S.AXP(4);

if tf1 && tf2
    try
        % Calculate the current point w.r.t. the axes.
        Cx =  S.XLM(1) + (F(1)-S.AXP(1)).*(S.DFX/S.AXP(3));
        Cy =  S.YLM(1) + (F(2)-S.AXP(2)).*(S.DFY/S.AXP(4));
        aa=get(gca,'XTickLabels');kk=str2num(aa);
        txt=sprintf('X= %0.02f   Y= %0.02f',Cx-S.XLM(1)+kk(1,1),Cy);
        title(txt)
    catch
        txt='Motion Detector ON';
        title(txt)
    end
else
    txt='Motion Detector ON';
    title(txt)
    
end
end


