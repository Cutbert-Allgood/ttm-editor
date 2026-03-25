unit TPDeviceUnit;

interface

uses
  Windows, Vcl.StdCtrls, Vcl.Graphics, System.Generics.Collections, System.Math,
  System.Types, System.SysUtils, System.Classes, OptUnit, Vcl.ValEdit, Vcl.Grids,
  Vcl.ComCtrls, System.RegularExpressions;

const
  { Цвета элементов }
  CSODeviceDefColor: TColor = $C3C3C3; // св. сер.
  CSODeviceBusColor: TColor = $00A5FF; // оранж
  CSODeviceBridgeColor: TColor = $00A5FF; // оранж
  CSODeviceGroundDisconnectorColor: TColor = $FF0000; // син
  CSODevicePowerSwitchColor: TColor = $0000FF; // крас
  CSODeviceVVColor: TColor = $0000FF; // крас
  CSODeviceCellLabelColor: TColor = $42F924; // зел
  CSODeviceLabelColor: TColor = $42F924; // зел
  CSODeviceRedModeColor: TColor = $0000FF; // крас
  CSODeviceBusConnColor: TColor = $FFFFFF; // бел
  CSODeviceTransformer1Color: TColor = $0000FF; // крас
  CSODeviceBreakColor: TColor = $FFFFFF; // бел
  CSODeviceEndClutchColor: TColor = $00A5FF; // оранж
  CSODeviceIndicatorKZColor: TColor = $00A5FF; // оранж
  CSODeviceIndicatorKZBlueColor: TColor = $FF0000; // син
  CSODeviceTextSwitchColor: TColor = $42F924; // зел
  CSODeviceTextSwitchRedBackTextColor: TColor = $FFFFFF; // бел
  CSODeviceTextSwitchRedBackColor: TColor = $00A5FF; // оранж
  CSODeviceVacuumSwitchColor: TColor = $0000FF; // крас
  CSODeviceDisconnectorColor: TColor = $0000FF; // крас
  CSODeviceTransformer2Color: TColor = $0000FF; // крас
  CSODeviceThermometerColor: TColor = $0000FF; // крас
  CSODeviceThermometerWhiteColor: TColor = $FFFFFF; // бел
  CSODeviceCartTNColor: TColor = $0000FF; // крас
  CSODeviceFuseColor: TColor = $0000FF; // крас
  CSODeviceOilSwitchColor: TColor = $0000FF; // крас
  CSODeviceOilSwitchBackColor: TColor = $C3C3C3; // серый
  CSODeviceRolloutSwitchColor: TColor = $0000FF; // крас
  CSODeviceVoltageIndicatorColor: TColor = $0000FF; // крас
  CSODeviceGrounderColor: TColor = $FF0000; // син
  CSODeviceGroundColor: TColor = $FF0000; // син

  CSODeviceSelectColor: TColor = $FF80FF; // сиреневый
  CSODeviceRectColor: TColor = $E2A200; // св. син.
  //CSODeviceCellColor: TColor = $FFFFFF; // белый $C3C3C3 // серый
  CSODeviceCellColor: TColor = $C3C3C3; // серый

  CSODeviceCartVVColor: TColor = $0000FF; // крас
  CSODeviceSectionDisconnectorColor: TColor = $0000FF; // крас
  CSODeviceFuseWithCartColor: TColor =$0000FF;  // крас
  CSODeviceTwoChannelTextSwitchColor: TColor = $42F924; // зел
  CSODeviceTwoChannelTextSwitchRedBackTextColor: TColor = $FFFFFF; // бел
  CSODeviceTwoChannelTextSwitchRedBackColor: TColor = $00A5FF; // оранж

  { названия секций }
  CSODeviceBusSection = 'TSOBus';
  CSODeviceBusConnectorSection = 'TSOBusConnector';
  CSODeviceCellLabelSection = 'TSOCellLabel';
  CSODevicePowerSwitchSection = 'TSOPowerSwitch';
  CSODeviceBridgeSection = 'TSOBridge';
  CSODeviceGroundDisconnectorSection = 'TSOGroundDisconnector';
  CSODeviceTransformer1Section = 'TSOTransformer1';
  CSODeviceLabelSection = 'TSOLabel';
  CSODeviceBreakSection = 'TSOBreak';
  CSODeviceEndClutchSection = 'TSOEndClutch';
  CSODeviceIndicatorKZSection = 'TSOIndicatorKZ';
  CSODeviceTextSwitchSection = 'TSOTextSwitch';
  CSODeviceVacuumSwitchSection = 'TSOVacuumSwitch';
  CSODeviceDisconnectorSection = 'TSODisconnector';
  CSODeviceTransformer2Section = 'TSOTransformer2';
  CSODeviceThermometerSection = 'TSOThermometer';
  CSODeviceCartTNSection = 'TSOCartTN';
  CSODeviceFuseSection = 'TSOFuse';
  CSODeviceOilSwitchSection = 'TSOOilSwitch';
  CSODeviceRolloutSwitchSection = 'TSORolloutSwitch';
  CSODeviceVoltageIndicatorSection = 'TSOVoltageIndicator';
  CSODeviceGrounderSection = 'TSOGrounder';
  CSODeviceGroundSection = 'TSOGround';

  CSODeviceCartVVSection = 'TSOCartVV';
  CSODeviceSectionDisconnectorSection = 'TSOSectionDisconnector';
  CSODeviceFuseWithCartSection = 'TSOFuseWithCart';
  CSODeviceTwoChannelTextSwitchSection = 'TSOTwoChannelTextSwitch';

type

  { Базовый класс элемента подстанции (аналог TSOBase) }

  TSODevice = class
  protected
    FID: integer;   // идентификатор
    FGUID: string;  // глобальный уникальный идентификатор
    FCell: integer; // идентификатор ячейки
    FDescr: string; // описание
    FText: string;  // выводимый на подложке справа текст
    FDefSize: TSize; // размеры по умолчанию
    FRect: TRect; // координаты
    FAngle: integer; // угол поворота кратно 90
    //
    FDeviceColor: TColor; // цвет элемента
    FSelect: boolean; // признак выделения
    FSelectColor: TColor; // цвет выбранного элемента
    FRectColor: TColor; // цвет границы
    FRectShow: boolean; // рисовать рамку по границам элемента
    FCellShow: boolean; // рисовать номер ячейки в границах элемента
    FGUIDShow: boolean; // рисовать GUID элемента
    //
    function GetDeviceName: string; virtual; abstract;
    function GetDeviceSection: string; virtual; abstract;
    function GetID: integer;
    procedure SetID(AID: integer);
    function GetGUID: string;
    procedure SetGUID(AGUID: string);
    function GetCell: integer;
    procedure SetCell(ACell: integer);
    function GetDescr: string;
    procedure SetDescr(ADescr: string);
    function GetText: string;
    procedure SetText(AText: string);
    function GetDefSize: TSize;
    procedure SetDefSize(ADefSize: TSize);
    function GetRect: TRect;
    procedure SetRect(ARect: TRect);
    function GetAngle: integer;
    procedure SetAngle(AAngle: integer);
    //
    function GetDeviceColor: TColor;
    procedure SetDeviceColor(ADeviceColor: TColor);
    function GetSelect: boolean;
    procedure SetSelect(ASelect: boolean);
    function GetSelectColor: TColor;
    procedure SetSelectColor(ASelectColor: TColor);
    function GetRectColor: TColor;
    procedure SetRectColor(ARectColor: TColor);
    function GetRectShow: boolean;
    procedure SetRectShow(ARectShow: boolean);
    function GetCellShow: boolean;
    procedure SetCellShow(ACellShow: boolean);
    function GetGUIDShow: boolean;
    procedure SetGUIDShow(AGUIDShow: boolean);
  public
    constructor Create;
    //destructor Destroy(); override;
    procedure Draw(ADst: TCanvas); virtual; // рисует на Canvas
    function Check(AMemo: TMemo): boolean; virtual; // возвращает FALSE, если ошибка в данных, подробно в Memo

    procedure SaveToStrings(AStrings: TStrings); virtual; // сохраняет в список строк
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; virtual; // загружает из списка AStrings, сообщения в AReport, FALSE - ошибка

    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); virtual; // сохраняет значения полей в список строк
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); virtual; // загружает значения полей из списка строк
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); virtual; // заполняет Values значениями для KeyName

    procedure ValuesHelpToString(AStrings: TStrings); virtual; // сохраняет значения поля и их описания в список строк

    property DeviceName: string read GetDeviceName; // возвращает название типа элемента
    property DeviceSection: string read GetDeviceSection; // возвращает название ключа элемента (ClassName)
    property ID: integer read GetID write SetID;
    property GUID: string read FGUID write SetGUID;
    property Cell: integer read GetCell write SetCell;
    property Description: string read GetDescr write SetDescr;
    property Text: string read GetText write SetText;
    property DefSize: TSize read GetDefSize write SetDefSize;
    property Rect: TRect read GetRect write SetRect;
    property Angle: integer read GetAngle write SetAngle;
    //
    property DeviceColor: TColor read GetDeviceColor write SetDeviceColor;
    property Select: boolean read GetSelect write SetSelect;
    property SelectColor: TColor read GetSelectColor write SetSelectColor;
    property RectColor: TColor read GetRectColor write SetRectColor;
    property RectShow: boolean read GetRectShow write SetRectShow;
    property CellShow: boolean read GetCellShow write SetCellShow;
    property GUIDShow: boolean read GetGUIDShow write SetGUIDShow;
  end;

  { сборная шина }

  TSODeviceBus = class(TSODevice)
  protected
    FElectric: boolean;  // напряжение присутствует/отсутствует
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetElectric: integer;
    procedure SetElectric(AElectric: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Electric: integer read GetElectric write SetElectric;
  end;

  { коннектор сборной шины }

  TSODeviceBusConnector = class(TSODevice)
  protected
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
  end;

  { метка с номером ячейки  }

  TSODeviceCellLabel = class(TSODevice)
  protected
    FName: string;  // наименование
    FBorder: boolean; // рамка
    FRedMode: boolean; // красная подложка в режиме ТУ
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetName: string;
    procedure SetName(AName: string);
    function GetBorder: integer;
    procedure SetBorder(ABorder: integer);
    function GetRedMode: integer;
    procedure SetRedMode(ARedMode: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Name: string read GetName write SetName;
    property Border: integer read GetBorder write SetBorder;
    property RedMode: integer read GetRedMode write SetRedMode;
  end;

  { выключатель нагрузки  }

  TSODevicePowerSwitch = class(TSODevice)
  protected
    FConnected: boolean;
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
  end;

  { удлиннитель соединений }

  TSODeviceBridge = class(TSODevice)
  protected
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
  end;

  { земляной нож }

  TSODeviceGroundDisconnector = class(TSODevice)
  protected
    FConnected: boolean;
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
  end;

  { трансформатор напряжения измерительный }

  TSODeviceTransformer1 = class(TSODevice)
  private
    FActive: boolean;
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetActive: integer;
    procedure SetActive(AActive: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Active: integer read GetActive write SetActive;
  end;

  { метка (обычная) }

  TSODeviceLabel = class(TSODevice)
  protected
    FName: string;  // наименование
    FBorder: boolean; // рамка
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetName: string;
    procedure SetName(AName: string);
    function GetBorder: integer;
    procedure SetBorder(ABorder: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Name: string read GetName write SetName;
    property Border: integer read GetBorder write SetBorder;
  end;

  { разрыв линии }

  TSODeviceBreak = class(TSODevice)
  protected
    FBreaked: boolean;  // разорвана
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetBreaked: integer;
    procedure SetBreaked(ABreaked: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Active: integer read GetBreaked write SetBreaked;
  end;

  { концевая муфта }

  TSODeviceEndClutch = class(TSODevice)
  protected
    FElectric: boolean; // напряжение присутствует/отсутствует
    FGrounded: boolean; // заземлена / нет
    FShowParams: boolean; // отображать таблицу с током и напряжением
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetElectric: integer;
    procedure SetElectric(AElectric: integer);
    function GetGrounded(): integer;
    procedure SetGrounded(AGrounded: integer);
    function GetShowParams(): integer;
    procedure SetShowParams(AShowParams: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Electric: integer read GetElectric write SetElectric;
    property Grounded: integer read GetGrounded write SetGrounded;
    property ShowParams: integer read GetShowParams write SetShowParams;
  end;

  { индикатор короткого замыкания }

  TSODeviceIndicatorKZ = class(TSODevice)
  protected
    FConnected: boolean;
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
  end;

  { Руч.реж., ОЗЗ, ШР, ЛР, ...  }

  TSODeviceTextSwitch = class(TSODevice)
  protected
    FConnected: boolean; // true - надпись видна, false - скрыта
    FConnInvers: boolean; //
    FRedBack: boolean; // надпись имеет красный фон
    FName: string;
    FNameOff: string;
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
    function GetConnInvers: integer;
    procedure SetConnInvers(AConnInvers: integer);
    function GetRedBack: integer;
    procedure SetRedBack(ARedBack: integer);
    function GetName: string;
    procedure SetName(AName: string);
    function GetNameOff: string;
    procedure SetNameOff(ANameOff: string);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
    property ConnInvers: integer read GetConnInvers write SetConnInvers;
    property RedBack: integer read GetRedBack write SetRedBack;
    property Name: string read GetName write SetName;
    property NameOff: string read GetNameOff write SetNameOff;
  end;

  { вакуумный выключатель }

  TSODeviceVacuumSwitch = class(TSODevice)
  protected
    FConnected: boolean; // включен/выключен
    FCollected: boolean; // собран/разобран
    FElectric: boolean;  // напряжение присутствует/отсутствует
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
    function GetCollected: integer;
    procedure SetCollected(ACollected: integer);
    function GetElectric: integer;
    procedure SetElectric(AElectric: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
    property Collected: integer read GetCollected write SetCollected;
    property Electric: integer read GetElectric write SetElectric;
  end;

  { разъединитель РВ }

  TSODeviceDisconnector = class(TSODevice)
  protected
    FConnected: boolean; // включен/выключен
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
  end;

  { трансформатор напряжения измерительный с двумя вторичными обмотками }

  TSODeviceTransformer2 = class(TSODevice)
  private
    FActive: boolean;
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetActive: integer;
    procedure SetActive(AActive: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Active: integer read GetActive write SetActive;
  end;

  { термометр }

  TSODeviceThermometer = class(TSODevice)
  private
    FOuter: boolean; // true = наружный, false = внутренний
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetOuter: integer;
    procedure SetOuter(AOuter: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Outer: integer read GetOuter write SetOuter;
  end;

  { Тележка ТН }

  TSODeviceCartTN = class(TSODevice)
  protected
    FConnected: boolean; // включен/выключен
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
  end;

  { плавкий предохранитель }

  TSODeviceFuse = class(TSODevice)
  protected
    FConnected: boolean; // true = рабочий
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
  end;

  { масляный выключатель }

  TSODeviceOilSwitch = class(TSODevice)
  protected
    FConnected: boolean; // включен/выключен
    FCollected: boolean; // собран/разобран
    FElectric: boolean;  // напряжение присутствует/отсутствует
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
    function GetCollected: integer;
    procedure SetCollected(ACollected: integer);
    function GetElectric: integer;
    procedure SetElectric(AElectric: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
    property Collected: integer read GetCollected write SetCollected;
    property Electric: integer read GetElectric write SetElectric;
  end;

  { выкатной выключатель }

  TSODeviceRolloutSwitch = class(TSODevice)
  protected
    FConnected: boolean; // включен/выключен
    FCollected: boolean; // собран/разобран
    FElectric: boolean;  // напряжение присутствует/отсутствует
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
    function GetCollected: integer;
    procedure SetCollected(ACollected: integer);
    function GetElectric: integer;
    procedure SetElectric(AElectric: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
    property Collected: integer read GetCollected write SetCollected;
    property Electric: integer read GetElectric write SetElectric;
  end;

  { индикатор напряжения }

  TSODeviceVoltageIndicator = class(TSODevice)
  protected
    FConnected: boolean; // включен/выключен
    FConnInversion: boolean; //
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
    function GetConnInversion: integer;
    procedure SetConnInversion(AConnInversion: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
    property ConnInvers: integer read GetConnInversion write SetConnInversion;
  end;

  { переносное заземление, ЛЗН, ШЗН }

  TSODeviceGrounder = class(TSODevice)
  protected
    FNumber: integer;
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetNumber: integer;
    procedure SetNumber(ANumber: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Number: integer read GetNumber write SetNumber;
  end;

  { заземление (ГОСТ) }

  TSODeviceGround = class(TSODevice)
  protected
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
  end;

  { Тележка BB }

  TSODeviceCartVV = class(TSODevice)
  protected
    FConnected: boolean; // включен/выключен
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
  end;

  { Секционный разъединитель с тележкой }

  TSODeviceSectionDisconnector = class(TSODevice)
  protected
    FConnected: boolean; // включен/выключен
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
  end;

  { Предохранитель с тележкой }

  TSODeviceFuseWithCart  = class(TSODevice)
  protected
    FConnected: boolean; // включен/выключен
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
  end;

  { Текстовый выключатель с двумя каналами }

  TSODeviceTwoChannelTextSwitch = class(TSODevice)
  protected
    FConnected: boolean; // true - надпись видна, false - скрыта
    FConnInvers: boolean; //
    FRedBack: boolean; // надпись имеет красный фон
    FName: string;
    FNameOff: string;
    function GetDeviceName: string; override;
    function GetDeviceSection: string; override;
    function GetConnected: integer;
    procedure SetConnected(AConnected: integer);
    function GetConnInvers: integer;
    procedure SetConnInvers(AConnInvers: integer);
    function GetRedBack: integer;
    procedure SetRedBack(ARedBack: integer);
    function GetName: string;
    procedure SetName(AName: string);
    function GetNameOff: string;
    procedure SetNameOff(ANameOff: string);
  public
    constructor Create;
    procedure Draw(ADst: TCanvas); override;
    function Check(AMemo: TMemo): boolean; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    function LoadFromStringList(AStrings: TStrings; var AReport: string): boolean; override;
    procedure ValuesToListEditor(AValueListEditor: TValueListEditor); override;
    procedure ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize); override;
    procedure ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings); override;
    procedure ValuesHelpToString(AStrings: TStrings); override;
    property Connected: integer read GetConnected write SetConnected;
    property ConnInvers: integer read GetConnInvers write SetConnInvers;
    property RedBack: integer read GetRedBack write SetRedBack;
    property Name: string read GetName write SetName;
    property NameOff: string read GetNameOff write SetNameOff;
  end;

  { TSODeviceList - Класс для хранения элементов подстанции }

  TSODeviceList = TObjectList<TSODevice>;

{ вспомогательные функции }

function PointRotate(AP, ACP: TPoint; AAngle: integer): TPoint; // вращение точки AP вокруг ACP на угол AAngle, градусы: 0 - вниз, вращение по часовой
procedure FindMinMax(var x1, y1, x2, y2: integer; const Ap: array of TPoint); // координаты для рисования окружности
function LoadStrToInt(ASrc: string): integer;

implementation

{ TSODevice }

constructor TSODevice.Create;
begin
  inherited;
  FID:=0;
  FGUID:='';
  FCell:=0;
  FDescr:='';
  FText:='';
  FDefSize:=TSize.Create(20, 40);
  FRect:=TRect.Create(0, 0, 20, 40);
  FAngle:=0;
  //
  FDeviceColor:=CSODeviceDefColor;
  // FBackColor: TColor; // цвет фона
  FSelect:=false;
  FSelectColor:=CSODeviceSelectColor;
  FRectColor:=CSODeviceRectColor;
  FRectShow:=VTPOptions.RectShow; // false;
  FCellShow:=VTPOptions.CellShow; // false;
  FGUIDShow:=VTPOptions.GUIDShow; // false;
end;

function TSODevice.GetID: integer;
begin
  Result:=FID;
end;

procedure TSODevice.SetID(AID: integer);
begin
  FID:=AID;
end;

function TSODevice.GetGUID: string;
begin
  Result:=FGUID;
end;

procedure TSODevice.SetGUID(AGUID: string);
begin
  FGUID:=AGUID;
end;

function TSODevice.GetCell: integer;
begin
  Result:=FCell;
end;

procedure TSODevice.SetCell(ACell: integer);
begin
  FCell:=ACell;
end;

function TSODevice.GetDescr: string;
begin
  Result:=FDescr;
end;

procedure TSODevice.SetDescr(ADescr: string);
begin
  FDescr:=ADescr;
end;

function TSODevice.GetText: string;
begin
  Result:=FText;
end;

procedure TSODevice.SetText(AText: string);
begin
  FText:=AText;
end;

function TSODevice.GetDefSize: TSize;
begin
  Result:=FDefSize;
end;

procedure TSODevice.SetDefSize(ADefSize: TSize);
begin
  FDefSize:=ADefSize;
end;

function TSODevice.GetRect: TRect;
begin
  Result:=FRect;
end;

procedure TSODevice.SetRect(ARect: TRect);
begin
  // прямоугольник уже сформирован под нужный угол
  FRect:=ARect;
end;

function TSODevice.GetAngle: integer;
begin
  Result:=FAngle;
end;

procedure TSODevice.SetAngle(AAngle: integer);
var
  a: integer;
begin
  // взято из function TSOBase.GetNormalizedAngle(): integer;
  // угол поворота => [0, 90, 180, 270]
  // приводим угол к значеню [0; 360)
  a:=AAngle;
  while (a < 0) do a := a + 360;
  a := Round(a) mod 360;
  // дальше приводим к значению из набора [0, 90, 180, 270]
  if (a <= 45) or (a > 315) then
    FAngle := 0
  else if (a > 45) and (a <= 135) then
    FAngle := 90
  else if (a > 135) and (a <= 225) then
    FAngle:=180
  else
    FAngle:=270;

  // прямоугольник формируется отдельно
end;

function TSODevice.GetDeviceColor: TColor;
begin
  Result:=FDeviceColor;
end;

procedure TSODevice.SetDeviceColor(ADeviceColor: TColor);
begin
  FDeviceColor:=ADeviceColor;
end;

function TSODevice.GetSelect: boolean;
begin
  Result:=FSelect;
end;

procedure TSODevice.SetSelect(ASelect: boolean);
begin
  FSelect:=ASelect;
end;

function TSODevice.GetSelectColor: TColor;
begin
  Result:=FSelectColor;
end;

procedure TSODevice.SetSelectColor(ASelectColor: TColor);
begin
  FSelectColor:=ASelectColor;
end;

function TSODevice.GetRectColor: TColor;
begin
  Result:=FRectColor;
end;

procedure TSODevice.SetRectColor(ARectColor: TColor);
begin
  FRectColor:=ARectColor;
end;

function TSODevice.GetRectShow: boolean;
begin
  Result:=FRectShow;
end;

procedure TSODevice.SetRectShow(ARectShow: boolean);
begin
  FRectShow:=ARectShow;
end;

function TSODevice.GetCellShow: boolean;
begin
  Result:=FCellShow;
end;

procedure TSODevice.SetCellShow(ACellShow: boolean);
begin
  FCellShow:=ACellShow;
end;

function TSODevice.GetGUIDShow: boolean;
begin
  Result:=FGUIDShow;
end;

procedure TSODevice.SetGUIDShow(AGUIDShow: boolean);
begin
  FGUIDShow:=AGUIDShow;
end;

procedure TSODevice.Draw(ADst: TCanvas);
begin
  // фон, если выбран
  if Select then
  begin
    ADst.Pen.Mode:=pmCopy;
    ADst.Pen.Style:=psSolid;
    ADst.Pen.Width:=1;
    ADst.Pen.Color:=SelectColor;
    ADst.Brush.Style:=bsSolid;
    ADst.Brush.Color:=SelectColor;
    ADst.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
  end;

  // рамка по границам элемента
  if RectShow then
  begin
    ADst.Pen.Mode:=pmCopy;
    ADst.Pen.Style:=psSolid;
    ADst.Pen.Width:=1;
    ADst.Pen.Color:=DeviceColor;
    ADst.Brush.Style:=bsClear;
    //ADst.Brush.Color:=VTPOptions.TPColor;
    ADst.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
  end;

  // номер ячейки в границах элемента
  if CellShow then
  begin
    ADst.Pen.Mode:=pmCopy;
    ADst.Pen.Style:=psClear;
    ADst.Pen.Width:=1;
    ADst.Pen.Color:=DeviceColor;
    ADst.Brush.Style:=bsClear;
    //ADst.Brush.Color:=DeviceColor;

    ADst.Font.Color:=CSODeviceCellColor; //DeviceColor;
    ADst.Font.Charset:=DEFAULT_CHARSET;
    ADst.Font.Name:='Arial';
    ADst.Font.Style:=[];
    ADst.Font.Height:=-round(10);
  {
    GetObject(ADst.Font.Handle, SizeOf(LogRec), Addr(LogRec)); // „итаем текущюю инф. о шрифте
    LogRec.lfEscapement:=round(RadToDeg(FAngle)*10); // »змен¤ем угол
    LogRec.lfOrientation:=round(RadToDeg(FAngle)*10); // »змен¤ем угол
    ADst.Font.Handle:=CreateFontIndirect(LogRec); // ”станавливаем новые параметры
  }
    ADst.TextOut(Rect.Left, Rect.Top, IntToStr(Cell));
  end;

  // GUID ячейки
  if GUIDShow then
  begin
    ADst.Pen.Mode:=pmCopy;
    ADst.Pen.Style:=psClear;
    ADst.Pen.Width:=1;
    ADst.Pen.Color:=DeviceColor;
    ADst.Brush.Style:=bsClear;
    //ADst.Brush.Color:=DeviceColor;

    ADst.Font.Color:=CSODeviceCellColor; //DeviceColor;
    ADst.Font.Charset:=DEFAULT_CHARSET;
    ADst.Font.Name:='Arial';
    ADst.Font.Style:=[];
    ADst.Font.Height:=-round(10);
  {
    GetObject(ADst.Font.Handle, SizeOf(LogRec), Addr(LogRec)); // „итаем текущюю инф. о шрифте
    LogRec.lfEscapement:=round(RadToDeg(FAngle)*10); // »змен¤ем угол
    LogRec.lfOrientation:=round(RadToDeg(FAngle)*10); // »змен¤ем угол
    ADst.Font.Handle:=CreateFontIndirect(LogRec); // ”станавливаем новые параметры
  }
    ADst.TextOut(Rect.Left, Rect.Top, Copy(GUID, 1, 8));
  end;
end;

function TSODevice.Check(AMemo: TMemo): boolean;
begin
  Result:=true;
  if (Description = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s (яч. %d) - не задано описание', [DeviceName, Cell]));
  end;
end;

procedure TSODevice.SaveToStrings(AStrings: TStrings);
begin
  AStrings.Add(' ');
  AStrings.Add(Format('[%s]', [DeviceSection]));
  AStrings.Add(Format('GUID:%s', [GUID]));
  AStrings.Add(Format('Cell:%d', [Cell]));
  AStrings.Add(Format('Description:%s', [Description]));
  AStrings.Add(Format('Text:%s', [Text]));
  AStrings.Add(Format('Left:%d', [Rect.Left]));
  AStrings.Add(Format('Top:%d', [Rect.Top]));
  AStrings.Add(Format('Width:%d', [Rect.Width]));
  AStrings.Add(Format('Height:%d', [Rect.Height]));
  AStrings.Add(Format('Angle:%d', [Angle]));
end;

function TSODevice.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=true;
  try
    GUID:=AStrings.Values['GUID'];
    Cell:=LoadStrToInt(AStrings.Values['Cell']);
    Description:=AStrings.Values['Description'];
    Text:=AStrings.Values['Text'];
    FRect.Left:=LoadStrToInt(AStrings.Values['Left']);
    FRect.Top:=LoadStrToInt(AStrings.Values['Top']);
    FRect.Width:=LoadStrToInt(AStrings.Values['Width']);
    FRect.Height:=LoadStrToInt(AStrings.Values['Height']);
    Angle:=LoadStrToInt(AStrings.Values['Angle']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODevice.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  AValueListEditor.Values['GUID']:=GUID;
  AValueListEditor.ItemProps['GUID'].EditStyle:=esEllipsis;
//  AValueListEditor.ItemProps['GUID'].ReadOnly:=true; // запрещено у всех, изменяется в специальном диалоговом окне

  AValueListEditor.Values['Cell']:=IntToStr(Cell);
  AValueListEditor.ItemProps['Cell'].EditMask:='###';
  AValueListEditor.ItemProps['Cell'].MaxLength:=3;

  AValueListEditor.Values['Description']:=Description;
  // запретить редактирование у каждого элемента индивидуально

  AValueListEditor.Values['Text']:=Text;
  // запретить редактирование у каждого элемента индивидуально

  AValueListEditor.Values['Left']:=IntToStr(Rect.Left);
  AValueListEditor.ItemProps['Left'].ReadOnly:=true; // запрещено у всех, изменяется в редакторе

  AValueListEditor.Values['Top']:=IntToStr(Rect.Top);
  AValueListEditor.ItemProps['Top'].ReadOnly:=true; // запрещено у всех, изменяется в редакторе

  AValueListEditor.Values['Width']:=IntToStr(Rect.Width);
  AValueListEditor.ItemProps['Width'].ReadOnly:=true; // разрешить редактирование у каждого элемента индивидуально

  AValueListEditor.Values['Height']:=IntToStr(Rect.Height);
  AValueListEditor.ItemProps['Height'].ReadOnly:=true; // разрешить редактирование у каждого элемента индивидуально

  AValueListEditor.Values['Angle']:=IntToStr(Angle);
  AValueListEditor.ItemProps['Angle'].ReadOnly:=true; // запрещено у всех, изменяется в редакторе
end;

procedure TSODevice.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
const
  // паттерн GUID
  CGUIDPattern = '^[0-9A-Fa-f]{8}\-[0-9A-Fa-f]{4}\-[0-9A-Fa-f]{4}\-[0-9A-Fa-f]{4}\-[0-9A-Fa-f]{12}$';
var
  r: TRect;
  f: boolean;
  s: string;
  RegEx: TRegEx;
begin
  if not AValueListEditor.ItemProps['GUID'].ReadOnly then
  begin
    s:=AValueListEditor.Values['GUID'];
    // пустая строка, либо GUID
    if (s='') or RegEx.IsMatch(s, CGUIDPattern) then
      GUID:=s
    else
      raise Exception.CreateFmt('GUID={%s} не соответствует формату GUID',[s]);
  end;

  if not AValueListEditor.ItemProps['Cell'].ReadOnly then
    Cell:=LoadStrToInt(AValueListEditor.Values['Cell']);
  if (Cell < 0) then
    raise Exception.CreateFmt('Cell=%d < 0',[Cell]);

  if not AValueListEditor.ItemProps['Description'].ReadOnly then
    Description:=AValueListEditor.Values['Description'];

  if not AValueListEditor.ItemProps['Text'].ReadOnly then
    Text:=AValueListEditor.Values['Text'];

  f:=false;
  r:=Rect;

  if not AValueListEditor.ItemProps['Left'].ReadOnly then
  begin
    r.Left:=LoadStrToInt(AValueListEditor.Values['Left']);
    f:=true;
  end;

  if not AValueListEditor.ItemProps['Top'].ReadOnly then
  begin
    r.Top:=LoadStrToInt(AValueListEditor.Values['Top']);
    f:=true;
  end;

  if not AValueListEditor.ItemProps['Width'].ReadOnly then
  begin
    r.Width:=LoadStrToInt(AValueListEditor.Values['Width']);
    f:=true;
  end;
  if (r.Width < 1) then
    raise Exception.CreateFmt('Ширина Width=%d < 1',[r.Width]);
  if (r.Width > ASize.Width) then
    raise Exception.CreateFmt('Ширина Width=%d > %d',[r.Width, ASize.Width]);

  if not AValueListEditor.ItemProps['Height'].ReadOnly then
  begin
    r.Height:=LoadStrToInt(AValueListEditor.Values['Height']);
    f:=true;
  end;
  if (r.Height < 1) then
    raise Exception.CreateFmt('Высота Height=%d < 1',[r.Height]);
  if (r.Height > ASize.Height) then
    raise Exception.CreateFmt('Высота Height=%d > %d',[r.Height, ASize.Height]);

  if f then Rect:=r;

  if not AValueListEditor.ItemProps['Angle'].ReadOnly then
    Angle:=LoadStrToInt(AValueListEditor.Values['Angle']);
  if (Angle < 0) then
    raise Exception.CreateFmt('Angle=%d < 0',[Angle]);

end;

procedure TSODevice.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin

end;

procedure TSODevice.ValuesHelpToString(AStrings: TStrings);
begin
  AStrings.Add('GUID - Глобальный уникальный идентификатор. Представляет собой значение поля Guid из таблицы dbo.Devices или dbo.ShemaElements для соответствующего устройства.');
  AStrings.Add(' ');
  AStrings.Add('Cell - Идентификатор ячейки ТП. Заполняется в соответствии с принципиальной или нормальной схемой ТП.');
  AStrings.Add(' ');
  AStrings.Add('Description - Описание элемента. Представляет собой название элемента (Сборная шина, Соединение к шине и т.п.). На схеме Телесистемы не показывается.');
  AStrings.Add(' ');
  AStrings.Add('Text - Выводимый на подложке справа текст. Обычно марка или тип применяемого оборудования. Для схемы Телесистемы не применяется.');
  AStrings.Add(' ');
  AStrings.Add('Left - Координата по оси абсцисс (X) левого верхнего угла элемента в пикселах. Ось направлена слева направо. Вручную не редактируется.');
  AStrings.Add(' ');
  AStrings.Add('Top - Координата по оси ординат (Y) левого верхнего угла элемента в пикселах. Ось направлена сверху вниз. Вручную не редактируется.');
  AStrings.Add(' ');
  AStrings.Add('Width - Ширина элемента в пикселах.');
  AStrings.Add(' ');
  AStrings.Add('Height - Высота элемента в пикселах.');
  AStrings.Add(' ');
  AStrings.Add('Angle - Угол поворота кратно 90. Положительное направление углов по часовой стрелке. Вручную не редактируется.');
  AStrings.Add(' ');
end;

{ TSODeviceBus }

constructor TSODeviceBus.Create;
begin
  inherited;
  FDefSize:=TSize.Create(200, 20);
  FRect:=TRect.Create(0, 0, 200, 20);
  FAngle:=0;
  FDeviceColor:=CSODeviceBusColor;

  GUID:='';
  Cell:=0;
  Description:='Сборная шина';
  Text:='';
  FElectric:=false;
end;

function TSODeviceBus.GetDeviceName: string;
begin
  Result:='СШ';
end;

function TSODeviceBus.GetDeviceSection: string;
begin
  Result:=CSODeviceBusSection; // Result:=Self.ClassName;
end;

procedure TSODeviceBus.Draw(ADst: TCanvas);
const
  offset: integer = 5;
  thickness: integer = 10;
var
  i, w, h, dL, dT: integer;
  p: array of TPoint;
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p, 4);
  // строим точки под угол 0 относительно 0:0
  p[0]:=TPoint.Create(Rect.Left+offset, Rect.Top+offset);
  p[1]:=TPoint.Create(Rect.Left+w-offset, Rect.Top+offset);
  p[2]:=TPoint.Create(Rect.Left+w-offset, Rect.Top+offset+thickness);
  p[3]:=TPoint.Create(Rect.Left+offset, Rect.Top+offset+thickness);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
    for i:=0 to Length(p)-1 do
    begin
      p[i]:=PointRotate(p[i], Rect.TopLeft, Angle);
      p[i].X:=p[i].X+dL;
      p[i].Y:=p[i].Y+dT;
    end;

  // рисуем
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=1;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polygon(p);

  SetLength(p, 0);
end;

function TSODeviceBus.GetElectric: integer;
begin
  if FElectric then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceBus.SetElectric(AElectric: integer);
begin
  FElectric:=AElectric <> 0;
end;

procedure TSODeviceBus.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Electric:%d', [Electric]));
end;

function TSODeviceBus.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Electric:=LoadStrToInt(AStrings.Values['Electric']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceBus.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.ItemProps['Width'].ReadOnly:=false;

  AValueListEditor.ItemProps['Height'].ReadOnly:=false;

  AValueListEditor.Values['Electric']:=IntToStr(Electric);
  AValueListEditor.ItemProps['Electric'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Electric'].ReadOnly:=true;
end;

procedure TSODeviceBus.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;

  if (Rect.Width < 10) then
    raise Exception.CreateFmt('Ширина Width=%d < 10',[Rect.Width]);

  if (Rect.Height < 10) then
    raise Exception.CreateFmt('Высота Width=%d < 10',[Rect.Height]);

  //if not AValueListEditor.ItemProps['Electric'].ReadOnly then
    Electric:=LoadStrToInt(AValueListEditor.Values['Electric']);
end;

procedure TSODeviceBus.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Electric') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceBus.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Electric - Напряжение присутствует/отсутствует. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceBusConnector }

constructor TSODeviceBusConnector.Create;
begin
  inherited;
  FDefSize:=TSize.Create(10, 20);
  FRect:=TRect.Create(0, 0, 10, 20);
  FAngle:=0;
  FDeviceColor:=CSODeviceBusConnColor;

  GUID:='';
  Cell:=1;
  Description:='Соединение к шине';
  Text:='';
end;

function TSODeviceBusConnector.GetDeviceName: string;
begin
  Result:='Соед. СШ';
end;

function TSODeviceBusConnector.GetDeviceSection: string;
begin
  Result:=CSODeviceBusConnectorSection;
end;

procedure TSODeviceBusConnector.Draw(ADst: TCanvas);
const
  offset: integer = 5;
  thickness: integer = 10;
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2: integer;
  p, p1: array of TPoint;
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p, 4);
  SetLength(p1, 2);
  // строим точки под угол 0 относительно 0:0
  p[0]:=TPoint.Create(Rect.Left, Rect.Top);
  p[1]:=TPoint.Create(Rect.Left+w, Rect.Top);
  p[2]:=TPoint.Create(Rect.Left+w, Rect.Top+thickness);
  p[3]:=TPoint.Create(Rect.Left, Rect.Top+thickness);

  p1[0]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+thickness);
  p1[1]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+h);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p)-1 do
    begin
      p[i]:=PointRotate(p[i], Rect.TopLeft, Angle);
      p[i].X:=p[i].X+dL;
      p[i].Y:=p[i].Y+dT;
    end;
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
  end;

  // ищем минимум
  x1:=p[0].X;
  y1:=p[0].Y;
  x2:=p[0].X;
  y2:=p[0].Y;
  for i:=1 to Length(p)-1 do
  begin
    x1:=Min(x1, p[i].X);
    y1:=Min(y1, p[i].Y);
    x2:=Max(x2, p[i].X);
    y2:=Max(y2, p[i].Y);
  end;

  // рисуем
  // линия
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=CSODeviceBusColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=CSODeviceBusColor;
  ADst.MoveTo(p1[0].X, p1[0].Y);
  ADst.LineTo(p1[1].X, p1[1].Y);

  // окружность
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=1;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  SetLength(p, 0);
  SetLength(p1, 0);
end;

{ TSODeviceCellLabel }

constructor TSODeviceCellLabel.Create;
begin
  inherited;
  FDefSize:=TSize.Create(25, 30);
  FRect:=TRect.Create(0, 0, FDefSize.Width, FDefSize.Height);
//  FDefSize:=TSize.Create(20, 12);
//  FRect:=TRect.Create(0, 0, 20, 12);
  FAngle:=0;
  FDeviceColor:=CSODeviceCellLabelColor;

  GUID:='';
  Cell:=1;
  Description:='Метка с номером ячейки';
  Text:='';
  Name:='1';
  FBorder:=false;
  FRedMode:=false;
end;

function TSODeviceCellLabel.GetDeviceName: string;
begin
  Result:='Метка яч.';
end;

function TSODeviceCellLabel.GetDeviceSection: string;
begin
  Result:=CSODeviceCellLabelSection;
end;

procedure TSODeviceCellLabel.Draw(ADst: TCanvas);
const
  thickness: integer = 3;
var
  i, w, h, dL, dT: integer;
  p: array of TPoint;
  tw: integer;
  sh: single;
  LogRec: TLogFont;
  rr: TPoint;
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p, 4);
  // строим точки под угол 0 относительно 0:0
  p[0]:=TPoint.Create(Rect.Left, Rect.Top);
  p[1]:=TPoint.Create(Rect.Left+w, Rect.Top);
  p[2]:=TPoint.Create(Rect.Left+w, Rect.Top+h);
  p[3]:=TPoint.Create(Rect.Left, Rect.Top+h);

  // высота символа
  ADst.Font.Charset:=DEFAULT_CHARSET;
  ADst.Font.Name:='Arial';
  ADst.Font.Style:=[];

  GetObject(ADst.Font.Handle, SizeOf(LogRec), Addr(LogRec)); // читаем текущюю инф. о шрифте
  LogRec.lfEscapement:=0; // измен¤ем угол
  LogRec.lfOrientation:=0; // измен¤ем угол
  ADst.Font.Handle:=CreateFontIndirect(LogRec); // устанавливаем новые параметры

  sh:=h*0.8;
  repeat
    ADst.Font.Height:=-round(sh);
    tw:=ADst.TextWidth(Name);
    if (tw = 0) then tw:=1;
    if (tw > w) then sh:=sh*w/tw;
  until (tw <= w);
  // координаты строк
  rr:=TPoint.Create(Rect.Left+w div 2-ADst.TextWidth(Name) div 2, Rect.Top+h div 2-ADst.TextHeight(Name) div 2);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p)-1 do
    begin
      p[i]:=PointRotate(p[i], Rect.TopLeft, Angle);
      p[i].X:=p[i].X+dL;
      p[i].Y:=p[i].Y+dT;
    end;

    rr:=PointRotate(rr, Rect.TopLeft, Angle);
    rr.X:=rr.X+dL;
    rr.Y:=rr.Y+dT;
  end;

  // рисуем

  // рамка или красный режим
  if (Border <> 0) or (RedMode <> 0) then
  begin
    ADst.Pen.Mode:=pmCopy;
    ADst.Pen.Style:=psSolid;
    ADst.Pen.Width:=thickness;
    if (Border <> 0) then
      ADst.Pen.Color:=DeviceColor
    else
      ADst.Pen.Color:=CSODeviceRedModeColor;
    if (RedMode <> 0) then
    begin
      ADst.Brush.Style:=bsSolid;
      ADst.Brush.Color:=CSODeviceRedModeColor;
    end else
    begin
      ADst.Brush.Style:=bsClear;
      // ADst.Brush.Color:=DeviceColor;
    end;
    ADst.Polygon(p);
  end;

  // текст
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psClear;
  ADst.Pen.Width:=thickness;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;

  ADst.Font.Color:=DeviceColor;

  GetObject(ADst.Font.Handle, SizeOf(LogRec), Addr(LogRec)); // читаем текущюю инф. о шрифте
  LogRec.lfEscapement:=-round(Angle*10); // изменяем угол
  LogRec.lfOrientation:=-round(Angle*10); // изменяем угол
  ADst.Font.Handle:=CreateFontIndirect(LogRec); // устанавливаем новые параметр

  ADst.TextOut(rr.X, rr.Y, Name);

  SetLength(p, 0);
end;

function TSODeviceCellLabel.GetName: string;
begin
  Result:=FName;
end;

procedure TSODeviceCellLabel.SetName(AName: string);
begin
  FName:=AName;
end;

function TSODeviceCellLabel.GetBorder: integer;
begin
  if FBorder then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceCellLabel.SetBorder(ABorder: integer);
begin
  FBorder:=ABorder <> 0;
end;

function TSODeviceCellLabel.GetRedMode: integer;
begin
  if FRedMode then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceCellLabel.SetRedMode(ARedMode: integer);
begin
  FRedMode:=ARedMode <> 0;
end;

function TSODeviceCellLabel.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (Name = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d) - не задано наименование', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceCellLabel.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Name:%s', [Name]));
  AStrings.Add(Format('Border:%d', [Border]));
  AStrings.Add(Format('RedMode:%d', [RedMode]));
end;

function TSODeviceCellLabel.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Name:=AStrings.Values['Name'];
    Border:=LoadStrToInt(AStrings.Values['Border']);
    RedMode:=LoadStrToInt(AStrings.Values['RedMode']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceCellLabel.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.ItemProps['Width'].ReadOnly:=false;
  AValueListEditor.ItemProps['Height'].ReadOnly:=false;

  AValueListEditor.Values['Name']:=Name;

  AValueListEditor.Values['Border']:=IntToStr(Border);
  AValueListEditor.ItemProps['Border'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Border'].ReadOnly:=true;

  AValueListEditor.Values['RedMode']:=IntToStr(RedMode);
  AValueListEditor.ItemProps['RedMode'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['RedMode'].ReadOnly:=true;
end;

procedure TSODeviceCellLabel.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Name'].ReadOnly then
    Name:=AValueListEditor.Values['Name'];

  //if not AValueListEditor.ItemProps['Border'].ReadOnly then
    Border:=LoadStrToInt(AValueListEditor.Values['Border']);

  //if not AValueListEditor.ItemProps['RedMode'].ReadOnly then
    RedMode:=LoadStrToInt(AValueListEditor.Values['RedMode']);
end;

procedure TSODeviceCellLabel.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Border') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;

  if (KeyName = 'RedMode') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceCellLabel.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Name - Наименование.');
  AStrings.Add(' ');
  AStrings.Add('Border - Рамка. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('RedMode - Красная подложка в режиме ТУ. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODevicePowerSwitch  }

constructor TSODevicePowerSwitch.Create;
begin
  inherited;
  FDefSize:=TSize.Create(20, 40);
  FRect:=TRect.Create(0, 0, 20, 40);
  FAngle:=0;
  FDeviceColor:=CSODevicePowerSwitchColor;

  GUID:='';
  Cell:=1;
  Description:='ВНВР';
  Text:='';
  FConnected:=true;
end;

function TSODevicePowerSwitch.GetDeviceName: string;
begin
  Result:='ВН';
end;

function TSODevicePowerSwitch.GetDeviceSection: string;
begin
  Result:=CSODevicePowerSwitchSection;
end;

procedure TSODevicePowerSwitch.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2: integer;
  p1, // верхняя палка
  p2, // верхний круг
  p3, // перекладина
  p4, // шарик
  p5, // нижняя палка
  p6: array of TPoint; // нижний круг
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 4);
  SetLength(p3, 2);
  SetLength(p4, 4);
  SetLength(p5, 2);
  SetLength(p6, 4);
  // строим точки под угол 0 относительно 0:0
  p1[0]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+4);
  p1[1]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+12);

  p2[0]:=TPoint.Create(Rect.Left+w div 2-3, Rect.Top);
  p2[1]:=TPoint.Create(Rect.Left+w div 2+3, Rect.Top);
  p2[2]:=TPoint.Create(Rect.Left+w div 2+3, Rect.Top+6);
  p2[3]:=TPoint.Create(Rect.Left+w div 2-3, Rect.Top+6);

  p3[0]:=TPoint.Create(Rect.Left+w div 2-5, Rect.Top+12);
  p3[1]:=TPoint.Create(Rect.Left+w div 2+5, Rect.Top+12);

  p4[0]:=TPoint.Create(Rect.Left+w div 2-4, Rect.Top+12);
  p4[1]:=TPoint.Create(Rect.Left+w div 2+4, Rect.Top+12);
  p4[2]:=TPoint.Create(Rect.Left+w div 2+4, Rect.Top+18);
  p4[3]:=TPoint.Create(Rect.Left+w div 2-4, Rect.Top+18);

  p5[0]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+18);
  p5[1]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+40);

  p6[0]:=TPoint.Create(Rect.Left+w div 2-3, Rect.Top+34);
  p6[1]:=TPoint.Create(Rect.Left+w div 2+3, Rect.Top+34);
  p6[2]:=TPoint.Create(Rect.Left+w div 2+3, Rect.Top+40);
  p6[3]:=TPoint.Create(Rect.Left+w div 2-3, Rect.Top+40);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;
    for i:=0 to Length(p5)-1 do
    begin
      p5[i]:=PointRotate(p5[i], Rect.TopLeft, Angle);
      p5[i].X:=p5[i].X+dL;
      p5[i].Y:=p5[i].Y+dT;
    end;
    for i:=0 to Length(p6)-1 do
    begin
      p6[i]:=PointRotate(p6[i], Rect.TopLeft, Angle);
      p6[i].X:=p6[i].X+dL;
      p6[i].Y:=p6[i].Y+dT;
    end;
  end;

  // рисуем
  // верхняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p1[0].X, p1[0].Y);
  ADst.LineTo(p1[1].X, p1[1].Y);

  // верхний круг
  FindMinMax(x1, y1, x2, y2, p2);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  // перекладина
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p3[0].X, p3[0].Y);
  ADst.LineTo(p3[1].X, p3[1].Y);

  // шарик
  FindMinMax(x1, y1, x2, y2, p4);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
//  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  // нижняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p5[0].X, p5[0].Y);
  ADst.LineTo(p5[1].X, p5[1].Y);

  // нижний круг
  FindMinMax(x1, y1, x2, y2, p6);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
  SetLength(p5, 0);
  SetLength(p6, 0);
end;

function TSODevicePowerSwitch.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODevicePowerSwitch.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODevicePowerSwitch.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODevicePowerSwitch.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
end;

function TSODevicePowerSwitch.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODevicePowerSwitch.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;
end;

procedure TSODevicePowerSwitch.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);
end;

procedure TSODevicePowerSwitch.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODevicePowerSwitch.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Включен/отключен. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceBridge }

constructor TSODeviceBridge.Create;
begin
  inherited;
  FDefSize:=TSize.Create(10, 30);
  FRect:=TRect.Create(0, 0, 10, 30);
  FAngle:=0;
  FDeviceColor:=CSODeviceBridgeColor;

  GUID:='';
  Cell:=1;
  Description:='Перемычка';
  Text:='';
end;

function TSODeviceBridge.GetDeviceName: string;
begin
  Result:='Перем.';
end;

function TSODeviceBridge.GetDeviceSection: string;
begin
  Result:=CSODeviceBridgeSection;
end;

procedure TSODeviceBridge.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  p1: array of TPoint;
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  // строим точки под угол 0 относительно 0:0
  p1[0]:=TPoint.Create(Rect.Left+w div 2, Rect.Top);
  p1[1]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+h);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
  end;

  // рисуем
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p1[0].X, p1[0].Y);
  ADst.LineTo(p1[1].X, p1[1].Y);

  SetLength(p1, 0);
end;

procedure TSODeviceBridge.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.ItemProps['Width'].ReadOnly:=false;

  AValueListEditor.ItemProps['Height'].ReadOnly:=false;
end;

procedure TSODeviceBridge.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;

  if (Rect.Width < 3) then
    raise Exception.CreateFmt('Ширина Width=%d < 3',[Rect.Width]);

  if (Rect.Height < 3) then
    raise Exception.CreateFmt('Высота Width=%d < 3',[Rect.Height]);
end;

{ TSODeviceGroundDisconnector }

constructor TSODeviceGroundDisconnector.Create;
begin
  inherited;
  FDefSize:=TSize.Create(25, 50);
  FRect:=TRect.Create(0, 0, 25, 50);
  FAngle:=0;
  FDeviceColor:=CSODeviceGroundDisconnectorColor;

  GUID:='';
  Cell:=1;
  Description:='Земляной нож';
  Text:='';
  FConnected:=false;
end;

function TSODeviceGroundDisconnector.GetDeviceName: string;
begin
  Result:='ЗН';
end;

function TSODeviceGroundDisconnector.GetDeviceSection: string;
begin
  Result:=CSODeviceGroundDisconnectorSection;
end;

procedure TSODeviceGroundDisconnector.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2: integer;
  p1, // верхн палка
  p2, // верх. круг
  p3, // перекладина
  p4, // нижняя ломаная
  p5, // заземление
  p6, // заземление
  p7: array of TPoint; // заземление
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 4);
  SetLength(p3, 2);
  SetLength(p4, 3);
  SetLength(p5, 2);
  SetLength(p6, 2);
  SetLength(p7, 2);

  // строим точки под угол 0 относительно 0:0
  p1[0]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+4);
  p1[1]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+12);

  p2[0]:=TPoint.Create(Rect.Left+w div 2-3, Rect.Top);
  p2[1]:=TPoint.Create(Rect.Left+w div 2+3, Rect.Top);
  p2[2]:=TPoint.Create(Rect.Left+w div 2+3, Rect.Top+6);
  p2[3]:=TPoint.Create(Rect.Left+w div 2-3, Rect.Top+6);

  p3[0]:=TPoint.Create(Rect.Left+w div 2-7, Rect.Top+12);
  p3[1]:=TPoint.Create(Rect.Left+w div 2+7, Rect.Top+12);

  p4[0]:=TPoint.Create(Rect.Left+w div 2+10, Rect.Top+14);
  p4[1]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+24);
  p4[2]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+40);

  p5[0]:=TPoint.Create(Rect.Left, Rect.Top+40);
  p5[1]:=TPoint.Create(Rect.Left+w, Rect.Top+40);

  p6[0]:=TPoint.Create(Rect.Left+4, Rect.Top+45);
  p6[1]:=TPoint.Create(Rect.Left+w-4, Rect.Top+45);

  p7[0]:=TPoint.Create(Rect.Left+8, Rect.Top+50);
  p7[1]:=TPoint.Create(Rect.Left+w-8, Rect.Top+50);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;
    for i:=0 to Length(p5)-1 do
    begin
      p5[i]:=PointRotate(p5[i], Rect.TopLeft, Angle);
      p5[i].X:=p5[i].X+dL;
      p5[i].Y:=p5[i].Y+dT;
    end;
    for i:=0 to Length(p6)-1 do
    begin
      p6[i]:=PointRotate(p6[i], Rect.TopLeft, Angle);
      p6[i].X:=p6[i].X+dL;
      p6[i].Y:=p6[i].Y+dT;
    end;
    for i:=0 to Length(p7)-1 do
    begin
      p7[i]:=PointRotate(p7[i], Rect.TopLeft, Angle);
      p7[i].X:=p7[i].X+dL;
      p7[i].Y:=p7[i].Y+dT;
    end;
  end;

  // рисуем
  // верхняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p1[0].X, p1[0].Y);
  ADst.LineTo(p1[1].X, p1[1].Y);

  // верхний круг
  FindMinMax(x1, y1, x2, y2, p2);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  // перекладина
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p3[0].X, p3[0].Y);
  ADst.LineTo(p3[1].X, p3[1].Y);

  // нижняя ломаная
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p4);

  // заземление
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p5[0].X, p5[0].Y);
  ADst.LineTo(p5[1].X, p5[1].Y);

  // заземление
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p6[0].X, p6[0].Y);
  ADst.LineTo(p6[1].X, p6[1].Y);

  // заземление
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p7[0].X, p7[0].Y);
  ADst.LineTo(p7[1].X, p7[1].Y);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
  SetLength(p5, 0);
  SetLength(p6, 0);
  SetLength(p7, 0);
end;

function TSODeviceGroundDisconnector.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceGroundDisconnector.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceGroundDisconnector.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d) - не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceGroundDisconnector.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
end;

function TSODeviceGroundDisconnector.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceGroundDisconnector.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;
end;

procedure TSODeviceGroundDisconnector.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);
end;

procedure TSODeviceGroundDisconnector.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceGroundDisconnector.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Отключен/включен. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceTransformer1 }

constructor TSODeviceTransformer1.Create;
begin
  inherited;
  FDefSize:=TSize.Create(20, 40);
  FRect:=TRect.Create(0, 0, 20, 40);
  FAngle:=0;
  FDeviceColor:=CSODeviceTransformer1Color;

  GUID:='';
  Cell:=1;
  Description:='Трансформатор измерительный';
  Text:='';
  FActive:=false; // до 20251001 было true
end;

function TSODeviceTransformer1.GetDeviceName: string;
begin
  Result:='ТН';
end;

function TSODeviceTransformer1.GetDeviceSection: string;
begin
  Result:=CSODeviceTransformer1Section;
end;

procedure TSODeviceTransformer1.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2: integer;
  p1, // верхн палка
  p2, // верх. круг
  p3, // нижн. круг
  p4: array of TPoint; // нижн. палка
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 4);
  SetLength(p3, 4);
  SetLength(p4, 2);

  // строим точки под угол 0 относительно 0:0
  p1[0]:=TPoint.Create(Rect.Left+w div 2, Rect.Top);
  p1[1]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+6);

  p2[0]:=TPoint.Create(Rect.Left+w div 2-8, Rect.Top+6);
  p2[1]:=TPoint.Create(Rect.Left+w div 2+8, Rect.Top+6);
  p2[2]:=TPoint.Create(Rect.Left+w div 2+8, Rect.Top+22);
  p2[3]:=TPoint.Create(Rect.Left+w div 2-8, Rect.Top+22);

  p3[0]:=TPoint.Create(Rect.Left+w div 2-8, Rect.Top+18);
  p3[1]:=TPoint.Create(Rect.Left+w div 2+8, Rect.Top+18);
  p3[2]:=TPoint.Create(Rect.Left+w div 2+8, Rect.Top+34);
  p3[3]:=TPoint.Create(Rect.Left+w div 2-8, Rect.Top+34);

  p4[0]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+34);
  p4[1]:=TPoint.Create(Rect.Left+w div 2, Rect.Top+40);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;
  end;

  // рисуем
  // верхняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p1[0].X, p1[0].Y);
  ADst.LineTo(p1[1].X, p1[1].Y);

  // верхний круг
  FindMinMax(x1, y1, x2, y2, p2);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  // нижний круг
  FindMinMax(x1, y1, x2, y2, p3);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  // нижняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p4[0].X, p4[0].Y);
  ADst.LineTo(p4[1].X, p4[1].Y);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
end;

function TSODeviceTransformer1.GetActive: integer;
begin
  if FActive then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceTransformer1.SetActive(AActive: integer);
begin
  FActive:=AActive <> 0;
end;

function TSODeviceTransformer1.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceTransformer1.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Active:%d', [Active]));
end;

function TSODeviceTransformer1.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Active:=LoadStrToInt(AStrings.Values['Active']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceTransformer1.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Active']:=IntToStr(Active);
  AValueListEditor.ItemProps['Active'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Active'].ReadOnly:=true;
end;

procedure TSODeviceTransformer1.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Active'].ReadOnly then
    Active:=LoadStrToInt(AValueListEditor.Values['Active']);
end;

procedure TSODeviceTransformer1.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Active') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceTransformer1.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Active - Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceLabel }

constructor TSODeviceLabel.Create;
begin
  inherited;
  FDefSize:=TSize.Create(60, 30);
  FRect:=TRect.Create(0, 0, FDefSize.Width, FDefSize.Height);
//  FDefSize:=TSize.Create(20, 12);
//  FRect:=TRect.Create(0, 0, 20, 12);
  FAngle:=0;
  FDeviceColor:=CSODeviceLabelColor;

  GUID:='';
  Cell:=1;
  Description:='Метка';
  Text:='';
  Name:='Метка';
  FBorder:=false;
end;

function TSODeviceLabel.GetDeviceName: string;
begin
  Result:='Метка';
end;

function TSODeviceLabel.GetDeviceSection: string;
begin
  Result:=CSODeviceLabelSection;
end;

procedure TSODeviceLabel.Draw(ADst: TCanvas);
const
  thickness: integer = 1;
var
  i, w, h, dL, dT: integer;
  p: array of TPoint;
  tw: integer;
  sh: single;
  LogRec: TLogFont;
  rr: TPoint;
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p, 4);
  // строим точки под угол 0 относительно 0:0
  p[0]:=TPoint.Create(Rect.Left, Rect.Top);
  p[1]:=TPoint.Create(Rect.Left+w, Rect.Top);
  p[2]:=TPoint.Create(Rect.Left+w, Rect.Top+h);
  p[3]:=TPoint.Create(Rect.Left, Rect.Top+h);

  // высота символа
  ADst.Font.Charset:=DEFAULT_CHARSET;
  ADst.Font.Name:='Arial';
  ADst.Font.Style:=[];

  GetObject(ADst.Font.Handle, SizeOf(LogRec), Addr(LogRec)); // читаем текущюю инф. о шрифте
  LogRec.lfEscapement:=0; // изменям угол
  LogRec.lfOrientation:=0; // изменяем угол
  ADst.Font.Handle:=CreateFontIndirect(LogRec); // устанавливаем новые параметры

  sh:=h*0.8;
  repeat
    ADst.Font.Height:=-round(sh);
    tw:=ADst.TextWidth(Name);
    if (tw = 0) then tw:=1;
    if (tw > w) then sh:=sh*w/tw;
  until (tw <= w);
  // координаты строк
  rr:=TPoint.Create(Rect.Left+w div 2-ADst.TextWidth(Name) div 2, Rect.Top+h div 2-ADst.TextHeight(Name) div 2);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p)-1 do
    begin
      p[i]:=PointRotate(p[i], Rect.TopLeft, Angle);
      p[i].X:=p[i].X+dL;
      p[i].Y:=p[i].Y+dT;
    end;

    rr:=PointRotate(rr, Rect.TopLeft, Angle);
    rr.X:=rr.X+dL;
    rr.Y:=rr.Y+dT;
  end;

  // рисуем
  // рамка
  if (Border <> 0) then
  begin
    ADst.Pen.Mode:=pmCopy;
    ADst.Pen.Style:=psSolid;
    ADst.Pen.Width:=thickness;
    ADst.Pen.Color:=DeviceColor;
    ADst.Brush.Style:=bsClear;
    //ADst.Brush.Color:=DeviceColor;
    ADst.Polygon(p);
  end;

  // текст
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psClear;
  ADst.Pen.Width:=1;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;

  ADst.Font.Color:=DeviceColor;

  GetObject(ADst.Font.Handle, SizeOf(LogRec), Addr(LogRec)); // читаем текущюю инф. о шрифте
  LogRec.lfEscapement:=-round(Angle*10); // изменяем угол
  LogRec.lfOrientation:=-round(Angle*10); // изменяем угол
  ADst.Font.Handle:=CreateFontIndirect(LogRec); // устанавливаем новые параметр

  ADst.TextOut(rr.X, rr.Y, Name);

  SetLength(p, 0);
end;

function TSODeviceLabel.GetName: string;
begin
  Result:=FName;
end;

procedure TSODeviceLabel.SetName(AName: string);
begin
  FName:=AName;
end;

function TSODeviceLabel.GetBorder: integer;
begin
  if FBorder then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceLabel.SetBorder(ABorder: integer);
begin
  FBorder:=ABorder <> 0;
end;

function TSODeviceLabel.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (Name = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задано наименование', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceLabel.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Name:%s', [Name]));
  AStrings.Add(Format('Border:%d', [Border]));
end;

function TSODeviceLabel.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Name:=AStrings.Values['Name'];
    Border:=LoadStrToInt(AStrings.Values['Border']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceLabel.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.ItemProps['Width'].ReadOnly:=false;
  AValueListEditor.ItemProps['Height'].ReadOnly:=false;

  AValueListEditor.Values['Name']:=Name;

  AValueListEditor.Values['Border']:=IntToStr(Border);
  AValueListEditor.ItemProps['Border'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Border'].ReadOnly:=true;
end;

procedure TSODeviceLabel.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Name'].ReadOnly then
    Name:=AValueListEditor.Values['Name'];

  //if not AValueListEditor.ItemProps['Border'].ReadOnly then
    Border:=LoadStrToInt(AValueListEditor.Values['Border']);
end;

procedure TSODeviceLabel.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Border') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceLabel.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Name - Наименование. Знак "_" означает перенос слов на другую строку.');
  AStrings.Add(' ');
  AStrings.Add('Border - Рамка. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceBreak }

constructor TSODeviceBreak.Create;
begin
  inherited;
  FDefSize:=TSize.Create(16, 16);
  FRect:=TRect.Create(0, 0, 16, 16);
  FAngle:=0;
  FDeviceColor:=CSODeviceBreakColor;

  GUID:='';
  Cell:=0;
  Description:='Разрыв линии';
  Text:='';
  FBreaked:=false;
end;

function TSODeviceBreak.GetDeviceName: string;
begin
  Result:='Разрыв';
end;

function TSODeviceBreak.GetDeviceSection: string;
begin
  Result:=CSODeviceBreakSection;
end;

procedure TSODeviceBreak.Draw(ADst: TCanvas);
const
  thiknessline: integer = 1;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2: integer;
  p1: array of TPoint; // звезда
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 8);

  // строим точки под угол 0 относительно 0:0
  p1[0]:=TPoint.Create(Rect.Left, Rect.Top);
  p1[1]:=TPoint.Create(Rect.Left+8, Rect.Top+5);
  p1[2]:=TPoint.Create(Rect.Left+16, Rect.Top);
  p1[3]:=TPoint.Create(Rect.Left+11, Rect.Top+8);
  p1[4]:=TPoint.Create(Rect.Left+16, Rect.Top+16);
  p1[5]:=TPoint.Create(Rect.Left+8, Rect.Top+11);
  p1[6]:=TPoint.Create(Rect.Left, Rect.Top+16);
  p1[7]:=TPoint.Create(Rect.Left+5, Rect.Top+8);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
  end;

  // рисуем
  // звезда
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polygon(p1);

  SetLength(p1, 0);
end;

function TSODeviceBreak.GetBreaked: integer;
begin
  if FBreaked then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceBreak.SetBreaked(ABreaked: integer);
begin
  FBreaked:=ABreaked <> 0;
end;

procedure TSODeviceBreak.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Active:%d', [Active]));
end;

function TSODeviceBreak.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Active:=LoadStrToInt(AStrings.Values['Active']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceBreak.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Active']:=IntToStr(Active);
  AValueListEditor.ItemProps['Active'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Active'].ReadOnly:=true;
end;

procedure TSODeviceBreak.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Active'].ReadOnly then
    Active:=LoadStrToInt(AValueListEditor.Values['Active']);
end;

procedure TSODeviceBreak.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Active') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceBreak.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Active - Линия разорвана. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceEndClutch }

constructor TSODeviceEndClutch.Create;
begin
  inherited;
  FDefSize:=TSize.Create(20, 36);
  FRect:=TRect.Create(0, 0, 20, 36);
  FAngle:=0;
  FDeviceColor:=CSODeviceEndClutchColor;

  GUID:='';
  Cell:=1;
  Description:='Концевая муфта';
  Text:='';
  FElectric:=false;
  FGrounded:=false;
  FShowParams:=false;
end;

function TSODeviceEndClutch.GetDeviceName: string;
begin
  Result:='Муфта';
end;

function TSODeviceEndClutch.GetDeviceSection: string;
begin
  Result:=CSODeviceEndClutchSection;
end;

procedure TSODeviceEndClutch.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2: integer;
  p1, // палка
  p2: array of TPoint; // треуг
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 3);

  // строим точки под угол 0 относительно 0:0
  p1[0]:=TPoint.Create(Rect.Left+10, Rect.Top);
  p1[1]:=TPoint.Create(Rect.Left+10, Rect.Bottom);

  p2[0]:=TPoint.Create(Rect.Left+3, Rect.Bottom-15);
  p2[1]:=TPoint.Create(Rect.Right-3, Rect.Bottom-15);
  p2[2]:=TPoint.Create(Rect.Left+10, Rect.Bottom-6);
{
  p2[0]:=TPoint.Create(Rect.Left, Rect.Bottom-9);
  p2[1]:=TPoint.Create(Rect.Left+10, Rect.Bottom);
  p2[2]:=TPoint.Create(Rect.Left+20, Rect.Bottom-9);
}
  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
  end;

  // рисуем
  // палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p1[0].X, p1[0].Y);
  ADst.LineTo(p1[1].X, p1[1].Y);

  // треуг
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polygon(p2);

  SetLength(p1, 0);
  SetLength(p2, 0);
end;

function TSODeviceEndClutch.GetElectric: integer;
begin
  if FElectric then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceEndClutch.SetElectric(AElectric: integer);
begin
  FElectric:=AElectric <> 0;
end;

function TSODeviceEndClutch.GetGrounded: integer;
begin
  if FGrounded then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceEndClutch.SetGrounded(AGrounded: integer);
begin
  FGrounded:=AGrounded <> 0;
end;

function TSODeviceEndClutch.GetShowParams: integer;
begin
  if FShowParams then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceEndClutch.SetShowParams(AShowParams: integer);
begin
  FShowParams:=AShowParams <> 0;
end;

procedure TSODeviceEndClutch.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Electric:%d', [Electric]));
  AStrings.Add(Format('Grounded:%d', [Grounded]));
  AStrings.Add(Format('ShowParams:%d', [ShowParams]));
end;

function TSODeviceEndClutch.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Electric:=LoadStrToInt(AStrings.Values['Electric']);
    Grounded:=LoadStrToInt(AStrings.Values['Grounded']);
    ShowParams:=LoadStrToInt(AStrings.Values['ShowParams']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceEndClutch.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Electric']:=IntToStr(Electric);
  AValueListEditor.ItemProps['Electric'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Electric'].ReadOnly:=true;

  AValueListEditor.Values['Grounded']:=IntToStr(Grounded);
  AValueListEditor.ItemProps['Grounded'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Grounded'].ReadOnly:=true;

  AValueListEditor.Values['ShowParams']:=IntToStr(ShowParams);
  AValueListEditor.ItemProps['ShowParams'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['ShowParams'].ReadOnly:=true;
end;

procedure TSODeviceEndClutch.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Electric'].ReadOnly then
    Electric:=LoadStrToInt(AValueListEditor.Values['Electric']);
  //if not AValueListEditor.ItemProps['Grounded'].ReadOnly then
    Grounded:=LoadStrToInt(AValueListEditor.Values['Grounded']);
  //if not AValueListEditor.ItemProps['ShowParams'].ReadOnly then
    ShowParams:=LoadStrToInt(AValueListEditor.Values['ShowParams']);
end;

procedure TSODeviceEndClutch.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Electric') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
  if (KeyName = 'Grounded') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
  if (KeyName = 'ShowParams') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceEndClutch.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Electric - Напряжение присутствует/отсутствует. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('Grounded - Заземлена/нет. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('ShowParams - Отображать таблицу с током и напряжением. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceIndicatorKZ }

constructor TSODeviceIndicatorKZ.Create;
begin
  inherited;
  FDefSize:=TSize.Create(40, 40);
  FRect:=TRect.Create(0, 0, 40, 40);
  FAngle:=0;
  FDeviceColor:=CSODeviceIndicatorKZColor;

  GUID:='';
  Cell:=1;
  Description:='Индикатор короткого замыкания';
  Text:='';
  FConnected:=false;
end;

function TSODeviceIndicatorKZ.GetDeviceName: string;
begin
  Result:='Инд.КЗ';
end;

function TSODeviceIndicatorKZ.GetDeviceSection: string;
begin
  Result:=CSODeviceIndicatorKZSection;
end;

procedure TSODeviceIndicatorKZ.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2: integer;
  p1, // палка
  p2, // палка
  p3: array of TPoint; // круг
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 2);
  SetLength(p3, 4);

  // строим точки под угол 0 относительно 0:0
  p1[0]:=TPoint.Create(Rect.Left+20, Rect.Top);
  p1[1]:=TPoint.Create(Rect.Left+20, Rect.Bottom);

  p2[0]:=TPoint.Create(Rect.Left+30, Rect.Top+20);
  p2[1]:=TPoint.Create(Rect.Left+37, Rect.Top+20);

  p3[0]:=TPoint.Create(Rect.Left+10, Rect.Top+10);
  p3[1]:=TPoint.Create(Rect.Left+30, Rect.Top+10);
  p3[2]:=TPoint.Create(Rect.Left+30, Rect.Top+30);
  p3[3]:=TPoint.Create(Rect.Left+10, Rect.Top+30);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
  end;

  // рисуем
  // палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.MoveTo(p1[0].X, p1[0].Y);
  ADst.LineTo(p1[1].X, p1[1].Y);

  // палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=CSODeviceIndicatorKZBlueColor;//DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=CSODeviceIndicatorKZBlueColor;//DeviceColor;
  ADst.MoveTo(p2[0].X, p2[0].Y);
  ADst.LineTo(p2[1].X, p2[1].Y);

  // круг
  FindMinMax(x1, y1, x2, y2, p3);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=CSODeviceIndicatorKZBlueColor;
  ADst.Brush.Style:=bsClear;
  // ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
end;

function TSODeviceIndicatorKZ.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceIndicatorKZ.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

procedure TSODeviceIndicatorKZ.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
end;

function TSODeviceIndicatorKZ.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceIndicatorKZ.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;
end;

procedure TSODeviceIndicatorKZ.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);
end;

procedure TSODeviceIndicatorKZ.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceIndicatorKZ.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Включен/отключен? Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceTextSwitch }

constructor TSODeviceTextSwitch.Create;
begin
  inherited;
  FDefSize:=TSize.Create(30, 20);
  FRect:=TRect.Create(0, 0, 30, 20);
  FAngle:=0;
  FDeviceColor:=CSODeviceTextSwitchColor;

  GUID:='';
  Cell:=1;
  Description:='Текстовый выключатель';
  Text:='';
  Connected:=0;
  ConnInvers:=0;
  RedBack:=0;
  Name:='ОЗЗ';
  NameOff:='';
end;

function TSODeviceTextSwitch.GetDeviceName: string;
begin
  Result:='Т.выкл.';
end;

function TSODeviceTextSwitch.GetDeviceSection: string;
begin
  Result:=CSODeviceTextSwitchSection;
end;

procedure TSODeviceTextSwitch.Draw(ADst: TCanvas);
const
  thickness: integer = 1;
var
  r: TRect;
  i, w, wt, ht, h, dL, dT: integer;
  x1, y1, x2, y2: integer;
  p, p1: array of TPoint;
  ss: TArray<string>;
  sc, tw: integer;
  sh: single;
  rr: TArray<TPoint>;
  LogRec: TLogFont;
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p, 4);
  SetLength(p1, 4);

  // строим точки под угол 0 относительно 0:0
  p[0]:=TPoint.Create(Rect.Left, Rect.Top);
  p[1]:=TPoint.Create(Rect.Left+w, Rect.Top);
  p[2]:=TPoint.Create(Rect.Left+w, Rect.Top+h);
  p[3]:=TPoint.Create(Rect.Left, Rect.Top+h);

  r:=Rect;
  r.Inflate(-round(w*0.08), -round(h*0.08));
  p1[0]:=TPoint.Create(r.Left, r.Top);
  p1[1]:=TPoint.Create(r.Right, r.Top);
  p1[2]:=TPoint.Create(r.Right, r.Bottom);
  p1[3]:=TPoint.Create(r.Left, r.Bottom);
  wt:=round(w*0.92);
  ht:=round(h*0.92);

  // разбор текста
  ss:=Name.Split(['_']); // символы для разрыва строки
  sc:=Length(ss);
  if (sc > 1) then
  begin
    SetLength(rr, sc);
    sh:=r.Height/sc;
  end else
  begin
    SetLength(rr, 1);
    sh:=r.Height;
    rr[0]:=r.TopLeft;
  end;

  // высота символа
  ADst.Font.Charset:=DEFAULT_CHARSET;
  ADst.Font.Name:='Arial';
  ADst.Font.Style:=[];

  GetObject(ADst.Font.Handle, SizeOf(LogRec), Addr(LogRec)); // читаем текущюю инф. о шрифте
  LogRec.lfEscapement:=0; // измен¤ем угол
  LogRec.lfOrientation:=0; // измен¤ем угол
  ADst.Font.Handle:=CreateFontIndirect(LogRec); // устанавливаем новые параметры

  repeat
    ADst.Font.Height:=-round(sh);
    i:=0;
    if (sc > 0) then
      tw:=ADst.TextWidth(ss[i])
    else
      tw:=0;
    while (i < sc) do
    begin
      if (ADst.TextWidth(ss[i]) < tw) then
        tw:=ADst.TextWidth(ss[i]);
      i:=i+1;
    end;
    if (tw = 0) then tw:=1;
    if (tw > wt) then sh:=sh*wt/tw;
  until (tw <= wt);
  // координаты строк
  for i:=0 to sc-1 do
    rr[i]:=TPoint.Create(r.Left, round(r.Top+sh*i));

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p)-1 do
    begin
      p[i]:=PointRotate(p[i], Rect.TopLeft, Angle);
      p[i].X:=p[i].X+dL;
      p[i].Y:=p[i].Y+dT;
    end;

    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;

    for i:=0 to Length(rr)-1 do
    begin
      rr[i]:=PointRotate(rr[i], Rect.TopLeft, Angle);
      rr[i].X:=rr[i].X+dL;
      rr[i].Y:=rr[i].Y+dT;
    end;
  end;

  // рисуем
  if (RedBack <> 0) then
  begin
    ADst.Pen.Mode:=pmCopy;
    ADst.Pen.Style:=psSolid;
    ADst.Pen.Width:=thickness;
    ADst.Pen.Color:=CSODeviceTextSwitchRedBackColor;
    ADst.Brush.Style:=bsSolid;
    ADst.Brush.Color:=CSODeviceTextSwitchRedBackColor;
    ADst.Polygon(p1);

    ADst.Font.Color:=CSODeviceTextSwitchRedBackTextColor;
  end else
  begin

    ADst.Font.Color:=CSODeviceTextSwitchColor;
  end;

  // текст
  //FindMinMax(x1, y1, x2, y2, p1);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psClear;
  ADst.Pen.Width:=1;
  //ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;

  GetObject(ADst.Font.Handle, SizeOf(LogRec), Addr(LogRec)); // читаем текущюю инф. о шрифте
  LogRec.lfEscapement:=-round(Angle*10); // изменяем угол
  LogRec.lfOrientation:=-round(Angle*10); // изменяем угол
  ADst.Font.Handle:=CreateFontIndirect(LogRec); // устанавливаем новые параметры

  for i:=0 to sc-1 do
    ADst.TextOut(rr[i].X, rr[i].Y, ss[i]);

  SetLength(p, 0);
  SetLength(p1, 0);
  SetLength(ss, 0);
  SetLength(rr, 0);
end;

function TSODeviceTextSwitch.GetName: string;
begin
  Result:=FName;
end;

procedure TSODeviceTextSwitch.SetName(AName: string);
begin
  FName:=AName;
end;

function TSODeviceTextSwitch.GetNameOff: string;
begin
  Result:=FNameOff;
end;

procedure TSODeviceTextSwitch.SetNameOff(ANameOff: string);
begin
  FNameOff:=ANameOff;
end;

function TSODeviceTextSwitch.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceTextSwitch.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceTextSwitch.GetConnInvers: integer;
begin
  if FConnInvers then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceTextSwitch.SetConnInvers(AConnInvers: integer);
begin
  FConnInvers:=AConnInvers <> 0;
end;

function TSODeviceTextSwitch.GetRedBack: integer;
begin
  if FRedBack then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceTextSwitch.SetRedBack(ARedBack: integer);
begin
  FRedBack:=ARedBack <> 0;
end;

function TSODeviceTextSwitch.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
  if (Name = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задано наименование', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceTextSwitch.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
  AStrings.Add(Format('ConnInvers:%d', [ConnInvers]));
  AStrings.Add(Format('RedBack:%d', [RedBack]));
  AStrings.Add(Format('Name:%s', [Name]));
  AStrings.Add(Format('NameOff:%s', [NameOff]));
end;

function TSODeviceTextSwitch.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
    ConnInvers:=LoadStrToInt(AStrings.Values['ConnInvers']);
    RedBack:=LoadStrToInt(AStrings.Values['RedBack']);
    Name:=AStrings.Values['Name'];
    NameOff:=AStrings.Values['NameOff'];
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceTextSwitch.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  // разрешить редактировать ширину
  AValueListEditor.ItemProps['Width'].ReadOnly:=false;
  // разрешить редактировать высоту
  AValueListEditor.ItemProps['Height'].ReadOnly:=false;

  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;

  AValueListEditor.Values['ConnInvers']:=IntToStr(ConnInvers);
  AValueListEditor.ItemProps['ConnInvers'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['ConnInvers'].ReadOnly:=true;

  AValueListEditor.Values['RedBack']:=IntToStr(RedBack);
  AValueListEditor.ItemProps['RedBack'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['RedBack'].ReadOnly:=true;

  AValueListEditor.Values['Name']:=Name;
  AValueListEditor.Values['NameOff']:=NameOff;
end;

procedure TSODeviceTextSwitch.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;

  if (Rect.Width < DefSize.Width) then
    raise Exception.CreateFmt('Ширина Width=%d < %d',[Rect.Width, DefSize.Width]);

  if (Rect.Height < DefSize.Height) then
    raise Exception.CreateFmt('Высота Width=%d < %d',[Rect.Height, DefSize.Height]);


  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);

  //if not AValueListEditor.ItemProps['ConnInvers'].ReadOnly then
    ConnInvers:=LoadStrToInt(AValueListEditor.Values['ConnInvers']);

  //if not AValueListEditor.ItemProps['RedBack'].ReadOnly then
    RedBack:=LoadStrToInt(AValueListEditor.Values['RedBack']);

  //if not AValueListEditor.ItemProps['Name'].ReadOnly then
    Name:=AValueListEditor.Values['Name'];

  //if not AValueListEditor.ItemProps['NameOff'].ReadOnly then
    NameOff:=AValueListEditor.Values['NameOff'];

end;

procedure TSODeviceTextSwitch.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;

  if (KeyName = 'ConnInvers') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;

  if (KeyName = 'RedBack') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceTextSwitch.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Надпись скрыта/видна. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('ConnInvers - Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('RedBack - Надпись имеет красный фон. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('Name - Надпись (скрыта). Например "Автомат ЗНЗ_откл", "Автомат ТН откл". Знак "_" означает перенос слов на другую строку.');
  AStrings.Add(' ');
  AStrings.Add('NameOff - Надпись (видна). Например "Автомат ЗНЗ_вкл", "Автомат ТН вкл". Знак "_" означает перенос слов на другую строку.');
  AStrings.Add(' ');
end;

{ TSODeviceVacuumSwitch  }

constructor TSODeviceVacuumSwitch.Create;
begin
  inherited;
  FDefSize:=TSize.Create(25, 50);
  FRect:=TRect.Create(0, 0, 25, 50);
  FAngle:=0;
  FDeviceColor:=CSODeviceVacuumSwitchColor;

  GUID:='';
  Cell:=1;
  Description:='Вакуумный выключатель';
  Text:='';
  FConnected:=false;
  FCollected:=true;
  FElectric:=false;
end;

function TSODeviceVacuumSwitch.GetDeviceName: string;
begin
  Result:='ВВ';
end;

function TSODeviceVacuumSwitch.GetDeviceSection: string;
begin
  Result:=CSODeviceVacuumSwitchSection;
end;

procedure TSODeviceVacuumSwitch.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // верхняя палка
  p2, // верхний круг
  p3, // квадрат
  p4, // внутр. палка
  p5, // нижняя палка
  p6: array of TPoint; // нижний круг
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 4);
  SetLength(p3, 4);
  SetLength(p4, 2);
  SetLength(p5, 2);
  SetLength(p6, 4);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+round(w/2);
  cy:=Rect.Top+round(h/2);

  p1[0]:=TPoint.Create(cx, cy-25);
  p1[1]:=TPoint.Create(cx, cy-13);

  p2[0]:=TPoint.Create(cx-3, cy-25-3);
  p2[1]:=TPoint.Create(cx+3, cy-25-3);
  p2[2]:=TPoint.Create(cx+3, cy-25+3);
  p2[3]:=TPoint.Create(cx-3, cy-25+3);

  p3[0]:=TPoint.Create(cx-13, cy-13);
  p3[1]:=TPoint.Create(cx+13, cy-13);
  p3[2]:=TPoint.Create(cx+13, cy+13);
  p3[3]:=TPoint.Create(cx-13, cy+13);

  p4[0]:=TPoint.Create(cx, cy-8);
  p4[1]:=TPoint.Create(cx, cy+8);

  p5[0]:=TPoint.Create(cx, cy+13);
  p5[1]:=TPoint.Create(cx, cy+25);

  p6[0]:=TPoint.Create(cx-3, cy+25-3);
  p6[1]:=TPoint.Create(cx+3, cy+25-3);
  p6[2]:=TPoint.Create(cx+3, cy+25+3);
  p6[3]:=TPoint.Create(cx-3, cy+25+3);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;
    for i:=0 to Length(p5)-1 do
    begin
      p5[i]:=PointRotate(p5[i], Rect.TopLeft, Angle);
      p5[i].X:=p5[i].X+dL;
      p5[i].Y:=p5[i].Y+dT;
    end;
    for i:=0 to Length(p6)-1 do
    begin
      p6[i]:=PointRotate(p6[i], Rect.TopLeft, Angle);
      p6[i].X:=p6[i].X+dL;
      p6[i].Y:=p6[i].Y+dT;
    end;
  end;

  // рисуем
  // верхняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p1);

  // верхний круг
  FindMinMax(x1, y1, x2, y2, p2);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  // квадрат
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;
  ADst.Polygon(p3);

  // внутр. палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p4);

  // нижняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p5);

  // нижний круг
  FindMinMax(x1, y1, x2, y2, p6);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
  SetLength(p5, 0);
  SetLength(p6, 0);
end;

function TSODeviceVacuumSwitch.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceVacuumSwitch.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceVacuumSwitch.GetCollected: integer;
begin
  if FCollected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceVacuumSwitch.SetCollected(ACollected: integer);
begin
  FCollected:=ACollected <> 0;
end;

function TSODeviceVacuumSwitch.GetElectric: integer;
begin
  if FElectric then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceVacuumSwitch.SetElectric(AElectric: integer);
begin
  FElectric:=AElectric <> 0;
end;

function TSODeviceVacuumSwitch.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceVacuumSwitch.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
  AStrings.Add(Format('Collected:%d', [Collected]));
  AStrings.Add(Format('Electric:%d', [Electric]));
end;

function TSODeviceVacuumSwitch.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
    Collected:=LoadStrToInt(AStrings.Values['Collected']);
    Electric:=LoadStrToInt(AStrings.Values['Electric']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceVacuumSwitch.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;

  AValueListEditor.Values['Collected']:=IntToStr(Collected);
  AValueListEditor.ItemProps['Collected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Collected'].ReadOnly:=true;

  AValueListEditor.Values['Electric']:=IntToStr(Electric);
  AValueListEditor.ItemProps['Electric'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Electric'].ReadOnly:=true;
end;

procedure TSODeviceVacuumSwitch.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);

  //if not AValueListEditor.ItemProps['Collected'].ReadOnly then
    Collected:=LoadStrToInt(AValueListEditor.Values['Collected']);

  //if not AValueListEditor.ItemProps['Electric'].ReadOnly then
    Electric:=LoadStrToInt(AValueListEditor.Values['Electric']);
end;

procedure TSODeviceVacuumSwitch.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;

  if (KeyName = 'Collected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;

  if (KeyName = 'Electric') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceVacuumSwitch.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Включен/отключен. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('Collected - Собран/разобран. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('Electric - Напряжение присутствует/отсутствует. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceDisconnector  }

constructor TSODeviceDisconnector.Create;
begin
  inherited;
  FDefSize:=TSize.Create(20, 40);
  FRect:=TRect.Create(0, 0, 20, 40);
  FAngle:=0;
  FDeviceColor:=CSODeviceDisconnectorColor;

  GUID:='';
  Cell:=1;
  Description:='Разъединитель РВ';
  Text:='';
  FConnected:=false;
end;

function TSODeviceDisconnector.GetDeviceName: string;
begin
  Result:='РВ';
end;

function TSODeviceDisconnector.GetDeviceSection: string;
begin
  Result:=CSODeviceDisconnectorSection;
end;

procedure TSODeviceDisconnector.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // верхняя палка
  p2, // верхний круг
  p3, // перекл
  p4, // нижняя лом
  p5: array of TPoint; // нижний круг
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 4);
  SetLength(p3, 2);
  SetLength(p4, 3);
  SetLength(p5, 4);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+round(w/2);
  cy:=Rect.Top+round(h/2);

  p1[0]:=TPoint.Create(cx, Rect.Top);
  p1[1]:=TPoint.Create(cx, Rect.Top+9);

  p2[0]:=TPoint.Create(cx-3, Rect.Top-3);
  p2[1]:=TPoint.Create(cx+3, Rect.Top-3);
  p2[2]:=TPoint.Create(cx+3, Rect.Top+3);
  p2[3]:=TPoint.Create(cx-3, Rect.Top+3);

  p3[0]:=TPoint.Create(cx-5, Rect.Top+9);
  p3[1]:=TPoint.Create(cx+5, Rect.Top+9);

  p4[0]:=TPoint.Create(cx+8, Rect.Top+11);
  p4[1]:=TPoint.Create(cx, Rect.Top+22);
  p4[2]:=TPoint.Create(cx, Rect.Top+40);

  p5[0]:=TPoint.Create(cx-3, Rect.Top+40-3);
  p5[1]:=TPoint.Create(cx+3, Rect.Top+40-3);
  p5[2]:=TPoint.Create(cx+3, Rect.Top+40+3);
  p5[3]:=TPoint.Create(cx-3, Rect.Top+40+3);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;
    for i:=0 to Length(p5)-1 do
    begin
      p5[i]:=PointRotate(p5[i], Rect.TopLeft, Angle);
      p5[i].X:=p5[i].X+dL;
      p5[i].Y:=p5[i].Y+dT;
    end;
  end;

  // рисуем
  // верхняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p1);

  // верхний круг
  FindMinMax(x1, y1, x2, y2, p2);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  // переклад
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p1);;

  // нижн. лом
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p4);

  // нижний круг
  FindMinMax(x1, y1, x2, y2, p5);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
  SetLength(p5, 0);
end;

function TSODeviceDisconnector.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceDisconnector.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceDisconnector.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceDisconnector.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
end;

function TSODeviceDisconnector.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceDisconnector.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;
end;

procedure TSODeviceDisconnector.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);
end;

procedure TSODeviceDisconnector.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceDisconnector.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Включен/отключен. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceTransformer2 }

constructor TSODeviceTransformer2.Create;
begin
  inherited;
  FDefSize:=TSize.Create(31, 40);
  FRect:=TRect.Create(0, 0, 31, 40);
  FAngle:=0;
  FDeviceColor:=CSODeviceTransformer2Color;

  GUID:='';
  Cell:=1;
  Description:='Трансф-р изм. с 2-мя вт.обм.';
  Text:='';
  FActive:=true;
end;

function TSODeviceTransformer2.GetDeviceName: string;
begin
  Result:='ТН2';
end;

function TSODeviceTransformer2.GetDeviceSection: string;
begin
  Result:=CSODeviceTransformer2Section;
end;

procedure TSODeviceTransformer2.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // верхн палка
  p2, // верх. круг
  p3, // нижн. круг лев
  p4, // нижн. палка лев
  p5, // нижн. круг прав
  p6: array of TPoint; // нижн. палка прав
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 4);
  SetLength(p3, 4);
  SetLength(p4, 2);
  SetLength(p5, 4);
  SetLength(p6, 2);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+w div 2+1;
  cy:=Rect.Top+h div 2+1;

  p1[0]:=TPoint.Create(cx, Rect.Top);
  p1[1]:=TPoint.Create(cx, Rect.Top+6);

  p2[0]:=TPoint.Create(cx-8, Rect.Top+6);
  p2[1]:=TPoint.Create(cx+8, Rect.Top+6);
  p2[2]:=TPoint.Create(cx+8, Rect.Top+22);
  p2[3]:=TPoint.Create(cx-8, Rect.Top+22);

  p3[0]:=TPoint.Create(cx-8-8, Rect.Top+18);
  p3[1]:=TPoint.Create(cx-8+8, Rect.Top+18);
  p3[2]:=TPoint.Create(cx-8+8, Rect.Top+34);
  p3[3]:=TPoint.Create(cx-8-8, Rect.Top+34);

  p4[0]:=TPoint.Create(cx-8, Rect.Top+34);
  p4[1]:=TPoint.Create(cx-8, Rect.Top+40);

  p5[0]:=TPoint.Create(cx+8-8, Rect.Top+18);
  p5[1]:=TPoint.Create(cx+8+8, Rect.Top+18);
  p5[2]:=TPoint.Create(cx+8+8, Rect.Top+34);
  p5[3]:=TPoint.Create(cx+8-8, Rect.Top+34);

  p6[0]:=TPoint.Create(cx+8, Rect.Top+34);
  p6[1]:=TPoint.Create(cx+8, Rect.Top+40);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;
    for i:=0 to Length(p5)-1 do
    begin
      p5[i]:=PointRotate(p5[i], Rect.TopLeft, Angle);
      p5[i].X:=p5[i].X+dL;
      p5[i].Y:=p5[i].Y+dT;
    end;
    for i:=0 to Length(p6)-1 do
    begin
      p6[i]:=PointRotate(p6[i], Rect.TopLeft, Angle);
      p6[i].X:=p6[i].X+dL;
      p6[i].Y:=p6[i].Y+dT;
    end;
  end;

  // рисуем
  // верхняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p1);

  // верхний круг
  FindMinMax(x1, y1, x2, y2, p2);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  // нижний круг лев
  FindMinMax(x1, y1, x2, y2, p3);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  // нижняя палка лев
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p4);

  // нижний круг прав
  FindMinMax(x1, y1, x2, y2, p5);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  // нижняя палка прав
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p6);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
  SetLength(p5, 0);
  SetLength(p6, 0);
end;

function TSODeviceTransformer2.GetActive: integer;
begin
  if FActive then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceTransformer2.SetActive(AActive: integer);
begin
  FActive:=AActive <> 0;
end;

function TSODeviceTransformer2.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceTransformer2.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Active:%d', [Active]));
end;

function TSODeviceTransformer2.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Active:=LoadStrToInt(AStrings.Values['Active']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceTransformer2.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Active']:=IntToStr(Active);
  AValueListEditor.ItemProps['Active'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Active'].ReadOnly:=true;
end;

procedure TSODeviceTransformer2.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Active'].ReadOnly then
    Active:=LoadStrToInt(AValueListEditor.Values['Active']);
end;

procedure TSODeviceTransformer2.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Active') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceTransformer2.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Active - Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceThermometer }

constructor TSODeviceThermometer.Create;
begin
  inherited;
  FDefSize:=TSize.Create(15, 40);
  FRect:=TRect.Create(0, 0, 15, 40);
  FAngle:=0;
  FDeviceColor:=CSODeviceThermometerColor;

  GUID:='';
  Cell:=1;
  Description:='Термометр';
  Text:='';
  FOuter:=true;
end;

function TSODeviceThermometer.GetDeviceName: string;
begin
  Result:='Терм.';
end;

function TSODeviceThermometer.GetDeviceSection: string;
begin
  Result:=CSODeviceThermometerSection;
end;

procedure TSODeviceThermometer.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // корпус
  p2, p3, p4, p5, p6, // палки
  p7, // средний прям.
  p8: array of TPoint; // нижний прям.
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 8);
  SetLength(p2, 2);
  SetLength(p3, 2);
  SetLength(p4, 2);
  SetLength(p5, 2);
  SetLength(p6, 2);
  SetLength(p7, 4);
  SetLength(p8, 4);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+w div 2;
  cy:=Rect.Top+h div 2;

  p1[0]:=TPoint.Create(Rect.Left+4, Rect.Top);
  p1[1]:=TPoint.Create(Rect.Left+15, Rect.Top);
  p1[2]:=TPoint.Create(Rect.Left+15, Rect.Top+24);
  p1[3]:=TPoint.Create(Rect.Left+11, Rect.Top+32);
  p1[4]:=TPoint.Create(Rect.Left+11, Rect.Top+40);
  p1[5]:=TPoint.Create(Rect.Left+8, Rect.Top+40);
  p1[6]:=TPoint.Create(Rect.Left+8, Rect.Top+32);
  p1[7]:=TPoint.Create(Rect.Left+4, Rect.Top+24);

  p2[0]:=TPoint.Create(Rect.Left+8, Rect.Top+8);
  p2[1]:=TPoint.Create(Rect.Left+11, Rect.Top+8);

  p3[0]:=TPoint.Create(Rect.Left+8, Rect.Top+12);
  p3[1]:=TPoint.Create(Rect.Left+11, Rect.Top+12);

  p4[0]:=TPoint.Create(Rect.Left+8, Rect.Top+16);
  p4[1]:=TPoint.Create(Rect.Left+11, Rect.Top+16);

  p5[0]:=TPoint.Create(Rect.Left+8, Rect.Top+20);
  p5[1]:=TPoint.Create(Rect.Left+11, Rect.Top+20);

  p6[0]:=TPoint.Create(Rect.Left+8, Rect.Top+24);
  p6[1]:=TPoint.Create(Rect.Left+11, Rect.Top+24);

  p7[0]:=TPoint.Create(Rect.Left+9, Rect.Top+4);
  p7[1]:=TPoint.Create(Rect.Left+10, Rect.Top+4);
  p7[2]:=TPoint.Create(Rect.Left+10, Rect.Top+40);
  p7[3]:=TPoint.Create(Rect.Left+9, Rect.Top+40);

  p8[0]:=TPoint.Create(Rect.Left+8, Rect.Top+32);
  p8[1]:=TPoint.Create(Rect.Left+11, Rect.Top+32);
  p8[2]:=TPoint.Create(Rect.Left+11, Rect.Top+39);
  p8[3]:=TPoint.Create(Rect.Left+8, Rect.Top+39);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;
    for i:=0 to Length(p5)-1 do
    begin
      p5[i]:=PointRotate(p5[i], Rect.TopLeft, Angle);
      p5[i].X:=p5[i].X+dL;
      p5[i].Y:=p5[i].Y+dT;
    end;
    for i:=0 to Length(p6)-1 do
    begin
      p6[i]:=PointRotate(p6[i], Rect.TopLeft, Angle);
      p6[i].X:=p6[i].X+dL;
      p6[i].Y:=p6[i].Y+dT;
    end;
    for i:=0 to Length(p7)-1 do
    begin
      p7[i]:=PointRotate(p7[i], Rect.TopLeft, Angle);
      p7[i].X:=p7[i].X+dL;
      p7[i].Y:=p7[i].Y+dT;
    end;
    for i:=0 to Length(p8)-1 do
    begin
      p8[i]:=PointRotate(p8[i], Rect.TopLeft, Angle);
      p8[i].X:=p8[i].X+dL;
      p8[i].Y:=p8[i].Y+dT;
    end;
  end;

  // рисуем
  // корпус
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=CSODeviceThermometerWhiteColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=CSODeviceThermometerWhiteColor;
  ADst.Polygon(p1);

  // палки
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p2);
  ADst.Polyline(p3);
  ADst.Polyline(p4);
  ADst.Polyline(p5);
  ADst.Polyline(p6);

  // средний прям.
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polygon(p7);

  // нижний прям.
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polygon(p8);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
  SetLength(p5, 0);
  SetLength(p6, 0);
  SetLength(p7, 0);
  SetLength(p8, 0);
end;

function TSODeviceThermometer.GetOuter: integer;
begin
  if FOuter then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceThermometer.SetOuter(AOuter: integer);
begin
  FOuter:=AOuter <> 0;
end;

function TSODeviceThermometer.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceThermometer.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Outer:%d', [Outer]));
end;

function TSODeviceThermometer.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Outer:=LoadStrToInt(AStrings.Values['Outer']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceThermometer.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Outer']:=IntToStr(Outer);
  AValueListEditor.ItemProps['Outer'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Outer'].ReadOnly:=true;
end;

procedure TSODeviceThermometer.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Outer'].ReadOnly then
    Outer:=LoadStrToInt(AValueListEditor.Values['Outer']);
end;

procedure TSODeviceThermometer.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Outer') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceThermometer.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Outher - Внутренний/наружный. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceCartTN  }

constructor TSODeviceCartTN.Create;
begin
  inherited;
  FDefSize:=TSize.Create(10, 65);
  FRect:=TRect.Create(0, 0, 10, 65);
  FAngle:=0;
  FDeviceColor:=CSODeviceCartTNColor;

  GUID:='';
  Cell:=1;
  Description:='Тележка ТН';
  Text:='';
  FConnected:=false;
end;

function TSODeviceCartTN.GetDeviceName: string;
begin
  Result:='Тел.ТН';
end;

function TSODeviceCartTN.GetDeviceSection: string;
begin
  Result:=CSODeviceCartTNSection;
end;

procedure TSODeviceCartTN.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // палка
  p2, // ломаная
  p3, // ломаная
  p4: array of TPoint; // прямоуг
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 3);
  SetLength(p3, 3);
  SetLength(p4, 4);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+round(w/2);
  cy:=Rect.Top+round(h/2);

  p1[0]:=TPoint.Create(cx, Rect.Top);
  p1[1]:=TPoint.Create(cx, Rect.Top+65);

  p2[0]:=TPoint.Create(cx-5, Rect.Top+10);
  p2[1]:=TPoint.Create(cx, Rect.Top+5);
  p2[2]:=TPoint.Create(cx+5, Rect.Top+10);

  p3[0]:=TPoint.Create(cx-5, Rect.Top+15);
  p3[1]:=TPoint.Create(cx, Rect.Top+10);
  p3[2]:=TPoint.Create(cx+5, Rect.Top+15);

  p4[0]:=TPoint.Create(cx-5, Rect.Top+25);
  p4[1]:=TPoint.Create(cx+5, Rect.Top+25);
  p4[2]:=TPoint.Create(cx+5, Rect.Top+60);
  p4[3]:=TPoint.Create(cx-5, Rect.Top+60);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;
  end;

  // рисуем
  // палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p1);

  // ломаная
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p2);

  // ломаная
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p3);

  // прямоуг
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;
  ADst.Polygon(p4);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
end;

function TSODeviceCartTN.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceCartTN.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceCartTN.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceCartTN.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
end;

function TSODeviceCartTN.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceCartTN.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;
end;

procedure TSODeviceCartTN.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);
end;

procedure TSODeviceCartTN.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceCartTN.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Включен/отключен? Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceFuse  }

constructor TSODeviceFuse.Create;
begin
  inherited;
  FDefSize:=TSize.Create(10, 50);
  FRect:=TRect.Create(0, 0, 10, 50);
  FAngle:=0;
  FDeviceColor:=CSODeviceFuseColor;

  GUID:='';
  Cell:=1;
  Description:='Предохранитель плавкий';
  Text:='';
  FConnected:=true;
end;

function TSODeviceFuse.GetDeviceName: string;
begin
  Result:='Пред.';
end;

function TSODeviceFuse.GetDeviceSection: string;
begin
  Result:=CSODeviceFuseSection;
end;

procedure TSODeviceFuse.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // палка
  p2: array of TPoint; // прямоуг
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 4);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+round(w/2);
  cy:=Rect.Top+round(h/2);

  p1[0]:=TPoint.Create(Rect.Left+5, Rect.Top);
  p1[1]:=TPoint.Create(Rect.Left+5, Rect.Top+50);

  p2[0]:=TPoint.Create(Rect.Left, Rect.Top+5);
  p2[1]:=TPoint.Create(Rect.Left+10, Rect.Top+5);
  p2[2]:=TPoint.Create(Rect.Left+10, Rect.Top+45);
  p2[3]:=TPoint.Create(Rect.Left, Rect.Top+45);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
  end;

  // рисуем
  // палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p1);

  // прямоуг
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;
  ADst.Polygon(p2);

  SetLength(p1, 0);
  SetLength(p2, 0);
end;

function TSODeviceFuse.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceFuse.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceFuse.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceFuse.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
end;

function TSODeviceFuse.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceFuse.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;
end;

procedure TSODeviceFuse.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);
end;

procedure TSODeviceFuse.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceFuse.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Не рабочий/рабочий. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceOilSwitch  }

constructor TSODeviceOilSwitch.Create;
begin
  inherited;
  FDefSize:=TSize.Create(25, 50);
  FRect:=TRect.Create(0, 0, 25, 50);
  FAngle:=0;
  FDeviceColor:=CSODeviceOilSwitchColor;

  GUID:='';
  Cell:=1;
  Description:='Масляный выключатель';
  Text:='';
  FConnected:=false;
  FCollected:=true;
  FElectric:=false;
end;

function TSODeviceOilSwitch.GetDeviceName: string;
begin
  Result:='МВ';
end;

function TSODeviceOilSwitch.GetDeviceSection: string;
begin
  Result:=CSODeviceOilSwitchSection;
end;

procedure TSODeviceOilSwitch.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // верхняя палка
  p2, // верхний круг
  p3, // квадрат
  p4, // внутр. палка
  p5, // нижняя палка
  p6: array of TPoint; // нижний круг
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 4);
  SetLength(p3, 4);
  SetLength(p4, 2);
  SetLength(p5, 2);
  SetLength(p6, 4);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+round(w/2);
  cy:=Rect.Top+round(h/2);

  p1[0]:=TPoint.Create(cx, cy-25);
  p1[1]:=TPoint.Create(cx, cy-13);

  p2[0]:=TPoint.Create(cx-3, cy-25-3);
  p2[1]:=TPoint.Create(cx+3, cy-25-3);
  p2[2]:=TPoint.Create(cx+3, cy-25+3);
  p2[3]:=TPoint.Create(cx-3, cy-25+3);

  p3[0]:=TPoint.Create(cx-13, cy-13);
  p3[1]:=TPoint.Create(cx+13, cy-13);
  p3[2]:=TPoint.Create(cx+13, cy+13);
  p3[3]:=TPoint.Create(cx-13, cy+13);

  p4[0]:=TPoint.Create(cx, cy-8);
  p4[1]:=TPoint.Create(cx, cy+8);

  p5[0]:=TPoint.Create(cx, cy+13);
  p5[1]:=TPoint.Create(cx, cy+25);

  p6[0]:=TPoint.Create(cx-3, cy+25-3);
  p6[1]:=TPoint.Create(cx+3, cy+25-3);
  p6[2]:=TPoint.Create(cx+3, cy+25+3);
  p6[3]:=TPoint.Create(cx-3, cy+25+3);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;
    for i:=0 to Length(p5)-1 do
    begin
      p5[i]:=PointRotate(p5[i], Rect.TopLeft, Angle);
      p5[i].X:=p5[i].X+dL;
      p5[i].Y:=p5[i].Y+dT;
    end;
    for i:=0 to Length(p6)-1 do
    begin
      p6[i]:=PointRotate(p6[i], Rect.TopLeft, Angle);
      p6[i].X:=p6[i].X+dL;
      p6[i].Y:=p6[i].Y+dT;
    end;
  end;

  // рисуем
  // верхняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p1);

  // верхний круг
  FindMinMax(x1, y1, x2, y2, p2);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  // квадрат
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=CSODeviceOilSwitchBackColor;
  ADst.Polygon(p3);

  // внутр. палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p4);

  // нижняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p5);

  // нижний круг
  FindMinMax(x1, y1, x2, y2, p6);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
  SetLength(p5, 0);
  SetLength(p6, 0);
end;

function TSODeviceOilSwitch.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceOilSwitch.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceOilSwitch.GetCollected: integer;
begin
  if FCollected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceOilSwitch.SetCollected(ACollected: integer);
begin
  FCollected:=ACollected <> 0;
end;

function TSODeviceOilSwitch.GetElectric: integer;
begin
  if FElectric then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceOilSwitch.SetElectric(AElectric: integer);
begin
  FElectric:=AElectric <> 0;
end;

function TSODeviceOilSwitch.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceOilSwitch.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
  AStrings.Add(Format('Collected:%d', [Collected]));
  AStrings.Add(Format('Electric:%d', [Electric]));
end;

function TSODeviceOilSwitch.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
    Collected:=LoadStrToInt(AStrings.Values['Collected']);
    Electric:=LoadStrToInt(AStrings.Values['Electric']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceOilSwitch.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;

  AValueListEditor.Values['Collected']:=IntToStr(Collected);
  AValueListEditor.ItemProps['Collected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Collected'].ReadOnly:=true;

  AValueListEditor.Values['Electric']:=IntToStr(Electric);
  AValueListEditor.ItemProps['Electric'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Electric'].ReadOnly:=true;
end;

procedure TSODeviceOilSwitch.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);

  //if not AValueListEditor.ItemProps['Collected'].ReadOnly then
    Collected:=LoadStrToInt(AValueListEditor.Values['Collected']);

  //if not AValueListEditor.ItemProps['Electric'].ReadOnly then
    Electric:=LoadStrToInt(AValueListEditor.Values['Electric']);
end;

procedure TSODeviceOilSwitch.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;

  if (KeyName = 'Collected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;

  if (KeyName = 'Electric') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceOilSwitch.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Включен/отключен. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('Collected - Собран/разобран. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('Electric - Напряжение присутствует/отсутствует. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceRolloutSwitch  }

constructor TSODeviceRolloutSwitch.Create;
begin
  inherited;
  FDefSize:=TSize.Create(25, 54);
  FRect:=TRect.Create(0, 0, 25, 54);
  FAngle:=0;
  FDeviceColor:=CSODeviceRolloutSwitchColor;

  GUID:='';
  Cell:=1;
  Description:='Выкатной выключатель';
  Text:='';
  FConnected:=false;
  FCollected:=true;
  FElectric:=false;
end;

function TSODeviceRolloutSwitch.GetDeviceName: string;
begin
  Result:='Вык.В';
end;

function TSODeviceRolloutSwitch.GetDeviceSection: string;
begin
  Result:=CSODeviceRolloutSwitchSection;
end;

procedure TSODeviceRolloutSwitch.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // верх палка 1
  p2, // верх галка 1
  p3, // верх галка 2
  p4, // верх палка 2
  p5, // квадрат
  p6, // внутр. палка
  p7, // ниж палка 1
  p8, // ниж галка 1
  p9, // ниж галка 2
  p10: array of TPoint; // ниж палка 2
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 3);
  SetLength(p3, 3);
  SetLength(p4, 2);
  SetLength(p5, 4);
  SetLength(p6, 2);
  SetLength(p7, 2);
  SetLength(p8, 3);
  SetLength(p9, 3);
  SetLength(p10, 2);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+round(w/2);
  cy:=Rect.Top+round(h/2);

  p1[0]:=TPoint.Create(cx, Rect.Top);
  p1[1]:=TPoint.Create(cx, Rect.Top+4);

  p2[0]:=TPoint.Create(cx-5, Rect.Top+7);
  p2[1]:=TPoint.Create(cx, Rect.Top+4);
  p2[2]:=TPoint.Create(cx+5, Rect.Top+7);

  p3[0]:=TPoint.Create(cx-5, Rect.Top+11);
  p3[1]:=TPoint.Create(cx, Rect.Top+8);
  p3[2]:=TPoint.Create(cx+5, Rect.Top+11);

  p4[0]:=TPoint.Create(cx, Rect.Top+8);
  p4[1]:=TPoint.Create(cx, Rect.Top+18);

  p5[0]:=TPoint.Create(cx-10, Rect.Top+18);
  p5[1]:=TPoint.Create(cx+10, Rect.Top+18);
  p5[2]:=TPoint.Create(cx+10, Rect.Top+36);
  p5[3]:=TPoint.Create(cx-10, Rect.Top+36);

  p6[0]:=TPoint.Create(cx, Rect.Top+21);
  p6[1]:=TPoint.Create(cx, Rect.Top+33);

  p7[0]:=TPoint.Create(cx, Rect.Top+36);
  p7[1]:=TPoint.Create(cx, Rect.Top+46);

  p8[0]:=TPoint.Create(cx-5, Rect.Top+43);
  p8[1]:=TPoint.Create(cx, Rect.Top+46);
  p8[2]:=TPoint.Create(cx+5, Rect.Top+43);

  p9[0]:=TPoint.Create(cx-5, Rect.Top+47);
  p9[1]:=TPoint.Create(cx, Rect.Top+50);
  p9[2]:=TPoint.Create(cx+5, Rect.Top+47);

  p10[0]:=TPoint.Create(cx, Rect.Top+50);
  p10[1]:=TPoint.Create(cx, Rect.Top+54);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;
    for i:=0 to Length(p5)-1 do
    begin
      p5[i]:=PointRotate(p5[i], Rect.TopLeft, Angle);
      p5[i].X:=p5[i].X+dL;
      p5[i].Y:=p5[i].Y+dT;
    end;
    for i:=0 to Length(p6)-1 do
    begin
      p6[i]:=PointRotate(p6[i], Rect.TopLeft, Angle);
      p6[i].X:=p6[i].X+dL;
      p6[i].Y:=p6[i].Y+dT;
    end;
    for i:=0 to Length(p7)-1 do
    begin
      p7[i]:=PointRotate(p7[i], Rect.TopLeft, Angle);
      p7[i].X:=p7[i].X+dL;
      p7[i].Y:=p7[i].Y+dT;
    end;
    for i:=0 to Length(p8)-1 do
    begin
      p8[i]:=PointRotate(p8[i], Rect.TopLeft, Angle);
      p8[i].X:=p8[i].X+dL;
      p8[i].Y:=p8[i].Y+dT;
    end;
    for i:=0 to Length(p9)-1 do
    begin
      p9[i]:=PointRotate(p9[i], Rect.TopLeft, Angle);
      p9[i].X:=p9[i].X+dL;
      p9[i].Y:=p9[i].Y+dT;
    end;
    for i:=0 to Length(p10)-1 do
    begin
      p10[i]:=PointRotate(p10[i], Rect.TopLeft, Angle);
      p10[i].X:=p10[i].X+dL;
      p10[i].Y:=p10[i].Y+dT;
    end;
  end;

  // рисуем
  // верхняя
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p1);
  ADst.Polyline(p2);
  ADst.Polyline(p3);
  ADst.Polyline(p4);

  // квадрат
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;
  ADst.Polygon(p5);

  // внутр. палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p6);

  // нижняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p7);
  ADst.Polyline(p8);
  ADst.Polyline(p9);
  ADst.Polyline(p10);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
  SetLength(p5, 0);
  SetLength(p6, 0);
  SetLength(p7, 0);
  SetLength(p8, 0);
  SetLength(p9, 0);
  SetLength(p10, 0);
end;

function TSODeviceRolloutSwitch.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceRolloutSwitch.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceRolloutSwitch.GetCollected: integer;
begin
  if FCollected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceRolloutSwitch.SetCollected(ACollected: integer);
begin
  FCollected:=ACollected <> 0;
end;

function TSODeviceRolloutSwitch.GetElectric: integer;
begin
  if FElectric then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceRolloutSwitch.SetElectric(AElectric: integer);
begin
  FElectric:=AElectric <> 0;
end;

function TSODeviceRolloutSwitch.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceRolloutSwitch.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
  AStrings.Add(Format('Collected:%d', [Collected]));
  AStrings.Add(Format('Electric:%d', [Electric]));
end;

function TSODeviceRolloutSwitch.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
    Collected:=LoadStrToInt(AStrings.Values['Collected']);
    Electric:=LoadStrToInt(AStrings.Values['Electric']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceRolloutSwitch.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;

  AValueListEditor.Values['Collected']:=IntToStr(Collected);
  AValueListEditor.ItemProps['Collected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Collected'].ReadOnly:=true;

  AValueListEditor.Values['Electric']:=IntToStr(Electric);
  AValueListEditor.ItemProps['Electric'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Electric'].ReadOnly:=true;
end;

procedure TSODeviceRolloutSwitch.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);

  //if not AValueListEditor.ItemProps['Collected'].ReadOnly then
    Collected:=LoadStrToInt(AValueListEditor.Values['Collected']);

  //if not AValueListEditor.ItemProps['Electric'].ReadOnly then
    Electric:=LoadStrToInt(AValueListEditor.Values['Electric']);
end;

procedure TSODeviceRolloutSwitch.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;

  if (KeyName = 'Collected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;

  if (KeyName = 'Electric') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceRolloutSwitch.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Включен/отключен. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('Collected - Собран/разобран. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('Electric - Напряжение присутствует/отсутствует. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceVoltageIndicator  }

constructor TSODeviceVoltageIndicator.Create;
begin
  inherited;
  FDefSize:=TSize.Create(20, 20);
  FRect:=TRect.Create(0, 0, 20, 20);
  FAngle:=0;
  FDeviceColor:=CSODeviceVoltageIndicatorColor;

  GUID:='';
  Cell:=1;
  Description:='Идикатор напряжения';
  Text:='';
  FConnected:=false;
  FConnInversion:=false;
end;

function TSODeviceVoltageIndicator.GetDeviceName: string;
begin
  Result:='Инд.U';
end;

function TSODeviceVoltageIndicator.GetDeviceSection: string;
begin
  Result:=CSODeviceVoltageIndicatorSection;
end;

procedure TSODeviceVoltageIndicator.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // верх круг
  p2, // верх палка
  p3, // круг
  p4, // ниж палка
  p5: array of TPoint; // ниж круг
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 4);
  SetLength(p2, 2);
  SetLength(p3, 4);
  SetLength(p4, 2);
  SetLength(p5, 4);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+round(w/2);
  cy:=Rect.Top+round(h/2);

  p1[0]:=TPoint.Create(cx-1, Rect.Top-1);
  p1[1]:=TPoint.Create(cx+1, Rect.Top-1);
  p1[2]:=TPoint.Create(cx+1, Rect.Top+1);
  p1[3]:=TPoint.Create(cx-1, Rect.Top+1);

  p2[0]:=TPoint.Create(cx, Rect.Top);
  p2[1]:=TPoint.Create(cx, Rect.Top+4);

  p3[0]:=TPoint.Create(cx-6, Rect.Top+4);
  p3[1]:=TPoint.Create(cx+6, Rect.Top+4);
  p3[2]:=TPoint.Create(cx+6, Rect.Top+16);
  p3[3]:=TPoint.Create(cx-6, Rect.Top+16);

  p4[0]:=TPoint.Create(cx, Rect.Top+16);
  p4[1]:=TPoint.Create(cx, Rect.Top+20);

  p5[0]:=TPoint.Create(cx-1, Rect.Top+19);
  p5[1]:=TPoint.Create(cx+1, Rect.Top+19);
  p5[2]:=TPoint.Create(cx+1, Rect.Top+21);
  p5[3]:=TPoint.Create(cx-1, Rect.Top+21);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;
    for i:=0 to Length(p5)-1 do
    begin
      p5[i]:=PointRotate(p5[i], Rect.TopLeft, Angle);
      p5[i].X:=p5[i].X+dL;
      p5[i].Y:=p5[i].Y+dT;
    end;
  end;

  // рисуем
  // верхний круг
  FindMinMax(x1, y1, x2, y2, p1);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  // верх палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p2);

  // круг
  FindMinMax(x1, y1, x2, y2, p3);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  // ADst.Brush.Color:=DeviceColor
  ADst.Ellipse(x1, y1, x2, y2);

  // ниж палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p4);

  // ниж круг
  FindMinMax(x1, y1, x2, y2, p5);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Ellipse(x1, y1, x2, y2);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
  SetLength(p5, 0);
end;

function TSODeviceVoltageIndicator.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceVoltageIndicator.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceVoltageIndicator.GetConnInversion: integer;
begin
  if FConnInversion then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceVoltageIndicator.SetConnInversion(AConnInversion: integer);
begin
  FConnInversion:=AConnInversion<> 0;
end;

function TSODeviceVoltageIndicator.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceVoltageIndicator.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
  AStrings.Add(Format('ConnInvers:%d', [ConnInvers]));
end;

function TSODeviceVoltageIndicator.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
    ConnInvers:=LoadStrToInt(AStrings.Values['ConnInvers']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceVoltageIndicator.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;

  AValueListEditor.Values['ConnInvers']:=IntToStr(ConnInvers);
  AValueListEditor.ItemProps['ConnInvers'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['ConnInvers'].ReadOnly:=true;
end;

procedure TSODeviceVoltageIndicator.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);

  //if not AValueListEditor.ItemProps['ConnInversion'].ReadOnly then
    ConnInvers:=LoadStrToInt(AValueListEditor.Values['ConnInvers']);
end;

procedure TSODeviceVoltageIndicator.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;

  if (KeyName = 'ConnInvers') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceVoltageIndicator.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Включен/отключен? Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('ConnInvers - Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceGrounder }

constructor TSODeviceGrounder.Create;
begin
  inherited;
  FDefSize:=TSize.Create(17, 30);
  FRect:=TRect.Create(0, 0, 17, 30);
  FAngle:=0;
  FDeviceColor:=CSODeviceGrounderColor;

  GUID:='';
  Cell:=1;
  Description:='Заземлитель';
  Text:='';
  Number:=0;
end;

function TSODeviceGrounder.GetDeviceName: string;
begin
  Result:='Заземл.';
end;

function TSODeviceGrounder.GetDeviceSection: string;
begin
  Result:=CSODeviceGrounderSection;
end;

procedure TSODeviceGrounder.Draw(ADst: TCanvas);
const
  thickness: integer = 2;
var
  i, w, h, dL, dT, cx, cy: integer;
  p: array of TPoint;
  tw: integer;
  sh: single;
  LogRec: TLogFont;
  rr: TPoint;
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p, 5);
  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+round(w/2);
  cy:=Rect.Top+round(h/2);
  p[0]:=TPoint.Create(Rect.Left, Rect.Top);
  p[1]:=TPoint.Create(Rect.Left+17, Rect.Top);
  p[2]:=TPoint.Create(Rect.Left+17, Rect.Top+26);
  p[3]:=TPoint.Create(Rect.Left+9, Rect.Top+30);
  p[4]:=TPoint.Create(Rect.Left, Rect.Top+26);

  // высота символа
  ADst.Font.Charset:=DEFAULT_CHARSET;
  ADst.Font.Name:='Arial';
  ADst.Font.Style:=[];

  GetObject(ADst.Font.Handle, SizeOf(LogRec), Addr(LogRec)); // читаем текущюю инф. о шрифте
  LogRec.lfEscapement:=0; // изменям угол
  LogRec.lfOrientation:=0; // изменяем угол
  ADst.Font.Handle:=CreateFontIndirect(LogRec); // устанавливаем новые параметры

  sh:=h*0.8;
  repeat
    ADst.Font.Height:=-round(sh);
    tw:=ADst.TextWidth(IntToStr(Number));
    if (tw = 0) then tw:=1;
    if (tw > w) then sh:=sh*w/tw;
  until (tw <= w);
  // координаты строк
  rr:=TPoint.Create(Rect.Left+w div 2-ADst.TextWidth(IntToStr(Number)) div 2, Rect.Top+h div 2-ADst.TextHeight(IntToStr(Number)) div 2);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p)-1 do
    begin
      p[i]:=PointRotate(p[i], Rect.TopLeft, Angle);
      p[i].X:=p[i].X+dL;
      p[i].Y:=p[i].Y+dT;
    end;

    rr:=PointRotate(rr, Rect.TopLeft, Angle);
    rr.X:=rr.X+dL;
    rr.Y:=rr.Y+dT;
  end;

  // рисуем
  // рамка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thickness;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;
  ADst.Polygon(p);

  // текст
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psClear;
  ADst.Pen.Width:=1;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;

  ADst.Font.Color:=DeviceColor;

  GetObject(ADst.Font.Handle, SizeOf(LogRec), Addr(LogRec)); // читаем текущюю инф. о шрифте
  LogRec.lfEscapement:=-round(Angle*10); // изменяем угол
  LogRec.lfOrientation:=-round(Angle*10); // изменяем угол
  ADst.Font.Handle:=CreateFontIndirect(LogRec); // устанавливаем новые параметр

  ADst.TextOut(rr.X, rr.Y, IntToStr(Number));

  SetLength(p, 0);
end;

function TSODeviceGrounder.GetNumber: integer;
begin
  Result:=FNumber;
end;

procedure TSODeviceGrounder.SetNumber(ANumber: integer);
begin
  FNumber:=ANumber;
end;

function TSODeviceGrounder.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (Number = 0) then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан номер %d', [DeviceName, Description, Cell, Number]));
  end;
end;

procedure TSODeviceGrounder.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Number:%d', [Number]));
end;

function TSODeviceGrounder.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Number:=LoadStrToInt(AStrings.Values['Number']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceGrounder.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Number']:=IntToStr(Number);
end;

procedure TSODeviceGrounder.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  if not AValueListEditor.ItemProps['Number'].ReadOnly then
    Number:=LoadStrToInt(AValueListEditor.Values['Number']);
end;

procedure TSODeviceGrounder.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
end;

procedure TSODeviceGrounder.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Number - Номер.');
  AStrings.Add(' ');
end;

{ TSODeviceGround }

constructor TSODeviceGround.Create;
begin
  inherited;
  FDefSize:=TSize.Create(20, 20);
  FRect:=TRect.Create(0, 0, 20, 20);
  FAngle:=0;
  FDeviceColor:=CSODeviceGroundColor;

  GUID:='';
  Cell:=1;
  Description:='Заземление';
  Text:='';
end;

function TSODeviceGround.GetDeviceName: string;
begin
  Result:='Змл.(ГОСТ)';
end;

function TSODeviceGround.GetDeviceSection: string;
begin
  Result:=CSODeviceGroundSection;
end;

procedure TSODeviceGround.Draw(ADst: TCanvas);
const
  thiknessline: integer = 2;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // верх палка
  p2, // гориз. палка 1
  p3, // гориз. палка 2
  p4: array of TPoint; // гориз. палка 3
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 2);
  SetLength(p3, 2);
  SetLength(p4, 2);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+round(w/2);
  cy:=Rect.Top+round(h/2);

  p1[0]:=TPoint.Create(cx, Rect.Top);
  p1[1]:=TPoint.Create(cx, Rect.Top+14);

  p2[0]:=TPoint.Create(cx-10, Rect.Top+14);
  p2[1]:=TPoint.Create(cx+10, Rect.Top+14);

  p3[0]:=TPoint.Create(cx-6, Rect.Top+17);
  p3[1]:=TPoint.Create(cx+6, Rect.Top+17);

  p4[0]:=TPoint.Create(cx-2, Rect.Top+20);
  p4[1]:=TPoint.Create(cx+2, Rect.Top+20);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;
  end;

  // рисуем
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p1);
  ADst.Polyline(p2);
  ADst.Polyline(p3);
  ADst.Polyline(p4);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
end;

{ TSODeviceCartVV }

constructor TSODeviceCartVV.Create;
begin
  inherited;
  FDefSize:=TSize.Create(25, 80);
  FRect:=TRect.Create(0, 0, 25, 80);
  FAngle:=0;
  FDeviceColor:=CSODeviceCartVVColor;

  GUID:='';
  Cell:=1;
  Description:='Тележка BB';
  Text:='';
  FConnected:=false;
end;

function TSODeviceCartVV.GetDeviceName: string;
begin
  Result:='Тел.ВВ';
end;

function TSODeviceCartVV.GetDeviceSection: string;
begin
  Result:=CSODeviceCartVVSection;
end;

procedure TSODeviceCartVV.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // верх палка 1
  p2, // верх галка 1
  p3, // верх галка 2
  p4, // верх палка 2
  p7, // ниж палка 1
  p8, // ниж галка 1
  p9, // ниж галка 2
  p10: array of TPoint; // ниж палка 2
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 3);
  SetLength(p3, 3);
  SetLength(p4, 2);
  SetLength(p7, 2);
  SetLength(p8, 3);
  SetLength(p9, 3);
  SetLength(p10, 2);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+round(w/2);
  cy:=Rect.Top+round(h/2);

  p1[0]:=TPoint.Create(cx, Rect.Top);
  p1[1]:=TPoint.Create(cx, Rect.Top+3);

  p2[0]:=TPoint.Create(cx-8, Rect.Top+6);
  p2[1]:=TPoint.Create(cx, Rect.Top+3);
  p2[2]:=TPoint.Create(cx+8, Rect.Top+6);

  p3[0]:=TPoint.Create(cx-8, Rect.Top+10);
  p3[1]:=TPoint.Create(cx, Rect.Top+7);
  p3[2]:=TPoint.Create(cx+8, Rect.Top+10);

  p4[0]:=TPoint.Create(cx, Rect.Top+7);
  p4[1]:=TPoint.Create(cx, Rect.Top+15);


  p7[0]:=TPoint.Create(cx, Rect.Top+65);
  p7[1]:=TPoint.Create(cx, Rect.Top+73);

  p8[0]:=TPoint.Create(cx-8, Rect.Top+70);
  p8[1]:=TPoint.Create(cx, Rect.Top+73);
  p8[2]:=TPoint.Create(cx+8, Rect.Top+70);

  p9[0]:=TPoint.Create(cx-8, Rect.Top+74);
  p9[1]:=TPoint.Create(cx, Rect.Top+77);
  p9[2]:=TPoint.Create(cx+8, Rect.Top+74);

  p10[0]:=TPoint.Create(cx, Rect.Top+77);
  p10[1]:=TPoint.Create(cx, Rect.Top+80);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;

    for i:=0 to Length(p7)-1 do
    begin
      p7[i]:=PointRotate(p7[i], Rect.TopLeft, Angle);
      p7[i].X:=p7[i].X+dL;
      p7[i].Y:=p7[i].Y+dT;
    end;
    for i:=0 to Length(p8)-1 do
    begin
      p8[i]:=PointRotate(p8[i], Rect.TopLeft, Angle);
      p8[i].X:=p8[i].X+dL;
      p8[i].Y:=p8[i].Y+dT;
    end;
    for i:=0 to Length(p9)-1 do
    begin
      p9[i]:=PointRotate(p9[i], Rect.TopLeft, Angle);
      p9[i].X:=p9[i].X+dL;
      p9[i].Y:=p9[i].Y+dT;
    end;
    for i:=0 to Length(p10)-1 do
    begin
      p10[i]:=PointRotate(p10[i], Rect.TopLeft, Angle);
      p10[i].X:=p10[i].X+dL;
      p10[i].Y:=p10[i].Y+dT;
    end;
  end;

  // рисуем
  // верхняя
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p1);
  ADst.Polyline(p2);
  ADst.Polyline(p3);
  ADst.Polyline(p4);

  // нижняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p7);
  ADst.Polyline(p8);
  ADst.Polyline(p9);
  ADst.Polyline(p10);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);

  SetLength(p7, 0);
  SetLength(p8, 0);
  SetLength(p9, 0);
  SetLength(p10, 0);
end;

function TSODeviceCartVV.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceCartVV.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceCartVV.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceCartVV.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
end;

function TSODeviceCartVV.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceCartVV.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;
end;

procedure TSODeviceCartVV.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);
end;

procedure TSODeviceCartVV.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceCartVV.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Включен/отключен. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceSectionDisconnector }

constructor TSODeviceSectionDisconnector.Create;
begin
  inherited;
  FDefSize:=TSize.Create(25, 80);
  FRect:=TRect.Create(0, 0, 25, 80);
  FAngle:=0;
  FDeviceColor:=CSODeviceSectionDisconnectorColor;

  GUID:='';
  Cell:=1;
  Description:='Секционный разъединитель с тележкой';
  Text:='';
  FConnected:=false;
end;

function TSODeviceSectionDisconnector.GetDeviceName: string;
begin
  Result:='Секц.раз.с тел.';
end;

function TSODeviceSectionDisconnector.GetDeviceSection: string;
begin
  Result:=CSODeviceSectionDisconnectorSection;
end;

procedure TSODeviceSectionDisconnector.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // верх палка 1
  p2, // верх галка 1
  p3, // верх галка 2
  p4, // верх палка 2
  p5, // сред. палка
  p7, // ниж палка 1
  p8, // ниж галка 1
  p9, // ниж галка 2
  p10: array of TPoint; // ниж палка 2
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 3);
  SetLength(p3, 3);
  SetLength(p4, 2);
  SetLength(p5, 2);
  SetLength(p7, 2);
  SetLength(p8, 3);
  SetLength(p9, 3);
  SetLength(p10, 2);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+round(w/2);
  cy:=Rect.Top+round(h/2);

  p1[0]:=TPoint.Create(cx, Rect.Top);
  p1[1]:=TPoint.Create(cx, Rect.Top+3);

  p2[0]:=TPoint.Create(cx-8, Rect.Top+6);
  p2[1]:=TPoint.Create(cx, Rect.Top+3);
  p2[2]:=TPoint.Create(cx+8, Rect.Top+6);

  p3[0]:=TPoint.Create(cx-8, Rect.Top+10);
  p3[1]:=TPoint.Create(cx, Rect.Top+7);
  p3[2]:=TPoint.Create(cx+8, Rect.Top+10);

  p4[0]:=TPoint.Create(cx, Rect.Top+7);
  p4[1]:=TPoint.Create(cx, Rect.Top+15);

  p5[0]:=TPoint.Create(cx, Rect.Top+15);
  p5[1]:=TPoint.Create(cx, Rect.Top+65);

  p7[0]:=TPoint.Create(cx, Rect.Top+65);
  p7[1]:=TPoint.Create(cx, Rect.Top+73);

  p8[0]:=TPoint.Create(cx-8, Rect.Top+70);
  p8[1]:=TPoint.Create(cx, Rect.Top+73);
  p8[2]:=TPoint.Create(cx+8, Rect.Top+70);

  p9[0]:=TPoint.Create(cx-8, Rect.Top+74);
  p9[1]:=TPoint.Create(cx, Rect.Top+77);
  p9[2]:=TPoint.Create(cx+8, Rect.Top+74);

  p10[0]:=TPoint.Create(cx, Rect.Top+77);
  p10[1]:=TPoint.Create(cx, Rect.Top+80);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;

    for i:=0 to Length(p5)-1 do
    begin
      p5[i]:=PointRotate(p5[i], Rect.TopLeft, Angle);
      p5[i].X:=p5[i].X+dL;
      p5[i].Y:=p5[i].Y+dT;
    end;

    for i:=0 to Length(p7)-1 do
    begin
      p7[i]:=PointRotate(p7[i], Rect.TopLeft, Angle);
      p7[i].X:=p7[i].X+dL;
      p7[i].Y:=p7[i].Y+dT;
    end;
    for i:=0 to Length(p8)-1 do
    begin
      p8[i]:=PointRotate(p8[i], Rect.TopLeft, Angle);
      p8[i].X:=p8[i].X+dL;
      p8[i].Y:=p8[i].Y+dT;
    end;
    for i:=0 to Length(p9)-1 do
    begin
      p9[i]:=PointRotate(p9[i], Rect.TopLeft, Angle);
      p9[i].X:=p9[i].X+dL;
      p9[i].Y:=p9[i].Y+dT;
    end;
    for i:=0 to Length(p10)-1 do
    begin
      p10[i]:=PointRotate(p10[i], Rect.TopLeft, Angle);
      p10[i].X:=p10[i].X+dL;
      p10[i].Y:=p10[i].Y+dT;
    end;
  end;

  // рисуем
  // верхняя
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p1);
  ADst.Polyline(p2);
  ADst.Polyline(p3);
  ADst.Polyline(p4);

  ADst.Polyline(p5);

  // нижняя палка
  //ADst.Pen.Mode:=pmCopy;
  //ADst.Pen.Style:=psSolid;
  //ADst.Pen.Width:=thiknessline;
  //ADst.Pen.Color:=DeviceColor;
  //ADst.Brush.Style:=bsSolid;
  //ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p7);
  ADst.Polyline(p8);
  ADst.Polyline(p9);
  ADst.Polyline(p10);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
  SetLength(p5, 0);

  SetLength(p7, 0);
  SetLength(p8, 0);
  SetLength(p9, 0);
  SetLength(p10, 0);
end;

function TSODeviceSectionDisconnector.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceSectionDisconnector.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceSectionDisconnector.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceSectionDisconnector.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
end;

function TSODeviceSectionDisconnector.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceSectionDisconnector.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;
end;

procedure TSODeviceSectionDisconnector.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);
end;

procedure TSODeviceSectionDisconnector.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceSectionDisconnector.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Включен/отключен. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceFuseWithCart  }

constructor TSODeviceFuseWithCart.Create;
begin
  inherited;
  FDefSize:=TSize.Create(25, 80);
  FRect:=TRect.Create(0, 0, 25, 80);
  FAngle:=0;
  FDeviceColor:=CSODeviceFuseWithCartColor;

  GUID:='';
  Cell:=1;
  Description:='Предохранитель с тележкой';
  Text:='';
  FConnected:=false;
end;

function TSODeviceFuseWithCart.GetDeviceName: string;
begin
  Result:='Пред.с тел.';
end;

function TSODeviceFuseWithCart.GetDeviceSection: string;
begin
  Result:=CSODeviceFuseWithCartSection;
end;

procedure TSODeviceFuseWithCart.Draw(ADst: TCanvas);
const
  thiknessline: integer = 3;
var
  i, w, h, dL, dT: integer;
  x1, y1, x2, y2, cx, cy: integer;
  p1, // верх палка 1
  p2, // верх галка 1
  p3, // верх галка 2
  p4, // верх палка 2
  p5, // прямоуг.
  p6, // внутр палка
  p7, // ниж палка 1
  p8, // ниж галка 1
  p9, // ниж галка 2
  p10: array of TPoint; // ниж палка 2
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p1, 2);
  SetLength(p2, 3);
  SetLength(p3, 3);
  SetLength(p4, 2);
  SetLength(p5, 4);
  SetLength(p6, 2);
  SetLength(p7, 2);
  SetLength(p8, 3);
  SetLength(p9, 3);
  SetLength(p10, 2);

  // строим точки под угол 0 относительно 0:0
  cx:=Rect.Left+round(w/2);
  cy:=Rect.Top+round(h/2);

  p1[0]:=TPoint.Create(cx, Rect.Top);
  p1[1]:=TPoint.Create(cx, Rect.Top+3);

  p2[0]:=TPoint.Create(cx-8, Rect.Top+6);
  p2[1]:=TPoint.Create(cx, Rect.Top+3);
  p2[2]:=TPoint.Create(cx+8, Rect.Top+6);

  p3[0]:=TPoint.Create(cx-8, Rect.Top+10);
  p3[1]:=TPoint.Create(cx, Rect.Top+7);
  p3[2]:=TPoint.Create(cx+8, Rect.Top+10);

  p4[0]:=TPoint.Create(cx, Rect.Top+7);
  p4[1]:=TPoint.Create(cx, Rect.Top+15);

  p5[0]:=TPoint.Create(cx-5, Rect.Top+20);
  p5[1]:=TPoint.Create(cx+5, Rect.Top+20);
  p5[2]:=TPoint.Create(cx+5, Rect.Top+60);
  p5[3]:=TPoint.Create(cx-5, Rect.Top+60);

  p6[0]:=TPoint.Create(cx, Rect.Top+15);
  p6[1]:=TPoint.Create(cx, Rect.Top+65);

  p7[0]:=TPoint.Create(cx, Rect.Top+65);
  p7[1]:=TPoint.Create(cx, Rect.Top+73);

  p8[0]:=TPoint.Create(cx-8, Rect.Top+70);
  p8[1]:=TPoint.Create(cx, Rect.Top+73);
  p8[2]:=TPoint.Create(cx+8, Rect.Top+70);

  p9[0]:=TPoint.Create(cx-8, Rect.Top+74);
  p9[1]:=TPoint.Create(cx, Rect.Top+77);
  p9[2]:=TPoint.Create(cx+8, Rect.Top+74);

  p10[0]:=TPoint.Create(cx, Rect.Top+77);
  p10[1]:=TPoint.Create(cx, Rect.Top+80);

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;
    for i:=0 to Length(p2)-1 do
    begin
      p2[i]:=PointRotate(p2[i], Rect.TopLeft, Angle);
      p2[i].X:=p2[i].X+dL;
      p2[i].Y:=p2[i].Y+dT;
    end;
    for i:=0 to Length(p3)-1 do
    begin
      p3[i]:=PointRotate(p3[i], Rect.TopLeft, Angle);
      p3[i].X:=p3[i].X+dL;
      p3[i].Y:=p3[i].Y+dT;
    end;
    for i:=0 to Length(p4)-1 do
    begin
      p4[i]:=PointRotate(p4[i], Rect.TopLeft, Angle);
      p4[i].X:=p4[i].X+dL;
      p4[i].Y:=p4[i].Y+dT;
    end;

    for i:=0 to Length(p5)-1 do
    begin
      p5[i]:=PointRotate(p5[i], Rect.TopLeft, Angle);
      p5[i].X:=p5[i].X+dL;
      p5[i].Y:=p5[i].Y+dT;
    end;
    for i:=0 to Length(p6)-1 do
    begin
      p6[i]:=PointRotate(p6[i], Rect.TopLeft, Angle);
      p6[i].X:=p6[i].X+dL;
      p6[i].Y:=p6[i].Y+dT;
    end;

    for i:=0 to Length(p7)-1 do
    begin
      p7[i]:=PointRotate(p7[i], Rect.TopLeft, Angle);
      p7[i].X:=p7[i].X+dL;
      p7[i].Y:=p7[i].Y+dT;
    end;
    for i:=0 to Length(p8)-1 do
    begin
      p8[i]:=PointRotate(p8[i], Rect.TopLeft, Angle);
      p8[i].X:=p8[i].X+dL;
      p8[i].Y:=p8[i].Y+dT;
    end;
    for i:=0 to Length(p9)-1 do
    begin
      p9[i]:=PointRotate(p9[i], Rect.TopLeft, Angle);
      p9[i].X:=p9[i].X+dL;
      p9[i].Y:=p9[i].Y+dT;
    end;
    for i:=0 to Length(p10)-1 do
    begin
      p10[i]:=PointRotate(p10[i], Rect.TopLeft, Angle);
      p10[i].X:=p10[i].X+dL;
      p10[i].Y:=p10[i].Y+dT;
    end;
  end;

  // рисуем
  // верхняя
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p1);
  ADst.Polyline(p2);
  ADst.Polyline(p3);
  ADst.Polyline(p4);

  // прямоуг
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;
  ADst.Polygon(p5);

  // внутр. палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p6);

  // нижняя палка
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psSolid;
  ADst.Pen.Width:=thiknessline;
  ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsSolid;
  ADst.Brush.Color:=DeviceColor;
  ADst.Polyline(p7);
  ADst.Polyline(p8);
  ADst.Polyline(p9);
  ADst.Polyline(p10);

  SetLength(p1, 0);
  SetLength(p2, 0);
  SetLength(p3, 0);
  SetLength(p4, 0);
  SetLength(p5, 0);
  SetLength(p6, 0);
  SetLength(p7, 0);
  SetLength(p8, 0);
  SetLength(p9, 0);
  SetLength(p10, 0);
end;

function TSODeviceFuseWithCart.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceFuseWithCart.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceFuseWithCart.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceFuseWithCart.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
end;

function TSODeviceFuseWithCart.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceFuseWithCart.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;
end;

procedure TSODeviceFuseWithCart.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;
  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);
end;

procedure TSODeviceFuseWithCart.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceFuseWithCart.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Включен/отключен. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
end;

{ TSODeviceTwoChannelTextSwitch }

constructor TSODeviceTwoChannelTextSwitch.Create;
begin
  inherited;
  FDefSize:=TSize.Create(30, 20);
  FRect:=TRect.Create(0, 0, 30, 20);
  FAngle:=0;
  FDeviceColor:=CSODeviceTwoChannelTextSwitchColor;

  GUID:='';
  Cell:=1;
  Description:='Текстовый выключатель с двумя каналами';
  Text:='';
  Connected:=0;
  ConnInvers:=0;
  RedBack:=0;
  Name:='ОЗЗ';
  NameOff:='';
end;

function TSODeviceTwoChannelTextSwitch.GetDeviceName: string;
begin
  Result:='Т.выкл.2кан.';
end;

function TSODeviceTwoChannelTextSwitch.GetDeviceSection: string;
begin
  Result:=CSODeviceTwoChannelTextSwitchSection;
end;

procedure TSODeviceTwoChannelTextSwitch.Draw(ADst: TCanvas);
const
  thickness: integer = 1;
var
  r: TRect;
  i, w, wt, ht, h, dL, dT: integer;
  x1, y1, x2, y2: integer;
  p, p1: array of TPoint;
  ss: TArray<string>;
  sc, tw: integer;
  sh: single;
  rr: TArray<TPoint>;
  LogRec: TLogFont;
begin
  inherited;

  // длина и ширина под угол 0
  if (Angle = 0) or (Angle = 180) then
  begin
    w:=Rect.Width;
    h:=Rect.Height;
  end else // 90 или 270
  begin
    w:=Rect.Height;
    h:=Rect.Width;
  end;

  // смещение при повороте
  case Angle of
    0: begin
      dL:=0;
      dT:=0;
    end;
    90: begin
      dL:=h;
      dT:=0;
    end;
    180: begin
      dL:=w;
      dT:=h;
    end;
    270: begin
      dL:=0;
      dT:=w;
    end;
  end;

  SetLength(p, 4);
  SetLength(p1, 4);

  // строим точки под угол 0 относительно 0:0
  p[0]:=TPoint.Create(Rect.Left, Rect.Top);
  p[1]:=TPoint.Create(Rect.Left+w, Rect.Top);
  p[2]:=TPoint.Create(Rect.Left+w, Rect.Top+h);
  p[3]:=TPoint.Create(Rect.Left, Rect.Top+h);

  r:=Rect;
  r.Inflate(-round(w*0.08), -round(h*0.08));
  p1[0]:=TPoint.Create(r.Left, r.Top);
  p1[1]:=TPoint.Create(r.Right, r.Top);
  p1[2]:=TPoint.Create(r.Right, r.Bottom);
  p1[3]:=TPoint.Create(r.Left, r.Bottom);
  wt:=round(w*0.92);
  ht:=round(h*0.92);

  // разбор текста
  ss:=Name.Split(['_']); // символы для разрыва строки
  sc:=Length(ss);
  if (sc > 1) then
  begin
    SetLength(rr, sc);
    sh:=r.Height/sc;
  end else
  begin
    SetLength(rr, 1);
    sh:=r.Height;
    rr[0]:=r.TopLeft;
  end;

  // высота символа
  ADst.Font.Charset:=DEFAULT_CHARSET;
  ADst.Font.Name:='Arial';
  ADst.Font.Style:=[];

  GetObject(ADst.Font.Handle, SizeOf(LogRec), Addr(LogRec)); // читаем текущюю инф. о шрифте
  LogRec.lfEscapement:=0; // измен¤ем угол
  LogRec.lfOrientation:=0; // измен¤ем угол
  ADst.Font.Handle:=CreateFontIndirect(LogRec); // устанавливаем новые параметры

  repeat
    ADst.Font.Height:=-round(sh);
    i:=0;
    if (sc > 0) then
      tw:=ADst.TextWidth(ss[i])
    else
      tw:=0;
    while (i < sc) do
    begin
      if (ADst.TextWidth(ss[i]) < tw) then
        tw:=ADst.TextWidth(ss[i]);
      i:=i+1;
    end;
    if (tw = 0) then tw:=1;
    if (tw > wt) then sh:=sh*wt/tw;
  until (tw <= wt);
  // координаты строк
  for i:=0 to sc-1 do
    rr[i]:=TPoint.Create(r.Left, round(r.Top+sh*i));

  // поворачиваем точки под угол Angle
  if (Angle <> 0) then
  begin
    for i:=0 to Length(p)-1 do
    begin
      p[i]:=PointRotate(p[i], Rect.TopLeft, Angle);
      p[i].X:=p[i].X+dL;
      p[i].Y:=p[i].Y+dT;
    end;

    for i:=0 to Length(p1)-1 do
    begin
      p1[i]:=PointRotate(p1[i], Rect.TopLeft, Angle);
      p1[i].X:=p1[i].X+dL;
      p1[i].Y:=p1[i].Y+dT;
    end;

    for i:=0 to Length(rr)-1 do
    begin
      rr[i]:=PointRotate(rr[i], Rect.TopLeft, Angle);
      rr[i].X:=rr[i].X+dL;
      rr[i].Y:=rr[i].Y+dT;
    end;
  end;

  // рисуем
  if (RedBack <> 0) then
  begin
    ADst.Pen.Mode:=pmCopy;
    ADst.Pen.Style:=psSolid;
    ADst.Pen.Width:=thickness;
    ADst.Pen.Color:=CSODeviceTwoChannelTextSwitchRedBackColor;
    ADst.Brush.Style:=bsSolid;
    ADst.Brush.Color:=CSODeviceTwoChannelTextSwitchRedBackColor;
    ADst.Polygon(p1);

    ADst.Font.Color:=CSODeviceTwoChannelTextSwitchRedBackTextColor;
  end else
  begin

    ADst.Font.Color:=CSODeviceTwoChannelTextSwitchColor;
  end;

  // текст
  //FindMinMax(x1, y1, x2, y2, p1);
  ADst.Pen.Mode:=pmCopy;
  ADst.Pen.Style:=psClear;
  ADst.Pen.Width:=1;
  //ADst.Pen.Color:=DeviceColor;
  ADst.Brush.Style:=bsClear;
  //ADst.Brush.Color:=DeviceColor;

  GetObject(ADst.Font.Handle, SizeOf(LogRec), Addr(LogRec)); // читаем текущюю инф. о шрифте
  LogRec.lfEscapement:=-round(Angle*10); // изменяем угол
  LogRec.lfOrientation:=-round(Angle*10); // изменяем угол
  ADst.Font.Handle:=CreateFontIndirect(LogRec); // устанавливаем новые параметры

  for i:=0 to sc-1 do
    ADst.TextOut(rr[i].X, rr[i].Y, ss[i]);

  SetLength(p, 0);
  SetLength(p1, 0);
  SetLength(ss, 0);
  SetLength(rr, 0);
end;

function TSODeviceTwoChannelTextSwitch.GetName: string;
begin
  Result:=FName;
end;

procedure TSODeviceTwoChannelTextSwitch.SetName(AName: string);
begin
  FName:=AName;
end;

function TSODeviceTwoChannelTextSwitch.GetNameOff: string;
begin
  Result:=FNameOff;
end;

procedure TSODeviceTwoChannelTextSwitch.SetNameOff(ANameOff: string);
begin
  FNameOff:=ANameOff;
end;

function TSODeviceTwoChannelTextSwitch.GetConnected: integer;
begin
  if FConnected then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceTwoChannelTextSwitch.SetConnected(AConnected: integer);
begin
  FConnected:=AConnected <> 0;
end;

function TSODeviceTwoChannelTextSwitch.GetConnInvers: integer;
begin
  if FConnInvers then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceTwoChannelTextSwitch.SetConnInvers(AConnInvers: integer);
begin
  FConnInvers:=AConnInvers <> 0;
end;

function TSODeviceTwoChannelTextSwitch.GetRedBack: integer;
begin
  if FRedBack then
    Result:=1
  else
    Result:=0;
end;

procedure TSODeviceTwoChannelTextSwitch.SetRedBack(ARedBack: integer);
begin
  FRedBack:=ARedBack <> 0;
end;

function TSODeviceTwoChannelTextSwitch.Check(AMemo: TMemo): boolean;
begin
  Result:=inherited;
  if (GUID = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задан GUID', [DeviceName, Description, Cell]));
  end;
  if (Name = '') then
  begin
    Result:=false;
    AMemo.Lines.Add(Format('%s: %s (яч. %d): не задано наименование', [DeviceName, Description, Cell]));
  end;
end;

procedure TSODeviceTwoChannelTextSwitch.SaveToStrings(AStrings: TStrings);
begin
  inherited;
  AStrings.Add(Format('Connected:%d', [Connected]));
  AStrings.Add(Format('ConnInvers:%d', [ConnInvers]));
  AStrings.Add(Format('RedBack:%d', [RedBack]));
  AStrings.Add(Format('Name:%s', [Name]));
  AStrings.Add(Format('NameOff:%s', [NameOff]));
end;

function TSODeviceTwoChannelTextSwitch.LoadFromStringList(AStrings: TStrings; var AReport: string): boolean;
begin
  Result:=inherited;
  try
    Connected:=LoadStrToInt(AStrings.Values['Connected']);
    ConnInvers:=LoadStrToInt(AStrings.Values['ConnInvers']);
    RedBack:=LoadStrToInt(AStrings.Values['RedBack']);
    Name:=AStrings.Values['Name'];
    NameOff:=AStrings.Values['NameOff'];
  except
    on E: Exception do
    begin
      Result:=false;
      AReport:=E.Message;
    end;
  end;
end;

procedure TSODeviceTwoChannelTextSwitch.ValuesToListEditor(AValueListEditor: TValueListEditor);
begin
  inherited;
  // разрешить редактировать ширину
  AValueListEditor.ItemProps['Width'].ReadOnly:=false;
  // разрешить редактировать высоту
  AValueListEditor.ItemProps['Height'].ReadOnly:=false;

  AValueListEditor.Values['Connected']:=IntToStr(Connected);
  AValueListEditor.ItemProps['Connected'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['Connected'].ReadOnly:=true;

  AValueListEditor.Values['ConnInvers']:=IntToStr(ConnInvers);
  AValueListEditor.ItemProps['ConnInvers'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['ConnInvers'].ReadOnly:=true;

  AValueListEditor.Values['RedBack']:=IntToStr(RedBack);
  AValueListEditor.ItemProps['RedBack'].EditStyle:=esPickList;
  AValueListEditor.ItemProps['RedBack'].ReadOnly:=true;

  AValueListEditor.Values['Name']:=Name;
  AValueListEditor.Values['NameOff']:=NameOff;
end;

procedure TSODeviceTwoChannelTextSwitch.ValuesFromListEditor(AValueListEditor: TValueListEditor; ASize: TSize);
begin
  inherited;

  if (Rect.Width < DefSize.Width) then
    raise Exception.CreateFmt('Ширина Width=%d < %d',[Rect.Width, DefSize.Width]);

  if (Rect.Height < DefSize.Height) then
    raise Exception.CreateFmt('Высота Width=%d < %d',[Rect.Height, DefSize.Height]);

  //if not AValueListEditor.ItemProps['Connected'].ReadOnly then
    Connected:=LoadStrToInt(AValueListEditor.Values['Connected']);

  //if not AValueListEditor.ItemProps['ConnInvers'].ReadOnly then
    ConnInvers:=LoadStrToInt(AValueListEditor.Values['ConnInvers']);

  //if not AValueListEditor.ItemProps['RedBack'].ReadOnly then
    RedBack:=LoadStrToInt(AValueListEditor.Values['RedBack']);

  //if not AValueListEditor.ItemProps['Name'].ReadOnly then
    Name:=AValueListEditor.Values['Name'];

  //if not AValueListEditor.ItemProps['NameOff'].ReadOnly then
    NameOff:=AValueListEditor.Values['NameOff'];

end;

procedure TSODeviceTwoChannelTextSwitch.ValuesGetPickList(Sender: TObject; const KeyName: string; Values: TStrings);
begin
  if (KeyName = 'Connected') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;

  if (KeyName = 'ConnInvers') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;

  if (KeyName = 'RedBack') then
  begin
    Values.Add('0');
    Values.Add('1');
  end;
end;

procedure TSODeviceTwoChannelTextSwitch.ValuesHelpToString(AStrings: TStrings);
begin
  inherited;
  AStrings.Add('Connected - Надпись скрыта/видна. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('ConnInvers - Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('RedBack - Надпись имеет красный фон. Принимает значения из выпадающего списка: 0, 1.');
  AStrings.Add(' ');
  AStrings.Add('Name - Надпись (скрыта). Например "Автомат ЗНЗ_откл", "Автомат ТН откл". Знак "_" означает перенос слов на другую строку.');
  AStrings.Add(' ');
  AStrings.Add('NameOff - Надпись (видна). Например "Автомат ЗНЗ_вкл", "Автомат ТН вкл". Знак "_" означает перенос слов на другую строку.');
  AStrings.Add(' ');
end;

{ вспомогательные функции }

// вращение точки AP вокруг ACP на угол AAngle: 0 - вниз, вращение по часовой
function PointRotate(AP, ACP: TPoint; AAngle: integer): TPoint;
var
  A: double;
begin
  A:=DegToRad(AAngle);
  Result.X:=round((AP.X-ACP.X)*cos(A)-(AP.Y-ACP.Y)*sin(A)+ACP.X);
  Result.Y:=round((AP.X-ACP.X)*sin(A)+(AP.Y-ACP.Y)*cos(A)+ACP.Y);
end;

// координаты для рисования окружности
procedure FindMinMax(var x1, y1, x2, y2: integer; const Ap: array of TPoint);
var
  i: integer;
begin
  x1:=Ap[0].X;
  y1:=Ap[0].Y;
  x2:=Ap[0].X;
  y2:=Ap[0].Y;
  for i:=1 to Length(Ap)-1 do
  begin
    x1:=Min(x1, Ap[i].X);
    y1:=Min(y1, Ap[i].Y);
    x2:=Max(x2, Ap[i].X);
    y2:=Max(y2, Ap[i].Y);
  end;
end;

// преобразует string в integer при загрузке с округлением вещественных
function LoadStrToInt(ASrc: string): integer;
var
  s: string;
  n1, n2: integer;
begin
  s:=trim(ASrc);
  n1:=Pos('.', s);
  n2:=Pos(',', s);
  if (n1 > 0) then
    Result:=StrToInt(Copy(s, 1, n1-1)) // обрезать до точки
  else if (n2 > 0) then
    Result:=StrToInt(Copy(s, 1, n2-1)) // обрезать до запятой
  else if (s = '') then
    Result:=0
  else
    Result:=StrToInt(s);
end;

end.