unit TPObjUnit;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Types, System.StrUtils,
  System.Classes, System.RegularExpressions, Vcl.Dialogs, CEventsUnit,
  System.Variants, XMLDoc, XMLIntf;

type

  // TControllerType - Тип контроллера

  TControllerType = record
    FControllerTypeId: integer; // ID из dbo.ControllerTypes
    FControllerTypeName: string; // название из dbo.ControllerTypes
  end;

const
  CControllerTypes: array [0..2] of TControllerType = (
    (FControllerTypeId: 1; FControllerTypeName: 'WinPac'),
  	(FControllerTypeId: 2; FControllerTypeName: 'Teleofis'),
	  (FControllerTypeId: 3; FControllerTypeName: 'Beckhoff')
  );

  CDateTimeControllerFormat: string = 'dd.mm.yyyy hh:nn:ss';

type

  // TDSController - Контроллер

  TDSController = class
    FControllerId: integer; // ID контроллера, если надо создавать в БД, то 0, если уже создан в БД, то значение из БД
    FControllerTypeIndex: integer; // локальный индекс типа контроллера в CControllerTypes
	  FDistrStationId: integer; // ID подстанции из БД
    FEthernetIsAvailable: boolean;
    FGprsIsAvailable: boolean;
    FEthernet_LinkLost_Date: TDateTime;
	  FGprs_LinkLost_Date: TDateTime;
  protected
    function GetControllerTypeID: integer;
  	procedure SetControllerTypeID(AControllerTypeId: integer);
  public
    constructor Create(AControllerID, AControllerTypeId, ADistrStationId: integer);
	  property ControllerId: integer read FControllerId write FControllerId;
    property ControllerTypeIndex: integer read FControllerTypeIndex write FControllerTypeIndex;
    property ControllerTypeId: integer read GetControllerTypeID write SetControllerTypeID; // ID типа контроллера из dbo.ControllerTypes, возвращает по номеру FControllerTypeIndex, устанавливает FControllerTypeIndex по TControllerType.FControllerTypeId
    property DistrStationId: integer read FDistrStationId write FDistrStationId;
    property EthernetIsAvailable: boolean read FEthernetIsAvailable write FEthernetIsAvailable;
    property GprsIsAvailable: boolean read FGprsIsAvailable write FGprsIsAvailable;
    property Ethernet_LinkLost_Date: TDateTime read FEthernet_LinkLost_Date write FEthernet_LinkLost_Date;
	  property Gprs_LinkLost_Date: TDateTime read FGprs_LinkLost_Date write FGprs_LinkLost_Date;
  end;

  // TDSControllerList - Класс для хранения контроллеров

  TDSControllerList = TObjectList<TDSController>;

type

  // TModuleType - Тип модуля

  TModuleType = record
    FModuleTypeId: integer; // ID из dbo.ModuleTypes
    FName: string; // название из dbo.ModuleTypes
  end;

const
  CModuleTypes: array [0..2] of TModuleType = (
    (FModuleTypeId: 4; FName: 'D/I'),
	  (FModuleTypeId: 5; FName: 'D/O'),
	  (FModuleTypeId: 6; FName: 'A/I')
  );

type

  // TDSModule - Модуль

  TDSModule = class
    FModuleId: integer; // ID модуля, если надо создавать в БД, то 0, если уже создан в БД, то значение из БД
    FModuleTypeIndex: integer; // локальный индекс типа модуля в CModuleTypes
	  FController: TDSController; // контроллер
    FModuleName: string; // название модуля
    FOrdinalNumber: integer; // порядковый номер
    FChannelCount: integer; // количество каналов в модуле. нет в БД.
  protected
    function GetModuleTypeID: integer;
    procedure SetModuleTypeID(AModuleTypeId: integer);
    function GetControllerID: integer;
  public
    constructor Create(AModuleID, AModuleTypeId: integer; AModuleName: string; AOrdinalNumber: integer; AController: TDSController; AChannelCount: integer);
  	property ModuleId: integer read FModuleId write FModuleId;
    property ModuleTypeIndex: integer read FModuleTypeIndex write FModuleTypeIndex;
    property ModuleTypeId: integer read GetModuleTypeID write SetModuleTypeID; // ID типа модуля из dbo.ModuleTypes, возвращает по номеру FModuleTypeIndex, устанавливает FModuleTypeIndex по TModuleType.FModuleTypeId
    property ControllerId: integer read GetControllerId; // ID контроллера
	  property Controller: TDSController read FController write FController;
    property ModuleName: string read FModuleName write FModuleName;
  	property OrdinalNumber: integer read FOrdinalNumber write FOrdinalNumber;
  	property ChannelCount: integer read FChannelCount write FChannelCount;
  end;

  // TDSModuleList - Класс для хранения модулей

  TDSModuleList = TObjectList<TDSModule>;

{
type

  // TCellType - Тип ячейки, пока НЕ используется

  TCellType = record
    FCellTypeId: integer; // ID из dbo.CellTypes
    FCellTypeName: string; // название из dbo.CellTypes
  end;

const
  CCellTypes: array [0..4] of TCellType = (
    (FCellTypeId: 1; FCellTypeName: 'Ввод'),
	(FCellTypeId: 2; FCellTypeName: 'Линия'),
	(FCellTypeId: 3; FCellTypeName: 'Тр-р'),
	(FCellTypeId: 4; FCellTypeName: 'ТН'),
	(FCellTypeId: 5; FCellTypeName: 'СВ')
  );
}

type

  // TDSCell - ячейка

  TDSCell = class
    FCellId: integer; // ID ячейки, если надо создавать в БД, то 0, если уже создан в БД, то значение из БД
    FDistrStationId: integer; // ID подстанции из БД
    // CellTypeId: integer; // NULL
    FOrderNumber: integer; // индекс сортировки, обычно равен номеру ячейки
    FGuid: string; // GUID ячейки из БД WattPassports, поле guid таблицы оборудования
    FCellName: string; // название ячейки
    FNote: string; // примечание, обычно номер ТП и ячейки на конце отходящей линии
  public
    constructor Create(ACellID, ADistrSatationID, AOrderNumber: integer; AGuid, ACellName, ANote: string);
  	property CellId: integer read FCellId write FCellId;
    property DistrStationId: integer read FDistrStationId write FDistrStationId;
	  property OrderNumber: integer read FOrderNumber write FOrderNumber;
    property Guid: string read FGuid write FGuid;
    property CellName: string read FCellName write FCellName;
  	property Note: string read FNote write FNote;
  end;

  // TDSCellList - Класс для хранения ячеек

  TDSCellList = TObjectList<TDSCell>;

type

  // TDeviceType - Тип устройства

  TDeviceType = record
    FDeviceTypeId: integer; // ID из dbo.DeviceTypes
    FDeviceTypeName: string; // название из dbo.DeviceTypes
	  FDescription: string; // описание
  end;

const
  CDeviceTypes: array [0..3] of TDeviceType = (
    (FDeviceTypeId: 1; FDeviceTypeName: 'SwgHL'; FDescription: 'Коммутационные устройства'),
  	(FDeviceTypeId: 2; FDeviceTypeName: 'GroundHL'; FDescription: 'Заземление'),
	  (FDeviceTypeId: 3; FDeviceTypeName: 'FuzeHL'; FDescription: 'Предохранители'),
  	(FDeviceTypeId: 4; FDeviceTypeName: 'Other'; FDescription: 'Другое')
  );

  function GetDeviceTypeIdAtName(ADeviceTypeName: string): integer;

type

  // TDSDevice - устройство

  TDSDevice = class
    FDeviceId: integer; // ID устройства, локальный, создается автоматически в БД
    FDeviceTypeIndex: integer; // локальный индекс типа модуля в CDeviceTypes
    FCell: TDSCell; // ячейка
    FGuid: string; // GUID устройства из БД WattPassports, поле deviceGuid таблицы оборудования
    FNote: string; // примечание, обычно NULL, можно swgType
    FComment: string; // комментарий для удобства
  protected
    function GetDeviceTypeID: integer;
    procedure SetDeviceTypeID(ADeviceTypeId: integer);
    function GetCellID: integer;
  public
    constructor Create(ADeviceID, ADeviceTypeId: integer; AGuid, ANote, AComment: string; ACell: TDSCell);
  	property DeviceId: integer read FDeviceId write FDeviceId;
    property DeviceTypeIndex: integer read FDeviceTypeIndex write FDeviceTypeIndex;
    property DeviceTypeId: integer read GetDeviceTypeID write SetDeviceTypeID; // ID типа устройства из таблицы dbo.DeviceTypes, возвращает по номеру FDeviceTypeIndex, устанавливает FDeviceTypeIndex по TDeviceType.FDeviceTypeId
    property CellId: integer read GetCellId; // ID ячейки из dbo.Cells
	  property Cell: TDSCell read FCell write FCell; // ячейка
    property Guid: string read FGuid write FGuid;
  	property Note: string read FNote write FNote;
  	property Comment: string read FComment write FComment;
  end;

  // TDSDeviceList - Класс для хранения устройств

  TDSDeviceList = TObjectList<TDSDevice>;

  // TDSSchemaElement - элемент схемы

  TDSSchemaElement = class
  private
    FSchemaElementId: integer; // ID элемента, локальный, создается автоматически в БД
    FDistrStationId: integer; // ID подстанции из БД
    FDevice: TDSDevice; // устройство, может быть NULL, если нет физического аналога
    FGuid: string; // GUID для соответствующего устройства из dbo.Devices из БД WattPassports, поле deviceGuid таблицы оборудования
    FNote: string; // примечание, обычно NULL, попробуем поле deviceType таблицы оборудования
    FComment: string; // комментарий для удобства, попробуем поле swgType таблицы оборудования
  protected
    function GetDeviceId: integer;
    function GetGuid: string;
    procedure SetGuid(AGuid: string);
  public
    constructor Create(ASchemaElementId, ADistrStationId: integer; ANote, AComment: string; ADevice: TDSDevice);
    property SchemaElementId: integer read FSchemaElementId write FSchemaElementId;
    property DistrStationId: integer read FDistrStationId write FDistrStationId;
    property Device: TDSDevice read FDevice write FDevice;
    property DeviceId: integer read GetDeviceID; // ID устройства для соответствующего устройства из dbo.Devices, либо NULL
    property Guid: string read GetGuid write SetGuid; // GUID, если Device=nil, иначе GUID устройства из dbo.Devices
  	property Note: string read FNote write FNote;
  	property Comment: string read FComment write FComment;
  end;

  // TDSSchemaElementList - Класс для хранения элементов схемы

  TDSSchemaElementList = TObjectList<TDSSchemaElement>;

type

  // TChannelTypes - Тип устройства

  TChannelType = record
    FChannelTypeId: integer; // ID из dbo.ChannelTypes
    FChannelTypeName: string; // название из dbo.ChannelTypes
	  FDescription: string; // описание
  end;

const
  CChannelTypes: array [0..2] of TChannelType = (
    (FChannelTypeId: 1; FChannelTypeName: 'Входной канал'; FDescription: ''),
  	(FChannelTypeId: 2; FChannelTypeName: 'Выходной канал'; FDescription: ''),
	  (FChannelTypeId: 3; FChannelTypeName: 'Аналоговый выходной канал	NULL'; FDescription: '')
  );

type

  // TDSChannel - Канал

  TDSChannel = class
  private
    FChannelId: integer; // ID элемента, локальный, создается автоматически в БД
    FModule: TDSModule; // модуль
    FOrderNumber: integer; // индекс сортировки, в соответствии с номером канала на модуле контроллера 0-15 или 0-3
    FChannelTypeIndex: integer; // локальный индекс типа канала в CChannelTypes
    FMinNormal: single; // минимальное значение сигнала (температуры)
    FMaxNormal: single; // максимальное значение сигнала (температуры)
    FMinEventId: integer; // ID события из dbo.Events при сигнале 0
    FMaxEventId: integer; // ID события из dbo.Events при сигнале 1
    FCell: TDSCell; // ячейка, может быть NULL, например для термометра
    FNote: string; // примечание, обычно NULL
    FSchemaElement: TDSSchemaElement; // элемент схемы, может быть NULL, если нет привзки к элементу
  protected
    function GetModuleId: integer;
    function GetControllerId: integer;
    function GetChannelTypeId: integer;
    procedure SetChannelTypeId(AChannelTypeId: integer);
    function GetCellID: integer;
    function GetSchemaElementId: integer;
  public
    constructor Create(AChannelId, AOrderNumber, AChannelTypeId: integer;
      AMinNormal, AMaxNormal: single;
      AMinEventId, AMaxEventId: integer;
      AModule: TDSModule; ACell: TDSCell; ANote: string);
    property ChannelId: integer read FChannelId write FChannelId;
    property Module: TDSModule read FModule write FModule;
    property ModuleId: integer read GetModuleId; // ID модуля из dbo.Modules
    property ControllerId: integer read GetControllerId; // ID контроллера из dbo.Controllers (из dbo.Modules)
    property OrderNumber: integer read FOrderNumber write FOrderNumber;
    property ChannelTypeIndex: integer read FChannelTypeIndex write FChannelTypeIndex;
    property ChannelTypeId: integer read GetChannelTypeID write SetChannelTypeID; // ID типа канала из таблицы dbo.ChannelTypes, возвращает по номеру FChannelTypeIndex, устанавливает FChannelTypeIndex по TChannelType.FChannelTypeId
    property MinNormal: single read FMinNormal write FMinNormal;
    property MaxNormal: single read FMaxNormal write FMaxNormal;
    property MinEventId: integer read FMinEventId write FMinEventId; // ID события из dbo.Events при сигнале 0
    property MaxEventId: integer read FMaxEventId write FMaxEventId; // ID события из dbo.Events при сигнале 1
    property CellId: integer read GetCellId; // ID ячейки из dbo.Cells
	  property Cell: TDSCell read FCell write FCell; // ячейка
  	property Note: string read FNote write FNote;
    property SchemaElement: TDSSchemaElement read FSchemaElement write FSchemaElement;
    property SchemaElementId: integer read GetSchemaElementId; // ID элемента из dbo.SchemaElements
  end;

  // TDSChannelList - Класс для хранения каналов

  TDSChannelList = TObjectList<TDSChannel>;

  // TDSSchemaElementChannel - элемент схемы с каналом

  TDSSchemaElementChannel = class
  private
    FSchemaElement: TDSSchemaElement; // элемента схемы
    FChannel: TDSChannel; // канал
  protected
    function GetSchemaElementId: integer;
    function GetChannelId: integer;
  public
    constructor Create(ASchemaElement: TDSSchemaElement; AChannel: TDSChannel);
    property SchemaElement: TDSSchemaElement read FSchemaElement write FSchemaElement;
    property Channel: TDSChannel read FChannel write FChannel;
    property SchemaElementId: integer read GetSchemaElementId; // ID элемента схемы из dbo.ShemaElements
    property ChannelId: integer read GetChannelId; // ID канала из dbo.Channels
  end;

 // TDSSchemaElementChannelList - Класс для хранения элементов схемы с каналом

  TDSSchemaElementChannelList = TObjectList<TDSSchemaElementChannel>;

type

  // TDistrStationType - Тип подстанции из таблицы dbo.DistrStationTypes

  TDistrStationType = record
  	FDistrStationTypeId: integer;
    FName: string;
  end;

const
  CDistrStationTypes: array [0..1] of TDistrStationType = (
    (FDistrStationTypeId: 1; FName: 'ТП'),
  	(FDistrStationTypeId: 2; FName: 'РП')
  );

const
  keyCellDeviceArray: array [0..7] of string = (
    'idCell',
    'guid',
    'number',
    'idCell',
    'numberOnOrder',
    'deviceGuid',
    'deviceType',
    'swgType'
  );

  keyCellidCell = 0;
  keyCellguid = 1;
  keyCellnumber = 2;
  keyDeviceidCell = 3;
  keyDevicenumberOnOrder = 4;
  keyDevicedeviceGuid = 5;
  keyDevicedeviceType = 6;
  keyDeviceswgType = 7;

  keyChannelArray: array [0..8] of string = (
    'ControllerNumber',
    'ModuleNumber',
    'OrderNumber',
    'CellNumber',
    'MinNormal',
    'MaxNormal',
    'MinEvent',
    'MaxEvent',
    'Note'
  );

  keyChannelControllerNumber = 0;
  keyChannelModuleNumber = 1;
  keyChannelOrderNumber = 2;
  keyChannelCellNumber = 3;
  keyChannelMinNormal = 4;
  keyChannelMaxNormal = 5;
  keyChannelMinEvent = 6;
  keyChannelMaxEvent = 7;
  keyChannelNote = 8;

const
  CScadaDBDistrStationsTable: string = '[dbo].[DistrStations]';
  CScadaDBControllersTable: string = '[dbo].[Controllers]';
  CScadaDBModulesTable: string = '[dbo].[Modules]';
  CScadaDBCellsTable: string = '[dbo].[Cells]';
  CScadaDBDevicesTable: string = '[dbo].[Devices]';
  CScadaDBSchemaElementsTable: string = '[dbo].[SchemaElements]';
  CScadaDBChannelsTable: string = '[dbo].[Channels]';
  CScadaDBSchemaElementChannelsTable: string = '[dbo].[SchemaElementChannels]';

{
  CScadaDBDistrStationsTable: string = 'ScadaDB.dbo.DistrStations';
  CScadaDBControllersTable: string = 'ScadaDB.dbo.Controllers';
  CScadaDBModulesTable: string = 'ScadaDB.dbo.Modules';
  CScadaDBCellsTable: string = 'ScadaDB.dbo.Cells';
  CScadaDBDevicesTable: string = 'ScadaDB.dbo.Devices';
  CScadaDBSchemaElementsTable: string = 'ScadaDB.dbo.SchemaElements';
  CScadaDBChannelsTable: string = 'ScadaDB.dbo.Channels';
  CScadaDBSchemaElementChannelsTable: string = 'ScadaDB.dbo.SchemaElementChannels';
}

type

  // TDistrStation - Подстанция

  TDistrStation = class
  private
    FDistrStationID: integer; // ID подстанции, если надо создавать в БД, то 0, если уже создан в БД, то значение из БД
    FDistrStationTypeIndex: integer; // локальный индекс типа подстанции в CDistrStationTypes
    FDistrStationName: string; // название подстанции
    FNumber: integer; // номер подстанции
    FGuid: string; // GUID устройства из БД
    FDescription: string; // описание (напр., Билайн)
{
    UserOrderIndex   // NULL
    ColorIndex // NULL
    Address // NULL
    LastPoll // NULL
    IsIgnored: boolean; // true
}
   	FControllers: TDSControllerList; // контроллеры
  	FModules: TDSModuleList; // модули
    FCells: TDSCellList; // ячейки
    FDevices: TDSDeviceList; // устройства
    FSchemaElements: TDSSchemaElementList; // элементы схемы
    FChannels: TDSChannelList; // каналы
    FSchemaElementChannels: TDSSchemaElementChannelList; // элементы схемы с каналами
  protected
    function GetDistrStationTypeID: integer;
    procedure SetDistrStationTypeID(ADistrStationTypeID: integer);
  public
    constructor Create;
	  destructor Destroy; override;
    procedure Clear; // удаляет ВСЕ элементы подстанции
    function CanDelController(AController: TDSController): boolean; // TRUE, если можно удалить контроллер
    function CanDelModule(AModule: TDSModule): boolean; // TRUE, если можно удалить модуль
    function CanDelCell(ACell: TDSCell): boolean; // TRUE, если можно удалить ячейку
    function CanDelDevice(ADevice: TDSDevice): boolean; // TRUE, если можно удалить устройство
    function CanDelSchemaElement(ASchemaElement: TDSSchemaElement): boolean; // TRUE, если можно удалить элемент схемы
    function CanDelChannel(AChannel: TDSChannel): boolean; // TRUE, если можно удалить канал

    procedure UpdateDistrStationID; // обновляет DistrStationID у всех зависимых элементов
    {
    procedure UpdateCellID(ACell: TDSCell); // обновляет CellID у всех зависимых элементов
    }
    procedure LoadCellsDevicesFromTxt(AFileName: string; AStrings: TStrings); // загрузить ячейки и устройства из текста с форматированием
    procedure LoadChannelsFromTxt(AFileName: string; AStrings: TStrings); // загрузить каналы из текста с форматированием

    function GetCellIndexAtGuid(AGuid: string): integer; // возвращает индекс ячейки или -1
    function GetCellIndexAtNumber(AOrderNumber: integer): integer; // возвращает индекс ячейки или -1

    function GetDeviceIndexAtGuid(AGuid: string): integer; // возвращает индекс устройства или -1

    function GetControllerIndexAtNumber(AOrderNumber: integer): integer; // возвращает индекс контроллера или -1
    function GetControllerNumber(AController: TDSController): integer; // возвращает номер контроллера или -1

    function GetModuleIndexAtNumber(AControllerIndex, AOrdinalNumber: integer): integer; // возвращает индекс модуля или -1

    function GetChannelIndexAtNumber(AModuleIndex, AOrderNumber: integer): integer; // возвращает индекс канала или -1

    procedure LoadFromXML(AFileName: string; AStrings: TStrings); // загрузить из XML файла
    procedure SaveToXML(AFileName: string; AStrings: TStrings); // сохранить в XML файл

    procedure SaveToSQL(AFileName: string; AStrings: TStrings); // сохранить запрос в SQL файл

  	property DistrStationID: integer read FDistrStationID write FDistrStationID;
    property DistrStationTypeIndex: integer read FDistrStationTypeIndex;
  	property DistrStationTypeID: integer read GetDistrStationTypeID write SetDistrStationTypeID;
    property DistrStationName: string read FDistrStationName write FDistrStationName;
    property Number: integer read FNumber write FNumber;
    property Guid: string read FGuid write FGuid;
    property Description: string read FDescription write FDescription;
	  property Controllers: TDSControllerList read FControllers write FControllers;
  	property Modules: TDSModuleList read FModules write FModules;
  	property Cells: TDSCellList read FCells write FCells;
  	property Devices: TDSDeviceList read FDevices write FDevices;
    property Channels: TDSChannelList read FChannels write FChannels;
  	property SchemaElements: TDSSchemaElementList read FSchemaElements write FSchemaElements;
  	property SchemaElementChannels: TDSSchemaElementChannelList read FSchemaElementChannels write FSchemaElementChannels;
  end;

const
  // паттерн GUID
  CGUIDPattern = '^[0-9A-Fa-f]{8}\-[0-9A-Fa-f]{4}\-[0-9A-Fa-f]{4}\-[0-9A-Fa-f]{4}\-[0-9A-Fa-f]{12}$';

// проверяет строку на соответствие формату GUID
function CheckGUIDString(AGUID: string): boolean;
// генерирует GUID
function GetGUIDString: string;

implementation

function GetGUIDString: string;
var
  NewGuid: TGUID;
begin
  CreateGUID(NewGuid);
  Result:=GUIDToString(NewGuid);
  Result:=Copy(Result, 2, Length(Result)-2);
end;

function CheckGUIDString(AGUID: string): boolean;
var
  RegEx: TRegEx;
begin
  Result:=RegEx.IsMatch(AGUID, CGUIDPattern);
{
  RegEx.Create(CGUIDPattern);
  Result:=RegEx.IsMatch(AGUID);
}
end;

// TDistrStation

constructor TDistrStation.Create;
begin
  inherited;
  DistrStationId:=0;
  DistrStationTypeID:=1;
  DistrStationName:='';
  Number:=0;
  Guid:='';
  Description:=''; // описание (напр., Билайн)

  // контроллеры
  FControllers:=TDSControllerList.Create();
  FControllers.OwnsObjects:=true; // по умолчанию

  // модули
  FModules:=TDSModuleList.Create();
  FModules.OwnsObjects:=true; // по умолчанию

  // ячейки
  FCells:=TDSCellList.Create();
  FCells.OwnsObjects:=true; // по умолчанию

  // устройства
  FDevices:=TDSDeviceList.Create();
  FDevices.OwnsObjects:=true; // по умолчанию

  // элементы схемы
  FSchemaElements:=TDSSchemaElementList.Create();
  FSchemaElements.OwnsObjects:=true; // по умолчанию

  // каналы
  FChannels:=TDSChannelList.Create();
  FChannels.OwnsObjects:=true; // по умолчанию

  // элементы схемы с каналами
  FSchemaElementChannels:=TDSSchemaElementChannelList.Create();
  FSchemaElementChannels.OwnsObjects:=true; // по умолчанию

  {
  // контроллеры
  FControllers:=TDSControllerList.Create();
  FControllers.OwnsObjects:=true; // по умолчанию
  // добавляем 1 контроллер, иначе нет смысла
  FControllers.Add(TDSController.Create(0, 1, DistrStationID));

  // модули
  FModules:=TDSModuleList.Create();
  FModules.OwnsObjects:=true; // по умолчанию
  // добавляем 1 модуль, иначе нет смысла
  FModules.Add(TDSModule.Create(0, 4, 'i-87053PW', 0, Controllers[0]));

  // ячейки
  FCells:=TDSCellList.Create();
  FCells.OwnsObjects:=true; // по умолчанию
  // добавляем 1 ячейку, иначе нет смысла
  FCells.Add(TDSCell.Create(0, DistrStationID, 1, '', 'Ячейка 1', ''));

  // устройства
  FDevices:=TDSDeviceList.Create();
  FDevices.OwnsObjects:=true; // по умолчанию
  // добавляем 1 устройство, иначе нет смысла
  FDevices.Add(TDSDevice.Create(0, 1, '', 'РВЗ-Орб 07.1а 630А', 'ШР-6-1', Cells[0]));

  // элементы схемы
  FSchemaElements:=TDSSchemaElementList.Create();
  FSchemaElements.OwnsObjects:=true; // по умолчанию
  // добавляем 1 элемент схемы, иначе нет смысла
  FSchemaElements.Add(TDSSchemaElement.Create(0, DistrStationId, '', Devices[0]));

  // каналы
  FChannels:=TDSChannelList.Create();
  FChannels.OwnsObjects:=true; // по умолчанию
  // добавляем 1 канал, иначе нет смысла
  FChannels.Add(TDSChannel.Create(0, 0, 1, 0.5, 0.5, 0, 1, Modules[0], Cells[0], ''));

  // элементы схемы с каналами
  FSchemaElementChannels:=TDSSchemaElementChannelList.Create();
  FSchemaElementChannels.OwnsObjects:=true; // по умолчанию
  // добавляем 1 элемент схемы с каналом, иначе нет смысла
  FSchemaElementChannels.Add(TDSSchemaElementChannel.Create(SchemaElements[0], Channels[0]));
}
end;

destructor TDistrStation.Destroy;
begin
  Clear;
  FSchemaElementChannels.Free;
  FChannels.Free;
  FSchemaElements.Free;
  FDevices.Free;
  FCells.Free;
  FModules.Free;
  FControllers.Free;
  inherited;
end;

procedure TDistrStation.Clear;
begin
  // элементы схемы с каналами
  FSchemaElementChannels.Clear;
  // каналы
  FChannels.Clear;
  // элементы схемы
  FSchemaElements.Clear;
  // устройства
  FDevices.Clear;
  // ячейки
  FCells.Clear;
  // модули
  FModules.Clear;
  // контроллеры
  FControllers.Clear;
  // прочие поля
  DistrStationId:=0;
  DistrStationTypeID:=1;
  DistrStationName:='';
  Number:=0;
  Guid:='';
  Description:=''; // описание (напр., Билайн)
end;

function TDistrStation.GetDistrStationTypeId: integer;
begin
  // ID типа подстанции из dbo.DistrStationTypes, возвращает по номеру FDistrStationTypeIndex
  Result:=CDistrStationTypes[FDistrStationTypeIndex].FDistrStationTypeId;
end;

procedure TDistrStation.SetDistrStationTypeID(ADistrStationTypeID: integer);
var
  i: integer;
begin
  // ID типа подстанции из dbo.DistrStationTypes, устанавливает FDistrStationTypeIndex по TDeviceType.FDistrStationTypeID
  i:=Low(CDistrStationTypes);
  while (i <= High(CDistrStationTypes)) and (ADistrStationTypeID <> CDistrStationTypes[i].FDistrStationTypeId) do
  begin
    i:=i+1;
  end;
  if (i <= High(CDistrStationTypes)) then
    FDistrStationTypeIndex:=i
  else
    raise Exception.CreateFmt('Неизвестный тип подстанции %d.', [ADistrStationTypeID]);
end;

function TDistrStation.CanDelController(AController: TDSController): boolean;
var
  i: integer;
begin
  // TRUE, если можно удалить контроллер
  Result:=true;
  for i:=0 to Modules.Count-1 do
    if (Modules[i].Controller = AController) then
      Result:=false;
end;

function TDistrStation.CanDelModule(AModule: TDSModule): boolean;
var
  i: integer;
begin
  // TRUE, если можно удалить модуль
  Result:=true;
  for i:=0 to Channels.Count-1 do
    if (Channels[i].Module = AModule) then
      Result:=false;
end;

function TDistrStation.CanDelCell(ACell: TDSCell): boolean;
var
  i: integer;
begin
  // TRUE, если можно удалить ячейку
  Result:=true;
  for i:=0 to Devices.Count-1 do
    if (Devices[i].Cell = ACell) then
      Result:=false;
  for i:=0 to Channels.Count-1 do
    if (Channels[i].Cell = ACell) then
      Result:=false;
end;

function TDistrStation.CanDelDevice(ADevice: TDSDevice): boolean;
var
  i: integer;
begin
  // TRUE, если можно удалить устройство
  Result:=true;
  for i:=0 to SchemaElements.Count-1 do
    if (SchemaElements[i].Device = ADevice) then
      Result:=false;
end;

function TDistrStation.CanDelChannel(AChannel: TDSChannel): boolean;
var
  i: integer;
begin
  // TRUE, если можно удалить канал
  Result:=true;
  for i:=0 to SchemaElementChannels.Count-1 do
    if (SchemaElementChannels[i].Channel = AChannel) then
      Result:=false;
end;

function TDistrStation.CanDelSchemaElement(ASchemaElement: TDSSchemaElement): boolean;
var
  i: integer;
begin
  // TRUE, если можно удалить элемент схемы
  Result:=true;
  for i:=0 to SchemaElementChannels.Count-1 do
    if (SchemaElementChannels[i].SchemaElement = ASchemaElement) then
      Result:=false;
end;

procedure TDistrStation.UpdateDistrStationID;
var
  i: integer;
begin
  // обновляет DistrStationID у всех зависимых элементов
  if assigned(Controllers) then
    for i:=0 to Controllers.Count-1 do
      Controllers[i].DistrStationId:=FDistrStationID;
  if assigned(Cells) then
    for i:=0 to Cells.Count-1 do
      Cells[i].DistrStationId:=FDistrStationID;
  if assigned(SchemaElements) then
    for i:=0 to SchemaElements.Count-1 do
      SchemaElements[i].DistrStationId:=FDistrStationID;
end;

procedure TDistrStation.LoadCellsDevicesFromTxt(AFileName: string; AStrings: TStrings);
var
  i, j, n, n1, n2: integer;
  ss: TStringList;
  nomCellDeviceArray: array [0..7] of integer;
  s: string;
  sArr: TStringDynArray;
begin
  // загрузить ячейки и устройства из текста с форматированием
  ss:=TStringList.Create;
  try
    // загрузка
    AStrings.Add('Загрузка ячеек и устройств подстанции из *.txt.');
    AStrings.Add(Format('Файл: %s',[AFileName]));
    ss.LoadFromFile(AFileName);
    if (ss.Count = 0) then
    begin
      AStrings.Add('Файл пустой.');
      raise Exception.Create('Файл пустой.');
    end;

    sArr:=SplitString(ss[0], #9);
    // проверка файла по наличию ключей
    for i:=Low(keyCellDeviceArray) to High(keyCellDeviceArray) do
    begin
      j:=0;
      nomCellDeviceArray[i]:=0;
      while (j < Length(sArr)) and (trim(sArr[j]) <> keyCellDeviceArray[i]) do
        inc(j);
      if (j < Length(sArr)) then
        nomCellDeviceArray[i]:=j
      else
        raise Exception.CreateFmt('Ключ не найден: %s', [keyCellDeviceArray[i]]);
    end;

    // все ключи найдены, удалаяем зависимости
    SchemaElementChannels.Clear;
    Channels.Clear;
    SchemaElements.Clear;
    Devices.Clear;
    Modules.Clear; // т.к. ссылается Channels
    Controllers.Clear; // дабы не смущать
    Cells.Clear;

    // загружаем ячейки
    for i:=1 to ss.Count-1 do
    begin
      sArr:=SplitString(ss[i], #9);
      n:=GetCellIndexAtGuid(sArr[nomCellDeviceArray[keyCellguid]]);
      if (n = -1) then
      begin
        Cells.Add(TDSCell.Create(0,
          DistrStationID,
          StrToInt(sArr[nomCellDeviceArray[keyCellnumber]]),
          sArr[nomCellDeviceArray[keyCellguid]],
          'Ячейка '+sArr[nomCellDeviceArray[keyCellnumber]],
          ''));
      end;
    end;

    // загружаем устройства
    for i:=1 to ss.Count-1 do
    begin
      sArr:=SplitString(ss[i], #9);
      n:=GetDeviceIndexAtGuid(sArr[nomCellDeviceArray[keyDevicedeviceguid]]);
      if (n = -1) then
      begin
        n1:=GetCellIndexAtGuid(sArr[nomCellDeviceArray[keyCellguid]]);
        n2:=GetDeviceTypeIdAtName(sArr[nomCellDeviceArray[keyDevicedeviceType]]);
        //if (n2 = -1) then
        //  raise Exception.CreateFmt('Неизвестный тип устройства: %s', sArr[nomCellDeviceArray[keyDevicedeviceType]]);
        if (n2 > -1) then
          Devices.Add(TDSDevice.Create(0,
            n2,
            sArr[nomCellDeviceArray[keyDevicedeviceGuid]],
            sArr[nomCellDeviceArray[keyDevicedeviceType]],
            sArr[nomCellDeviceArray[keyDeviceswgType]],
            Cells[n1]));
      end;
    end;

    // создаем элементы схемы, соответствующие физическим устройствам
    for i:=0 to Devices.Count-1 do
      SchemaElements.Add(TDSSchemaElement.Create(0,
        DistrStationId,
        Devices[i].Note,
        Devices[i].Comment,
        Devices[i]));

    AStrings.Add('Подстанция загружена из *.txt.');
    AStrings.Add(Format('Создано ячеек: %d',[Cells.Count]));
    AStrings.Add(Format('Создано устройств: %d',[Devices.Count]));
    AStrings.Add(Format('Создано элементов схемы: %d',[SchemaElements.Count]));
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
    end;
  end;
  SetLength(sArr, 0);
  ss.Free;
end;

function IsEmptyString(AString: string): boolean;
var
  i: integer;
  s: string;
begin
  s:=AString;
  i:=1;
  while (i <= Length(s)) do
    if (s[i] = #9) or (s[i] = ' ') or (s[i] = #10) or (s[i] = #13) then
      Delete(s, i, 1)
    else
      i:=i+1;
  Result:=Length(s) = 0;
end;

function StrToFloatDS(AString: string): single;
var
  s: string;
  i1, i2: integer;
begin
  s:=trim(AString);
  i1:=Pos('.', s);
  i2:=Pos(',', s);
  if (FormatSettings.DecimalSeparator = ',') and (i1 > 0) then
    s[i1]:=',';
  if (FormatSettings.DecimalSeparator = '.') and (i2 > 0) then
    s[i2]:='.';
  if (s = '') or (UpperCase(s) = 'NULL') then
    Result:=0
  else
    Result:=StrToFloat(s);
end;

function StrToIntDS(AString: string): integer;
var
  s: string;
begin
  s:=trim(AString);
  if (s = '') or (UpperCase(s) = 'NULL')then
    Result:=0
  else
    Result:=StrToInt(s);
end;

procedure TDistrStation.LoadChannelsFromTxt(AFileName: string; AStrings: TStrings);
var
  i, j, n, nCo, nMo, nCh, nCe, minE, maxE: integer;
  minN, maxN: single;
  ss: TStringList;
  nomChannelArray: array [0..8] of integer;
  s: string;
  sArr: TStringDynArray;
begin
  // загрузить каналы из текста с форматированием
  ss:=TStringList.Create;
  try
    // загрузка
    AStrings.Add('Загрузка каналов из *.txt.');
    AStrings.Add(Format('Файл: %s',[AFileName]));
    ss.LoadFromFile(AFileName);
    if (ss.Count <= 1) then
    begin
      AStrings.Add('Файл пустой.');
      raise Exception.Create('Файл пустой.');
    end;

    sArr:=SplitString(ss[0], #9);
    AStrings.Add(Format('Подстанция: %s',[sArr[0]]));

    sArr:=SplitString(ss[1], #9);
    // проверка файла по наличию ключей
    for i:=Low(keyChannelArray) to High(keyChannelArray) do
    begin
      j:=0;
      nomChannelArray[i]:=0;
      while (j < Length(sArr)) and (trim(sArr[j]) <> keyChannelArray[i]) do
        inc(j);
      if (j < Length(sArr)) then
        nomChannelArray[i]:=j
      else
        raise Exception.CreateFmt('Ключ не найден: %s', [keyChannelArray[i]]);
    end;

    // все ключи найдены, удалаяем зависимости
    SchemaElementChannels.Clear;

    // загружаем каналы
    for i:=2 to ss.Count-1 do
    begin
      // AStrings.Add(Format('[Стр. %d] %s', [i, ss[i]]));
      sArr:=SplitString(ss[i], #9);
      // пропускаем пустые строки
      if not IsEmptyString(
        sArr[nomChannelArray[keyChannelControllerNumber]]+
        sArr[nomChannelArray[keyChannelModuleNumber]]+
        sArr[nomChannelArray[keyChannelOrderNumber]]+
        sArr[nomChannelArray[keyChannelCellNumber]]) then
      //if not IsEmptyString(ss[i]) then
      begin
        nCo:=GetControllerIndexAtNumber(StrToInt(sArr[nomChannelArray[keyChannelControllerNumber]]));
        if (nCo = -1) then
          raise Exception.CreateFmt('[Стр. %d] Неверный номер контроллера: %d', [i, StrToInt(sArr[nomChannelArray[keyChannelControllerNumber]])]);

        nMo:=GetModuleIndexAtNumber(nCo, StrToInt(sArr[nomChannelArray[keyChannelModuleNumber]]));
        if (nMo < 0) then
          raise Exception.CreateFmt('[Стр. %d] Неверный номер модуля: %d', [i, StrToInt(sArr[nomChannelArray[keyChannelModuleNumber]])]);

        nCh:=GetChannelIndexAtNumber(nMo, StrToInt(sArr[nomChannelArray[keyChannelOrderNumber]]));
        if (nCh < 0) then
          raise Exception.CreateFmt('[Стр. %d] Неверный номер канала: %d', [i, StrToInt(sArr[nomChannelArray[keyChannelOrderNumber]])]);

        nCe:=GetCellIndexAtNumber(StrToIntDS(sArr[nomChannelArray[keyChannelCellNumber]]));
        if (nCe < 0) then
          AStrings.Add(Format('[Стр. %d] Отсутствует или неверный номер ячейки: %d', [i, StrToIntDS(sArr[nomChannelArray[keyChannelCellNumber]])]));
{
        if (nCe < 0) then
          raise Exception.CreateFmt('[Стр. %d] Неверный номер ячейки: %d', [i, StrToInt(sArr[nomChannelArray[keyChannelCellNumber]])]);
}
        minN:=StrToFloatDS(sArr[nomChannelArray[keyChannelMinNormal]]);
        maxN:=StrToFloatDS(sArr[nomChannelArray[keyChannelMaxNormal]]);

        minE:=StrToIntDS(sArr[nomChannelArray[keyChannelMinEvent]]);
        if (minE < 0) then
          raise Exception.CreateFmt('[Стр. %d] Номер события minEventID=%d < 0', [i, minE]);
        if (minE > CMaxEventsID) then
          AStrings.Add(Format('[Стр. %d] Номер события minEventID=%d > %d', [i, minE, CMaxEventsID]));
        maxE:=StrToIntDS(sArr[nomChannelArray[keyChannelMaxEvent]]);
        if (maxE < 0) then
          raise Exception.CreateFmt('[Стр. %d] Номер события maxEventID=%d < 0', [i, maxE]);
        if (maxE > CMaxEventsID) then
          AStrings.Add(Format('[Стр. %d] Номер события maxEventID=%d > %d', [i, maxE, CMaxEventsID]));

        // все нормально, устанавливаем значения
        if (nCe < 0) then
          Channels[nCh].Cell:=nil
        else
          Channels[nCh].Cell:=Cells[nCe];
        Channels[nCh].MinNormal:=minN;
        Channels[nCh].MaxNormal:=maxN;
        Channels[nCh].MinEventId:=minE;
        Channels[nCh].MaxEventId:=maxE;
        Channels[nCh].Note:=sArr[nomChannelArray[keyChannelNote]];
      end else
      begin
        AStrings.Add(Format('[Стр. %d] Пропущена как пустая', [i]));
      end;
    end;

    // все каналы загружены, создаем связи каналов с элементами
    if (Channels.Count > 0) then
      for i:=0 to Channels.Count-1 do
      begin
        n:=SchemaElementChannels.Add(TDSSchemaElementChannel.Create(nil, Channels[i]));

      end;

    AStrings.Add('Каналы загружены из *.txt.');
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
    end;
  end;
  SetLength(sArr, 0);
  ss.Free;
end;

function TDistrStation.GetCellIndexAtGuid(AGuid: string): integer;
var
  i: integer;
begin
  // возвращает индекс ячейки или -1
  Result:=-1;
  for i:=0 to Cells.Count-1 do
    if (Cells[i].Guid = AGuid) then
      Result:=i;
end;

function TDistrStation.GetDeviceIndexAtGuid(AGuid: string): integer;
var
  i: integer;
begin
  // возвращает индекс устройства или -1
  Result:=-1;
  for i:=0 to Devices.Count-1 do
    if (Devices[i].Guid = AGuid) then
      Result:=i;
end;

function TDistrStation.GetControllerIndexAtNumber(AOrderNumber: integer): integer;
var
  i: integer;
begin
  // возвращает индекс контроллера или -1
  Result:=-1;
  if (AOrderNumber >=0 ) and (AOrderNumber < Controllers.Count) then
    Result:=AOrderNumber;
end;

function TDistrStation.GetControllerNumber(AController: TDSController): integer;
var
  i: integer;
begin
  // возвращает номер контроллера или -1
  Result:=-1;
  for i:=0 to Controllers.Count-1 do
    if (AController = Controllers[i]) then
      Result:=i;
end;

function TDistrStation.GetModuleIndexAtNumber(AControllerIndex, AOrdinalNumber: integer): integer;
var
  i: integer;
begin
  // возвращает индекс модуля или -1
  Result:=-1;
  for i:=0 to Modules.Count-1 do
    if (Modules[i].Controller = Controllers[AControllerIndex]) and
     (Modules[i].OrdinalNumber = AOrdinalNumber) then
      Result:=i;
end;

function TDistrStation.GetCellIndexAtNumber(AOrderNumber: integer): integer;
var
  i: integer;
begin
  // возвращает индекс ячейки или -1
  Result:=-1;
  for i:=0 to Cells.Count-1 do
    if (Cells[i].OrderNumber = AOrderNumber) then
      Result:=i;
end;

function TDistrStation.GetChannelIndexAtNumber(AModuleIndex, AOrderNumber: integer): integer;
var
  i: integer;
begin
  // возвращает индекс канала или -1
  Result:=-1;
  for i:=0 to Channels.Count-1 do
    if (Channels[i].Module = Modules[AModuleIndex]) and
      (Channels[i].OrderNumber = AOrderNumber) then
      Result:=i;
end;

procedure TDistrStation.LoadFromXML(AFileName: string; AStrings: TStrings);
var
  XMLDoc: IXMLDocument;
  XMLNode, XMLNode2, XMLNode3: IXMLNode;
  c: Char;
  s: string;
  i, n, k: integer;
begin
  // загрузить из XML файла
  try
    // загрузка
    AStrings.Add('Загрузка ТП из *.xml.');
    AStrings.Add(Format('Файл: %s',[AFileName]));

    // удалаяем зависимости
    Clear;

    XMLDoc:=TXMLDocument.Create(nil);
    XMLDoc.Active:=true;
    XMLDoc.LoadFromFile(AFileName);
    c:=FormatSettings.DecimalSeparator;
{
    if (XMLDoc.DocumentElement.Attributes['DecimalSeparator'] <> Null) then
      FormatSettings.DecimalSeparator:=XMLDoc.DocumentElement.Attributes['DecimalSeparator']
    else
      FormatSettings.DecimalSeparator:='.';
}

    XMLNode:=XMLDoc.ChildNodes['DistrStation'];


    if (XMLNode.Attributes['DistrStationID'] <> Null) then
      DistrStationID:=XMLNode.Attributes['DistrStationID'];

    if (XMLNode.Attributes['DistrStationTypeIndex'] <> Null) then
      DistrStationTypeID:=CDistrStationTypes[integer(XMLNode.Attributes['DistrStationTypeIndex'])].FDistrStationTypeId;
    if (XMLNode.Attributes['DistrStationName'] <> Null) then
      DistrStationName:=XMLNode.Attributes['DistrStationName'];
    if (XMLNode.Attributes['Number'] <> Null) then
      Number:=XMLNode.Attributes['Number'];
    if (XMLNode.Attributes['Guid'] <> Null) then
      Guid:=XMLNode.Attributes['Guid'];
    if (XMLNode.Attributes['Description'] <> Null) then
      Description:=XMLNode.Attributes['Description'];
    if (XMLNode.Attributes['DecimalSeparator'] <> Null) then
      s:=XMLNode.Attributes['DecimalSeparator']
    else
      s:=c;
    FormatSettings.DecimalSeparator:=s[1];

    XMLNode2:=XMLNode.ChildNodes['Controllers'];
    if (XMLNode2.Attributes['Count'] <> Null) then
      Controllers.Count:=XMLNode2.Attributes['Count'];
    for i:=0 to Controllers.Count-1 do
      Controllers[i]:=TDSController.Create(0, 1, DistrStationId);
    for i:=0 to XMLNode2.ChildNodes.Count-1 do
    begin
      XMLNode3:=XMLNode2.ChildNodes[i];
      n:=XMLNode3.Attributes['Index'];
      if (XMLNode3.Attributes['ControllerId'] <> Null) then
        Controllers[n].ControllerId:=XMLNode3.Attributes['ControllerId'];
      if (XMLNode3.Attributes['ControllerTypeIndex'] <> Null) then
        Controllers[n].ControllerTypeIndex:=XMLNode3.Attributes['ControllerTypeIndex'];
      if (XMLNode3.Attributes['DistrStationId'] <> Null) then
        Controllers[n].DistrStationId:=XMLNode3.Attributes['DistrStationId'];
      if (XMLNode3.Attributes['EthernetIsAvailable'] <> Null) then
        Controllers[n].EthernetIsAvailable:=XMLNode3.Attributes['EthernetIsAvailable'];
      if (XMLNode3.Attributes['GprsIsAvailable'] <> Null) then
        Controllers[n].GprsIsAvailable:=XMLNode3.Attributes['GprsIsAvailable'];
      if (XMLNode3.Attributes['Ethernet_LinkLost_Date'] <> Null) then
        Controllers[n].Ethernet_LinkLost_Date:=StrToDateTime(XMLNode3.Attributes['Ethernet_LinkLost_Date']);
        //Controllers[n].Ethernet_LinkLost_Date:=StrToDateTime(XMLNode3.Attributes['Ethernet_LinkLost_Date'], TFormatSettings);
        //Controllers[n].Ethernet_LinkLost_Date:=StrToDateTime(XMLNode3.Attributes['Ethernet_LinkLost_Date'], CDateTimeControllerFormat);
      if (XMLNode3.Attributes['Gprs_LinkLost_Date'] <> Null) then
        Controllers[n].Gprs_LinkLost_Date:=StrToDateTime(XMLNode3.Attributes['Gprs_LinkLost_Date']);
       //Controllers[n].Gprs_LinkLost_Date:=StrToDateTime(XMLNode3.Attributes['Gprs_LinkLost_Date'], CDateTimeControllerFormat);
       //Controllers[n].Gprs_LinkLost_Date:=StrToDateTime(XMLNode3.Attributes['Gprs_LinkLost_Date'], CDateTimeControllerFormat);
    end;
    AStrings.Add(Format('Контроллеры: %d',[Controllers.Count]));

    XMLNode2:=XMLNode.ChildNodes['Modules'];
    if (XMLNode2.Attributes['Count'] <> Null) then
      Modules.Count:=XMLNode2.Attributes['Count'];
    for i:=0 to Modules.Count-1 do
      Modules[i]:=TDSModule.Create(0, 4, '', 0, nil, 0);
    for i:=0 to XMLNode2.ChildNodes.Count-1 do
    begin
      XMLNode3:=XMLNode2.ChildNodes[i];
      n:=XMLNode3.Attributes['Index'];
      if (XMLNode3.Attributes['ModuleId'] <> Null) then
        Modules[n].ModuleId:=XMLNode3.Attributes['ModuleId'];
      if (XMLNode3.Attributes['ModuleTypeIndex'] <> Null) then
        Modules[n].ModuleTypeIndex:=XMLNode3.Attributes['ModuleTypeIndex'];
      if (XMLNode3.Attributes['Controller'] <> Null) then
        if (XMLNode3.Attributes['Controller'] > -1) and
          (XMLNode3.Attributes['Controller'] < Controllers.Count) then
          Modules[n].Controller:=Controllers[XMLNode3.Attributes['Controller']];
      if (XMLNode3.Attributes['ModuleName'] <> Null) then
        Modules[n].ModuleName:=XMLNode3.Attributes['ModuleName'];
      if (XMLNode3.Attributes['OrdinalNumber'] <> Null) then
        Modules[n].OrdinalNumber:=XMLNode3.Attributes['OrdinalNumber'];
      if (XMLNode3.Attributes['ChannelCount'] <> Null) then
        Modules[n].ChannelCount:=XMLNode3.Attributes['ChannelCount'];
      // сразу каналы не создаем, надежда на целостность файла, создадутся потом
    end;
    AStrings.Add(Format('Модули: %d',[Modules.Count]));

    XMLNode2:=XMLNode.ChildNodes['Cells'];
    if (XMLNode2.Attributes['Count'] <> Null) then
      Cells.Count:=XMLNode2.Attributes['Count'];
    for i:=0 to Cells.Count-1 do
      Cells[i]:=TDSCell.Create(0, DistrStationID, i+1, '', '', '');
    for i:=0 to XMLNode2.ChildNodes.Count-1 do
    begin
      XMLNode3:=XMLNode2.ChildNodes[i];
      n:=XMLNode3.Attributes['Index'];
      if (XMLNode3.Attributes['CellId'] <> Null) then
        Cells[n].CellId:=XMLNode3.Attributes['CellId'];
      if (XMLNode3.Attributes['DistrStationId'] <> Null) then
        Cells[n].DistrStationId:=XMLNode3.Attributes['DistrStationId'];
      //if (XMLNode3.Attributes['CellTypeId'] <> Null) then
      //  Cells[i].CellTypeId:=XMLNode3.Attributes['CellTypeId'];
      if (XMLNode3.Attributes['OrderNumber'] <> Null) then
        Cells[n].OrderNumber:=XMLNode3.Attributes['OrderNumber'];
      if (XMLNode3.Attributes['Guid'] <> Null) then
        Cells[n].Guid:=XMLNode3.Attributes['Guid'];
      if (XMLNode3.Attributes['CellName'] <> Null) then
        Cells[n].CellName:=XMLNode3.Attributes['CellName'];
      if (XMLNode3.Attributes['Note'] <> Null) then
        Cells[n].Note:=XMLNode3.Attributes['Note'];
    end;
    AStrings.Add(Format('Ячейки: %d',[Cells.Count]));


    XMLNode2:=XMLNode.ChildNodes['Devices'];
    if (XMLNode2.Attributes['Count'] <> Null) then
      Devices.Count:=XMLNode2.Attributes['Count'];
    for i:=0 to Devices.Count-1 do
      Devices[i]:=TDSDevice.Create(0, 1, '', '', '', Cells[0]);
    for i:=0 to XMLNode2.ChildNodes.Count-1 do
    begin
      XMLNode3:=XMLNode2.ChildNodes[i];
      n:=XMLNode3.Attributes['Index'];
      if (XMLNode3.Attributes['DeviceId'] <> Null) then
        Devices[n].DeviceId:=XMLNode3.Attributes['DeviceId'];
      if (XMLNode3.Attributes['DeviceTypeIndex'] <> Null) then
        Devices[n].DeviceTypeIndex:=XMLNode3.Attributes['DeviceTypeIndex'];
      if (XMLNode3.Attributes['Cell'] <> Null) then
        if (XMLNode3.Attributes['Cell'] > -1) and
          (XMLNode3.Attributes['Cell'] < Cells.Count) then
          Devices[n].Cell:=Cells[XMLNode3.Attributes['Cell']];
      if (XMLNode3.Attributes['Guid'] <> Null) then
        Devices[n].Guid:=XMLNode3.Attributes['Guid'];
      if (XMLNode3.Attributes['Note'] <> Null) then
        Devices[n].Note:=XMLNode3.Attributes['Note'];
      if (XMLNode3.Attributes['Comment'] <> Null) then
        Devices[n].Comment:=XMLNode3.Attributes['Comment'];
    end;
    AStrings.Add(Format('Устройства: %d',[Devices.Count]));

    XMLNode2:=XMLNode.ChildNodes['SchemaElements'];
    if (XMLNode2.Attributes['Count'] <> Null) then
      SchemaElements.Count:=XMLNode2.Attributes['Count'];
    for i:=0 to SchemaElements.Count-1 do
      SchemaElements[i]:=TDSSchemaElement.Create(0, DistrStationId, '', '', nil);
    for i:=0 to XMLNode2.ChildNodes.Count-1 do
    begin
      XMLNode3:=XMLNode2.ChildNodes[i];
      n:=XMLNode3.Attributes['Index'];
      if (XMLNode3.Attributes['SchemaElementId'] <> Null) then
        SchemaElements[n].SchemaElementId:=XMLNode3.Attributes['SchemaElementId'];
      if (XMLNode3.Attributes['DistrStationId'] <> Null) then
        SchemaElements[n].DistrStationId:=XMLNode3.Attributes['DistrStationId'];
      if (XMLNode3.Attributes['Device'] <> Null) then
        if (XMLNode3.Attributes['Device'] > -1) and
          (XMLNode3.Attributes['Device'] < Devices.Count) then
          SchemaElements[n].Device:=Devices[XMLNode3.Attributes['Device']];
      if (XMLNode3.Attributes['Guid'] <> Null) and (SchemaElements[n].Device = nil) then
        SchemaElements[n].Guid:=XMLNode3.Attributes['Guid'];
      if (XMLNode3.Attributes['Note'] <> Null) then
        SchemaElements[n].Note:=XMLNode3.Attributes['Note'];
      if (XMLNode3.Attributes['Comment'] <> Null) then
        SchemaElements[n].Comment:=XMLNode3.Attributes['Comment'];

    end;
    AStrings.Add(Format('Элементы схемы: %d',[SchemaElements.Count]));

    XMLNode2:=XMLNode.ChildNodes['Channels'];
    if (XMLNode2.Attributes['Count'] <> Null) then
      Channels.Count:=XMLNode2.Attributes['Count'];
    for i:=0 to Channels.Count-1 do
      Channels[i]:=TDSChannel.Create(0, 0, 1, 0.5, 0.5, 0, 0, nil, nil, '');
    for i:=0 to XMLNode2.ChildNodes.Count-1 do
    begin
      XMLNode3:=XMLNode2.ChildNodes[i];
      n:=XMLNode3.Attributes['Index'];
      if (XMLNode3.Attributes['ChannelId'] <> Null) then
        Channels[n].ChannelId:=XMLNode3.Attributes['ChannelId'];
      if (XMLNode3.Attributes['Module'] <> Null) then
        if (XMLNode3.Attributes['Module'] > -1) and
          (XMLNode3.Attributes['Module'] < Modules.Count) then
          Channels[n].Module:=Modules[XMLNode3.Attributes['Module']];

      if (XMLNode3.Attributes['OrderNumber'] <> Null) then
       Channels[i].OrderNumber:=XMLNode3.Attributes['OrderNumber'];
      if (XMLNode3.Attributes['ChannelTypeIndex'] <> Null) then
        Channels[i].ChannelTypeIndex:=XMLNode3.Attributes['ChannelTypeIndex'];
      if (XMLNode3.Attributes['MinNormal'] <> Null) then
        Channels[i].MinNormal:=XMLNode3.Attributes['MinNormal'];
      if (XMLNode3.Attributes['MaxNormal'] <> Null) then
        Channels[i].MaxNormal:=XMLNode3.Attributes['MaxNormal'];
      if (XMLNode3.Attributes['MinEventId'] <> Null) then
        Channels[i].MinEventId:=XMLNode3.Attributes['MinEventId'];
      if (XMLNode3.Attributes['MaxEventId'] <> Null) then
        Channels[i].MaxEventId:=XMLNode3.Attributes['MaxEventId'];

      if (XMLNode3.Attributes['Cell'] <> Null) then
        if (XMLNode3.Attributes['Cell'] > -1) and
          (XMLNode3.Attributes['Cell'] < Cells.Count) then
          Channels[n].Cell:=Cells[XMLNode3.Attributes['Cell']];
      if (XMLNode3.Attributes['Note'] <> Null) then
        Channels[n].Note:=XMLNode3.Attributes['Note'];
      if (XMLNode3.Attributes['SchemaElement'] <> Null) then
        if (XMLNode3.Attributes['SchemaElement'] > -1) and
          (XMLNode3.Attributes['SchemaElement'] < SchemaElements.Count) then
          Channels[n].SchemaElement:=SchemaElements[XMLNode3.Attributes['SchemaElement']];

    end;
    AStrings.Add(Format('Каналы: %d',[Channels.Count]));

    XMLDoc.Active:=false;
    //(XMLDoc as TXMLDocument).Free; категорически нет!!!
    FormatSettings.DecimalSeparator:=c;

    AStrings.Add('ТП загружена из *.xml.');
  except
    on E: Exception do
    begin
      FormatSettings.DecimalSeparator:=c;
      MessageDlg(E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TDistrStation.SaveToXML(AFileName: string; AStrings: TStrings); // сохранить в XML файл
var
  XMLDoc: IXMLDocument;
  XMLNode, XMLNode2, XMLNode3: IXMLNode;
  c: Char;
  i: integer;
begin
  try
    // сохранение
    AStrings.Add('Сохранение ТП в *.xml.');
    AStrings.Add(Format('Файл: %s',[AFileName]));

    XMLDoc:=TXMLDocument.Create(nil);
    XMLDoc.Active:=true;
    XMLDoc.Version := '1.0';
    XMLDoc.Encoding := 'utf-8';
    c:=FormatSettings.DecimalSeparator;
    FormatSettings.DecimalSeparator:='.';

    XMLNode:=XMLDoc.AddChild('DistrStation');
    XMLNode.Attributes['DistrStationID']:=DistrStationID;
    XMLNode.Attributes['DistrStationTypeIndex']:=DistrStationTypeIndex;
    XMLNode.Attributes['DistrStationName']:=DistrStationName;
    XMLNode.Attributes['Number']:=Number;
    XMLNode.Attributes['Guid']:=Guid;
    XMLNode.Attributes['Description']:=Description;
    XMLNode.Attributes['DecimalSeparator']:='.';

    //XMLNode:=XMLDoc.DocumentElement;
    XMLNode2:=XMLNode.AddChild('Controllers');
    XMLNode2.Attributes['Count']:=Controllers.Count;
    for i:=0 to Controllers.Count-1 do
    begin
      XMLNode3:=XMLNode2.AddChild('Controller');
      XMLNode3.Attributes['Index']:=i;
      XMLNode3.Attributes['ControllerId']:=Controllers[i].ControllerId;
      XMLNode3.Attributes['ControllerTypeIndex']:=Controllers[i].ControllerTypeIndex;
      XMLNode3.Attributes['DistrStationId']:=Controllers[i].DistrStationId;
      XMLNode3.Attributes['EthernetIsAvailable']:=Controllers[i].EthernetIsAvailable;
      XMLNode3.Attributes['GprsIsAvailable']:=Controllers[i].GprsIsAvailable;
      XMLNode3.Attributes['Ethernet_LinkLost_Date']:=DateTimeToStr(Controllers[i].Ethernet_LinkLost_Date);
      //XMLNode3.Attributes['Ethernet_LinkLost_Date']:=DateTimeToStr(Controllers[i].Ethernet_LinkLost_Date, CDateTimeControllerFormat);
      //XMLNode3.Attributes['Ethernet_LinkLost_Date']:=Controllers[i].Ethernet_LinkLost_Date;
      XMLNode3.Attributes['Gprs_LinkLost_Date']:=DateTimeToStr(Controllers[i].Gprs_LinkLost_Date);
      //XMLNode3.Attributes['Gprs_LinkLost_Date']:=DateTimeToStr(Controllers[i].Gprs_LinkLost_Date, CDateTimeControllerFormat);
      //XMLNode3.Attributes['Gprs_LinkLost_Date']:=Controllers[i].Gprs_LinkLost_Date;
    end;
    AStrings.Add(Format('Контроллеры: %d',[Controllers.Count]));

    XMLNode2:=XMLNode.AddChild('Modules');
    XMLNode2.Attributes['Count']:=Modules.Count;
    for i:=0 to Modules.Count-1 do
    begin
      XMLNode3:=XMLNode2.AddChild('Module');
      XMLNode3.Attributes['Index']:=i;
      XMLNode3.Attributes['ModuleId']:=Modules[i].ModuleId;
      XMLNode3.Attributes['ModuleTypeIndex']:=Modules[i].ModuleTypeIndex;
      XMLNode3.Attributes['Controller']:=Controllers.IndexOf(Modules[i].Controller);
      XMLNode3.Attributes['ModuleName']:=Modules[i].ModuleName;
      XMLNode3.Attributes['OrdinalNumber']:=Modules[i].OrdinalNumber;
      XMLNode3.Attributes['ChannelCount']:=Modules[i].ChannelCount;
    end;
    AStrings.Add(Format('Модули: %d',[Modules.Count]));

    XMLNode2:=XMLNode.AddChild('Cells');
    XMLNode2.Attributes['Count']:=Cells.Count;
    for i:=0 to Cells.Count-1 do
    begin
      XMLNode3:=XMLNode2.AddChild('Cell');
      XMLNode3.Attributes['Index']:=i;
      XMLNode3.Attributes['CellId']:=Cells[i].CellId;
      XMLNode3.Attributes['DistrStationId']:=Cells[i].DistrStationId;
      //XMLNode3.Attributes['CellTypeId']:=Cells[i].CellTypeId;
      XMLNode3.Attributes['OrderNumber']:=Cells[i].OrderNumber;
      XMLNode3.Attributes['Guid']:=Cells[i].Guid;
      XMLNode3.Attributes['CellName']:=Cells[i].CellName;
      XMLNode3.Attributes['Note']:=Cells[i].Note;
    end;
    AStrings.Add(Format('Ячейки: %d',[Cells.Count]));

    XMLNode2:=XMLNode.AddChild('Devices');
    XMLNode2.Attributes['Count']:=Devices.Count;
    for i:=0 to Devices.Count-1 do
    begin
      XMLNode3:=XMLNode2.AddChild('Device');
      XMLNode3.Attributes['Index']:=i;
      XMLNode3.Attributes['DeviceId']:=Devices[i].DeviceId;
      XMLNode3.Attributes['DeviceTypeIndex']:=Devices[i].DeviceTypeIndex;
      XMLNode3.Attributes['Cell']:=Cells.IndexOf(Devices[i].Cell);
      XMLNode3.Attributes['Guid']:=Devices[i].Guid;
      XMLNode3.Attributes['Note']:=Devices[i].Note;
      XMLNode3.Attributes['Comment']:=Devices[i].Comment;
    end;
    AStrings.Add(Format('Устройства: %d',[Devices.Count]));

    XMLNode2:=XMLNode.AddChild('SchemaElements');
    XMLNode2.Attributes['Count']:=SchemaElements.Count;
    for i:=0 to SchemaElements.Count-1 do
    begin
      XMLNode3:=XMLNode2.AddChild('SchemaElement');
      XMLNode3.Attributes['Index']:=i;
      XMLNode3.Attributes['SchemaElementId']:=SchemaElements[i].SchemaElementId;
      XMLNode3.Attributes['DistrStationId']:=SchemaElements[i].DistrStationId;
      XMLNode3.Attributes['Device']:=Devices.IndexOf(SchemaElements[i].Device);
      XMLNode3.Attributes['Guid']:=SchemaElements[i].Guid;
      XMLNode3.Attributes['Note']:=SchemaElements[i].Note;
      XMLNode3.Attributes['Comment']:=SchemaElements[i].Comment;
    end;
    AStrings.Add(Format('Элементы схемы: %d',[SchemaElements.Count]));

    XMLNode2:=XMLNode.AddChild('Channels');
    XMLNode2.Attributes['Count']:=Channels.Count;
    for i:=0 to Channels.Count-1 do
    begin
      XMLNode3:=XMLNode2.AddChild('Channel');
      XMLNode3.Attributes['Index']:=i;
      XMLNode3.Attributes['ChannelId']:=Channels[i].ChannelId;
      XMLNode3.Attributes['Module']:=Modules.IndexOf(Channels[i].Module);
      XMLNode3.Attributes['OrderNumber']:=Channels[i].OrderNumber;
      XMLNode3.Attributes['ChannelTypeIndex']:=Channels[i].ChannelTypeIndex;
      XMLNode3.Attributes['MinNormal']:=Channels[i].MinNormal;
      XMLNode3.Attributes['MaxNormal']:=Channels[i].MaxNormal;
      XMLNode3.Attributes['MinEventId']:=Channels[i].MinEventId;
      XMLNode3.Attributes['MaxEventId']:=Channels[i].MaxEventId;
      XMLNode3.Attributes['Cell']:=Cells.IndexOf(Channels[i].Cell);
      XMLNode3.Attributes['Note']:=Channels[i].Note;
      XMLNode3.Attributes['SchemaElement']:=SchemaElements.IndexOf(Channels[i].SchemaElement);
    end;
    AStrings.Add(Format('Каналы: %d',[Channels.Count]));

{
    XMLNode.ChildValues['Size.X']:=FSize.X;
    XMLNode.ChildValues['Size.Y']:=FSize.Y;
}

    XMLDoc.SaveToFile(AFileName);
    XMLDoc.Active:=false;
    //(XMLDoc as TXMLDocument).Free; категорически нет!!!
    FormatSettings.DecimalSeparator:=c;

    AStrings.Add('ТП сохранена в *.xml.');
  except
    on E: Exception do
    begin
      FormatSettings.DecimalSeparator:=c;
      MessageDlg(E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TDistrStation.SaveToSQL(AFileName: string; AStrings: TStrings);
var
  i, ni, nu: integer;
  ss: TStringList;
  c: char;
  sCellGuid, sMinEventId, sMaxEventId: string;
begin
  // сохранить запрос в SQL файл
  try
    c:=FormatSettings.DecimalSeparator;
    FormatSettings.DecimalSeparator:='.';

    // сохранение
    AStrings.Add('Сохранение запроса на создание ТП в *.sql.');
    AStrings.Add(Format('Файл: %s',[AFileName]));

    // начало
    ss:=TStringList.Create;
    ss.Add('USE scadadb');
    ss.Add('GO');

    // подстанция
    ss.Add(' ');
    ss.Add('-- Создаем подстанцию');
    ss.Add(' ');
    ss.Add('DECLARE @dsguid uniqueidentifier');
    if (Guid = '') then
      ss.Add('SET @dsguid = NEWID()')
    else
      ss.Add(Format('SET @dsguid = ''%s''', [Guid]));
    ss.Add(' ');
    ss.Add('DECLARE @DistrStationID int');
    if (DistrStationId = 0) then
    begin
      ss.Add(' ');
      ss.Add(Format('INSERT INTO %s (DistrStationTypeId, DistrStationName, Number, Guid, UserOrderIndex, ColorIndex, Address, Description, LastPoll, IsIgnored)',
        [CScadaDBDistrStationsTable]));
      ss.Add(Format('VALUES (%d, ''%s'', %d, @dsguid, NULL, NULL, NULL, ''%s'', NULL, 1)',
        [DistrStationTypeId,
         DistrStationName,
         Number,
         Description]));
      ss.Add(Format('SET @DistrStationId = IDENT_CURRENT(''%s'')', [CScadaDBDistrStationsTable]));
      // для примера и последующего применения
      //ss.Add(Format('select @dsguid = Guid from %s where DistrStationId = @DistrStationID', [CScadaDBDistrStationsTable]));
      AStrings.Add('Подстанция: создана');
    end else
    begin
      ss.Add(Format('SET @DistrStationID = %d', [DistrStationId]));
      ss.Add(' ');
      ss.Add(Format('UPDATE %s', [CScadaDBDistrStationsTable]));
      ss.Add(Format('SET '+
        'DistrStationTypeId = %d, '+
        'DistrStationName = ''%s'', '+ 
        'Number = %d, '+ 
        'Description = ''%s''', 
        [DistrStationTypeId,
         DistrStationName,
         Number, 
         Description]));
      ss.Add('WHERE DistrStationID = @DistrStationID');
      AStrings.Add('Подстанция: обновлена');
    end;

    // контроллеры
    ss.Add(' ');
    ss.Add('-- Создаем контроллеры');
    ss.Add(' ');
    for i:=0 to Controllers.Count-1 do
      ss.Add(Format('DECLARE @ControllerID%d int', [i]));
    ss.Add(' ');
    for i:=0 to Controllers.Count-1 do
      if (Controllers[i].ControllerId <> 0) then
        ss.Add(Format('SET @ControllerID%d = %d', [i, Controllers[i].ControllerId]));
    ni:=0;
    nu:=0;
    for i:=0 to Controllers.Count-1 do
      if (Controllers[i].ControllerId = 0) then
      begin
        ss.Add(' ');
        ss.Add(Format('INSERT INTO %s (ControllerTypeId, DistrStationId, EthernetIsAvailable, GprsIsAvailable, Ethernet_LinkLost_Date, Gprs_LinkLost_Date)',
          [CScadaDBControllersTable]));
        ss.Add(Format('VALUES (%d, @DistrStationID, 0, 0, NULL, NULL)',
          [Controllers[i].ControllerTypeId]));
        ss.Add(Format('SET @ControllerID%d = IDENT_CURRENT(''%s'')', [i, CScadaDBControllersTable]));
        ni:=ni+1;
      end else
      begin
        ss.Add(' ');
        ss.Add(Format('UPDATE %s', [CScadaDBControllersTable]));
        ss.Add(Format('SET '+
          'ControllerTypeId = %d, '+
          'DistrStationId = @DistrStationID', 
          [Controllers[i].ControllerTypeId]));
        ss.Add(Format('WHERE ControllerID = @ControllerID%d', [i]));
        nu:=nu+1;  
      end;
    AStrings.Add(Format('Контроллеры: %d (создано %d, обновлено %d)',[Controllers.Count, ni, nu]));

    // модули
    ss.Add(' ');
    ss.Add('-- Создаем модули');
    ss.Add(' ');
    for i:=0 to Modules.Count-1 do
      ss.Add(Format('DECLARE @ModuleID%d int', [i]));
    ss.Add(' ');
    for i:=0 to Modules.Count-1 do
      if (Modules[i].ModuleId <> 0) then
        ss.Add(Format('SET @ModuleID%d = %d', [i, Modules[i].ModuleId]));
    ni:=0;
    nu:=0;
    for i:=0 to Modules.Count-1 do
      if (Modules[i].ModuleId = 0) then
      begin
        ss.Add(' ');
        ss.Add(Format('INSERT INTO %s (ControllerId, ModuleTypeId, ModuleName, OrdinalNumber)',
          [CScadaDBModulesTable]));
        ss.Add(Format('VALUES (@ControllerID%d, %d, ''%s'', %d)',
          [Controllers.IndexOf(Modules[i].Controller),
           Modules[i].ModuleTypeId,
           Modules[i].ModuleName,
           Modules[i].OrdinalNumber]));
        ss.Add(Format('SET @ModuleID%d = IDENT_CURRENT(''%s'')', [i, CScadaDBModulesTable]));
        ni:=ni+1;
      end else
      begin
        ss.Add(' ');
        ss.Add(Format('UPDATE %s', [CScadaDBModulesTable]));
        ss.Add(Format('SET '+
          'ControllerId = @ControllerID%d, '+
          'ModuleTypeId = %d,'+
          'ModuleName = ''%s'', '+
          'OrdinalNumber = %d', 
          [Controllers.IndexOf(Modules[i].Controller),
           Modules[i].ModuleTypeId,
           Modules[i].ModuleName,
           Modules[i].OrdinalNumber]));
        ss.Add(Format('WHERE ModuleID = @ModuleID%d', [i]));
        nu:=nu+1;  
      end;
    AStrings.Add(Format('Модули: %d (создано %d, обновлено %d)',[Modules.Count, ni, nu]));

    // ячейки
    ss.Add(' ');
    ss.Add('-- Создаем ячейки');
    ss.Add(' ');
    for i:=0 to Cells.Count-1 do
      ss.Add(Format('DECLARE @CellID%d int', [i]));
    ss.Add(' ');
    for i:=0 to Cells.Count-1 do
      if (Cells[i].CellId <> 0) then
        ss.Add(Format('SET @CellID%d = %d', [i, Cells[i].CellId]));
    ni:=0;
    nu:=0;
    for i:=0 to Cells.Count-1 do
    begin

      if (Cells[i].Guid = '') then
        sCellGuid:='NULL'
      else
        sCellGuid:=''''+Cells[i].Guid+'''';

      if (Cells[i].CellId = 0) then
      begin
        ss.Add(' ');
        ss.Add(Format('INSERT INTO %s (DistrStationId, CellTypeId, OrderNumber, Guid, CellName, Note)',
          [CScadaDBCellsTable]));
        ss.Add(Format('VALUES (@DistrStationID, NULL, %d, %s, ''%s'', ''%s'')',
          [Cells[i].OrderNumber,
           sCellGuid,
           Cells[i].CellName,
           Cells[i].Note]));
        ss.Add(Format('SET @CellID%d = IDENT_CURRENT(''%s'')', [i, CScadaDBCellsTable]));
        ni:=ni+1;
      end else
      begin
        ss.Add(' ');
        ss.Add(Format('UPDATE %s', [CScadaDBCellsTable]));
        ss.Add(Format('SET '+
          'DistrStationId = @DistrStationID '+
          'OrderNumber = %d, '+
          'Guid = %s, '+
          'CellName = ''%s'', '+
          'Note = ''%s''', 
          [Cells[i].OrderNumber,
           sCellGuid,
           Cells[i].CellName,
           Cells[i].Note]));
        ss.Add(Format('WHERE CellID = @CellID%d', [i]));
        nu:=nu+1;
      end;
    end;
    AStrings.Add(Format('Ячейки: %d (создано %d, обновлено %d)',[Cells.Count, ni, nu]));
        
    // устройства
    ss.Add(' ');
    ss.Add('-- Создаем устройства');
    ss.Add(' ');
    for i:=0 to Devices.Count-1 do
      ss.Add(Format('DECLARE @DeviceID%d int', [i]));
    ss.Add(' ');
    for i:=0 to Devices.Count-1 do
      if (Devices[i].DeviceId <> 0) then
        ss.Add(Format('SET @DeviceID%d = %d', [i, Devices[i].DeviceId]));
    ss.Add(' ');
    for i:=0 to Devices.Count-1 do
      ss.Add(Format('DECLARE @DeviceGuid%d uniqueidentifier', [i]));
    ss.Add(' ');
    for i:=0 to Devices.Count-1 do
      ss.Add(Format('SET @DeviceGuid%d = ''%s''', [i, Devices[i].Guid]));
    ni:=0;
    nu:=0;
    for i:=0 to Devices.Count-1 do
      if (Devices[i].DeviceId = 0) then
      begin
        ss.Add(' ');
        ss.Add(Format('INSERT INTO %s (DeviceTypeId, CellId, Guid, Note)',
          [CScadaDBDevicesTable]));
        ss.Add(Format('VALUES (%d, @CellID%d, @DeviceGuid%d, ''%s'')',
          [Devices[i].DeviceTypeId,
           Cells.IndexOf(Devices[i].Cell),
           i,
           Devices[i].Note]));
        ss.Add(Format('SET @DeviceID%d = IDENT_CURRENT(''%s'')', [i, CScadaDBDevicesTable]));
        ni:=ni+1;
      end else
      begin
        ss.Add(' ');
        ss.Add(Format('UPDATE %s', [CScadaDBDevicesTable]));
        ss.Add(Format('SET '+
          'DeviceTypeId = %d '+
          'CellId = @CellID%d, '+
          'Guid = @DeviceGuid%d, '+
          'Note = ''%s''', 
          [Devices[i].DeviceTypeId,
           Cells.IndexOf(Devices[i].Cell),
           i,
           Devices[i].Note]));
        ss.Add(Format('WHERE DeviceID = @DeviceID%d', [i]));
        nu:=nu+1;
      end;
    AStrings.Add(Format('Устройства: %d (создано %d, обновлено %d)',[Devices.Count, ni, nu]));


    // элементы схемы
    ss.Add(' ');
    ss.Add('-- Создаем элементы схемы');
    ss.Add(' ');
    for i:=0 to SchemaElements.Count-1 do
      ss.Add(Format('DECLARE @SchemaElementID%d int', [i]));
    ss.Add(' ');
    for i:=0 to SchemaElements.Count-1 do
      if (SchemaElements[i].SchemaElementId <> 0) then
        ss.Add(Format('SET @SchemaElementID%d = %d', [i, SchemaElements[i].SchemaElementId]));

    ss.Add(' ');
    for i:=0 to SchemaElements.Count-1 do
      ss.Add(Format('DECLARE @SchemaElementGuid%d uniqueidentifier', [i]));
    ss.Add(' ');

    for i:=0 to SchemaElements.Count-1 do
    begin
      if (SchemaElements[i].Device = nil) then
      begin
        if (SchemaElements[i].Guid = '') then
          ss.Add(Format('SET @SchemaElementGuid%d = NEWID()', [i]))
        else  
          ss.Add(Format('SET @SchemaElementGuid%d = ''%s''', [i, SchemaElements[i].Guid]));
       end else
         ss.Add(Format('SET @SchemaElementGuid%d = @DeviceGuid%d', [i, Devices.IndexOf(SchemaElements[i].Device)]));
    end;

    ni:=0;
    nu:=0;
    for i:=0 to SchemaElements.Count-1 do
      if (SchemaElements[i].SchemaElementId = 0) then
      begin
        ss.Add(' ');
        ss.Add(Format('INSERT INTO %s (DeviceId, DistrStationId, Guid, Note)',
          [CScadaDBSchemaElementsTable]));
        if (SchemaElements[i].Device <> nil) then
          ss.Add(Format('VALUES (@DeviceID%d, @DistrStationID, @SchemaElementGuid%d, ''%s'')',
            [Devices.IndexOf(SchemaElements[i].Device),
             i,
             SchemaElements[i].Note]))
        else
          ss.Add(Format('VALUES (NULL, @DistrStationID, @SchemaElementGuid%d, ''%s'')',
            [i,
             SchemaElements[i].Note]));
        ss.Add(Format('SET @SchemaElementID%d = IDENT_CURRENT(''%s'')', [i, CScadaDBSchemaElementsTable]));
        ni:=ni+1;
      end else
      begin
        ss.Add(' ');
        ss.Add(Format('UPDATE %s', [CScadaDBSchemaElementsTable]));
        ss.Add(Format('SET '+
          'DeviceId = @DeviceID%d, '+
          'DistrStationId = @DistrStationID, '+
          'Guid = @SchemaElementGuid%d, '+
          'Note = ''%s''', 
          [Devices.IndexOf(SchemaElements[i].Device),
           i,
           SchemaElements[i].Note]));
        ss.Add(Format('WHERE SchemaElementID = @SchemaElementID%d', [i]));
        nu:=nu+1;  
      end;
    AStrings.Add(Format('Элементы схемы: %d (создано %d, обновлено %d)',[SchemaElements.Count, ni, nu]));

    // каналы
    // канал без модуля и контроллера не существует
    ss.Add(' ');
    ss.Add('-- Создаем каналы');
    ss.Add(' ');
    for i:=0 to Channels.Count-1 do
      ss.Add(Format('DECLARE @ChannelID%d int', [i]));
    ss.Add(' ');
    for i:=0 to Channels.Count-1 do
      if (Channels[i].ChannelId <> 0) then
        ss.Add(Format('SET @ChannelID%d = %d', [i, Channels[i].ChannelId]));
    ss.Add(' ');
    ni:=0;
    nu:=0;
    for i:=0 to Channels.Count-1 do
    begin
      if (Channels[i].MinEventId = 0) then
        sMinEventId:='NULL'
      else
        sMinEventId:=IntToStr(Channels[i].MinEventId);
      if (Channels[i].MaxEventId = 0) then
        sMaxEventId:='NULL'
      else
        sMaxEventId:=IntToStr(Channels[i].MaxEventId);
      if (Channels[i].ChannelId = 0) then
      begin
        ss.Add(' ');
        ss.Add(Format('INSERT INTO %s (ModuleId, ControllerId, OrderNumber, ChannelTypeId, MinNormal, MaxNormal, MinEventId, MaxEventId, CellId, Note)',
          [CScadaDBChannelsTable]));
        if (Channels[i].Cell <> nil) then
          ss.Add(Format('VALUES (@ModuleID%d, @ControllerID%d, %d, %d, %f, %f, %s, %s, @CellID%d, ''%s'')',
            [Modules.IndexOf(Channels[i].Module),
             Controllers.IndexOf(Channels[i].Module.Controller),
             Channels[i].OrderNumber,
             Channels[i].ChannelTypeId,
             Channels[i].MinNormal,
             Channels[i].MaxNormal,
             sMinEventId,
             sMaxEventId,
             Cells.IndexOf(Channels[i].Cell),
             Channels[i].Note]))
        else
          ss.Add(Format('VALUES (@ModuleID%d, @ControllerID%d, %d, %d, %f, %f, %s, %s, NULL, ''%s'')',
            [Modules.IndexOf(Channels[i].Module),
             Controllers.IndexOf(Channels[i].Module.Controller),
             Channels[i].OrderNumber,
             Channels[i].ChannelTypeId,
             Channels[i].MinNormal,
             Channels[i].MaxNormal,
             sMinEventId,
             sMaxEventId,
             Channels[i].Note]));
        ss.Add(Format('SET @ChannelID%d = IDENT_CURRENT(''%s'')', [i, CScadaDBChannelsTable]));
        ni:=ni+1;
      end else
      begin
        ss.Add(' ');
        ss.Add(Format('UPDATE %s', [CScadaDBChannelsTable]));
        if (Channels[i].Cell <> nil) then
          ss.Add(Format('SET '+
            'ChannelTypeId = %d, '+
            'CellId = @CellID%d, '+
            'OrderNumber = %d, '+
            'ChannelTypeId = %d, '+
            'MinNormal = %f, '+
            'MaxNormal = %f, '+
            'MinEventId = %s, '+
            'MaxEventId = %s, '+
            'CellId = @CellID%d, '+
            'Note = ''%s''',
            [Modules.IndexOf(Channels[i].Module),
             Controllers.IndexOf(Channels[i].Module.Controller),
             Channels[i].OrderNumber,
             Channels[i].ChannelTypeId,
             Channels[i].MinNormal,
             Channels[i].MaxNormal,
             sMinEventId,
             sMaxEventId,
             Cells.IndexOf(Channels[i].Cell),
             Channels[i].Note]))
        else
          ss.Add(Format('SET '+
            'ChannelTypeId = %d, '+
            'CellId = @CellID%d, '+
            'OrderNumber = %d, '+
            'ChannelTypeId = %d, '+
            'MinNormal = %f, '+
            'MaxNormal = %f, '+
            'MinEventId = %s, '+
            'MaxEventId = %s, '+
            'CellId = NULL, '+
            'Note = ''%s''',
            [Modules.IndexOf(Channels[i].Module),
             Controllers.IndexOf(Channels[i].Module.Controller),
             Channels[i].OrderNumber,
             Channels[i].ChannelTypeId,
             Channels[i].MinNormal,
             Channels[i].MaxNormal,
             sMinEventId,
             sMaxEventId,
             Channels[i].Note]));
        ss.Add(Format('WHERE ChannelID = @ChannelID%d', [i]));
        nu:=nu+1;
      end;
    end;
    AStrings.Add(Format('Каналы: %d (создано %d, обновлено %d)',[Channels.Count, ni, nu]));

    ss.Add(' ');
    ss.Add('-- Создаем элементы схемы с каналами');
    ss.Add(' ');
    ni:=0;
    nu:=0;
    for i:=0 to Channels.Count-1 do
      if (Channels[i].ChannelId = 0) then
      begin
        ss.Add(' ');
        // НЕ СОЗДАЕМ каналы, не связанные с элементом схемы
        if (Channels[i].SchemaElement <> nil) then
        begin
          ss.Add(Format('INSERT INTO %s (SchemaElementId, ChannelId)',
            [CScadaDBSchemaElementChannelsTable]));
          ss.Add(Format('VALUES (@SchemaElementID%d, @ChannelID%d)',
            [SchemaElements.IndexOf(Channels[i].SchemaElement), i]));
        end;
{
        ss.Add(Format('INSERT INTO %s (SchemaElementId, ChannelId)',
          [CScadaDBSchemaElementChannelsTable]));
        if (Channels[i].SchemaElement <> nil) then
          ss.Add(Format('VALUES (@SchemaElementID%d, @ChannelID%d)',
            [SchemaElements.IndexOf(Channels[i].SchemaElement), i]))
        else
          ss.Add(Format('VALUES (NULL, @ChannelID%d)', [i]));
}
        ni:=ni+1;
      end else
      begin
        ss.Add(' ');
        // НЕ ОБНОВЛЯЕМ каналы, не связанные с элементом схемы
        if (Channels[i].SchemaElement <> nil) then
        begin
          ss.Add(Format('UPDATE %s', [CScadaDBSchemaElementChannelsTable]));
          ss.Add(Format('SET '+
            'SchemaElementId = @SchemaElementID%d',
            [SchemaElements.IndexOf(Channels[i].SchemaElement)]));
          ss.Add(Format('WHERE ChannelID = @ChannelID%d', [i]));
        end;
{
        ss.Add(Format('UPDATE %s', [CScadaDBSchemaElementChannelsTable]));
        if (Channels[i].SchemaElement <> nil) then
          ss.Add(Format('SET '+
            'SchemaElementId = @SchemaElementID%d',
            [SchemaElements.IndexOf(Channels[i].SchemaElement)]))
        else
          ss.Add('SET SchemaElementId = NULL');
        ss.Add(Format('WHERE ChannelID = @ChannelID%d', [i]));
}
        nu:=nu+1;
      end;
    AStrings.Add(Format('Элементы схемы с каналами: %d (создано %d, обновлено %d)',[Channels.Count, ni, nu]));

    // сохранение
    ss.SaveToFile(AFileName);
    ss.Free;

    FormatSettings.DecimalSeparator:=c;
    AStrings.Add('Запрос на создание ТП сохранен в *.sql.');
  except
    on E: Exception do
    begin
      FormatSettings.DecimalSeparator:=c;
      if assigned(ss) then ss.Free;
      MessageDlg(E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

// TDSController - Контроллер

constructor TDSController.Create(AControllerID, AControllerTypeId, ADistrStationId: integer);
begin
  ControllerId:=AControllerID;
  ControllerTypeId:=AControllerTypeId;
  DistrStationId:=ADistrStationId;
  EthernetIsAvailable:=false;
  GprsIsAvailable:=false;
  Ethernet_LinkLost_Date:=Now;
  Gprs_LinkLost_Date:=Now;
end;

function TDSController.GetControllerTypeID: integer;
begin
  // ID типа контроллера из dbo.ControllerTypes, возвращает по номеру FControllerTypeIndex
  Result:=CControllerTypes[FControllerTypeIndex].FControllerTypeId;
end;

procedure TDSController.SetControllerTypeID(AControllerTypeId: integer);
var
  i: integer;
begin
  // ID типа контроллера из dbo.ControllerTypes, устанавливает FControllerTypeIndex по TControllerType.FControllerTypeId
  i:=Low(CControllerTypes);
  while (i <= High(CControllerTypes)) and (AControllerTypeId <> CControllerTypes[i].FControllerTypeId) do
  begin
    i:=i+1;
  end;
  if (i <= High(CControllerTypes)) then
    FControllerTypeIndex:=i
  else
    raise Exception.CreateFmt('Неизвестный тип контроллера %d.', [AControllerTypeId]);
end;

// TDSModule - Модуль

constructor TDSModule.Create(AModuleID, AModuleTypeId: integer; AModuleName: string; AOrdinalNumber: integer; AController: TDSController; AChannelCount: integer);
begin
  ModuleId:=AModuleID;
  ModuleTypeId:=AModuleTypeId;
  Controller:=AController;
  ModuleName:=AModuleName;
  OrdinalNumber:=AOrdinalNumber;
  ChannelCount:=16;
end;

function TDSModule.GetModuleTypeID: integer;
begin
  // ID типа модуля из dbo.ModuleTypes, возвращает по номеру FModuleTypeIndex
  Result:=CModuleTypes[FModuleTypeIndex].FModuleTypeId;
end;

procedure TDSModule.SetModuleTypeID(AModuleTypeId: integer);
var
  i: integer;
begin
  // ID типа модуля из dbo.ModuleTypes, устанавливает FModuleTypeIndex по TModuleType.FModuleTypeId
  i:=Low(CModuleTypes);
  while (i <= High(CModuleTypes)) and (AModuleTypeId <> CModuleTypes[i].FModuleTypeId) do
  begin
    i:=i+1;
  end;
  if (i <= High(CModuleTypes)) then
    FModuleTypeIndex:=i
  else
    raise Exception.CreateFmt('Неизвестный тип модуля %d.', [AModuleTypeId]);
end;

function TDSModule.GetControllerID: integer;
begin
  if (Controller <> nil) then
    Result:=Controller.ControllerId
  else
    raise Exception.CreateFmt('Не установлен контроллер для модуля %d %s.', [ModuleId, ModuleName]);
end;

// TDSCell - ячейка

constructor TDSCell.Create(ACellID, ADistrSatationID, AOrderNumber: integer; AGuid, ACellName, ANote: string);
begin
  CellId:=ACellID;
  DistrStationId:=ADistrSatationID;
  OrderNumber:=AOrderNumber;
  Guid:=AGuid;
  CellName:=ACellName;
  Note:=ANote;
end;

// TDSDevice - устройство

function GetDeviceTypeIdAtName(ADeviceTypeName: string): integer;
var
  i: integer;
begin
  Result:=-1;
  for i:=Low(CDeviceTypes) to High(CDeviceTypes) do
    if (CDeviceTypes[i].FDeviceTypeName = ADeviceTypeName) then
       Result:=CDeviceTypes[i].FDeviceTypeId;
end;

constructor TDSDevice.Create(ADeviceID, ADeviceTypeId: integer; AGuid, ANote, AComment: string; ACell: TDSCell);
begin
  DeviceId:=ADeviceID;
  DeviceTypeId:=ADeviceTypeId;
  Guid:=AGuid;
  Note:=ANote;
  Comment:=AComment;
  Cell:=ACell;
end;

function TDSDevice.GetDeviceTypeID: integer;
begin
  // ID типа устройства из dbo.DeviceTypes, возвращает по номеру FDeviceTypeIndex
  Result:=CDeviceTypes[FDeviceTypeIndex].FDeviceTypeId;
end;

procedure TDSDevice.SetDeviceTypeID(ADeviceTypeId: integer);
var
  i: integer;
begin
  // ID типа устройства из dbo.DeviceTypes, устанавливает FDeviceTypeIndex по TDeviceType.FDeviceTypeId
  i:=Low(CDeviceTypes);
  while (i <= High(CDeviceTypes)) and (ADeviceTypeId <> CDeviceTypes[i].FDeviceTypeId) do
  begin
    i:=i+1;
  end;
  if (i <= High(CDeviceTypes)) then
    FDeviceTypeIndex:=i
  else
    raise Exception.CreateFmt('Неизвестный тип устройства %d.', [ADeviceTypeId]);
end;

function TDSDevice.GetCellID: integer;
begin
  if (Cell <> nil) then
    Result:=Cell.CellId
  else
    raise Exception.CreateFmt('Не установлена ячейка для устройства %d [%s] %s.', [DeviceId, Guid, Note]);
end;

// TDSSchemaElement - элемент схемы

constructor TDSSchemaElement.Create(ASchemaElementId, ADistrStationId: integer; ANote, AComment: string; ADevice: TDSDevice);
begin
  SchemaElementId:=ASchemaElementId;
  DistrStationId:=ADistrStationId;
  Device:=ADevice;
  if (Device = nil) then
    Guid:=GetGUIDString;
  Note:=ANote;
  Comment:=AComment;
end;

function TDSSchemaElement.GetDeviceId: integer;
begin
  if (Device <> nil) then
    Result:=Device.DeviceId
  else
    Result:=0; // отсутствует физический аналог устройства
  //  raise Exception.CreateFmt('Не установлено устройство для элемента схемы %d %s.', [SchemaElementId, Note]);
end;

function TDSSchemaElement.GetGuid: string;
begin
  if (Device <> nil) then
    Result:=Device.Guid
  else
    Result:=FGuid; // отсутствует физический аналог устройства
  //  raise Exception.CreateFmt('Не установлено устройство для элемента схемы %d %s.', [SchemaElementId, Note]);
end;

procedure TDSSchemaElement.SetGuid(AGuid: string);
begin
  if (Device = nil) then
    FGuid:=AGuid
  else
    // ассоциировано устройство
    raise Exception.CreateFmt('Попытка установить GUID элемента схемы %d %s с ассоциированным устройством.', [SchemaElementId, Note]);
end;

// TDSChannel - Канал

constructor TDSChannel.Create(AChannelId, AOrderNumber, AChannelTypeId: integer;
  AMinNormal, AMaxNormal: single;
  AMinEventId, AMaxEventId: integer;
  AModule: TDSModule; ACell: TDSCell; ANote: string);
begin
  FChannelId:=AChannelId;
  FOrderNumber:=AOrderNumber;

  ChannelTypeId:=AChannelTypeId;

  FMinNormal:=AMinNormal;
  FMaxNormal:=AMaxNormal;
  FMinEventId:=AMinEventId;
  FMaxEventId:=AMinEventId;

  FModule:=AModule;
  FCell:=ACell;
  FNote:=ANote;

  FSchemaElement:=nil;
end;

function TDSChannel.GetSchemaElementId: integer;
begin
  if (SchemaElement <> nil) then
    Result:=SchemaElement.SchemaElementId
  else
    raise Exception.CreateFmt('Не установлен элемент схемы для канала %d %d %s.', [ChannelId, OrderNumber, Note]);
end;

function TDSChannel.GetModuleId: integer;
begin
  if (Module <> nil) then
    Result:=Module.ModuleId
  else
    raise Exception.CreateFmt('Не установлен модуль для канала %d %d %s.', [ChannelId, OrderNumber, Note]);
end;

function TDSChannel.GetControllerId: integer;
begin
  if (Module <> nil) then
    Result:=Module.ControllerId
  else
    raise Exception.CreateFmt('Не установлен модуль для канала %d %d %s.', [ChannelId, OrderNumber, Note]);
end;

function TDSChannel.GetChannelTypeID: integer;
begin
  // ID типа устройства из dbo.ChannelTypes, возвращает по номеру FChannelTypeIndex
  Result:=CChannelTypes[FChannelTypeIndex].FChannelTypeId;
end;

procedure TDSChannel.SetChannelTypeID(AChannelTypeId: integer);
var
  i: integer;
begin
  // ID типа устройства из dbo.ChannelTypes, устанавливает FChannelTypeIndex по TChannelType.FChannelTypeId
  i:=Low(CChannelTypes);
  while (i <= High(CChannelTypes)) and (AChannelTypeId <> CChannelTypes[i].FChannelTypeId) do
  begin
    i:=i+1;
  end;
  if (i <= High(CChannelTypes)) then
    FChannelTypeIndex:=i
  else
    raise Exception.CreateFmt('Неизвестный тип канала %d.', [AChannelTypeId]);
end;

function TDSChannel.GetCellID: integer;
begin
  if (Cell <> nil) then
    Result:=Cell.CellId
  else
    Result:=0; // не установлена ячейка, например для термометра
  //  raise Exception.CreateFmt('Не установлена ячейка для канала %d %s.', [ChannelId, Note]);
end;

// TDSSchemaElementChannel - элемент схемы с каналом

constructor TDSSchemaElementChannel.Create(ASchemaElement: TDSSchemaElement; AChannel: TDSChannel);
begin
  SchemaElement:=ASchemaElement;
  Channel:=AChannel;
end;

function TDSSchemaElementChannel.GetSchemaElementId: integer;
begin
  if (SchemaElement <> nil) then
    Result:=SchemaElement.SchemaElementId
  else
    raise Exception.Create('Не установлен элемент схемы для элемента схемы с каналом.');
end;

function TDSSchemaElementChannel.GetChannelId: integer;
begin
  if (Channel <> nil) then
    Result:=Channel.ChannelId
  else
    raise Exception.Create('Не установлен канал для элемента схемы с каналом.');
end;

end.