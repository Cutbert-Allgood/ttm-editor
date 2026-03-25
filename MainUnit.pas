unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.Menus, System.Actions,
  Vcl.StdActns, System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ExtCtrls, OptUnit, TPSizeUnit, TPDeviceUnit, Vcl.StdCtrls, EditDeviceUnit,
  CellToSelectUnit, About, ViewSQLUnit, TPObjUnit, EditMasterDS, EditMasterCells,
  EditMasterDevices, EditMasterControllers, EditMasterModules,
  EditMasterSchemaElements, EditMasterChannels;

const
  CDefMainFormCaption = 'Редактор схем подстанций для Телесистемы';
  CsqlDefaultExt = 'sql';
  CsqlFilter = 'Файл SQL запроса со схемой ТП (*.sql)|*.sql';
  CsqlFilterDS = 'Файл SQL запроса со структурой ТП (*.sql)|*.sql';

  CtxtDefaultExt = 'txt';
  CtxtFilterCellDevice = 'Файл TXT ячеек и устройств ТП (*.txt)|*.txt';
  CtxtFilterChannel = 'Файл TXT каналов ТП (*.txt)|*.txt';

  CxmlDefaultExt = 'xml';
  CxmlFilter = 'Файл xml со схемой ТП (*.xml)|*.xml';

type
  TEditMode = (
    emNormal,
    emEdit,
    emEditDblClick,
    emSelect,
    emSelectAdd,
    emMove,

    emAddBus,
    emAddBusConnector,
    emAddCellLabel,
    emAddPowerSwitch,
    emAddGroundDisconnector,
    emAddTransformer1,
    emAddLabel,
    emAddBreak,
    emAddEndClutch,
    emAddIndicatorKZ,
    emAddTextSwitch,
    emAddVacuumSwitch,
    emAddDisconnector,
    emAddTransformer2,
    emAddThermometer,
    emAddCartTN,
    emAddFuse,
    emAddOilSwitch,
    emAddRolloutSwitch,
    emAddVoltageIndicator,
    emAddGrounder,
    emAddGround,

    emAddCartVV,
    emAddSectionDisconnector,
    emAddFuseWithCart,
    emAddTwoChannelTextSwitch,

    emAddBridge
  );

const
  CEditModeNames: array [emNormal..emAddBridge] of string =
    ('Режим ожидания',
     'Режим редактирования',
     'Режим редактирования',
     'Режим выделения блока',
     'Режим выделения блока с добавлением',
     'Режим перемещения блока',

     'Режим добавления сборных шин',
     'Режим добавления соединения к шине',
     'Режим добавления метки с номером ячейки',
     'Режим добавления выключателя нагрузки',
     'Режим добавления земляного ножа с выключателем',
     'Режим добавления трансформатора',
     'Режим добавления метки (обычной)',
     'Режим добавления разрыва линии',
     'Режим добавления концевой муфты',
     'Режим добавления индикатора короткого замыкания',
     'Режим добавления руч.реж., ОЗЗ, ШР, ЛР, ...',
     'Режим добавления вакуумного выключателя',
     'Режим добавления разъединителя РВ',
     'Режим добавления трансформатора напряжения',
     'Режим добавления термометра',
     'Режим добавления тележки ТН',
     'Режим добавления предохранителя плавкого',
     'Режим добавления масляного выключателя',
     'Режим добавления выкатного выключателя',
     'Режим добавления индикатора напряжения',
     'Режим добавления переносного заземления, ЛЗН, ШЗН',
     'Режим добавления заземления (ГОСТ)',

     'Режим добавления тележки BB',
     'Режим добавления секционного разъединителя с тележкой',
     'Режим добавления предохранителя с тележкой',
     'Режим добавления текстового выключателя с двумя каналами',

     'Режим добавления перемычки'
    );

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    N1: TMenuItem;
    N2: TMenuItem;
    ActionFileNew: TAction;
    ActionFileSave: TAction;
    ActionFileSaveAs: TAction;
    ActionEditAddBus: TAction;
    ActionAddBusConnector: TAction;
    ActionEditDel: TAction;
    ImageList1: TImageList;
    ActionEditAddVacuumSwitch: TAction;
    ActionEditDel1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    ActionEditAddPowerSwitch: TAction;
    N14: TMenuItem;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ActionEditAddLabel: TAction;
    N15: TMenuItem;
    ActionEditAddBreak: TAction;
    N16: TMenuItem;
    ActionEditAddBridge: TAction;
    ActionEditAddCartTN: TAction;
    N17: TMenuItem;
    ActionEditAddCellLabel: TAction;
    N18: TMenuItem;
    ActionEditAddDisconnector: TAction;
    N19: TMenuItem;
    N20: TMenuItem;
    ActionEditAddEndClutch: TAction;
    N21: TMenuItem;
    ActionEditAddFuse: TAction;
    N22: TMenuItem;
    ActionEditAddGroundDisconnector: TAction;
    N23: TMenuItem;
    ActionEditAddGrounder: TAction;
    N24: TMenuItem;
    ActionEditAddGround: TAction;
    N25: TMenuItem;
    ActionEditAddIndicatorKZ: TAction;
    N26: TMenuItem;
    ActionEditAddOilSwitch: TAction;
    N27: TMenuItem;
    ActionEditAddRolloutSwitch: TAction;
    N28: TMenuItem;
    ActionEditAddTextSwitch: TAction;
    N29: TMenuItem;
    ActionEditAddThermometer: TAction;
    N30: TMenuItem;
    ActionEditAddTransformer1: TAction;
    ActionEditAddTransformer2: TAction;
    N31: TMenuItem;
    N32: TMenuItem;
    ActionEditAddVoltageIndicator: TAction;
    N33: TMenuItem;
    StatusBar: TStatusBar;
    ActionEditTPSize: TAction;
    N34: TMenuItem;
    N35: TMenuItem;
    ActionEditGridShow: TAction;
    N36: TMenuItem;
    N37: TMenuItem;
    ToolBar2: TToolBar;
    ToolButton3: TToolButton;
    ActionFileExit: TAction;
    ActionFileOpen: TAction;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolBar3: TToolBar;
    ActionEditRectShow: TAction;
    ToolButton9: TToolButton;
    N38: TMenuItem;
    ActionServiceCheck: TAction;
    Memo1: TMemo;
    Splitter1: TSplitter;
    N39: TMenuItem;
    N40: TMenuItem;
    ToolButton10: TToolButton;
    ToolBar4: TToolBar;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    N42: TMenuItem;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolBar5: TToolBar;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolBar6: TToolBar;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    N41: TMenuItem;
    ToolBar7: TToolBar;
    ToolButton14: TToolButton;
    N43: TMenuItem;
    N44: TMenuItem;
    ActionEditSelectAll: TAction;
    N46: TMenuItem;
    ActionEditRotateRight: TAction;
    ActionEditRotateLeft: TAction;
    N901: TMenuItem;
    N902: TMenuItem;
    ToolButton22: TToolButton;
    ActionEditCellShow: TAction;
    N47: TMenuItem;
    ToolButton23: TToolButton;
    ActionEditCellToSelected: TAction;
    N48: TMenuItem;
    ToolButton15: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ActionHelpAbout: TAction;
    N45: TMenuItem;
    N49: TMenuItem;
    ScrollBox1: TScrollBox;
    PaintBox1: TPaintBox;
    ActionServiceViewSQL: TAction;
    SQL1: TMenuItem;
    ActionSubstationCheckDS: TAction;
    ActionSubstationMasterDS: TAction;
    N50: TMenuItem;
    N51: TMenuItem;
    N52: TMenuItem;
    N53: TMenuItem;
    ActionSubstationMasterCell: TAction;
    N55: TMenuItem;
    ActionSubstationLoadFromTXT: TAction;
    txt1: TMenuItem;
    ActionSubstationMasterDevice: TAction;
    N54: TMenuItem;
    ActionSubstationMasterController: TAction;
    ActionSubstationMasterModule: TAction;
    N56: TMenuItem;
    N57: TMenuItem;
    ActionSubstationMasterSchemaElements: TAction;
    N58: TMenuItem;
    ActionEditGUIDShow: TAction;
    ToolButton30: TToolButton;
    GUID1: TMenuItem;
    ActionSubstationMasterChannels: TAction;
    N59: TMenuItem;
    ActionSubstationChannelsFromTXT: TAction;
    txt2: TMenuItem;
    ActionSubstationSaveToXML: TAction;
    ActionSubstationLoadFromXML: TAction;
    N60: TMenuItem;
    xml1: TMenuItem;
    xml2: TMenuItem;
    ActionSubstationSaveToSQL: TAction;
    N61: TMenuItem;
    sql2: TMenuItem;
    ActionSubstationNew: TAction;
    N62: TMenuItem;
    ActionEditAddCartVV: TAction;
    ActionEditAddFuseWithCart: TAction;
    ActionEditAddSectionDisconnector: TAction;
    ActionEditAddTwoChannelTextSwitch: TAction;
    N63: TMenuItem;
    N64: TMenuItem;
    N65: TMenuItem;
    BB1: TMenuItem;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure ActionEditTPSizeExecute(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ActionEditGridShowExecute(Sender: TObject);
    procedure ActionFileNewExecute(Sender: TObject);
    procedure ActionFileExitExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActionFileOpenExecute(Sender: TObject);
    procedure ActionFileSaveAsExecute(Sender: TObject);
    procedure ActionFileSaveExecute(Sender: TObject);
    procedure ActionFileSaveUpdate(Sender: TObject);
    procedure ActionEditDelUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionEditRectShowExecute(Sender: TObject);
    procedure ActionServiceCheckExecute(Sender: TObject);
    procedure ActionEditSelectAllExecute(Sender: TObject);
    procedure ActionEditDelExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseLeave(Sender: TObject);
    procedure ActionEditAddBusExecute(Sender: TObject);
    procedure ActionEditAddBusUpdate(Sender: TObject);
    procedure ActionAddBusConnectorExecute(Sender: TObject);
    procedure ActionAddBusConnectorUpdate(Sender: TObject);
    procedure ActionEditAddCellLabelExecute(Sender: TObject);
    procedure ActionEditAddCellLabelUpdate(Sender: TObject);
    procedure ActionEditAddLabelExecute(Sender: TObject);
    procedure ActionEditAddLabelUpdate(Sender: TObject);
    procedure ActionEditAddBridgeExecute(Sender: TObject);
    procedure ActionEditAddBridgeUpdate(Sender: TObject);
    procedure ActionEditAddPowerSwitchExecute(Sender: TObject);
    procedure ActionEditAddPowerSwitchUpdate(Sender: TObject);
    procedure ActionEditAddGroundDisconnectorExecute(Sender: TObject);
    procedure ActionEditAddGroundDisconnectorUpdate(Sender: TObject);
    procedure ActionEditAddTransformer1Execute(Sender: TObject);
    procedure ActionEditAddTransformer1Update(Sender: TObject);
    procedure ActionEditRotateLeftExecute(Sender: TObject);
    procedure ActionEditRotateRightExecute(Sender: TObject);
    procedure ActionEditRotateRightUpdate(Sender: TObject);
    procedure ActionEditRotateLeftUpdate(Sender: TObject);
    procedure ActionEditBreakUpdate(Sender: TObject);
    procedure ActionEditBreakExecute(Sender: TObject);
    procedure ActionEditAddBreakExecute(Sender: TObject);
    procedure ActionEditAddBreakUpdate(Sender: TObject);
    procedure ActionEditAddEndClutchExecute(Sender: TObject);
    procedure ActionEditAddEndClutchUpdate(Sender: TObject);
    procedure ActionEditAddIndicatorKZExecute(Sender: TObject);
    procedure ActionEditAddIndicatorKZUpdate(Sender: TObject);
    procedure ActionEditCellShowExecute(Sender: TObject);
    procedure ActionEditCellToSelectedExecute(Sender: TObject);
    procedure ActionEditCellToSelectedUpdate(Sender: TObject);
    procedure ActionEditAddTextSwitchExecute(Sender: TObject);
    procedure ActionEditAddTextSwitchUpdate(Sender: TObject);
    procedure ActionEditAddVacuumSwitchExecute(Sender: TObject);
    procedure ActionEditAddVacuumSwitchUpdate(Sender: TObject);
    procedure ActionEditAddDisconnectorExecute(Sender: TObject);
    procedure ActionEditAddDisconnectorUpdate(Sender: TObject);
    procedure ActionEditAddTransformer2Execute(Sender: TObject);
    procedure ActionEditAddTransformer2Update(Sender: TObject);
    procedure ActionEditAddThermometerExecute(Sender: TObject);
    procedure ActionEditAddThermometerUpdate(Sender: TObject);
    procedure ActionEditAddCartTNExecute(Sender: TObject);
    procedure ActionEditAddCartTNUpdate(Sender: TObject);
    procedure ActionEditAddFuseExecute(Sender: TObject);
    procedure ActionEditAddFuseUpdate(Sender: TObject);
    procedure ActionEditAddOilSwitchExecute(Sender: TObject);
    procedure ActionEditAddOilSwitchUpdate(Sender: TObject);
    procedure ActionEditAddRolloutSwitchExecute(Sender: TObject);
    procedure ActionEditAddRolloutSwitchUpdate(Sender: TObject);
    procedure ActionEditAddVoltageIndicatorExecute(Sender: TObject);
    procedure ActionEditAddVoltageIndicatorUpdate(Sender: TObject);
    procedure ActionEditAddGrounderExecute(Sender: TObject);
    procedure ActionEditAddGrounderUpdate(Sender: TObject);
    procedure ActionEditAddGroundExecute(Sender: TObject);
    procedure ActionEditAddGroundUpdate(Sender: TObject);
    procedure ActionHelpAboutExecute(Sender: TObject);
    procedure ActionServiceViewSQLExecute(Sender: TObject);
    procedure ActionSubstationMasterDSExecute(Sender: TObject);
    procedure ActionSubstationMasterCellExecute(Sender: TObject);
    procedure ActionSubstationLoadFromTXTExecute(Sender: TObject);
    procedure ActionSubstationMasterDeviceExecute(Sender: TObject);
    procedure ActionSubstationMasterDeviceUpdate(Sender: TObject);
    procedure ActionSubstationMasterControllerExecute(Sender: TObject);
    procedure ActionSubstationMasterModuleExecute(Sender: TObject);
    procedure ActionSubstationMasterModuleUpdate(Sender: TObject);
    procedure ActionSubstationMasterSchemaElementsUpdate(Sender: TObject);
    procedure ActionSubstationMasterSchemaElementsExecute(Sender: TObject);
    procedure ActionEditGUIDShowExecute(Sender: TObject);
    procedure ActionSubstationMasterChannelsExecute(Sender: TObject);
    procedure ActionSubstationMasterChannelsUpdate(Sender: TObject);
    procedure ActionSubstationChannelsFromTXTExecute(Sender: TObject);
    procedure ActionSubstationChannelsFromTXTUpdate(Sender: TObject);
    procedure ActionSubstationLoadFromXMLExecute(Sender: TObject);
    procedure ActionSubstationSaveToXMLExecute(Sender: TObject);
    procedure ActionSubstationSaveToSQLExecute(Sender: TObject);
    procedure ActionSubstationSaveToSQLUpdate(Sender: TObject);
    procedure ActionSubstationNewExecute(Sender: TObject);
    procedure ActionEditAddFuseWithCartUpdate(Sender: TObject);
    procedure ActionEditAddSectionDisconnectorUpdate(Sender: TObject);
    procedure ActionEditAddTwoChannelTextSwitchUpdate(Sender: TObject);
    procedure ActionEditAddCartVVUpdate(Sender: TObject);
    procedure ActionEditAddCartVVExecute(Sender: TObject);
    procedure ActionEditAddFuseWithCartExecute(Sender: TObject);
    procedure ActionEditAddSectionDisconnectorExecute(Sender: TObject);
    procedure ActionEditAddTwoChannelTextSwitchExecute(Sender: TObject);
  private
    { Private declarations }
    Dst: TCanvas; // канвас для рисования, по умолчанию PaintBox1.Canvas
    FStationID: integer; // ID подстанции
    FTPWidth: integer; // ширина схемы пикс.
    FTPHeight: integer; // высота схемы пикс.
    FRatio: single; // ?
    FModify: boolean; // признак изменениня
    FFileName: string; // имя файла
    FSODeviceList: TSODeviceList; // список элементов подстанции

    FDS: TDistrStation; // подстанция
    FDSFileName: string; // имя файла подстанции
    FDSModify: boolean; // признак изменениня подстанции

    FEditMode: TEditMode; // режим
    FMousePos: TPoint; // позиция мыши в координатах мыши
    FClickPos: TPoint; // позиция клика в координатах мыши
    FClickItem: integer; // кликнутый элемент
    FMoveImage: TBitmap; // изображение перемещаемого блока
    FMoveRect: TRect; // координаты перемещаемого блока
    procedure DrawSelect; // рисовать границу выделения
    procedure DrawMove; // рисовать картинку при перемещении
    procedure Delete; // удалить выделенный блок
    procedure SelectAll; // выделить все
    procedure DeselectAll; // развыделить все
    procedure SelectInRect(ARect: TRect); // выделить всё в прямоугольнике
    procedure MoveSelectedTo(dx, dy: integer); // перемещает выделенные элементы на dx:dy
    function MouseInItem(APoint: TPoint): integer; // возвращает номер элемента, в Rect которого Point
    function GetMoveImage: TBitmap; // изображение перемещаемого

    procedure DrawFon; // рисование фона
    procedure DrawGrid; // рисование сетки
    procedure DrawTP; // рисование схемы
    procedure SaveToFile; // сохранение в файл
    procedure LoadFromFile; // загрузка из файла

  protected
    function GetTPWidthMin: integer; // минимальная ширина схемы по размерам элементов
    function GetTPHeightMin: integer; // минимальная высота схемы по размерам элементов
    procedure SetModify(AModify: boolean); // установить признак изменения
    procedure SetFileName(AFileName: string); // установить имя файла
    function GetSelected: boolean; // возвращает true, если есть выбранный элемент
    function GetSelectedRect: TRect; // возвращает границы выделенных элементов
    function GetSelectedCount: integer; // возвращает кол-во выделенных элементов
    procedure SetDSModify(ADSModify: boolean); // установить признак изменения подстанции
    procedure SetDSFileName(ADSFileName: string); // установить имя файла подстанции
  public
    { Public declarations }
    procedure UpdateStatusBar; // обновить строку состояния
    property StationID: integer read FStationID write FStationID;
    property TPWidth: integer read FTPWidth write FTPWidth;
    property TPHeight: integer read FTPHeight write FTPHeight;
    property Ratio: single read FRatio write FRatio;
    property TPWidthMin: integer read GetTPWidthMin;
    property TPHeightMin: integer read GetTPHeightMin;
    property Modify: boolean read FModify write SetModify;
    property FileName: string read FFileName write SetFileName;
    property Selected: boolean read GetSelected;

    property EditMode: TEditMode read FEditMode write FEditMode;
    property ClickItem: integer read FClickItem;

    property SelectedRect: TRect read GetSelectedRect;
    property SelectedCount: integer read GetSelectedCount;

    property SODeviceList: TSODeviceList read FSODeviceList write FSODeviceList;

    property DS: TDistrStation read FDS write FDS;
    property DSFileName: string read FDSFileName write SetDSFileName;
    property DSModify: boolean read FDSModify write SetDSModify;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  Resize := Resize and ((NewWidth > 640) and (NewHeight > 480));
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // удалить ТП
  DS.Free;
  // удалить элементы
  SODeviceList.Clear;
  SODeviceList.Free;
  if assigned(FMoveImage) then FMoveImage.Free;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Modify then
  begin
    case MessageDlg(Format('Документ (схема) "%s" был изменен. Сохранить?', [ExtractFileName(FileName)]), mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: begin
        MainForm.ActionFileSaveExecute(Self);
        // CanClose:=not Modify;
        CanClose:=true;
      end;
      mrNo: CanClose:=true;
      mrCancel: CanClose:=false;
    end;
  end;
  if DSModify and CanClose then
  begin
    case MessageDlg(Format('Документ (ТП) "%s" был изменен. Сохранить?', [ExtractFileName(DSFileName)]), mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: begin
        MainForm.ActionSubstationSaveToXMLExecute(Self);
        CanClose:=true;
      end;
      mrNo: CanClose:=true;
      mrCancel: CanClose:=false;
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // по умолчанию при запуске программы
  StationID:=VTPOptions.StationID;
  TPWidth:=VTPOptions.TPWidth;
  TPHeight:=VTPOptions.TPHeight;
  Ratio:=VTPOptions.Ratio;

  PaintBox1.Width:=TPWidth;
  PaintBox1.Height:=TPHeight;
  Dst:=PaintBox1.Canvas;

  FileName:='';
  Modify:=false;

  DSFileName:='';
  DSModify:=false;

  SODeviceList:=TSODeviceList.Create();
  SODeviceList.OwnsObjects:=true; // по умолчанию

  FEditMode:=emNormal;
  FClickItem:=-1;
  FMoveImage:=nil;
{
  SODeviceList.Add(TSODeviceBus.Create());
  SODeviceList.Items[0].Rect:=Rect(25, 60, 465, 80);
  // SODeviceList.Items[1].Angle:=90;

  SODeviceList.Add(TSODeviceBusConnector.Create());
  SODeviceList.Items[1].Rect:=Rect(60, 65, 70, 85);

  SODeviceList.Add(TSODeviceCellLabel.Create());
  SODeviceList.Items[2].Rect:=Rect(50, 35, 75, 65);

  SODeviceList.Add(TSODevicePowerSwitch.Create());
  SODeviceList.Items[3].Rect:=Rect(55, 85, 75, 125);

  SODeviceList.Add(TSODeviceBridge.Create());
  SODeviceList.Items[4].Rect:=Rect(60, 127, 70, 147);

  SODeviceList.Add(TSODeviceBridge.Create());
  SODeviceList.Items[5].Rect:=Rect(65, 138, 75, 158);
  SODeviceList.Items[5].Angle:=-90;

  SODeviceList.Add(TSODeviceGroundDisconnector.Create());
  SODeviceList.Items[6].Rect:=Rect(74, 135, 124, 160);
  SODeviceList.Items[6].Angle:=-90;

  SODeviceList.Add(TSODeviceBridge.Create());
  SODeviceList.Items[7].Rect:=Rect(60, 147, 70, 167);

  SODeviceList.Add(TSODeviceTransformer1.Create());
  SODeviceList.Items[8].Rect:=Rect(55, 167, 75, 207);

  SODeviceList.Add(TSODeviceLabel.Create());
  SODeviceList.Items[9].Rect:=Rect(45, 207, 95, 237);
  (SODeviceList.Items[9] as TSODeviceLabel).Name:='Тр-р 1';
}

  DS:=TDistrStation.Create;

  UpdateStatusBar;

  ActionEditGridShow.Checked:=VTPOptions.GridShow;
  ActionEditRectShow.Checked:=VTPOptions.RectShow;
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: integer;
  r: TRect;
begin
  case Key of
    VK_ESCAPE: begin
      case FEditMode of
        emEdit,
        emSelect,
        emSelectAdd,
        emMove,

        emAddBus,
        emAddBusConnector,
        emAddCellLabel,
        emAddPowerSwitch,
        emAddGroundDisconnector,
        emAddTransformer1,
        emAddLabel,
        emAddBreak,
        emAddEndClutch,
        emAddIndicatorKZ,
        emAddTextSwitch,
        emAddVacuumSwitch,
        emAddDisconnector,
        emAddTransformer2,
        emAddThermometer,
        emAddCartTN,
        emAddFuse,
        emAddOilSwitch,
        emAddRolloutSwitch,
        emAddVoltageIndicator,
        emAddGrounder,
        emAddGround,

        emAddCartVV,
        emAddSectionDisconnector,
        emAddFuseWithCart,
        emAddTwoChannelTextSwitch,

        emAddBridge:
        begin
          FClickItem:=-1;
          PaintBox1.Refresh;
          FEditMode:=emNormal;
        end;
      end;
    end;

    VK_LEFT: begin
      // перемещение влево
      if Selected then
      begin
        for i:=0 to SODeviceList.Count-1 do
          if (SODeviceList.Items[i].Select) then
          begin
            // новые координаты
            r:=SODeviceList.Items[i].Rect;
            r.Offset(-1, 0);
            if (r.Left > 0) then
            begin
              SODeviceList.Items[i].Rect:=r;
              Modify:=true;
            end;
          end;
        PaintBox1.Refresh;
      end;
    end;

    VK_UP: begin
      // перемещение вверх
      if Selected then
      begin
        for i:=0 to SODeviceList.Count-1 do
          if (SODeviceList.Items[i].Select) then
          begin
            // новые координаты
            r:=SODeviceList.Items[i].Rect;
            r.Offset(0, -1);
            if (r.Top > 0) then
            begin
              SODeviceList.Items[i].Rect:=r;
              Modify:=true;
            end;
          end;
        PaintBox1.Refresh;
      end;
    end;

    VK_RIGHT: begin
      // перемещение влево
      if Selected then
      begin
        for i:=0 to SODeviceList.Count-1 do
          if (SODeviceList.Items[i].Select) then
          begin
            // новые координаты
            r:=SODeviceList.Items[i].Rect;
            r.Offset(1, 0);
            if (r.Right < TPWidth) then
            begin
              SODeviceList.Items[i].Rect:=r;
              Modify:=true;
            end;
          end;
        PaintBox1.Refresh;
      end;
    end;

    VK_DOWN: begin
      // перемещение влево
      if Selected then
      begin
        for i:=0 to SODeviceList.Count-1 do
          if (SODeviceList.Items[i].Select) then
          begin
            // новые координаты
            r:=SODeviceList.Items[i].Rect;
            r.Offset(0, 1);
            if (r.Bottom < TPHeight) then
            begin
              SODeviceList.Items[i].Rect:=r;
              Modify:=true;
            end;
          end;
        PaintBox1.Refresh;
      end;
    end;
  end;
{
  PgUp 33
  PgDn 34
  End  35
  Home 36
}
  //MessageDlg(inttostr(Key), mtInformation, [mbOk], 0);
end;

procedure TMainForm.DrawFon;
begin
  // рисование фона ТП
  Dst.Pen.Mode:=pmCopy;
  Dst.Pen.Style:=psSolid;
  Dst.Pen.Width:=1;
  Dst.Pen.Color:=VTPOptions.FontColor;
  Dst.Brush.Style:=bsSolid;
  Dst.Brush.Color:=VTPOptions.TPColor;
  Dst.Rectangle(0, 0, TPWidth, TPHeight);
end;

procedure TMainForm.DrawGrid;
var
  x: integer;
begin
  // рисование сетки
  if VTPOptions.GridShow then
  begin
    Dst.Pen.Mode:=pmCopy;
    Dst.Pen.Style:=psSolid;
    Dst.Pen.Width:=1;
    Dst.Pen.Color:=VTPOptions.GridColor;
    Dst.Brush.Style:=bsClear;

    // вертикальные
    x:=0;
    while (x <= TPWidth-1) do
    begin
      Dst.MoveTo(x, 0);
      Dst.LineTo(x, TPHeight-1);
      if (x = 0) then
        x:=x+VTPOptions.GridStep-1
     else
        x:=x+VTPOptions.GridStep;
    end;

    // горизонтальные
    x:=0;
    while (x <= TPHeight-1) do
    begin
      Dst.MoveTo(0, x);
      Dst.LineTo(TPWidth-1, x);
      if (x = 0) then
        x:=x+VTPOptions.GridStep-1
      else
        x:=x+VTPOptions.GridStep;
    end;
  end;
end;

procedure TMainForm.DrawTP;
var
  i: integer;
begin
  // рисование объектов
  for i:=0 to SODeviceList.Count-1 do
    SODeviceList.Items[i].Draw(Dst);
end;

procedure TMainForm.SaveToFile;
var
  i: integer;
  ss: TStringList;
begin
  // сохранение в файл
  ss:=TStringList.Create;
  // заполнение
  // начало
  ss.Add('UPDATE [dbo].[DistrStationMaps]');
  ss.Add('SET [Map] =');
  ss.Add('N''[MAP]');
  ss.Add(Format('StationId:%d', [StationID]));
  ss.Add(Format('Width:%d', [TPWidth]));
  ss.Add(Format('Height:%d', [TPHeight]));
  ss.Add('Ratio:'+FloatToStr(Ratio));
  //ss.Add(Format('Ratio:%f', [Ratio]));
  // элементы
  for i:=0 to SODeviceList.Count-1 do
    SODeviceList.Items[i].SaveToStrings(ss);
  // конец
  ss.Add('''');
  ss.Add(Format('WHERE [DistrStationId] = %d', [StationID]));
  ss.Add('GO');
  // сохранение
  ss.SaveToFile(FileName);
  ss.Free;
end;

procedure TMainForm.LoadFromFile;

// пропускает все пустые строки начиная c ANumber, возвращает номер значащей
function SkipEmptyStrings(ASrc: TStringList; ANumber: integer): integer;
var
  i: integer;
  f: boolean;
  s: string;
begin
  i:=ANumber;
  f:=true;
  while (i < ASrc.Count) and f do
  begin
    s:=trim(ASrc[i]);
    // пустая строка или комментарий
    if ((s = '') or (Pos('--', s) > 0)) then
      i:=i+1
    else
      f:=false;
  end;
  Result:=i;
end;

// возвращает ADst без пустых строк начиная c ANumber до следующей секции []
function CopyFromSection(ASrc, ADst: TStringList; ANumber: integer): integer;
var
  i: integer;
  f: boolean;
  s: string;
begin
  i:=ANumber;
  f:=true;
  ADst.Clear;
  while (i < ASrc.Count) and f do
  begin
    s:=trim(ASrc[i]);
    // пустая строка или комментарий
    if ((s = '') or (Pos('--', s) > 0)) then
    begin
      i:=i+1
    end else if ((Pos('[', s) = 1) and (Pos(']', s) > 0)) then
    begin
      // следующая секция
      f:=false;
    end else if (Pos('''', s) = 1) then
    begin
      // конец секции [MAP]
      f:=false;
    end else
    begin
      ADst.Add(s);
      i:=i+1;
    end;
  end;
  Result:=i;
end;

function GetSectionName(ASrc: string): string;
var
  n1, n2: integer;
begin
  n1:=Pos('[', ASrc);
  n2:=Pos(']', ASrc);
  Result:=Copy(ASrc, n1+1, n2-n1-1);
end;

var
  i, n, n1, n2: integer;
  s, rs: string;
  ds: string; // declare ID string
  dsID: integer; // set ID значение, подставляется вместо StationID при чтении секции [MAP]
  f: boolean;
  dsf: boolean; // флаг наличия declare ID string
  ss, ss1: TStringList;
begin
  // загрузка из файла
  Memo1.Clear;
  ss:=TStringList.Create;
  ss1:=TStringList.Create;
  ss1.NameValueSeparator:=':';
  try
    // загрузка
    ss.LoadFromFile(FileName);

    // читаем заголовок файла
    // проверяем declare ID подстанции
  {
    1. файл с неявным указанием ID подстанции
    declare @RP14ID int

    set @RP14ID = 2057

    UPDATE [dbo].[DistrStationMaps]
    SET [Map] =
    N'[MAP]
    ==========
    '
    WHERE [DistrStationId] = @RP14ID
    GO
  }
    dsf:=false;
    n:=SkipEmptyStrings(ss, 0);
    s:=trim(ss[n]);
    if (Pos('declare', s) > 0) then
    begin
      dsf:=true;
      // declare
      n1:=Pos('declare', s);
      n2:=Pos('int', s);
      if (n2 = 0) then
        raise Exception.CreateFmt('(Cтр. %d) Не найден int в declare',[n]);
      ds:=trim(Copy(s, n1+Length('declare'), n2-n1-Length('declare')));
      if (ds = '') then
        raise Exception.CreateFmt('(Cтр. %d) Не определен шаблон ТП в declare',[n]);
      // set
      n:=SkipEmptyStrings(ss, n+1);
      s:=trim(ss[n]);
      if (Pos('set', s) > 0) then
      begin
        n1:=Pos('set', s);
        n2:=Pos(ds, s, n1+Length('set'));
        if (n2 = 0) then
          raise Exception.CreateFmt('(Cтр. %d) Не найден шаблон ТП в set',[n]);
        n2:=Pos('=', s, n2+Length(ds));
        if (n2 = 0) then
          raise Exception.CreateFmt('(Cтр. %d) Не найден = в set',[n]);
        dsID:=StrToInt(trim(Copy(s, n2+1, Length(s)-n2)));
      end else
        raise Exception.CreateFmt('(Cтр. %d) Не найден set при объявленном declare',[n]);
      n:=n+1; // именно здесь
    end;

  {
    2. файл с неявным указанием ID подстанции
    UPDATE [dbo].[DistrStationMaps]
    SET [Map] =
    N'[MAP]
    ==========
    '
    WHERE [DistrStationId] = 2085
    GO
  }
    n:=SkipEmptyStrings(ss, n);
    s:=trim(ss[n]);
    if (Pos('UPDATE [dbo].[DistrStationMaps]', s) = 0) then
      raise Exception.CreateFmt('(Cтр. %d) Не найден UPDATE [dbo].[DistrStationMaps]',[n]);
    n:=SkipEmptyStrings(ss, n+1);
    s:=trim(ss[n]);
    if (Pos('SET [Map] =', s) = 0) then
      raise Exception.CreateFmt('(Cтр. %d) Не найден SET [Map]',[n]);
    n:=SkipEmptyStrings(ss, n+1);
    s:=trim(ss[n]);
    if (Pos('N''[MAP]', s) = 0) then
      raise Exception.CreateFmt('(Cтр. %d) Не найдена секция N''[MAP]',[n]);

    // разбор секции [MAP]
    n1:=n;
    n:=CopyFromSection(ss, ss1, n+1); // n - номер следующей секции
    s:=ss1.Values['StationID'];
    if dsf then
    begin
      // если был declare
      if (s <> ds) then
        raise Exception.CreateFmt('(Cтр. %d) [%s] Не совпадают шаблоны ТП %s и %s',[n1, 'MAP', s, ds]);
      StationID:=dsID;
    end else
      StationID:=StrToInt(s);

    TPWidth:=LoadStrToInt(ss1.Values['Width']);
    TPHeight:=LoadStrToInt(ss1.Values['Height']);
    Ratio:=StrToFloat(ss1.Values['Ratio']);

    // разбор секций элементов
    while (n < ss.Count) and (trim(ss[n]) <> '''') do
    begin
      s:=GetSectionName(trim(ss[n]));
      n1:=n;
      n:=CopyFromSection(ss, ss1, n+1); // n - номер следующей секции
      f:=true;
      if (s = CSODeviceBusSection) then
        n2:=SODeviceList.Add(TSODeviceBus.Create())
      else if (s = CSODeviceBusConnectorSection) then
        n2:=SODeviceList.Add(TSODeviceBusConnector.Create())
      else if (s = CSODeviceCellLabelSection) then
        n2:=SODeviceList.Add(TSODeviceCellLabel.Create())
      else if (s = CSODevicePowerSwitchSection) then
        n2:=SODeviceList.Add(TSODevicePowerSwitch.Create())
      else if (s = CSODeviceBridgeSection) then
        n2:=SODeviceList.Add(TSODeviceBridge.Create())
      else if (s = CSODeviceGroundDisconnectorSection) then
        n2:=SODeviceList.Add(TSODeviceGroundDisconnector.Create())
      else if (s = CSODeviceTransformer1Section) then
        n2:=SODeviceList.Add(TSODeviceTransformer1.Create())
      else if (s = CSODeviceLabelSection) then
        n2:=SODeviceList.Add(TSODeviceLabel.Create())
      else if (s = CSODeviceBreakSection) then
        n2:=SODeviceList.Add(TSODeviceBreak.Create())
      else if (s = CSODeviceEndClutchSection) then
        n2:=SODeviceList.Add(TSODeviceEndClutch.Create())
      else if (s = CSODeviceIndicatorKZSection) then
        n2:=SODeviceList.Add(TSODeviceIndicatorKZ.Create())
      else if (s = CSODeviceTextSwitchSection) then
        n2:=SODeviceList.Add(TSODeviceTextSwitch.Create())
      else if (s = CSODeviceVacuumSwitchSection) then
        n2:=SODeviceList.Add(TSODeviceVacuumSwitch.Create())
      else if (s = CSODeviceDisconnectorSection) then
        n2:=SODeviceList.Add(TSODeviceDisconnector.Create())
      else if (s = CSODeviceTransformer2Section) then
        n2:=SODeviceList.Add(TSODeviceTransformer2.Create())
      else if (s = CSODeviceThermometerSection) then
        n2:=SODeviceList.Add(TSODeviceThermometer.Create())
      else if (s = CSODeviceCartTNSection) then
        n2:=SODeviceList.Add(TSODeviceCartTN.Create())
      else if (s = CSODeviceFuseSection) then
        n2:=SODeviceList.Add(TSODeviceFuse.Create())
      else if (s = CSODeviceOilSwitchSection) then
        n2:=SODeviceList.Add(TSODeviceOilSwitch.Create())
      else if (s = CSODeviceRolloutSwitchSection) then
        n2:=SODeviceList.Add(TSODeviceRolloutSwitch.Create())
      else if (s = CSODeviceVoltageIndicatorSection) then
        n2:=SODeviceList.Add(TSODeviceVoltageIndicator.Create())
      else if (s = CSODeviceGrounderSection) then
        n2:=SODeviceList.Add(TSODeviceGrounder.Create())
      else if (s = CSODeviceGroundSection) then
        n2:=SODeviceList.Add(TSODeviceGround.Create())

      else if (s = CSODeviceCartVVSection) then
        n2:=SODeviceList.Add(TSODeviceCartVV.Create())
      else if (s = CSODeviceSectionDisconnectorSection) then
        n2:=SODeviceList.Add(TSODeviceSectionDisconnector.Create())
      else if (s = CSODeviceFuseWithCartSection) then
        n2:=SODeviceList.Add(TSODeviceFuseWithCart.Create())
      else if (s = CSODeviceTwoChannelTextSwitchSection) then
        n2:=SODeviceList.Add(TSODeviceTwoChannelTextSwitch.Create())

      else begin
        f:=false;
        Memo1.Lines.Add(Format('(Cтр. %d) [%s] неизвестный элемент',[n1, s]));

        // raise Exception.CreateFmt('(Cтр. %d) [%s] неизвестный элемент',[n, s]);
      end;
      if f then
      begin
        f:=SODeviceList.Items[n2].LoadFromStringList(ss1, rs);
        if not f then
          Memo1.Lines.Add(Format('(Cтр. %d) [%s] %s',[n1, s, rs]));
      end;
    end;

    // конец файла
    n:=SkipEmptyStrings(ss, n);
    s:=trim(ss[n]);
    if (Pos('''', s) = 0) then
      raise Exception.CreateFmt('(Cтр. %d) Не найден ''',[n]);
    n:=SkipEmptyStrings(ss, n+1);
    s:=trim(ss[n]);

    if dsf then
    begin
      if (Pos('WHERE [DistrStationId] = '+ds, s) = 0) then
        raise Exception.CreateFmt('(Cтр. %d) Не найдена WHERE [DistrStationId] = %s',[n, ds]);
    end else
    begin
      if (Pos('WHERE [DistrStationId] = '+IntToStr(StationID), s) = 0) then
        raise Exception.CreateFmt('(Cтр. %d) Не найдена WHERE [DistrStationId] = %d',[n, StationID]);
    end;

    n:=SkipEmptyStrings(ss, n+1);
    s:=trim(ss[n]);
    if (Pos('GO', s) = 0) then
      raise Exception.CreateFmt('(Cтр. %d) Не найдено GO',[n]);

    // репорт
    Memo1.Lines.Add(Format('Загружено %d строк', [ss.Count]));
    if dsf then
    begin
      Memo1.Lines.Add(Format('Объявлен шаблон:', [ds]));
      Memo1.Lines.Add(Format('   declare %s', [ds]));
      Memo1.Lines.Add(Format('   set ID=%d', [dsID]));
    end;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
    end;
  end;
  ss1.Free;
  ss.Free;
end;

procedure TMainForm.DrawSelect;
begin
  // рисовать границу выделения
  Dst.Pen.Mode:=pmNotXor;
  Dst.Pen.Style:=psDot;
  Dst.Pen.Width:=1;
  Dst.Pen.Color:=VTPOptions.SelectColor;
  Dst.Brush.Style:=bsClear;
  Dst.Polygon(
   [FClickPos,
    Point(FMousePos.X, FClickPos.Y),
    FMousePos,
    Point(FClickPos.X, FMousePos.Y)]);
end;

procedure TMainForm.DrawMove;
var
  rs, rd: TRect;
begin
  // рисовать картинку при перемещении
  Dst.CopyMode:=cmSrcInvert;
  rs:=Rect(0, 0, FMoveImage.Width, FMoveImage.Height);
  rd.Left:=FMousePos.x-FClickPos.x;
  rd.Top:=FMousePos.y-FClickPos.y;
  rd.Right:=rd.Left+FMoveImage.Width;
  rd.Bottom:=Rd.Top+FMoveImage.Height;
  Dst.CopyRect(rd, FMoveImage.Canvas, rs);
end;

procedure TMainForm.Delete;
var
  i: integer;
begin
  // удалить выделенный блок
  i:=0;
  while ((SODeviceList.Count > 0) and (i < SODeviceList.Count)) do
    if (SODeviceList.Items[i].Select) then
       SODeviceList.Delete(i)
    else
       inc(i);
end;

procedure TMainForm.SelectAll;
var
  i: integer;
begin
  // выделить все
  for i:=0 to SODeviceList.Count-1 do
    SODeviceList.Items[i].Select:=true;
end;

procedure TMainForm.DeselectAll;
var
  i: integer;
begin
  // развыделить все
  for i:=0 to SODeviceList.Count-1 do
    SODeviceList.Items[i].Select:=false;
end;

procedure TMainForm.SelectInRect(ARect: TRect);
var
  i: integer;
begin
 // выделить всё в прямоугольнике
  for i:=0 to SODeviceList.Count-1 do
    if (ARect.Contains(SODeviceList.Items[i].Rect)) then
      SODeviceList.Items[i].Select:=true;
end;

procedure TMainForm.MoveSelectedTo(dx, dy: integer);
var
  i: integer;
  p: TPoint;
  r: TRect;
begin
  // перемещает выделенные элементы на dx:dy
  for i:=0 to SODeviceList.Count-1 do
    if (SODeviceList.Items[i].Select) then
    begin
      r:=SODeviceList.Items[i].Rect;
      p:=r.Location;
      p.Offset(dx, dy);
      r.Location:=p;
      SODeviceList.Items[i].Rect:=r;
    end;
end;

function TMainForm.MouseInItem(APoint: TPoint): integer;
var
  i: integer;
begin
  // возвращает номер элемента, в Rect которого Point
  Result:=-1;
  i:=0;
  while (i < SODeviceList.Count) and (Result = -1) do
  begin
    if SODeviceList.Items[i].Rect.Contains(APoint) then
      Result:=i;
    if (Result = -1) then i:=i+1;
  end;
end;

function TMainForm.GetMoveImage: TBitmap;
var
  i: integer;
  b: TBitmap;
begin
  // изображение перемещаемого
  b:=TBitmap.Create;
  b.Width:=TPWidth;
  b.Height:=TPHeight;
  b.Canvas.Pen.Mode:=pmCopy;
  b.Canvas.Pen.Style:=psSolid;
  b.Canvas.Pen.Width:=1;
  b.Canvas.Pen.Color:=VTPOptions.MoveColor;
  b.Canvas.Brush.Style:=bsSolid;
  b.Canvas.Brush.Color:=VTPOptions.MoveColor;
  b.Canvas.Rectangle(0, 0, Width-1, Height-1);
  // рисование объектов
  for i:=0 to SODeviceList.Count-1 do
    if (SODeviceList.Items[i].Select) then
      SODeviceList.Items[i].Draw(b.Canvas);
  Result:=b;
end;

procedure TMainForm.ActionAddBusConnectorExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddBusConnector
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionAddBusConnectorUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddBusConnector;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddBreakExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddBreak
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddBreakUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddBreak;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddBridgeExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddBridge
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddBridgeUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddBridge;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddBusExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddBus
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddBusUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddBus;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddCartTNExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddCartTN
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddCartTNUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddCartTN;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddCartVVExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddCartVV
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddCartVVUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddCartVV;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddCellLabelExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddCellLabel
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddCellLabelUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddCellLabel;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddDisconnectorExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddDisconnector
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddDisconnectorUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddDisconnector;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddEndClutchExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddEndClutch
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddEndClutchUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddEndClutch;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddFuseExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddFuse
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddFuseUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddFuse;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddFuseWithCartExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddFuseWithCart
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddFuseWithCartUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddFuseWithCart;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddGroundDisconnectorExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddGroundDisconnector
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddGroundDisconnectorUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddGroundDisconnector;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddGrounderExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddGrounder
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddGrounderUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddGrounder;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddGroundExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddGround
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddGroundUpdate(Sender: TObject);
begin
   (Sender as TAction).Checked:=EditMode = emAddGround;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddIndicatorKZExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddIndicatorKZ
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddIndicatorKZUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddIndicatorKZ;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddLabelExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddLabel
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddLabelUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddLabel;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddOilSwitchExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddOilSwitch
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddOilSwitchUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddOilSwitch;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddPowerSwitchExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddPowerSwitch
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddPowerSwitchUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddPowerSwitch;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddRolloutSwitchExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddRolloutSwitch
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddRolloutSwitchUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddRolloutSwitch;
  UpdateStatusBar
end;

procedure TMainForm.ActionEditAddSectionDisconnectorExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddSectionDisconnector
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddSectionDisconnectorUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddSectionDisconnector;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddTextSwitchExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddTextSwitch
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddTextSwitchUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddTextSwitch;
  UpdateStatusBar
end;

procedure TMainForm.ActionEditAddThermometerExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddThermometer
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddThermometerUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddThermometer;
  UpdateStatusBar
end;

procedure TMainForm.ActionEditAddTransformer1Execute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddTransformer1
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddTransformer1Update(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddTransformer1;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddTransformer2Execute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddTransformer2
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddTransformer2Update(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddTransformer2;
  UpdateStatusBar
end;

procedure TMainForm.ActionEditAddTwoChannelTextSwitchExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddTwoChannelTextSwitch
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddTwoChannelTextSwitchUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddTwoChannelTextSwitch;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddVacuumSwitchExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddVacuumSwitch
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddVacuumSwitchUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddVacuumSwitch;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddVoltageIndicatorExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddVoltageIndicator
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditAddVoltageIndicatorUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddVoltageIndicator;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditBreakExecute(Sender: TObject);
begin
  (Sender as TAction).Checked:=not (Sender as TAction).Checked;
  if (Sender as TAction).Checked then
    EditMode:=emAddBreak
  else
    EditMode:=emNormal;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditBreakUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked:=EditMode = emAddBreak;
  UpdateStatusBar;
end;

procedure TMainForm.ActionEditCellShowExecute(Sender: TObject);
var
  i: integer;
begin
  VTPOptions.CellShow:=ActionEditCellShow.Checked;
  for i:=0 to SODeviceList.Count-1 do
     SODeviceList.Items[i].CellShow:=VTPOptions.CellShow;
  PaintBox1.Refresh;
end;

procedure TMainForm.ActionEditCellToSelectedExecute(Sender: TObject);
var
  i, n: integer;
begin
  // изменение номера ячейки для выбранных элементов
  n:=0;
  i:=0;
  while (i < SODeviceList.Count) and (not SODeviceList.Items[i].Select) do
    i:=i+1;
  if (i < SODeviceList.Count) then
     n:=SODeviceList.Items[i].Cell;

  FormCellToSelect:=nil;
  try
    FormCellToSelect:=TFormCellToSelect.Create(Application);
    FormCellToSelect.EditCell.Text:=IntToStr(n);
    if (FormCellToSelect.ShowModal = mrOk) then
    begin
      n:=StrToInt(FormCellToSelect.EditCell.Text);
      for i:=0 to SODeviceList.Count-1 do
        if SODeviceList.Items[i].Select then
          SODeviceList.Items[i].Cell:=n;

      Modify:=true;
      PaintBox1.Refresh;
      UpdateStatusBar;
    end;
  finally
    if assigned(FormCellToSelect) then FormCellToSelect.Free;
  end;
end;

procedure TMainForm.ActionEditCellToSelectedUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled:=Selected;
end;

procedure TMainForm.ActionEditDelExecute(Sender: TObject);
begin
  Delete;
  Modify:=true;
  PaintBox1.Refresh;
end;

procedure TMainForm.ActionEditDelUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled:=Selected;
end;

procedure TMainForm.ActionEditGridShowExecute(Sender: TObject);
begin
  VTPOptions.GridShow:=ActionEditGridShow.Checked;
  PaintBox1.Refresh;
end;

procedure TMainForm.ActionEditGUIDShowExecute(Sender: TObject);
var
  i: integer;
begin
  VTPOptions.GUIDShow:=ActionEditGUIDShow.Checked;
  for i:=0 to SODeviceList.Count-1 do
     SODeviceList.Items[i].GUIDShow:=VTPOptions.GUIDShow;
  PaintBox1.Refresh;
end;

procedure TMainForm.ActionEditRectShowExecute(Sender: TObject);
var
  i: integer;
begin
  VTPOptions.RectShow:=ActionEditRectShow.Checked;
  for i:=0 to SODeviceList.Count-1 do
     SODeviceList.Items[i].RectShow:=VTPOptions.RectShow;
  PaintBox1.Refresh;
end;

procedure TMainForm.ActionEditRotateLeftExecute(Sender: TObject);
var
  i: integer;
  r: TRect;
begin
  // вращение на -90° (против часовой)
  for i:=0 to SODeviceList.Count-1 do
    if (SODeviceList.Items[i].Select) then
    begin
      // новые координаты
      r:=SODeviceList.Items[i].Rect;
      r.Right:=r.Left+SODeviceList.Items[i].Rect.Height;
      r.Bottom:=r.Top+SODeviceList.Items[i].Rect.Width;
      if (r.Right < TPWidth) and (r.Bottom < TPHeight) then
      begin
        // только координаты
        SODeviceList.Items[i].Rect:=r;
        // только угол
        SODeviceList.Items[i].Angle:=SODeviceList.Items[i].Angle-90;
        // изменен
        Modify:=true;
      end;
    end;
  PaintBox1.Refresh;
end;

procedure TMainForm.ActionEditRotateLeftUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled:=Selected and (SelectedCount = 1);
end;

procedure TMainForm.ActionEditRotateRightExecute(Sender: TObject);
var
  i: integer;
  r: TRect;
begin
  // вращение на 90° (по часовой)
  for i:=0 to SODeviceList.Count-1 do
    if (SODeviceList.Items[i].Select) then
    begin
      // новые координаты
      r:=SODeviceList.Items[i].Rect;
      r.Right:=r.Left+SODeviceList.Items[i].Rect.Height;
      r.Bottom:=r.Top+SODeviceList.Items[i].Rect.Width;
      if (r.Right < TPWidth) and (r.Bottom < TPHeight) then
      begin
        // только координаты
        SODeviceList.Items[i].Rect:=r;
        // только угол
        SODeviceList.Items[i].Angle:=SODeviceList.Items[i].Angle+90;
        // изменен
        Modify:=true;
      end;
    end;
  PaintBox1.Refresh;
end;

procedure TMainForm.ActionEditRotateRightUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled:=Selected and (SelectedCount = 1);
end;

procedure TMainForm.ActionEditSelectAllExecute(Sender: TObject);
begin
  SelectAll;
  PaintBox1.Refresh;
end;

procedure TMainForm.ActionEditTPSizeExecute(Sender: TObject);
begin
  // изменение размера схемы
  FormTPSize:=nil;
  try
    FormTPSize:=TFormTPSize.Create(Application);
    FormTPSize.EditStationID.Text:=IntToStr(StationID);
    FormTPSize.EditTPWidth.MinValue:=TPWidthMin;
    FormTPSize.EditTPWidth.Value:=TPWidth;
    FormTPSize.EditTPHeight.MinValue:=TPHeightMin;
    FormTPSize.EditTPHeight.Value:=TPHeight;
    FormTPSize.EditRatio.Text:=FloatToStr(Ratio);
    if (FormTPSize.ShowModal = mrOk) then
    begin
      StationID:=StrToInt(FormTPSize.EditStationID.Text);

      TPWidth:=FormTPSize.EditTPWidth.Value;
      TPHeight:=FormTPSize.EditTPHeight.Value;
      Ratio:=StrToFloat(FormTPSize.EditRatio.Text);

      PaintBox1.Width:=TPWidth;
      PaintBox1.Height:=TPHeight;

      Modify:=true;
      UpdateStatusBar;
    end;
  finally
    if assigned(FormTPSize) then FormTPSize.Free;
  end;
end;

procedure TMainForm.ActionFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ActionFileNewExecute(Sender: TObject);
begin
  // новая схема
  if (MessageDlg('Действительно начать работу с новой схемой?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    if Modify and
      (MessageDlg('Документ (схема) '+ExtractFileName(FileName)+' был изменен. Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      MainForm.ActionFileSaveExecute(Self);
    end;
    ActionEditRectShow.Checked:=false;
    ActionEditCellShow.Checked:=false;
    ActionEditGUIDShow.Checked:=false;
    // создать новую
    FormTPSize:=nil;
    try
      FormTPSize:=TFormTPSize.Create(Application);
      FormTPSize.EditStationID.Text:=IntToStr(StationID);
      FormTPSize.EditTPWidth.MinValue:=100; //TPWidthMin;
      FormTPSize.EditTPWidth.Value:=TPWidth;
      FormTPSize.EditTPHeight.MinValue:=100; //TPHeightMin;
      FormTPSize.EditTPHeight.Value:=TPHeight;
      FormTPSize.EditRatio.Text:=FloatToStr(Ratio);
      if (FormTPSize.ShowModal = mrOk) then
      begin
        // очистить старую
        SODeviceList.Clear;
        FileName:='';
        StationID:=VTPOptions.StationID;
        TPWidth:=VTPOptions.TPWidth;
        TPHeight:=VTPOptions.TPHeight;
        Ratio:=VTPOptions.Ratio;

        // параметры новой
        StationID:=StrToInt(FormTPSize.EditStationID.Text);
        TPWidth:=FormTPSize.EditTPWidth.Value;
        TPHeight:=FormTPSize.EditTPHeight.Value;
        Ratio:=StrToFloat(FormTPSize.EditRatio.Text);

        PaintBox1.Width:=TPWidth;
        PaintBox1.Height:=TPHeight;

        // отрисоваться
        Modify:=false;// новая и пустая считается сохраненной
        FEditMode:=emNormal;
        PaintBox1.Refresh;
        Memo1.Clear;
        UpdateStatusBar;
      end;
    finally
      if assigned(FormTPSize) then FormTPSize.Free;
    end;

  end;
end;

procedure TMainForm.ActionFileOpenExecute(Sender: TObject);
begin
  // сохранить текущую, если изменена
  if Modify and
    (MessageDlg('Документ (схема) '+ExtractFileName(FileName)+' был изменен. Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    MainForm.ActionFileSaveExecute(Self);
  end;
  // открыть документ
  OpenDialog.Title:='Открыть документ';
  OpenDialog.DefaultExt:=CsqlDefaultExt;
  OpenDialog.Filter:=CsqlFilter;
  OpenDialog.FilterIndex:=1;
  OpenDialog.FileName:='';
  if OpenDialog.Execute then
  begin
    ActionEditRectShow.Checked:=false;
    ActionEditCellShow.Checked:=false;
    ActionEditGUIDShow.Checked:=false;
    VTPOptions.RectShow:=ActionEditRectShow.Checked;
    VTPOptions.CellShow:=ActionEditCellShow.Checked;
    VTPOptions.GUIDShow:=ActionEditGUIDShow.Checked;
    // загрузить
    FileName:=OpenDialog.FileName;
    Memo1.Clear;
    SODeviceList.Clear;
    LoadFromFile;
    PaintBox1.Width:=TPWidth;
    PaintBox1.Height:=TPHeight;
    Modify:=false;
    FEditMode:=emNormal;
    PaintBox1.Refresh;
    UpdateStatusBar;
  end;
end;

procedure TMainForm.ActionFileSaveAsExecute(Sender: TObject);
begin
  // сохранить как
  SaveDialog.Title:='Сохранить документ как';
  SaveDialog.DefaultExt:=CsqlDefaultExt;
  SaveDialog.Filter:=CsqlFilter;
  SaveDialog.FilterIndex:=1;
  SaveDialog.FileName:=Filename;
  if SaveDialog.Execute then
  begin
    FileName:=SaveDialog.FileName;
    // сохранить
    SaveToFile;
    Modify:=false;
    UpdateStatusBar;
  end;
end;

procedure TMainForm.ActionFileSaveExecute(Sender: TObject);
begin
  // сохранить
  if Filename = '' then
    ActionFileSaveAsExecute(Self)
  else begin
    // сохранить
    SaveToFile;
    Modify:=false;
    UpdateStatusBar;
  end;
end;

procedure TMainForm.ActionFileSaveUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled:=Modify;
end;

procedure TMainForm.ActionHelpAboutExecute(Sender: TObject);
begin
  ShowAboutBox;
end;

procedure TMainForm.ActionServiceCheckExecute(Sender: TObject);
var
  i: integer;
  f: boolean;
begin
  // контроль данных
  f:=true; // всё правильно
  Memo1.Clear;

  // проверяем ТП
  if (StationID = 0) then
  begin
    f:=false;
    Memo1.Lines.Add('Не задан ID подстанции');
  end;

  // проверяем элементы
  if (SODeviceList.Count = 0) then
    Memo1.Lines.Add('Отсутствуют элементы подстанции')
  else
    Memo1.Lines.Add('Контроль элементов подстанции:');

  for i:=0 to SODeviceList.Count-1 do
    if not SODeviceList.Items[i].Check(Memo1) then f:=false;
end;

procedure TMainForm.ActionServiceViewSQLExecute(Sender: TObject);
var
  i: integer;
begin
  FormViewSQL:=nil;
  try
    FormViewSQL:=TFormViewSQL.Create(Application);
    // начало
    FormViewSQL.MemoSQL.Lines.Add('UPDATE [dbo].[DistrStationMaps]');
    FormViewSQL.MemoSQL.Lines.Add('SET [Map] =');
    FormViewSQL.MemoSQL.Lines.Add('N''[MAP]');
    FormViewSQL.MemoSQL.Lines.Add(Format('StationId:%d', [StationID]));
    FormViewSQL.MemoSQL.Lines.Add(Format('Width:%d', [TPWidth]));
    FormViewSQL.MemoSQL.Lines.Add(Format('Height:%d', [TPHeight]));
    FormViewSQL.MemoSQL.Lines.Add('Ratio:'+FloatToStr(Ratio));
    //FormViewSQL.MemoSQL.Lines.Add(Format('Ratio:%f', [Ratio]));
    // элементы
    for i:=0 to SODeviceList.Count-1 do
      SODeviceList.Items[i].SaveToStrings(FormViewSQL.MemoSQL.Lines);
    // конец
    FormViewSQL.MemoSQL.Lines.Add('''');
    FormViewSQL.MemoSQL.Lines.Add(Format('WHERE [DistrStationId] = %d', [StationID]));
    FormViewSQL.MemoSQL.Lines.Add('GO');
    FormViewSQL.ShowModal;
  finally
    if assigned(FormViewSQL) then FormViewSQL.Release;
  end;
end;

procedure TMainForm.ActionSubstationChannelsFromTXTExecute(Sender: TObject);
begin
  // загрузить каналы из текста с форматориванием табуляцией
  if (MessageDlg('Действительно хотите загрузить данные каналов из текста с форматированием табуляцией?'+#13#10+#13#10+
     'Все введенные ранее каналы и связи элементов схемы с каналами будут удалены!',
     mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    OpenDialog.Title:='Открыть документ';
    OpenDialog.DefaultExt:=CtxtDefaultExt;
    OpenDialog.Filter:=CtxtFilterChannel;
    OpenDialog.FilterIndex:=1;
    OpenDialog.FileName:='';
    if OpenDialog.Execute then
    begin
      Memo1.Lines.Clear;
      DS.LoadChannelsFromTxt(OpenDialog.FileName, Memo1.Lines);
      DSModify:=true;
    end;
    UpdateStatusBar;
  end;
end;

procedure TMainForm.ActionSubstationChannelsFromTXTUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled:=DS.Channels.Count > 0;
end;

procedure TMainForm.ActionSubstationLoadFromTXTExecute(Sender: TObject);
begin
  // загрузить ячейки и устройства из текста с форматориванием табуляцией
  if (MessageDlg('Действительно хотите загрузить данные подстанции из текста с форматированием табуляцией?'+#13#10+#13#10+
     'Все введенные ранее ячейки, устройства, элементы схемы, каналы и связи элементов схемы с каналами будут удалены!',
     mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    OpenDialog.Title:='Открыть документ';
    OpenDialog.DefaultExt:=CtxtDefaultExt;
    OpenDialog.Filter:=CtxtFilterCellDevice;
    OpenDialog.FilterIndex:=1;
    OpenDialog.FileName:='';
    if OpenDialog.Execute then
    begin
      Memo1.Lines.Clear;
      DS.LoadCellsDevicesFromTxt(OpenDialog.FileName, Memo1.Lines);
      DSModify:=true;
    end;
    UpdateStatusBar;
  end;
end;

procedure TMainForm.ActionSubstationLoadFromXMLExecute(Sender: TObject);
begin
  // загрузить подстанцию из XML
  if (MessageDlg('Действительно хотите загрузить данные подстанции из файла формата XML?'+#13#10+#13#10+
     'Все введенные ранее данные будут удалены!',
     mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    OpenDialog.Title:='Открыть документ';
    OpenDialog.DefaultExt:=CxmlDefaultExt;
    OpenDialog.Filter:=CxmlFilter;
    OpenDialog.FilterIndex:=1;
    OpenDialog.FileName:='';
    if OpenDialog.Execute then
    begin
      DSFileName:=OpenDialog.FileName;
      Memo1.Lines.Clear;
      DS.LoadFromXML(DSFileName, Memo1.Lines);
      DSModify:=false;
    end;
    UpdateStatusBar;
  end;
end;

procedure TMainForm.ActionSubstationMasterCellExecute(Sender: TObject);
begin
  // конструктор ячеек
  FormMasterCells:=nil;
  try
    FormMasterCells:=TFormMasterCells.Create(Application, DS);
    FormMasterCells.ShowModal;
    DSModify:=true;
  finally
    if assigned(FormMasterCells) then FormMasterCells.Release;
  end;
end;

procedure TMainForm.ActionSubstationMasterChannelsExecute(Sender: TObject);
begin
  // конструктор каналов
  FormMasterChannels:=nil;
  try
    FormMasterChannels:=TFormMasterChannels.Create(Application, DS, SODeviceList);
    FormMasterChannels.ShowModal;
    DSModify:=true;
  finally
    if assigned(FormMasterChannels) then FormMasterChannels.Release;
  end;
end;

procedure TMainForm.ActionSubstationMasterChannelsUpdate(Sender: TObject);
begin
  // разрешен, если есть ячейки
  (Sender as TAction).Enabled:=(DS.Cells.Count > 0) and (DS.Modules.Count > 0);
end;

procedure TMainForm.ActionSubstationMasterControllerExecute(Sender: TObject);
begin
  // конструктор контроллеров
  FormMasterControllers:=nil;
  try
    FormMasterControllers:=TFormMasterControllers.Create(Application, DS);
    FormMasterControllers.ShowModal;
    DSModify:=true;
  finally
    if assigned(FormMasterControllers) then FormMasterControllers.Release;
  end;
end;

procedure TMainForm.ActionSubstationMasterDeviceExecute(Sender: TObject);
begin
  // конструктор устройств
  FormMasterDevices:=nil;
  try
    FormMasterDevices:=TFormMasterDevices.Create(Application, DS);
    FormMasterDevices.ShowModal;
    DSModify:=true;
  finally
    if assigned(FormMasterDevices) then FormMasterDevices.Release;
  end;
end;

procedure TMainForm.ActionSubstationMasterDeviceUpdate(Sender: TObject);
begin
  // разрешен, если есть ячейки
  (Sender as TAction).Enabled:=DS.Cells.Count > 0;
end;

procedure TMainForm.ActionSubstationMasterDSExecute(Sender: TObject);
begin
  // конструктор подстанций
  FormMasterDS:=nil;
  try
    FormMasterDS:=TFormMasterDS.Create(Application, DS);
    FormMasterDS.ShowModal;
    DSModify:=true;
  finally
    if assigned(FormMasterDS) then FormMasterDS.Release;
  end;
end;

procedure TMainForm.ActionSubstationMasterModuleExecute(Sender: TObject);
begin
  // конструктор модулей
  FormMasterModules:=nil;
  try
    FormMasterModules:=TFormMasterModules.Create(Application, DS);
    FormMasterModules.ShowModal;
    DSModify:=true;
  finally
    if assigned(FormMasterModules) then FormMasterModules.Release;
  end;
end;

procedure TMainForm.ActionSubstationMasterModuleUpdate(Sender: TObject);
begin
  // разрешен, если есть контроллеры и ячейки, т.к. сразу создаются каналы
  (Sender as TAction).Enabled:=(DS.Controllers.Count > 0) and (DS.Cells.Count > 0);
end;

procedure TMainForm.ActionSubstationMasterSchemaElementsExecute(
  Sender: TObject);
begin
  // конструктор элементов схемы
  FormMasterSchemaelements:=nil;
  try
    FormMasterSchemaelements:=TFormMasterSchemaelements.Create(Application, DS, SODeviceList);
    FormMasterSchemaelements.ShowModal;
    DSModify:=true;
  finally
    if assigned(FormMasterSchemaelements) then FormMasterSchemaelements.Release;
  end;
end;

procedure TMainForm.ActionSubstationMasterSchemaElementsUpdate(Sender: TObject);
begin
  // всегда разрешен, т.к. могут быть элементы схемы без устройств, или на тестовой подстанции
  (Sender as TAction).Enabled:=true;
  // разрешен, если есть устройства
  //(Sender as TAction).Enabled:=(DS.Devices.Count > 0);
end;

procedure TMainForm.ActionSubstationNewExecute(Sender: TObject);
begin
  // новая подстанция
  if (MessageDlg('Действительно хотите создать новую подстанцию?'+#13#10+#13#10+
     'Все введенные ранее данные будут удалены!',
     mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    if DSModify and
      (MessageDlg('Документ (ТП) '+ExtractFileName(DSFileName)+' был изменен. Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      MainForm.ActionSubstationSaveToXMLExecute(Self);
    end;
    DSFileName:='';
    DSModify:=false;
    DS.Clear;
    UpdateStatusBar;
  end;
end;

procedure TMainForm.ActionSubstationSaveToSQLExecute(Sender: TObject);
begin
  // сохранить как SQL
  SaveDialog.Title:='Сохранить документ как';
  SaveDialog.DefaultExt:=CsqlDefaultExt;
  SaveDialog.Filter:=CsqlFilterDS;
  SaveDialog.FilterIndex:=1;
  SaveDialog.FileName:='';
  if SaveDialog.Execute then
  begin
    Memo1.Lines.Clear;
    DS.SaveToSQL(SaveDialog.FileName, Memo1.Lines);
    UpdateStatusBar;
  end;
end;

procedure TMainForm.ActionSubstationSaveToSQLUpdate(Sender: TObject);
begin
  // разрешен, если есть всё
  (Sender as TAction).Enabled:=
    (DS.Controllers.Count > 0) and
    (DS.Modules.Count > 0) and
    (DS.Cells.Count > 0) and
{    (DS.Devices.Count > 0) and  устройств может и не быть  }
    (DS.SchemaElements.Count > 0) and
    (DS.Channels.Count > 0);
end;

procedure TMainForm.ActionSubstationSaveToXMLExecute(Sender: TObject);
begin
  // сохранить как XML
  SaveDialog.Title:='Сохранить документ как';
  SaveDialog.DefaultExt:=CxmlDefaultExt;
  SaveDialog.Filter:=CxmlFilter;
  SaveDialog.FilterIndex:=1;
  SaveDialog.FileName:=DSFileName;
  if SaveDialog.Execute then
  begin
    Memo1.Lines.Clear;
    DSFileName:=SaveDialog.FileName;
    DS.SaveToXML(DSFileName, Memo1.Lines);
    DSModify:=false;
    UpdateStatusBar;
  end;
end;

function TMainForm.GetSelected: boolean;
var
  i: integer;
begin
  // TRUE, если есть выбранный элемент
  Result:=false;
  for i:=0 to SODeviceList.Count-1 do
    if SODeviceList.Items[i].Select then Result:=true;
end;

function TMainForm.GetSelectedRect: TRect;
var
  i: integer;
  r: TRect;
  f: boolean;
begin
  // возвращает границы выделенных элементов
  if (SODeviceList.Count > 0) then
  begin
    f:=false;
    for i:=0 to SODeviceList.Count-1 do
      if (SODeviceList.Items[i].Select) then
      begin
        if f then
        begin
          r:=SODeviceList.Items[i].Rect;
          if (r.Left < Result.Left) then Result.Left:=r.Left;
          if (r.Right > Result.Right) then Result.Right:=r.Right;
          if (r.Bottom > Result.Bottom) then Result.Bottom:=r.Bottom;
          if (r.Top < Result.Top) then Result.Top:=r.Top;
        end else
        begin
          Result:=SODeviceList.Items[i].Rect;
          f:=true;
        end;
      end;
  end else
    Result:=Rect(0, 0, 0, 0);
end;

function TMainForm.GetSelectedCount: integer;
var
  i: integer;
begin
  // возвращает кол-во выделенных элементов
  Result:=0;
  for i:=0 to SODeviceList.Count-1 do
    if (SODeviceList.Items[i].Select) then
      Result:=Result+1;
end;

function TMainForm.GetTPWidthMin: integer;
var
  i: integer;
begin
  // минимальная ширина схемы по размерам элементов, но не менее 100
  Result:=100;
  for i:=0 to SODeviceList.Count-1 do
    if (SODeviceList.Items[i].Rect.Right > Result) then
      Result:=SODeviceList.Items[i].Rect.Right;
end;

function TMainForm.GetTPHeightMin: integer;
var
  i: integer;
begin
  // минимальная высота схемы по размерам элементов, но не менее 100
  Result:=100;
  for i:=0 to SODeviceList.Count-1 do
    if (SODeviceList.Items[i].Rect.Bottom > Result) then
      Result:=SODeviceList.Items[i].Rect.Bottom;
end;

procedure TMainForm.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FMousePos:=Point(X, Y);
  case EditMode of
    emNormal:
    begin
      case Button of
        mbLeft:
        begin
          if ssDouble in Shift then
          begin
            // режим редактирования
            FClickPos:=FMousePos;
            FClickItem:=MouseInItem(FClickPos);
            if (FClickItem >= 0) then
            begin
              EditMode:=emEditDblClick;
              DeselectAll;
            end;
          end else
          if (ssShift in Shift) or (ssCtrl in Shift) then
          begin
            // режим выделения с добавлением
            EditMode:=emSelectAdd;
            FClickPos:=FMousePos;
          end else
          begin
            if Selected then
            begin
              FClickItem:=MouseInItem(FMousePos);
              if (FClickItem >= 0) and (SODeviceList.Items[FClickItem].Select) then
              begin
                // режим перемещения
                EditMode:=emMove;
                FClickPos:=FMousePos;
                FMoveRect:=SelectedRect;
                FMoveImage:=GetMoveImage;
                DrawMove;
              end else
              begin
                // режим выделения
                DeselectAll;
                PaintBox1.Refresh;
                EditMode:=emSelect;
                FClickPos:=FMousePos;
              end;
            end else
            begin
              // режим выделения
              EditMode:=emSelect;
              FClickPos:=FMousePos;
            end;
          end;
        end;

        mbRight:
        begin
          // режим редактирования
          FClickPos:=FMousePos;
          FClickItem:=MouseInItem(FClickPos);
          if (FClickItem >= 0) then
          begin
            EditMode:=emEdit;
          end;
        end;

      end;
    end;

    emAddBus,
    emAddBusConnector,
    emAddCellLabel,
    emAddPowerSwitch,
    emAddGroundDisconnector,
    emAddTransformer1,
    emAddLabel,
    emAddBreak,
    emAddEndClutch,
    emAddIndicatorKZ,
    emAddTextSwitch,
    emAddVacuumSwitch,
    emAddDisconnector,
    emAddTransformer2,
    emAddThermometer,
    emAddCartTN,
    emAddFuse,
    emAddOilSwitch,
    emAddRolloutSwitch,
    emAddVoltageIndicator,
    emAddGrounder,
    emAddGround,

    emAddCartVV,
    emAddSectionDisconnector,
    emAddFuseWithCart,
    emAddTwoChannelTextSwitch,

    emAddBridge:
    begin
      case Button of
        mbLeft:
        begin
          FClickPos:=FMousePos;
        end;
      end;
    end;

    emEdit, emEditDblClick:
    begin
      EditMode:=emNormal;
    end;

  end;
  MainForm.UpdateStatusBar;
end;


procedure TMainForm.PaintBox1MouseLeave(Sender: TObject);
begin
  case EditMode of
    emSelect:
      EditMode:=emNormal;
  end;
  // MainForm.UpdateStatusBar;
end;

procedure TMainForm.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  p1, p2: TPoint;
  dx, dy: double;
begin
  // Перерисовки
  case EditMode of
    emSelect: DrawSelect;
    emSelectAdd: DrawSelect;
    emMove: DrawMove;
  end;

  // Строка статуса
  FMousePos:=Point(X, Y);
  MainForm.StatusBar.Panels[0].Text:=Format('%.d:%.d',[FMousePos.X, FMousePos.Y]);

  // прочее
  case EditMode of
    emSelect:
    begin
      DrawSelect;
    end;

    emSelectAdd:
    begin
      if not ((ssShift in Shift) or (ssCtrl in Shift)) then EditMode:=emNormal;
      DrawSelect;
    end;

    emMove:
    begin
      dx:=round(FMousePos.X-FClickPos.X);
      dy:=round(FMousePos.Y-FClickPos.Y);
      DrawMove;
    end;
  end;
end;

procedure TMainForm.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  n, EditModalResult: integer;
  r1: TRect;
  dx, dy: integer;
begin
  FMousePos:=Point(X, Y);
  case EditMode of

    emAddBus,
    emAddBusConnector,
    emAddCellLabel,
    emAddPowerSwitch,
    emAddGroundDisconnector,
    emAddTransformer1,
    emAddLabel,
    emAddBreak,
    emAddEndClutch,
    emAddIndicatorKZ,
    emAddTextSwitch,
    emAddVacuumSwitch,
    emAddDisconnector,
    emAddTransformer2,
    emAddThermometer,
    emAddCartTN,
    emAddFuse,
    emAddOilSwitch,
    emAddRolloutSwitch,
    emAddVoltageIndicator,
    emAddGrounder,
    emAddGround,

    emAddCartVV,
    emAddSectionDisconnector,
    emAddFuseWithCart,
    emAddTwoChannelTextSwitch,

    emAddBridge:
    begin
      case Button of
        mbLeft:
        begin
          // добавление элемента
          if (FMousePos = FClickPos) then
          begin
            case EditMode of
              emAddBus: n:=SODeviceList.Add(TSODeviceBus.Create());
              emAddBusConnector: n:=SODeviceList.Add(TSODeviceBusConnector.Create());
              emAddCellLabel: n:=SODeviceList.Add(TSODeviceCellLabel.Create());
              emAddPowerSwitch: n:=SODeviceList.Add(TSODevicePowerSwitch.Create());
              emAddGroundDisconnector: n:=SODeviceList.Add(TSODeviceGroundDisconnector.Create());
              emAddTransformer1: n:=SODeviceList.Add(TSODeviceTransformer1.Create());
              emAddLabel: n:=SODeviceList.Add(TSODeviceLabel.Create());
              emAddBreak: n:=SODeviceList.Add(TSODeviceBreak.Create());
              emAddEndClutch: n:=SODeviceList.Add(TSODeviceEndClutch.Create());
              emAddIndicatorKZ: n:=SODeviceList.Add(TSODeviceIndicatorKZ.Create());
              emAddTextSwitch: n:=SODeviceList.Add(TSODeviceTextSwitch.Create());
              emAddVacuumSwitch: n:=SODeviceList.Add(TSODeviceVacuumSwitch.Create());
              emAddDisconnector: n:=SODeviceList.Add(TSODeviceDisconnector.Create());
              emAddTransformer2: n:=SODeviceList.Add(TSODeviceTransformer2.Create());
              emAddThermometer: n:=SODeviceList.Add(TSODeviceThermometer.Create());
              emAddCartTN: n:=SODeviceList.Add(TSODeviceCartTN.Create());
              emAddFuse: n:=SODeviceList.Add(TSODeviceFuse.Create());
              emAddOilSwitch: n:=SODeviceList.Add(TSODeviceOilSwitch.Create());
              emAddRolloutSwitch: n:=SODeviceList.Add(TSODeviceRolloutSwitch.Create());
              emAddVoltageIndicator: n:=SODeviceList.Add(TSODeviceVoltageIndicator.Create());
              emAddGrounder: n:=SODeviceList.Add(TSODeviceGrounder.Create());
              emAddGround: n:=SODeviceList.Add(TSODeviceGround.Create());

              emAddCartVV: n:=SODeviceList.Add(TSODeviceCartVV.Create());
              emAddSectionDisconnector: n:=SODeviceList.Add(TSODeviceSectionDisconnector.Create());
              emAddFuseWithCart: n:=SODeviceList.Add(TSODeviceFuseWithCart.Create());
              emAddTwoChannelTextSwitch: n:=SODeviceList.Add(TSODeviceTwoChannelTextSwitch.Create());

              emAddBridge: n:=SODeviceList.Add(TSODeviceBridge.Create());
            else
              raise Exception.Create('Добавление объекта неизвестного типа');
            end;
            SODeviceList.Items[n].Rect:=Rect(
              FMousePos.X,
              FMousePos.Y,
              FMousePos.X+SODeviceList.Items[n].DefSize.cx,
              FMousePos.Y+SODeviceList.Items[n].DefSize.cy
            );
            if not (Rect(0, 0, TPWidth, TPHeight).Contains(SODeviceList.Items[n].Rect)) then
            begin
              SODeviceList.Delete(n);
              FModify:=false;
            end else
            begin
              FModify:=true;
            end;
            PaintBox1.Refresh;
          end;
        end;
      end;
    end;

    emSelect:
    begin
      case Button of
        mbLeft:
        begin
          // выделение блока
          DrawSelect;
          if (FClickPos = FMousePos) then
          begin
            // один элемент
            FClickItem:=MouseInItem(FMousepos);
            if (FClickItem >= 0) then
              SODeviceList.Items[FClickItem].Select:=not SODeviceList.Items[FClickItem].Select;
          end else
          begin
            // несколько в рамке
            r1:=Rect(FClickPos.X, FClickPos.Y, FMousePos.X, FMousePos.Y);
            r1.NormalizeRect;
            SelectInRect(r1);
          end;
          PaintBox1.Refresh;
          EditMode:=emNormal;
        end;
      end;
    end;

    emSelectAdd:
    begin
      case Button of
        mbLeft:
        begin
          if (ssShift in Shift) or (ssCtrl in Shift) then
          begin
            // выделение блока
            DrawSelect;
            if (FClickPos = FMousePos) then
            begin
              // один элемент
              FClickItem:=MouseInItem(FMousepos);
              if (FClickItem >= 0) then
                SODeviceList.Items[FClickItem].Select:=not SODeviceList.Items[FClickItem].Select;
            end else
            begin
              // несколько в рамке
              r1:=Rect(FClickPos.X, FClickPos.Y, FMousePos.X, FMousePos.Y);
              r1.NormalizeRect;
              SelectInRect(r1);
            end;
          end;
          PaintBox1.Refresh;
          EditMode:=emNormal;
        end;
      end;
    end;

    emMove:
    begin
      case Button of
        mbLeft:
        begin
          DrawMove;
          FMoveImage.Free;
          FMoveImage:=nil;
          dx:=FMousePos.X-FClickPos.X;
          dy:=FMousePos.Y-FClickPos.Y;
          if (FMoveRect.Left+dx >= 0) and
            (FMoveRect.Right+dx <= TPWidth) and
            (FMoveRect.Top+dy >= 0) and
            (FMoveRect.Bottom+dy <= TPHeight) then
          begin
            MoveSelectedTo(dx, dy);
            FModify:=true;
          end;
          PaintBox1.Refresh;
          EditMode:=emNormal;
        end;
      end;
    end;

    emEdit:
    begin
      // режим редактирования
      if (FClickPos = FMousePos) then
      begin
        EditModalResult:=ShowFormDeviceEdit(
          SODeviceList.Items[FClickItem],
          TPWidth-SODeviceList.Items[FClickItem].Rect.Left,
          TPWidth-SODeviceList.Items[FClickItem].Rect.Top,
          DS,
          SODeviceList
        );
        if (EditModalResult = mrOk) then FModify:=true;
        PaintBox1.Refresh;
      end;
      EditMode:=emNormal;
    end;

    emEditDblClick:
    begin
      // режим редактирования по двойному клику
      if (FClickPos = FMousePos) then
      begin
        EditModalResult:=ShowFormDeviceEdit(
          SODeviceList.Items[FClickItem],
          TPWidth-SODeviceList.Items[FClickItem].Rect.Left,
          TPWidth-SODeviceList.Items[FClickItem].Rect.Top,
          DS,
          SODeviceList
        );
        if (EditModalResult = mrOk) then FModify:=true;
        PaintBox1.Refresh;
      end;
    end;

  end;
  MainForm.UpdateStatusBar;
end;

procedure TMainForm.PaintBox1Paint(Sender: TObject);
begin
  // отрисовка
  DrawFon;
  DrawGrid;
  DrawTP;
end;

procedure TMainForm.SetFileName(AFileName: string);
begin
  FFileName:=AFileName;
  if (FileName <> '') then
    Caption:=ExtractFileName(FFileName)
  else
    Caption:=CDefMainFormCaption;
{
  Caption:=CDefMainFormCaption;
  if (FileName <> '') then
    Caption:=Caption+' '+ExtractFileName(FFileName);
}
end;

procedure TMainForm.SetDSFileName(ADSFileName: string);
begin
  // установить имя файла подстанции
  FDSFileName:=ADSFileName;
end;

procedure TMainForm.SetModify(AModify: boolean);
begin
  FModify:=AModify;
end;

procedure TMainForm.SetDSModify(ADSModify: boolean);
begin
  // установить признак изменения подстанции
  FDSModify:=ADSModify;
end;

procedure TMainForm.UpdateStatusBar;
var
  i: integer;
begin
  // координаты мыши в OnMouseMove
  // StatusBar.Panels[0].Text:='';
  // размер ТП
  StatusBar.Panels[1].Text:=Format('%dx%d', [TPWidth, TPHeight]);
  // ID ТП
  StatusBar.Panels[2].Text:=Format('ID=%d', [StationID]);
  // статус изменения
  if Modify then
    StatusBar.Panels[3].Text:='Изменен'
  else
    StatusBar.Panels[3].Text:='';

  // ТП файл
  if (DSFileName = '') then
    StatusBar.Panels[4].Text:=''
  else
    StatusBar.Panels[4].Text:='ТП. загр.';
  // ТП название
  StatusBar.Panels[5].Text:=DS.DistrStationName;
  // статус изменения
  if DSModify then
    StatusBar.Panels[6].Text:='Изменен'
  else
    StatusBar.Panels[6].Text:='';

  // режим
  StatusBar.Panels[7].Text:=CEditModeNames[EditMode];
end;

end.