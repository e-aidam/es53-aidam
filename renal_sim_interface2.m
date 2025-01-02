function y = renal_sim_interface2(action,p)

% If no arguments are presented, set action to intialize by default.
if nargin < 1
    action = 'initialize';
end

warning off;

% Declare global variables to be used in renal_sim_interface2.m and
% renal_sim4.m.
global CR_RATE CR_BOLUS GFR CR_RATE_ CR_BOLUS_ GFR_;
global H_SLIDER_GFR H_SLIDER_CR_RATE H_SLIDER_CR_BOLUS;
global H_TEXT_GFR H_TEXT_CR_RATE H_TEXT_CR_BOLUS;
global H_EDIT_C0 H_EDIT_NUMSTEPS H_EDIT_FILENAME;
global H_LABEL_C0 H_LABEL_NUMSTEPS H_LABEL_FILENAME;
global H_LABEL_CR_RATE H_LABEL_GFR H_LABEL_CR_BOLUS;
global START_HANDLE STOP_HANDLE APPLY_HANDLE PAUSE_HANDLE RESUME_HANDLE;
global H_A H_B H_C H_D H_E;
global Blood_Volume Initial_Conc dt;
global STOP_SIM PAUSE_SIM RESUME_SIM C0 NUMSTEPS FILENAME;

Blood_Volume = 50; % Blood volume in decileters.
Initial_Conc = 2;  % Concentration in mg/dl.
dt = 1;            % Change in time in minutes.
C0 = 3;            % Initial creatinine concentration (mg/dl).
NUMSTEPS=500;      % # of iterations (simulation duration = NUMSTEPS*dt).
FILENAME = 'sim_data.mat'; % Default datafile name.

% If the action was intialize...
if strcmp(action,'initialize')
    
    % Set defaults values.
    default_CR_RATE = 1;		% Default CR_RATE (mg/min)
    default_CR_BOLUS = 0;		% Default CR_BOLUS (mg)
    default_GFR = 1.25;		% Default GFR (dl/min)
    default_box = 1;		% Default play field outline (on=1, off=0)
    
    CR_RATE = default_CR_RATE; 
    CR_RATE_ = CR_RATE;
    CR_BOLUS = default_CR_BOLUS; 
    CR_BOLUS_= CR_BOLUS;
    GFR = default_GFR; 
    GFR_= GFR;
    BOX = default_box;
  
    fig=figure('Name','ES-53 RenalSim 1.0', 'NumberTitle','off', 'Visible','on', 'BackingStore','off');
    figure(fig);

    H_A = create_axis([.1 .56 .4 .4]); % Creatinine plot.
    H_B = create_axis([.1 .3 .4 .15]); % Immediately below creatinine.
    H_C = create_axis([.56 .35 .4 .15]); % Southeast
    H_D = create_axis([0.05 .04 .65 .18]); % Lowermost.
    H_E = create_axis([0.56 .6 .4 .15]); % Northeast

    STOP_HANDLE = create_pushbutton([.55 .8 .1 .05], 'stop', 'off');
    START_HANDLE = create_pushbutton([.55 .8 .1 .05], 'start', 'on');
    APPLY_HANDLE = create_pushbutton([.7 .8 .1 .05], 'apply', 'on');
    PAUSE_HANDLE = create_pushbutton([.85 .8 .1 .05], 'pause', 'on');
    RESUME_HANDLE = create_pushbutton([.85 .8 .1 .05], 'resume', 'off');
    
    [H_EDIT_C0, H_LABEL_C0] = create_editbox([.55 .87 .14 .05], num2str(C0), [.55 .93 .14 .04], 'Init. Conc. (mg/dl)');
    [H_EDIT_NUMSTEPS, H_LABEL_NUMSTEPS] = create_editbox([.7 .87 .14 .05], num2str(NUMSTEPS), [.7 .93 .14 .04], 'Duration (min)');
    [H_EDIT_FILENAME, H_LABEL_FILENAME] = create_editbox([.85 .87 .14 .05], FILENAME, [.85 .93 .14 .04], 'File Name');
  
    [H_SLIDER_GFR, H_LABEL_GFR, H_TEXT_GFR] = create_slider([400 80 120 20], [0 2.5], 'GFR', GFR, 'GFR (dl/min)');
    [H_SLIDER_CR_RATE, H_LABEL_CR_RATE, H_TEXT_CR_RATE] = create_slider([400 50 120 20], [0 5], 'CR_RATE', CR_RATE, 'Rate In (mg/min)');
    [H_SLIDER_CR_BOLUS, H_LABEL_CR_BOLUS, H_TEXT_CR_BOLUS] = create_slider([400 20 120 20], [0 500], 'CR_BOLUS', CR_BOLUS, 'Bolus In (mg)');

end 

if strcmp(action,'start')   
    set(START_HANDLE,'visible','off');
    set(STOP_HANDLE,'visible','on');
    p1.Blood_Volume = Blood_Volume;
    p1.Initial_Conc = str2num(get(H_EDIT_C0,'String')); %Initial_Conc;
    NUMSTEPS = str2num(get(H_EDIT_NUMSTEPS,'String')); %Initial_Conc;
    p1.Num_Steps = NUMSTEPS;
    p1.FileName = get(H_EDIT_FILENAME,'String'); %Initial_Conc.
    p1.dt = dt;
    STOP_SIM = 0;
    renal_sim4(p1);
end

if strcmp(action,'stop')
    STOP_SIM = 1;
    set(START_HANDLE,'visible','on');
    set(STOP_HANDLE,'visible','off');
end

if strcmp(action,'apply')
    GFR_ = GFR;
    CR_RATE_ = CR_RATE;
    CR_BOLUS_ = CR_BOLUS;
    set(H_SLIDER_CR_BOLUS,'val',0);
    feval(mfilename,'CR_BOLUS');
end

if strcmp(action,'pause')
    RESUME_SIM = 0;
    PAUSE_SIM = 1;
    set(RESUME_HANDLE,'visible','on');
    set(PAUSE_HANDLE,'visible','off');
end

if strcmp(action,'resume')
    PAUSE_SIM = 0;
    RESUME_SIM = 1;
    set(PAUSE_HANDLE,'visible','on');
    set(RESUME_HANDLE,'visible','off');
end

if strcmp(action,'GFR')
	GFR = get(H_SLIDER_GFR,'val'); 
	set(H_TEXT_GFR,'string',GFR);
end

if strcmp(action,'CR_BOLUS')
	CR_BOLUS = get(H_SLIDER_CR_BOLUS,'val'); 
	set(H_TEXT_CR_BOLUS,'string',CR_BOLUS); 
end	

if strcmp(action,'CR_RATE')
	CR_RATE = get(H_SLIDER_CR_RATE,'val'); 
	set(H_TEXT_CR_RATE,'string',CR_RATE); 
end	

if strcmp(action,'get_settings')				
	y.GFR = GFR_;
    y.CR_RATE = CR_RATE_;
    y.CR_BOLUS = CR_BOLUS_;
    CR_BOLUS_ = 0;
end

if strcmp(action,'update_display')
    DISPLAY_GAIN = 100;
    N1 = round(DISPLAY_GAIN*p.N(p.k));
    x=rand(N1,1); 
    y=rand(N1,1);
    axes(H_A); 
    plot(x,y,'.','markersize',3);
    set(gca,'xtick',[],'ytick',[]);
    title('Plasma Creatinine Concentration')
    Concentration = p.N(1:p.k)/Blood_Volume;
    ii = 1:p.k; 
    t = ii*dt;
    hold off;
    axes(H_D); 
    plot(t,Concentration,'b','linewidth',4);
    title('Concentration over time');
    grid on;
    axes(H_B);
    plot(t, p.Added(ii),'g','linewidth',2);
    title('Creatinine added over time');
    grid on;
    axes(H_C);
    plot(t,p.Removed(ii),'r','linewidth',2);
    title('Creatinine removed over time');
    grid on;
   
    NUMSTEPS = str2num(get(H_EDIT_NUMSTEPS,'String'));
    ADD10 = p.Added(1:p.k); 
    ADD10 = ADD10(find(ADD10<10));  %arcane code to prevent overscaling plot when big boluses are applied
    max1 = max([max(ADD10), max(p.Removed(1:p.k)), max(Concentration),2]);
    axis([0 NUMSTEPS 0 max(2,max1)]);
    
    if p.k==1,
        set(gca,'xtick',0:60:NUMSTEPS);
        axes(H_E); 
        plot(ones(3)); 
        grid on;
        title('Baseline');
    end
end

function h = create_axis(position_rect)
h = axes('Units','normalized', 'Position', position_rect, ...
    'Visible','on', 'DrawMode','fast','NextPlot','replace');
return
    
function h = create_pushbutton(position_rect, name_string, visible)
h = uicontrol('Units','normalized','Position',position_rect,'String',name_string, ...
	'Callback',[mfilename,'(''',name_string,''');'],'Interruptible','on','Visible',visible);
return

function [h_edit, h_label] = create_editbox(pos_edit, init_str, pos_label, label_str)
h_edit = uicontrol('Units','normalized','Position', pos_edit,...
    'String',init_str,'Style','edit','Interruptible','on','Visible','on');
h_label = uicontrol('ForegroundColor',[0 0 0], 'Position',pos_label,... 
		'String',label_str, 'Style','text', 'Units','normalized','Visible','on'); 
return

function [h_slider, h_label, h_text] = create_slider(pos, range, action_str, init_value, label)
h_slider = uicontrol('CallBack', [mfilename,'(''',action_str,''');'],'Max',range(2),'Min',range(1),...
		'Value',init_value, 'Position',pos,'Style','slider','Units','normalized','Visible','on'); 
h_label = uicontrol('Position',[pos(1)+25, pos(2)+pos(4), 80, 13],... 
		'String',label,'Style','text','Visible','on'); 
h_text = uicontrol('Position',[pos(1)+120 pos(2) 40 20],... 
		'String',init_value, 'Style','text','Visible','on'); 
return
  
