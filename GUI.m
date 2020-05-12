function varargout = GUI(varargin)
%GUI MATLAB code file for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('Property','Value',...) creates a new GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to GUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI('CALLBACK') and GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
 
% Edit the above text to modify the response to help GUI
 
% Last Modified by GUIDE v2.5 12-May-2013 19:39:21
 
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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
% End initialization code - DO NOT EDIT
 
 
% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)
 
% Choose default command line output for GUI
handles.output = hObject;
 
% Update handles structure
guidata(hObject, handles);
 
% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
 
 
% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Get default command line output from handles structure
varargout{1} = handles.output;
 
 
% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hint: get(hObject,'Value') returns toggle state of checkbox1
 
function plotting (x1,x2,fun)
      global sz;
      fplot(fun,[x1,x2]);
      hold on
      x = linspace(x1,x2,50);
      if (sz==0)
          y=x;
      else
          y=0;
      end
      plot(x,y);
      grid();
      
      
function setting ()
cla reset
grid();
          
      
% --- Executes on button press in fixed.
function fixed_Callback(hObject, eventdata, handles)
%cla reset
global equ;
[value,max,es]=GetInputs('FixedPoint');
if (es==-1)
    return;
end
if(strcmp(equ, '')==0)
    if(size(value)>0)
        [result,time,iter,root,ea]=FixedPoint(value(1),max,es,equ);
        myString = sprintf('time=%f\n  no.of iterations=%f\n  approximate Error=%f\n   precision=%f\n',time,iter,root,ea);
        set(handles.results, 'String', myString);
        table_as_cell = num2cell(result);
        colnames = {'i','Xr','Ea'};
        set(handles.Table, 'Data', table_as_cell,'ColumnName',colnames);
        plotting (value(1),value(1)+10,equ)
        
    end
end
 
% --- Executes on button press in newton.
function newton_Callback(hObject, eventdata, handles)
global equ;
setting();
[value,max,es]=GetInputs('NewtonRaphson');
if(size(value)>0)
    [result,time,iter,root,ea]=NewtonRaphson(equ,max,es,value(1));
        table_as_cell = num2cell(result);
        colnames = {'i','Xi','Xi-1','F(Xi)','F`(Xi)','Ea'};
        set(handles.Table, 'Data', table_as_cell,'ColumnName',colnames);
    myString = sprintf('time=%f\n  no.of iterations=%f\n  approximate Error=%f\n   precision=%f\n',time,iter,root,ea);
        set(handles.results, 'String', myString);
    plotting (value(1),value(1)+10,equ)
end
 
 
 
% --- Executes on button press in bisection.
function bisection_Callback(hObject, eventdata, handles)
global equ;
setting();
[value,max,es]=GetInputs('Bisection');
if(size(value)>0)
    [result,time,iter,root,ea]=bisection(equ,value(1),value(2),es,max);
    table_as_cell = num2cell(result);
    colnames = {'i','Xl','XU','Xr','Ea'};
    set(handles.Table, 'Data', table_as_cell,'ColumnName',colnames);
    myString = sprintf('time=%f\n  no.of iterations=%f\n  approximate Error=%f\n   precision=%f\n',time,iter,root,ea);
    set(handles.results, 'String', myString);
    plotting (value(1),value(2),equ)
end
 
% --- Executes on button press in falsepos.
function falsepos_Callback(hObject, eventdata, handles)
global equ;
setting();
[value,max,es]=GetInputs('FalsePosition');
if(size(value)>0)
   [result,time,iter,root,ea]= falsePosition(equ,value(1),value(2),max,es);
  table_as_cell = num2cell(result);
        colnames = {'i','Xl','XU','Xr','F(Xr)','Ea'};
        set(handles.Table, 'Data', table_as_cell,'ColumnName',colnames);
    myString = sprintf('time=%f\n  no.of iterations=%f\n  approximate Error=%f\n   precision=%f\n',time,iter,root,ea);
        set(handles.results, 'String', myString);
   plotting (value(1),value(2),equ)
end
 
 
% --- Executes on button press in secant.
function secant_Callback(hObject, eventdata, handles)
global equ;
setting();
[value,max,es]=GetInputs('Secant');
if(size(value)>0)
   [result,time,iter,root,ea] = secant(equ,max,es,value(1),value(2));
  table_as_cell = num2cell(result);
        colnames = {'i','XP','Xc','F(Xp)','F(Xc)','Xr','Ea'};
        set(handles.Table, 'Data', table_as_cell,'ColumnName',colnames);
    myString = sprintf('time=%f\n  no.of iterations=%f\n  approximate Error=%f\n   precision=%f\n',time,iter,root,ea);
        set(handles.results, 'String', myString);
end
 
 
% --- Executes on button press in p7.
function p7_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'7');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p4.
function p4_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'4');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p1.
function p1_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'1');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p8.
function p8_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'8');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p5.
function p5_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'5');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p2.
function p2_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'2');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p9.
function p9_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'9');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p6.
function p6_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'6');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p3.
function p3_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'3');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in pow.
function pow_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'^');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'(');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in mul.
function mul_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'*');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in sub.
function sub_Callback(hObject, eventdata, handles)
% hObject    handle to sub (see GCBO)
ca = get (handles.t1,'string');
ca = strcat(ca,'-');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in pPlus.
function pPlus_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'+');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,')');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in del.
function del_Callback(hObject, eventdata, handles)
set(handles.t1,'string','');
 
 global eq;
 eq = 0;
% --- Executes on button press in eq.
function eq_Callback(hObject, eventdata, handles)
 global eq;
 eq=1;
ca = get (handles.t1,'string');
ca = strcat(ca,'=');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in exp.
function exp_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'exp');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in sin.
function sin_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'sin');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in cos.
function cos_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'cos');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in var.
function var_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'x');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p0.
function p0_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'0');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in dot.
function dot_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'.');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = ca(1:end-1);
set(handles.t1,'string',ca);
 


% --- Executes on button press in solve.
function solve_Callback(hObject, eventdata, handles)
global equ;
global sz;
str = get (handles.t1,'string');
find = strfind(str,'=');
sz= size(find);
if(sz==1)
    str = str (1:end-2);
end
    equ=str2func(['@(x)',str]);
    try
      equ(0);
    catch 
        msgbox('Please enter a valid function');
       return;
    end

    % --- Executes when entered data in editable cell(s) in Table.
function Table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to Table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)





% --- Executes during object creation, after setting all properties.
function results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
