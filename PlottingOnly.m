function varargout = PlottingOnly(varargin)

% USE: Plot Time series with easy GUI based customization
% How to: Intuitive 
% What happens: GUI based Plotting and saving figures
% Who did: Swapan Masanta - 12-Mar-2019 16:29:39



%PLOTTINGONLY M-file for PlottingOnly.fig
%      PLOTTINGONLY, by itself, creates a new PLOTTINGONLY or raises the existing
%      singleton*.
%
%      H = PLOTTINGONLY returns the handle to a new PLOTTINGONLY or the handle to
%      the existing singleton*.
%
%      PLOTTINGONLY('Property','Value',...) creates a new PLOTTINGONLY using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to PlottingOnly_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PLOTTINGONLY('CALLBACK') and PLOTTINGONLY('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PLOTTINGONLY.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PlottingOnly

% Last Modified by GUIDE v2.5 14-Mar-2019 19:33:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @PlottingOnly_OpeningFcn, ...
    'gui_OutputFcn',  @PlottingOnly_OutputFcn, ...
    'gui_LayoutFcn',  [], ...
    'gui_Callback',   []);

if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% h = actxserver('WScript.Shell');
% h.SendKeys('% "" {DOWN} {DOWN} {DOWN} {DOWN}{ENTER}');
% End initialization code - DO NOT EDIT


% --- Executes just before PlottingOnly is made visible.
function PlottingOnly_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for PlottingOnly
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PlottingOnly wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PlottingOnly_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function XlabelS_Callback(hObject, eventdata, handles)
% hObject    handle to XlabelS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XlabelS as text
%        str2double(get(hObject,'String')) returns contents of XlabelS as a double

try
    valueXlabel = get(handles.XlabelS, 'String');
    valueYlabel = get(handles.YlabelS, 'String');
    h=get(gca,'YLabel');
    set(h,'String',valueYlabel);
    h2=get(gca,'XLabel');
    set(h2,'String',valueXlabel);
catch
end





% --- Executes during object creation, after setting all properties.
function XlabelS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XlabelS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GridOn.
function GridOn_Callback(hObject, eventdata, handles)
% hObject    handle to GridOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GridOn
try
    value = get(handles.GridOn, 'Value');
    if value==1
        grid on
    else
        grid off
    end
catch
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    push = handles.pushbutton1;
    col = get(push,'BackgroundColor');  % Get the background color of the figure.
    name=get(push,'String');
    set(push,'String','Running...','BackgroundColor',[1 .6 .6]) % Change color of button.
    
    [FileName,PathName] = uigetfile('*.xlsx','Select Annual Maxima Excel Data file');
    X=xlsread([PathName,FileName]);
    x=X(:,2);y=1:length(x);
    handles.myData=X;
    %%
    H=plot(handles.Plotting,y,x,'Color','k','LineStyle','-','LineWidth',1);
    Y=X(:,1);
    aa=get(gca,'XTick');
    set(gca,'XTickLabels',aa+Y(1)-aa(1));
    
    %%
    valueXlabel = get(handles.XlabelS, 'String');
    valueYlabel = get(handles.YlabelS, 'String');
    
    xlabel(valueXlabel)
    ylabel(valueYlabel)
    
    %%
    value = get(handles.GridOn, 'Value');
    if value==1
        grid on
    end
    %%
    value = get(handles.MinorGrid, 'Value');
    if value==1
        grid minor
    end
    %%
    handles.H=H;
    tickl=get(gca,'ticklength');handles.tickl=tickl;
    hAx=gca;handles.hAx=hAx;guidata(hObject,handles);
    
    %%
    edit9 = str2num(get(handles.edit9, 'String'));
    hAx=gca;
    L=get(hAx,'XLim');
    set(handles.edit9,'string',L(1));
    edit11 = str2num(get(handles.edit11, 'String'));
    set(handles.edit11,'string',L(2));
    edit12 = str2num(get(handles.edit12, 'String'));
    L=get(hAx,'YLim');
    set(handles.edit12,'string',L(1));
    edit13 = str2num(get(handles.edit13, 'String'));
    set(handles.edit13,'string',L(2));
    
    list = {'*','o','+','.','x','s','d',...
        '^','v','>','<','p','h'};
    set(handles.ScatterListBox,'string',list);
    
    list2 = {'-','--',':','-.'};
    set(handles.LineStyleListbox,'string',list2);
    
catch
    set(push,'String',name,'BackgroundColor',col)  % Now reset the button features.
end
set(push,'String',name,'BackgroundColor',col)  % Now reset the button features.



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% do something with myData
try
    push = handles.pushbutton3;
    col = get(push,'BackgroundColor');  % Get the background color of the figure.
    name=get(push,'String');
    set(push,'String','Running...','BackgroundColor',[1 .6 .6]) % Change color of button.
    
    
    if isfield(handles,'myData')
        % do something with myData
        value = get(handles.GridOn, 'Value');
        if value==1
            grid on
        else
            grid off
        end
        %%
        value = get(handles.MinorGrid, 'Value');
        if value==1
            grid minor
        else
            hAx=handles.hAx;
            set(hAx,'xminorgrid','off','yminorgrid','off')
        end
        %%
        valueXlabel = get(handles.XlabelS, 'String');
        valueYlabel = get(handles.YlabelS, 'String');
        h=get(gca,'YLabel');
        set(h,'String',valueYlabel);
        h2=get(gca,'XLabel');
        set(h2,'String',valueXlabel);
        X=handles.myData;
        Y=X(:,1);
        aa=get(gca,'XTick');
        set(gca,'XTickLabels',aa+Y(1)-aa(1),'fontsize',12);
        
        hAx=handles.H;
        coloring=uisetcolor([0 0 0],'Time Series Colour');
        set(hAx,'Color',coloring)
        
        hAx=gca;
        set(hAx,'Color','w')
        
        %%
    else
        pushbutton1_Callback(hObject, eventdata, handles)
    end
    
catch
    set(push,'String',name,'BackgroundColor',col)  % Now reset the button features.
end
set(push,'String',name,'BackgroundColor',col)  % Now reset the button features.


% --- Executes on button press in MinorGrid.
function MinorGrid_Callback(hObject, eventdata, handles)
% hObject    handle to MinorGrid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MinorGrid
try
    value = get(handles.MinorGrid, 'Value');
    if value==1
        grid minor
    else
        hAx=handles.hAx;
        set(hAx,'xminorgrid','off','yminorgrid','off')
    end
catch
end

% --- Executes on slider movement.
function redSlider_Callback(hObject, eventdata, handles)
% hObject    handle to redSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
try
    select=get(handles.ChoosePlotScatter,'SelectedObject');
    
    reD=get(handles.redSlider, 'Value');
    gREEN=get(handles.greenSlider, 'Value');
    bLUE=get(handles.blueSlider, 'Value');
    colour_teal=[reD gREEN bLUE];
    
    
    if strcmp(select.String,'Plot')
        hAx=handles.H;
        set(hAx,'Color',colour_teal)
    elseif strcmp(select.String,'Back')
        hAx=gca;
        set(hAx,'Color',colour_teal)
    elseif strcmp(select.String,'Scatter')
        if isfield(handles,'HS')
            HS=handles.HS;
            set(HS,'MarkerEdgeColor',colour_teal)
            set(HS,'MarkerFaceColor',colour_teal)
        end
    elseif strcmp(select.String,'Trend')
        if isfield(handles,'hT')
            hT=handles.hT;
            set(hT,'Color',colour_teal)
            set(hT,'Color',colour_teal)
        end
    end
catch
end


% --- Executes during object creation, after setting all properties.
function redSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to redSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function greenSlider_Callback(hObject, eventdata, handles)
% hObject    handle to greenSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
try
    select=get(handles.ChoosePlotScatter,'SelectedObject');
    
    reD=get(handles.redSlider, 'Value');
    gREEN=get(handles.greenSlider, 'Value');
    bLUE=get(handles.blueSlider, 'Value');
    colour_teal=[reD gREEN bLUE];
    
    
    if strcmp(select.String,'Plot')
        hAx=handles.H;
        set(hAx,'Color',colour_teal)
    elseif strcmp(select.String,'Back')
        hAx=gca;
        set(hAx,'Color',colour_teal)
    elseif strcmp(select.String,'Scatter')
        if isfield(handles,'HS')
            HS=handles.HS;
            set(HS,'MarkerEdgeColor',colour_teal)
            set(HS,'MarkerFaceColor',colour_teal)
        end
    elseif strcmp(select.String,'Trend')
        if isfield(handles,'hT')
            hT=handles.hT;
            set(hT,'Color',colour_teal)
            set(hT,'Color',colour_teal)
        end
    end
catch
end
% --- Executes during object creation, after setting all properties.
function greenSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to greenSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blueSlider_Callback(hObject, eventdata, handles)
% hObject    handle to blueSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
try
    select=get(handles.ChoosePlotScatter,'SelectedObject');
    
    reD=get(handles.redSlider, 'Value');
    gREEN=get(handles.greenSlider, 'Value');
    bLUE=get(handles.blueSlider, 'Value');
    colour_teal=[reD gREEN bLUE];
    
    
    if strcmp(select.String,'Plot')
        hAx=handles.H;
        set(hAx,'Color',colour_teal)
    elseif strcmp(select.String,'Back')
        hAx=gca;
        set(hAx,'Color',colour_teal)
    elseif strcmp(select.String,'Scatter')
        if isfield(handles,'HS')
            HS=handles.HS;
            set(HS,'MarkerEdgeColor',colour_teal)
            set(HS,'MarkerFaceColor',colour_teal)
        end
    elseif strcmp(select.String,'Trend')
        if isfield(handles,'hT')
            hT=handles.hT;
            set(hT,'Color',colour_teal)
            set(hT,'Color',colour_teal)
        end
    end
catch
end

% --- Executes during object creation, after setting all properties.
function blueSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blueSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function YlabelS_Callback(hObject, eventdata, handles)
% hObject    handle to YlabelS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YlabelS as text
%        str2double(get(hObject,'String')) returns contents of YlabelS as a double
try
    valueXlabel = get(handles.XlabelS, 'String');
    valueYlabel = get(handles.YlabelS, 'String');
    h=get(gca,'YLabel');
    set(h,'String',valueYlabel);
    h2=get(gca,'XLabel');
    set(h2,'String',valueXlabel);
catch
end

% --- Executes during object creation, after setting all properties.
function YlabelS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YlabelS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function XlabelSize_Callback(hObject, eventdata, handles)
% hObject    handle to XlabelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XlabelSize as text
%        str2double(get(hObject,'String')) returns contents of XlabelSize as a double


% --- Executes during object creation, after setting all properties.
function XlabelSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XlabelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ScatterPlot.
function ScatterPlot_Callback(hObject, eventdata, handles)
% hObject    handle to ScatterPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ScatterPlot
try
    valueScatter = get(handles.ScatterPlot, 'Value');
    if valueScatter==1
        X=handles.myData;
        if isfield(handles,'HS')
            HS=handles.HS;
            set(HS,'visible','off');
        end
        
        hold on
        HS=plot((1:length(X(:,2)))',X(:,2),'*b');
        hold off
        
        
        list2 = {'*','o','+','.','x','s','diamond',...
            '^','v','>','<','pentagram','hexagram'};
        
        indx2=get(handles.ScatterListBox,'Value');
        
        if isempty(indx2);indx2=1;end
        
        sSize=get(handles.scatterSize, 'Value');
        set(HS,'Marker',list2{indx2},'Color','b','MarkerSize',0.01+16*sSize)
        
        handles.HS=HS;guidata(hObject,handles);clear indx2
    elseif isfield(handles,'HS') && valueScatter==0
        HS=handles.HS;
        set(HS,'visible','off');
    end
catch
end

% --- Executes on button press in AddNewSeries.
function AddNewSeries_Callback(hObject, eventdata, handles)
% hObject    handle to AddNewSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    push = handles.AddNewSeries;
    col = get(push,'BackgroundColor');  % Get the background color of the figure.
    name=get(push,'String');
    set(push,'String','Saving Data...','BackgroundColor',[1 .6 .6]) % Change color of button.
    pause(0.00001)
    
    c=clock;filename = sprintf('InputData-%d_%d_%d-%d_%d.xlsx',c(3),c(2),c(1),c(4),c(5));
    A =handles.myData;
    sheet = 1;
    xlRange = 'A2';
    xlswrite(filename,A,sheet,xlRange)
    
    B = {'Serial No','Time Series'};
    xlRange = 'A1';
    xlswrite(filename,B,sheet,xlRange)
catch
end


try
    push = handles.AddNewSeries;
    set(push,'String','Running...','BackgroundColor',[1 .6 .6]) % Change color of button.
    pause(0.00001)
    
    hold on
    pushbutton1_Callback(hObject, eventdata, handles)
catch
    set(push,'String',name,'BackgroundColor',col)  % Now reset the button features.
end
set(push,'String',name,'BackgroundColor',col)  % Now reset the button features.


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%
try
    push = handles.pushbutton5;
    col = get(push,'BackgroundColor');  % Get the background color of the figure.
    name=get(push,'String');
    set(push,'String','Running...','BackgroundColor',[1 .6 .6]) % Change color of button.
    pause(0.00001)
    
    valueScatter = get(handles.ScatterPlot, 'Value');
    if valueScatter==1
        X=handles.myData;
        if isfield(handles,'HS')
            HS=handles.HS;
            set(HS,'visible','off');
        end
        
        hold on
        HS=plot((1:length(X(:,2)))',X(:,2),'*b');
        hold off
        
        
        list2 = {'*','o','+','.','x','s','diamond',...
            '^','v','>','<','pentagram','hexagram'};
        
        indx2=get(handles.ScatterListBox,'Value');
        
        if isempty(indx2);indx2=1;end
        
        sSize=get(handles.scatterSize, 'Value');
        set(HS,'Marker',list2{indx2},'Color','b','MarkerSize',0.01+16*sSize)
        
        handles.HS=HS;guidata(hObject,handles);clear indx2
    elseif isfield(handles,'HS') && valueScatter==0
        HS=handles.HS;
        set(HS,'visible','off');
    end
    %%
    edit9 = str2num(get(handles.edit9, 'String'));
    edit11 = str2num(get(handles.edit11, 'String'));
    edit12 = str2num(get(handles.edit12, 'String'));
    edit13 = str2num(get(handles.edit13, 'String'));
    if ~isempty(edit9)&& ~isempty(edit11)&& ~isempty(edit12)&& ~isempty(edit13)
        xlim([edit9 edit11]);
        ylim([edit12 edit13]);
    end
    %%
    valueTrendLine = get(handles.TrendLine, 'Value');
    if valueTrendLine==1
        hold on
        X=handles.myData;
        
        scatter((1:length(X(:,2)))',X(:,2),1,'k','.');
        hT=lsline;set(hT,'Color','r');
        handles.hT=hT;guidata(hObject,handles);
        hold off
    elseif isfield(handles,'hT') && valueTrendLine==0
        hT=handles.hT;
        set(hT,'visible','off');
    end
    valu = get(handles.Savefigure, 'Value');
    if valu==1
        fh = figure;
        copyobj(handles.Plotting, fh)
    end
    
    val = str2num(get(handles.XlableRotation, 'String'));
    if ~isempty(val)
        set(gca,'XTickLabelRotation',val)
    end
    
    LineStylevalu = get(handles.LineStyleTag, 'Value');
    if LineStylevalu==1
        list3 = {'-','--',':','-.'};
        indx3=get(handles.LineStyleListbox,'Value');
        
        if isempty(indx3);indx3=1;end
        hAx=handles.H;
        set(hAx,'LineStyle',list3{indx3})
        clear indx3
    end
    
    LineThicknessvalu = str2num(get(handles.LineThickness, 'String'));
    if ~isempty(LineThicknessvalu)
        hAx=handles.H;
        set(hAx,'LineWidth',LineThicknessvalu)
    end
    
catch
    set(push,'String',name,'BackgroundColor',col)  % Now reset the button features.
end
set(push,'String',name,'BackgroundColor',col)  % Now reset the button features.


% --- Executes on button press in TrendLine.
function TrendLine_Callback(hObject, eventdata, handles)
% hObject    handle to TrendLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TrendLine
try
    valueTrendLine = get(handles.TrendLine, 'Value');
    if valueTrendLine==1
        hold on
        X=handles.myData;
        
        scatter((1:length(X(:,2)))',X(:,2),1,'k','.');
        hT=lsline;set(hT,'Color','r');
        handles.hT=hT;guidata(hObject,handles);
        hold off
    elseif isfield(handles,'hT') && valueTrendLine==0
        hT=handles.hT;
        set(hT,'visible','off');
    end
catch
end


function YlabelSize_Callback(hObject, eventdata, handles)
% hObject    handle to YlabelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YlabelSize as text
%        str2double(get(hObject,'String')) returns contents of YlabelSize as a double


% --- Executes during object creation, after setting all properties.
function YlabelSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YlabelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Savefigure.
function Savefigure_Callback(hObject, eventdata, handles)
% hObject    handle to Savefigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Savefigure
try
    valu = get(handles.Savefigure, 'Value');
    if valu==1
        fh = figure;
        copyobj(handles.Plotting, fh)
    end
catch
end


function XlableRotation_Callback(hObject, eventdata, handles)
% hObject    handle to XlableRotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XlableRotation as text
%        str2double(get(hObject,'String')) returns contents of XlableRotation as a double
try
    val = str2num(get(handles.XlableRotation, 'String'));
    if ~isempty(val)
        set(gca,'XTickLabelRotation',val)
    end
catch
end

% --- Executes during object creation, after setting all properties.
function XlableRotation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XlableRotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LineThickness_Callback(hObject, eventdata, handles)
% hObject    handle to LineThickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LineThickness as text
%        str2double(get(hObject,'String')) returns contents of LineThickness as a double
try
    LineThicknessvalu = str2num(get(handles.LineThickness, 'String'));
    if ~isempty(LineThicknessvalu)
        hAx=handles.H;
        set(hAx,'LineWidth',LineThicknessvalu)
    end
    
catch
end

% --- Executes during object creation, after setting all properties.
function LineThickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LineThickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LineStyleTag.
function LineStyleTag_Callback(hObject, eventdata, handles)
% hObject    handle to LineStyleTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LineStyleTag
try
    LineStylevalu = get(handles.LineStyleTag, 'Value');
    if LineStylevalu==1
        list3 = {'-','--',':','-.'};
        indx3=get(handles.LineStyleListbox,'Value');
        
        if isempty(indx3);indx3=1;end
        hAx=handles.H;
        set(hAx,'LineStyle',list3{indx3})
        clear indx3
    end
catch
end

function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double
try
    edit9 = str2num(get(handles.edit9, 'String'));
    edit11 = str2num(get(handles.edit11, 'String'));
    edit12 = str2num(get(handles.edit12, 'String'));
    edit13 = str2num(get(handles.edit13, 'String'));
    xlim([edit9 edit11]);
    ylim([edit12 edit13]);
    
catch
end


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double
try
    edit9 = str2num(get(handles.edit9, 'String'));
    edit11 = str2num(get(handles.edit11, 'String'));
    edit12 = str2num(get(handles.edit12, 'String'));
    edit13 = str2num(get(handles.edit13, 'String'));
    xlim([edit9 edit11]);
    ylim([edit12 edit13]);
    
catch
end

% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double
try
    edit9 = str2num(get(handles.edit9, 'String'));
    edit11 = str2num(get(handles.edit11, 'String'));
    edit12 = str2num(get(handles.edit12, 'String'));
    edit13 = str2num(get(handles.edit13, 'String'));
    xlim([edit9 edit11]);
    ylim([edit12 edit13]);
    
catch
end
% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    edit9 = str2num(get(handles.edit9, 'String'));
    edit11 = str2num(get(handles.edit11, 'String'));
    edit12 = str2num(get(handles.edit12, 'String'));
    edit13 = str2num(get(handles.edit13, 'String'));
    xlim([edit9 edit11]);
    ylim([edit12 edit13]);
    
catch
end
% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
try
    tickl=handles.tickl;
    sslider4=get(handles.slider4, 'Value');
    set(gca,'ticklength',sslider4*tickl)
    
    if  sslider4<0.95 && sslider4>0.05
        set(handles.text26, 'String',round(sslider4*10)/10);
    else
        set(handles.text26, 'String','Tick Length');
    end
catch
end

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function scatterSize_Callback(hObject, eventdata, handles)
% hObject    handle to scatterSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

valueScatter = get(handles.ScatterPlot, 'Value');
if isfield(handles,'HS') && valueScatter==1
    sSize=get(handles.scatterSize, 'Value');
    HS=handles.HS;
    set(HS,'MarkerSize',0.01+16*sSize)
    if sSize<0.95 && sSize>0.05
        set(handles.text27, 'String',round(0.01+16*sSize*10)/10);
    else
        set(handles.text27, 'String','Scatter Size');
    end
end


% --- Executes during object creation, after setting all properties.
function scatterSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scatterSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end





% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
try
    slider8=get(handles.slider8, 'Value');
    a = get(gca,'YTickLabel');
    set(gca,'YTickLabel',a,'fontsize',5+slider8*30);
    b = get(gca,'XTickLabel');
    set(gca,'XTickLabel',b,'fontsize',5+slider8*30);
    if slider8>0.05 && slider8<0.95
        set(handles.text30, 'String',round(5+30*slider8*10)/10);
    else
        set(handles.text30, 'String','Label Size');
    end
catch
end
try
    X=handles.myData;
    Y=X(:,1);
    aa=get(gca,'XTick');
    set(gca,'XTickLabels',aa+Y(1)-aa(1));
catch
end

% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(PlottingOnly)




% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
push = handles.pushbutton7;
col = get(push,'BackgroundColor');  % Get the background color of the figure.
name=get(push,'String');
set(push,'String','Running...','BackgroundColor',[1 .6 .6]) % Change color of button.
pause(0.0001)

fh = figure;
copyobj(handles.Plotting, fh)
reset(fh)
reset(gca)
reset(gcf)
box on
grid minor
set(gcf, 'Position', get(0, 'Screensize'));
annotation(fh,'textbox',...
    [0.771595900439241 0.355395683453237 0.199121522693995 0.268496288352818],...
    'String',{'o left click pressed','','o Careful about axis level','','o Zoom: Press +/- while left click pressed','','o Window: Press >/< while button pressed','','o Hold Ctrl while clicking to leave','   magnification on figure'},...
    'FitBoxToText','off');

%%
magnify(fh)


set(push,'String',name,'BackgroundColor',col)  % Now reset the button features.


% --- Executes on selection change in ScatterListBox.
function ScatterListBox_Callback(hObject, eventdata, handles)
% hObject    handle to ScatterListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ScatterListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ScatterListBox
try
    valueScatter = get(handles.ScatterPlot, 'Value');
    if valueScatter==1
        X=handles.myData;
        if isfield(handles,'HS')
            HS=handles.HS;
            set(HS,'visible','off');
        end
        
        hold on
        HS=plot((1:length(X(:,2)))',X(:,2),'*b');
        hold off
        
        
        list2 = {'*','o','+','.','x','s','diamond',...
            '^','v','>','<','pentagram','hexagram'};
        
        indx2=get(handles.ScatterListBox,'Value');
        
        if isempty(indx2);indx2=1;end
        
        sSize=get(handles.scatterSize, 'Value');
        set(HS,'Marker',list2{indx2},'Color','b','MarkerSize',0.01+16*sSize)
        
        handles.HS=HS;guidata(hObject,handles);clear indx2
    elseif isfield(handles,'HS') && valueScatter==0
        HS=handles.HS;
        set(HS,'visible','off');
    end
catch
end

% --- Executes during object creation, after setting all properties.
function ScatterListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScatterListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LineStyleListbox.
function LineStyleListbox_Callback(hObject, eventdata, handles)
% hObject    handle to LineStyleListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LineStyleListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LineStyleListbox
try
    LineStylevalu = get(handles.LineStyleTag, 'Value');
    if LineStylevalu==1
        list3 = {'-','--',':','-.'};
        indx3=get(handles.LineStyleListbox,'Value');
        
        if isempty(indx3);indx3=1;end
        hAx=handles.H;
        set(hAx,'LineStyle',list3{indx3})
        clear indx3
    end
catch
end


% --- Executes during object creation, after setting all properties.
function LineStyleListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LineStyleListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MotionDetect.
function MotionDetect_Callback(hObject, eventdata, handles)
% hObject    handle to MotionDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    valueScatter = get(handles.MotionDetect, 'Value');
    if valueScatter==1
        txt='Motion Detector ON';
        title(txt)
        set(gcf,'windowbuttonmotionfcn',{@detectMotion}); % Set the motion detector.
    else
        set(gcf,'windowbuttonmotionfcn','');
        txt='';
        title(txt)
    end
catch
end
% Hint: get(hObject,'Value') returns toggle state of MotionDetect
