%% Programmatic App That Displays a Table

%changable variable
Data_Loaded=0; 

%% load 
 %Open Windows 'open file'-window
       [filename,path] = uigetfile('*.*'); 
        data = dataLoad(fullfile(path,filename));
    
%% Create a Table UI Component Within a Figure
 % Create UI figure
fig = uifigure('Position',[300 400 760 360]);
uit = uitable(fig);
uit.Position = [20 20 720 320];
    uit.Data = data;
    uit.ColumnSortable = true;
    uit.ColumnEditable = [false false true];
    uit.Position(3) = 290;
    uit.RowName = 'numbered';
    uit.ColumnWidth = {'auto',75,'auto','auto','auto',100};
    uit.BackgroundColor = [1 1 .9; .9 .95 1;1 .5 .5];

    uit.DisplayDataChangedFcn = @updatePlot;
%% Get All Table Properties
%To see all the properties of the table, use the get command.

get(uit);

%%
clear all 




