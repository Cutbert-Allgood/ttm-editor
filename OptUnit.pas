unit OptUnit;

interface

uses
  Graphics, System.Types;

type
  TTPOptions = record
    // общие
    StationID: integer; // ID подстанции
    Ratio: single; // ?
    // формат
    TPWidth: integer; // ширина схемы ТП, пикс.
    TPHeight: integer; // высота схемы ТП, пикс.
    TPColor: TColor; // цвет схемы ТП
    FontColor: TColor; // цвет шрифта схемы ТП
    // сетка
    GridShow: boolean; // показывать сетку
    GridStep: integer; //  шаг сетки, пикс.
    GridColor: TColor; // цвет сетки
    // границы элементов
    RectShow: boolean; // показывать границы элементов
    // выделение, перемещение
    SelectColor: TColor; // цвет рамки выделения
    MoveColor: TColor; // цвет перемещения
    // ячейки элементов
    CellShow: boolean; // показывать номер ячейки
    // GUID элементов
    GUIDShow: boolean; // показывать GUID элемента
  end;

  TDSOptions = record
    // элементы схемы
    LightSchemaElementColor: TColor; // подсветка ячейки, элементом схемы связан со схемой
    UnlightSchemaElementColor: TColor; // подсветка ячейки, канал НЕ связан со схемой
    SelectSchemaElementColor: TColor; // цвет выделенной ячейки

    LightColor: TColor; // подсветка ячейки, одинаковой с ячейкой элемента
    SelectColor: TColor; // цвет выделенной ячейки
    ErrorColor: TColor; // цвет ячейки, у которой номер ячейки устройства и ячейки элемента на схеме не совпадают
    SelectErrorColor: TColor; // цвет выделенной ячейки, у которой номер ячейки устройства и ячейки элемента на схеме не совпадают
    // каналы
    LightChannelColor: TColor; // подсветка ячейки, канал связан с элементом схемы
    UnlightChannelColor: TColor; // подсветка ячейки, канал НЕ связан с элементом схемы
    SelectChannelColor: TColor; // цвет выделенной ячейки
  end;

  TFormPos = record
    // свойства элемента
    FormDeviceEditSaved: boolean; // признак сохраненной позиции, при первом запуске FALSE
    FormDeviceEditPos: TPoint; // позиция LEFT TOP
    FormDeviceEditSize: TSize; // размер WIDTH HEIGHT
    // GUID элемента
    FormEditDeviceGUIDSaved: boolean;
    FormEditDeviceGUIDPos: TPoint;
    FormEditDeviceGUIDSize: TSize;
    // каналы
    FormMasterChannelsSaved: boolean;
    FormMasterChannelsPos: TPoint;
    FormMasterChannelsSize: TSize;
    // канал
    FormEditChannelSaved: boolean;
    FormEditChannelPos: TPoint;
    FormEditChannelSize: TSize;
  end;

const
  CTPOptions: TTPOptions = (
    // общие
    StationID: 0;
    Ratio: 1; // почему? что это?
    // формат
    TPWidth: 640;
    TPHeight: 480;
    TPColor: $000000; // черный
    FontColor: $FFFFFF; // белый
    // сетка
    GridShow: true;
    GridStep: 20;
    GridColor: $464646; //$646464; //$7F7F7F; //$E8E8E8; // серый
    // границы элементов
    RectShow: false;
    // выделение, перемещение
    SelectColor: $FF80FF; // сиреневый
    MoveColor: $800000; // clNavy;
    // ячейки элементов
    CellShow: false;
    // GUID элементов
    GUIDShow: false;
  );

  CDSOptions: TDSOptions = (
    // $FFD5AA - синий, $CCCCFF - красный, $8080FF - темно-красный, $CCFFCC - зеленый, $FFCCCC - сиреневый
    // элементы схемы
    LightSchemaElementColor: $FFFFFF; // $CCFFCC;
    UnlightSchemaElementColor: $CCCCFF;
    SelectSchemaElementColor: $FFD5AA;

    LightColor: $CCFFCC;
    SelectColor: $FFD5AA;
    ErrorColor: $CCCCFF;
    SelectErrorColor: $8080FF;
    // каналы
    LightChannelColor: $FFFFFF; // $CCFFCC;
    UnlightChannelColor: $CCCCFF;
    SelectChannelColor: $FFD5AA;
  );

  CFormPos: TFormPos = (
    // свойства элемента
    FormDeviceEditSaved: false;
    FormDeviceEditPos: (X: 0; Y: 0);
    FormDeviceEditSize: (cx: 500; cy: 450);
    // GUID элемента
    FormEditDeviceGUIDSaved: false;
    FormEditDeviceGUIDPos: (X: 0; Y: 0);
    FormEditDeviceGUIDSize: (cx: 640; cy: 380);
    // каналы
    FormMasterChannelsSaved: false;
    FormMasterChannelsPos: (X: 0; Y: 0);
    FormMasterChannelsSize: (cx: 640; cy: 380);
    // канал
    FormEditChannelSaved: false;
    FormEditChannelPos: (X: 0; Y: 0);
    FormEditChannelSize: (cx: 640; cy: 460)
  );

var
  VTPOptions: TTPOptions;
  VDSOptions: TDSOptions;
  VFormPos: TFormPos;

implementation

initialization

  VTPOptions:=CTPOptions;
  VDSOptions:=CDSOptions;
  VFormPos:=CFormPos;

end.