import 'package:my_test/util/AppColors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SelectField extends StatefulWidget {
  final double? width; //欄位寬，可給可不給
  final List items; //下拉選項 (ex:[['跑步', 'Running'],['爬山', 'Climbing']]  or  [['跑步'],['爬山']])
  final String value;
  final Function? onChanged; //change時觸發
  final String? label; //輸入欄位label
  final String hint; //輸入欄位提示文字
  final String errMsg; //錯誤訊息
  final bool hasErr; //是否有錯誤
  final bool enable; //是否禁用
  final bool whiteBg; //禁用時是否白底
  final String searchHint; //搜尋彈窗label
  final EdgeInsetsGeometry margin; //欄位邊距
  final bool showLabel; //下拉沒有選到時，是否需顯示label區塊
  final bool display; //是否顯示此欄位
  final bool hideClearIcon;//隱藏清空Icon
  final TextEditingController? controller;
  final String alertMsg; //提示訊息

  const SelectField(
      {Key? key,
        this.width,
        this.items = const [],
        this.value = '',
        this.onChanged,
        this.label,
        this.hint = '',
        this.errMsg = '',
        this.hasErr = false,
        this.enable = true,
        this.whiteBg = false,
        this.searchHint='',
        this.margin = const EdgeInsets.only(bottom: 15),
        this.showLabel = false,
        this.display = true,
        this.controller,
        this.hideClearIcon = false,
        this.alertMsg = '',
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return SelectFieldWidgetState();
  }
}

class SelectFieldWidgetState extends State<SelectField> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Visibility(
      visible: widget.display,
      child: Container(
        color: widget.enable
            ? null
            : widget.whiteBg ? Colors.transparent : const Color(0xFFF1F1F1),
        margin: widget.margin,
        width: widget.width,
        child: Stack(
          children: <Widget>[
            DropDownFormField(
              titleText: widget.label!,
              hintText: widget.hint,
              onChanged: widget.enable ? (v){
                FocusScope.of(context)
                    .requestFocus(FocusNode());
                if(widget.controller!=null){
                  if(widget.controller!.text==v) return;
                  widget.controller!.text = v;
                }
                widget.onChanged!(v);
              } : null,
              value: widget.items.isNotEmpty?widget.controller!=null ? widget.controller!.text : widget.value :'',
              dataSource: widget.items,
              enable: widget.enable,
              searchHintText: widget.searchHint,
              showLabel:widget.showLabel,
              whiteBg: widget.whiteBg,
              hideClearIcon: widget.hideClearIcon,
            ),
            Positioned(
              right: 65,
              bottom: 8,
              child: Visibility(
                visible: widget.hasErr,
                child: Container(
                  color: const Color(0xFFD0021B),
                  padding: const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
                  child: Text(widget.errMsg,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14 ,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      )),
                ),
              ),
            ),
            Positioned(
              right: 65,
              bottom: 8,
              child: Visibility(
                visible: !widget.hasErr && widget.alertMsg.isNotEmpty,
                child: Container(
                  color: AppColors.white0,
                  padding: const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
                  child: Text(widget.alertMsg,
                      style: const TextStyle(
                        color: AppColors.scarlet,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DropDownFormField extends FormField<dynamic> {
  final dynamic titleText;
  final String? hintText;
  final dynamic value;
  final List? dataSource;
  final Function? onChanged;
  final bool? enable;
  final String? searchHintText;
  final bool? showLabel;
  final bool whiteBg;
  final bool hideClearIcon;

  DropDownFormField(
      {Key? key,
        FormFieldSetter<dynamic>? onSaved,
        FormFieldValidator<dynamic>? validator,
        bool autoValidate = false,
        this.titleText,
        this.hintText,
        this.value,
        this.dataSource,
        this.onChanged,
        this.enable,
        this.searchHintText,
        this.showLabel,
        this.whiteBg = false,
        this.hideClearIcon = false})
      : super(key: key,
    onSaved: onSaved,
    validator: validator,
    builder: (FormFieldState<dynamic> state) {
      String selectDisplayValue = '';
      if(value != null && value != ''){
        dataSource!.forEach((e) {
          if(e.length==1 && e[0] == value){
            selectDisplayValue = e[0];
          }else if(e.length==2 && e[1] == value){
            selectDisplayValue = e[0];
          }
        });
      }
      return Container(
//              padding:EdgeInsets.only(bottom:15,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InputDecorator(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: enable! ? Colors.black : Colors.transparent,width:0),
                  ),
                  contentPadding: titleText!=null&&!enable ? const EdgeInsets.fromLTRB(0, 0, 0, -16) : const EdgeInsets.fromLTRB(0, 0, 0, -4),
                ),
                child: SearchableDropdown.single(
                  showLabel:showLabel!,
                  label:titleText,
                  underline: SizedBox(),
                  displayClearIcon: (whiteBg || hideClearIcon)?false:true,
                  icon: Transform.rotate(
                    //旋转90度
                    angle: math.pi / 2,
                    child: Icon(Icons.arrow_forward_ios,size:whiteBg?0:null),
                  ),
                  iconEnabledColor: const Color(0xff2d73a5),
                  style: const TextStyle(
                    color: Color(0xff2d73a5),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  ),
                  hint: Text(
                    hintText!,
                    style: const TextStyle(
                      color: Color(0xff2d73a5),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    ),
                  ),
                  disabledHint: Text(
                    selectDisplayValue.trim().isEmpty ? hintText : selectDisplayValue,
                    style: TextStyle(
                      color: selectDisplayValue.trim().isEmpty ? const Color(0xff2d73a5) : const Color(0xff373a3c),
                      fontSize: 20 ,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    ),
                  ),
                  searchHint: searchHintText==''?null:Text(
                    searchHintText!,
                    style: const TextStyle(
                      color: Color(0xff2d73a5),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    ),
                  ),
                  value: value,
                  onChanged: onChanged!,
                  items: dataSource!.map((item) {
                    return DropdownMenuItem<dynamic>(
                      value: item.length == 1 ? item[0] : item[1],
                      child: Text(item[0]),
                    );
                  }).toList(),
                  isExpanded: true,
                  selectedValueWidgetFn: (item) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.child.data,
//                      textWidthBasis:TextWidthBasis.parent,
                        style: const TextStyle(
                          color: Color(0xff373a3c),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0,
                        ),
                        softWrap: false,
                      ),
                    );
                  },
                )),
          ],
        ),
      );
    },
  );
}

const EdgeInsetsGeometry _kAlignedButtonPadding =
EdgeInsetsDirectional.only(start: 16.0, end: 4.0);
const EdgeInsets _kUnalignedButtonPadding = EdgeInsets.zero;

class NotGiven {
  const NotGiven();
}

Widget prepareWidget(dynamic object,
    {dynamic parameter = const NotGiven(),
      BuildContext? context,
      Function? stringToWidgetFunction}) {
  if (object is Widget) {
    return (object);
  }
  if (object is String) {
    if (stringToWidgetFunction == null) {
      return (Text(object));
    } else {
      return (stringToWidgetFunction(object));
    }
  }
  if (object is Function) {
    if (parameter is NotGiven) {
      if (context == null) {
        return (prepareWidget(object(),
            stringToWidgetFunction: stringToWidgetFunction));
      } else {
        return (prepareWidget(object(context)!,
            stringToWidgetFunction: stringToWidgetFunction));
      }
    }
    if (context == null) {
      return (prepareWidget(object(parameter),
          stringToWidgetFunction: stringToWidgetFunction));
    }
    return (prepareWidget(object(parameter, context)!,
        stringToWidgetFunction: stringToWidgetFunction));
  }
  return (Text("Unknown type: ${object.runtimeType.toString()}"));
}

class SearchableDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>>? items;
  final Function? onChanged;
  final T? value;
  final TextStyle? style;
  final dynamic searchHint;
  final dynamic hint;
  final dynamic disabledHint;
  final dynamic icon;
  final dynamic underline;
  final dynamic doneButton;
  final dynamic label;
  final dynamic closeButton;
  final bool displayClearIcon;
  final Icon clearIcon;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double iconSize;
  final bool isExpanded;
  final bool isCaseSensitiveSearch;
  final Function? searchFn;
  final Function? onClear;
  final Function? selectedValueWidgetFn;
  final TextInputType keyboardType;
  final Function? validator;
  final bool multipleSelection;
  final List<int> selectedItems;
  final Function? displayItem;
  final bool? dialogBox;
  final BoxConstraints? menuConstraints;
  final bool readOnly;
  final Color? menuBackgroundColor;
  final bool? isButton;
  final bool? showLabel;

  /// Search choices Widget with a single choice that opens a dialog or a menu to let the user do the selection conveniently with a search.
  ///
  /// @param items with __child__: [Widget] displayed ; __value__: any object with .toString() used to match search keyword.
  /// @param onChanged [Function] with parameter: __value__ not returning executed after the selection is done.
  /// @param value value to be preselected.
  /// @param style used for the hint if it is given is [String].
  /// @param searchHint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed at the top of the search dialog box.
  /// @param hint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed before any value is selected or after the selection is cleared.
  /// @param disabledHint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed instead of hint when the widget is displayed.
  /// @param icon [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed next to the selected item or the hint if none.
  /// @param underline [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed below the selected item or the hint if none.
  /// @param doneButton [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed at the top of the search dialog box.
  /// @param label [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed above the selected item or the hint if none.
  /// @param closeButton [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed at the bottom of the search dialog box.
  /// @param displayClearIcon whether or not to display an icon to clear the selected value.
  /// @param clearIcon [Icon] to be used for clearing the selected value.
  /// @param iconEnabledColor [Color] to be used for enabled icons.
  /// @param iconDisabledColor [Color] to be used for disabled icons.
  /// @param iconSize for the icons next to the selected value (icon and clearIcon).
  /// @param isExpanded can be necessary to avoid pixel overflows (zebra symptom).
  /// @param isCaseSensitiveSearch only used when searchFn is not specified.
  /// @param searchFn [Function] with parameters: __keyword__, __items__ returning [List<int>] as the list of indexes for the items to be displayed.
  /// @param onClear [Function] with no parameter not returning executed when the clear icon is tapped.
  /// @param selectedValueWidgetFn [Function] with parameter: __item__ returning [Widget] to be used to display the selected value.
  /// @param keyboardType used for the search.
  /// @param validator [Function] with parameter: __value__ returning [String] displayed below selected value when not valid and null when valid.
  /// @param assertUniqueValue whether to run a consistency check of the list of items.
  /// @param displayItem [Function] with parameters: __item__, __selected__ returning [Widget] to be displayed in the search list.
  /// @param dialogBox whether the search should be displayed as a dialog box or as a menu below the selected value if any.
  /// @param menuConstraints [BoxConstraints] used to define the zone where to display the search menu. Example: BoxConstraints.tight(Size.fromHeight(250)) . Not to be used for dialogBox = true.
  /// @param readOnly [bool] whether to let the user choose the value to select or just present the selected value if any.
  /// @param menuBackgroundColor [Color] background color of the menu whether in dialog box or menu mode.
  factory SearchableDropdown.single({
    Key? key,
    @required List<DropdownMenuItem<T>>? items,
    @required Function? onChanged,
    T? value,
    TextStyle? style,
    dynamic searchHint,
    dynamic hint,
    dynamic disabledHint,
    dynamic icon = const Icon(Icons.arrow_drop_down),
    dynamic underline,
    dynamic doneButton,
    dynamic label,
    dynamic closeButton,
    bool displayClearIcon = true,
    Icon clearIcon = const Icon(Icons.clear),
    Color? iconEnabledColor,
    Color? iconDisabledColor,
    double iconSize = 24.0,
    bool isExpanded = false,
    bool isCaseSensitiveSearch = false,
    Function? searchFn,
    Function? onClear,
    Function? selectedValueWidgetFn,
    TextInputType keyboardType = TextInputType.text,
    Function? validator,
    bool assertUniqueValue = true,
    Function? displayItem,
    bool dialogBox = true,
    BoxConstraints? menuConstraints,
    bool readOnly = false,
    Color? menuBackgroundColor,
    bool isButton = false,
    bool showLabel = false,
  }) {
    return (SearchableDropdown._(
      key: key,
      items: items!,
      onChanged: onChanged!,
      value: value as T,
      style: style!,
      searchHint: searchHint,
      hint: hint,
      disabledHint: disabledHint,
      icon: icon,
      underline: underline,
      iconEnabledColor: iconEnabledColor!,
      iconDisabledColor: iconDisabledColor!,
      iconSize: iconSize,
      isExpanded: isExpanded,
      isCaseSensitiveSearch: isCaseSensitiveSearch,
      closeButton: closeButton,
      displayClearIcon: displayClearIcon,
      clearIcon: clearIcon,
      onClear: onClear!,
      selectedValueWidgetFn: selectedValueWidgetFn!,
      keyboardType: keyboardType,
      validator: validator!,
      label: label,
      searchFn: searchFn!,
      multipleSelection: false,
      doneButton: doneButton,
      displayItem: displayItem!,
      dialogBox: dialogBox,
      menuConstraints: menuConstraints!,
      readOnly: readOnly,
      menuBackgroundColor: menuBackgroundColor!,
      isButton:isButton,
      showLabel: showLabel,
    ));
  }

  /// Search choices Widget with a multiple choice that opens a dialog or a menu to let the user do the selection conveniently with a search.
  ///
  /// @param items with __child__: [Widget] displayed ; __value__: any object with .toString() used to match search keyword.
  /// @param onChanged [Function] with parameter: __selectedItems__ not returning executed after the selection is done.
  /// @param selectedItems indexes of items to be preselected.
  /// @param style used for the hint if it is given is [String].
  /// @param searchHint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed at the top of the search dialog box.
  /// @param hint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed before any value is selected or after the selection is cleared.
  /// @param disabledHint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed instead of hint when the widget is displayed.
  /// @param icon [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed next to the selected items or the hint if none.
  /// @param underline [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed below the selected items or the hint if none.
  /// @param doneButton [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed at the top of the search dialog box. Cannot be null in multiple selection mode.
  /// @param label [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed above the selected items or the hint if none.
  /// @param closeButton [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed at the bottom of the search dialog box.
  /// @param displayClearIcon whether or not to display an icon to clear the selected values.
  /// @param clearIcon [Icon] to be used for clearing the selected values.
  /// @param iconEnabledColor [Color] to be used for enabled icons.
  /// @param iconDisabledColor [Color] to be used for disabled icons.
  /// @param iconSize for the icons next to the selected values (icon and clearIcon).
  /// @param isExpanded can be necessary to avoid pixel overflows (zebra symptom).
  /// @param isCaseSensitiveSearch only used when searchFn is not specified.
  /// @param searchFn [Function] with parameters: __keyword__, __items__ returning [List<int>] as the list of indexes for the items to be displayed.
  /// @param onClear [Function] with no parameter not returning executed when the clear icon is tapped.
  /// @param selectedValueWidgetFn [Function] with parameter: __item__ returning [Widget] to be used to display the selected values.
  /// @param keyboardType used for the search.
  /// @param validator [Function] with parameter: __selectedItems__ returning [String] displayed below selected values when not valid and null when valid.
  /// @param displayItem [Function] with parameters: __item__, __selected__ returning [Widget] to be displayed in the search list.
  /// @param dialogBox whether the search should be displayed as a dialog box or as a menu below the selected values if any.
  /// @param menuConstraints [BoxConstraints] used to define the zone where to display the search menu. Example: BoxConstraints.tight(Size.fromHeight(250)) . Not to be used for dialogBox = true.
  /// @param readOnly [bool] whether to let the user choose the value to select or just present the selected value if any.
  /// @param menuBackgroundColor [Color] background color of the menu whether in dialog box or menu mode.
  factory SearchableDropdown.multiple({
    Key? key,
    @required List<DropdownMenuItem<T>>? items,
    @required Function? onChanged,
    List<int> selectedItems = const [],
    TextStyle? style,
    dynamic searchHint,
    dynamic hint,
    dynamic disabledHint,
    dynamic icon = const Icon(Icons.arrow_drop_down),
    dynamic underline,
    dynamic doneButton = "Done",
    dynamic label,
    dynamic closeButton = "Close",
    bool displayClearIcon = true,
    Icon clearIcon = const Icon(Icons.clear),
    Color? iconEnabledColor,
    Color? iconDisabledColor,
    double iconSize = 24.0,
    bool isExpanded = false,
    bool isCaseSensitiveSearch = false,
    Function? searchFn,
    Function? onClear,
    Function? selectedValueWidgetFn,
    TextInputType keyboardType = TextInputType.text,
    Function? validator,
    Function? displayItem,
    bool dialogBox = true,
    BoxConstraints? menuConstraints,
    bool readOnly = false,
    Color? menuBackgroundColor,
  }) {
    return (SearchableDropdown._(
      key: key!,
      items: items!,
      style: style!,
      searchHint: searchHint,
      hint: hint,
      disabledHint: disabledHint,
      icon: icon,
      underline: underline,
      iconEnabledColor: iconEnabledColor!,
      iconDisabledColor: iconDisabledColor!,
      iconSize: iconSize,
      isExpanded: isExpanded,
      isCaseSensitiveSearch: isCaseSensitiveSearch,
      closeButton: closeButton,
      displayClearIcon: displayClearIcon,
      clearIcon: clearIcon,
      onClear: onClear!,
      selectedValueWidgetFn: selectedValueWidgetFn!,
      keyboardType: keyboardType,
      validator: validator!,
      label: label,
      searchFn: searchFn!,
      multipleSelection: true,
      selectedItems: selectedItems,
      doneButton: doneButton,
      onChanged: onChanged!,
      displayItem: displayItem!,
      dialogBox: dialogBox,
      menuConstraints: menuConstraints!,
      readOnly: readOnly,
      menuBackgroundColor: menuBackgroundColor!,
    ));
  }

  SearchableDropdown._({
    Key? key,
    @required this.items,
    this.onChanged,
    this.value,
    this.style,
    this.searchHint,
    this.hint,
    this.disabledHint,
    this.icon,
    this.underline,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.iconSize = 24.0,
    this.isExpanded = false,
    this.isCaseSensitiveSearch = false,
    this.closeButton,
    this.displayClearIcon = true,
    this.clearIcon = const Icon(Icons.clear),
    this.onClear,
    this.selectedValueWidgetFn,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.label,
    this.searchFn,
    this.multipleSelection = false,
    this.selectedItems = const [],
    this.doneButton,
    this.displayItem,
    this.dialogBox,
    this.menuConstraints,
    this.readOnly = false,
    this.menuBackgroundColor,
    this.isButton,
    this.showLabel,
  })  : assert(items != null),
        assert(iconSize != null),
        assert(isExpanded != null),
        assert(!multipleSelection || doneButton != null),
        assert(menuConstraints == null || !dialogBox!),
        super(key: key);

  SearchableDropdown({
    Key? key,
    @required this.items,
    @required this.onChanged,
    this.value,
    this.style,
    this.searchHint,
    this.hint,
    this.disabledHint,
    this.icon = const Icon(Icons.arrow_drop_down),
    this.underline,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.iconSize = 24.0,
    this.isExpanded = false,
    this.isCaseSensitiveSearch = false,
    this.closeButton = "Close",
    this.displayClearIcon = false,
    this.clearIcon = const Icon(Icons.clear),
    this.onClear,
    this.selectedValueWidgetFn,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.label,
    this.searchFn,
    this.multipleSelection = false,
    this.selectedItems = const [],
    this.doneButton,
    this.displayItem,
    this.dialogBox = true,
    this.menuConstraints,
    this.readOnly = false,
    this.menuBackgroundColor,
    this.isButton = false,
    this.showLabel = false,
  })  : assert(items != null),
        assert(iconSize != null),
        assert(isExpanded != null),
        assert(!multipleSelection || doneButton != null),
        assert(menuConstraints == null || !dialogBox!),
        super(key: key);

  @override
  _SearchableDropdownState<T> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  List<int> selectedItems = [];
  List<bool> displayMenu = [false];
  dynamic selectedVal;

  TextStyle get _textStyle =>
      widget.style ??
          (_enabled && !(widget.readOnly)
              ? Theme.of(context).textTheme.subtitle1!
              : Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: _disabledIconColor));

  bool get _enabled =>
      widget.items != null &&
          widget.items!.isNotEmpty &&
          widget.onChanged != null;

  Color get _enabledIconColor {
    if (widget.iconEnabledColor != null) {
      return widget.iconEnabledColor!;
    }
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return Colors.grey.shade700;
      case Brightness.dark:
        return Colors.white70;
    }
    return Colors.grey.shade700;
  }

  Color get _disabledIconColor {
    if (widget.iconDisabledColor != null) {
      return widget.iconDisabledColor!;
    }
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return Colors.grey.shade400;
      case Brightness.dark:
        return Colors.white10;
    }
    return Colors.grey.shade400;
  }

  Color get _iconColor {
    // These colors are not defined in the Material Design spec.
    return (_enabled && !(widget.readOnly)
        ? _enabledIconColor
        : _disabledIconColor);
  }

  bool get valid {
    if (widget.validator == null) {
      return (true);
    }
    return (widget.validator!(selectedResult) == null);
  }

  bool get hasSelection {
    return (selectedItems != null && selectedItems.isNotEmpty);
  }

  dynamic get selectedResult {
    return (widget.multipleSelection
        ? selectedItems
        : selectedItems.isNotEmpty
        ? widget.items![selectedItems.first].value
        : null);
  }

  int indexFromValue(T value) {
    return (widget.items!.indexWhere((item) {
      return (item.value == value);
    }));
  }

  @override
  void initState() {
    _updateSelectedIndex();
    selectedVal = widget.value;
    super.initState();
  }

  void _updateSelectedIndex() {
    if (!_enabled) {
      return;
    }
    if (widget.multipleSelection) {
      selectedItems = List.from(widget.selectedItems);
    } else if (widget.value != null) {
      int i = indexFromValue(widget.value!);
      if (i != null && i != -1) {
        selectedItems.clear();
        selectedItems.add(i);
        selectedVal = widget.value;
      }else{
//        if(widget.value==''){
//          selectedItems.clear();
//          selectedVal = null;
//        }
        selectedItems.clear();
        selectedVal = null;
      }
    }
    if (selectedItems == null) selectedItems = [];
  }

  @override
  void didUpdateWidget(SearchableDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSelectedIndex();
  }

  Widget get menuWidget {
    return (DropdownDialog(
      items: widget.items!,
      hint: prepareWidget(widget.searchHint!),
      isCaseSensitiveSearch: widget.isCaseSensitiveSearch,
      closeButton: widget.closeButton,
      keyboardType: widget.keyboardType,
      searchFn: widget.searchFn,
      multipleSelection: widget.multipleSelection,
      selectedItems: selectedItems,
      doneButton: widget.doneButton,
      displayItem: widget.displayItem,
      validator: widget.validator,
      dialogBox: widget.dialogBox,
      displayMenu: displayMenu,
      menuConstraints: widget.menuConstraints,
      menuBackgroundColor: widget.menuBackgroundColor,
      callOnPop: () {
        if (!widget.dialogBox! &&
            widget.onChanged != null &&
            selectedItems != null) {
          widget.onChanged!(selectedResult);
        }
        setState(() {});
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items =
    _enabled ? List<Widget>.from(widget.items!) : <Widget>[];
    int? hintIndex;
    if (widget.hint != null ||
        (!_enabled && prepareWidget(widget.disabledHint) != null)) {
      final Widget emplacedHint = _enabled
          ? prepareWidget(widget.hint!)
          : widget.isButton! ||(widget.items!.length==0 && widget.onChanged!=null)?prepareWidget(widget.disabledHint!??widget.hint!):DropdownMenuItem<Widget>(
          child: prepareWidget(widget.disabledHint));
      hintIndex = items.length;
      items.add(DefaultTextStyle(
        style: _textStyle.copyWith(color: Theme.of(context).hintColor),
        child: IgnorePointer(
          ignoringSemantics: false,
          child: emplacedHint,
        ),
      ));
    }
    Widget innerItemsWidget;
    List<Widget> list = [];
    if(widget.items!.isEmpty) selectedItems.clear();
    selectedItems.forEach((item) {
      list.add(widget.selectedValueWidgetFn != null
          ? widget.selectedValueWidgetFn!(widget.items![item])
          : items[item]);
    });
    if (list.isEmpty && hintIndex != null) {
      innerItemsWidget = items[hintIndex];
    } else {
      innerItemsWidget = Column(
        children: list,
      );
    }
    final EdgeInsetsGeometry padding = ButtonTheme.of(context).alignedDropdown
        ? _kAlignedButtonPadding
        : _kUnalignedButtonPadding;

    Widget clickable = InkWell(
        key: Key("clickableResultPlaceHolder"),
        //this key is used for running automated tests
        onTap: (widget.readOnly) || !_enabled
            ? null
            : () async {
          if (widget.dialogBox!) {
            await showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return (menuWidget);
                });
            if (widget.onChanged != null && selectedItems != null) {
              widget.onChanged!(selectedResult??'');
              selectedVal = selectedResult??'';
            }
          } else {
            displayMenu.first = true;
          }
          setState(() {});
        },
        child: Row(
          children: <Widget>[
            widget.isExpanded
                ? Expanded(child: innerItemsWidget)
                : innerItemsWidget,
            IconTheme(
              data: IconThemeData(
                color: _iconColor,
                size: widget.iconSize,
              ),
              child: prepareWidget(widget.icon, parameter: selectedResult)
            ),
          ],
        ));

    Widget result = DefaultTextStyle(
      style: _textStyle,
      child: Container(
        padding: padding.resolve(Directionality.of(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.isExpanded ? Expanded(child: clickable) : clickable,
            !widget.displayClearIcon
                ? SizedBox()
                : InkWell(
              onTap: hasSelection && _enabled && !widget.readOnly
                  ? () {
                clearSelection();
              }
                  : null,
              child: Container(
//                      padding: padding.resolve(Directionality.of(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconTheme(
                      data: IconThemeData(
                        color:
                        hasSelection && _enabled && !widget.readOnly
                            ? _enabledIconColor
                            : _disabledIconColor,
                        size: widget.iconSize,
                      ),
                      child: widget.clearIcon,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    int selI = indexFromValue(selectedVal);
    final double bottom = 8.0;
    var validatorOutput;
    if (widget.validator != null) {
      validatorOutput = widget.validator!(selectedResult);
    }
    var labelOutput = prepareWidget((selI!= null&&selI!=-1)||widget.showLabel!?widget.label:'', parameter: selectedResult,
        stringToWidgetFunction: (string) {
          return Container(
            height:21 ,
            padding:const EdgeInsets.only(left:13),
            child: (Text(string,
                style: const TextStyle(
                  color: Color(0xff2d73a5),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                ))),
          );
        });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        labelOutput,
        Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: result,
            ),
            widget.underline is NotGiven
                ? const SizedBox.shrink()
                : Positioned(
              left: 0.0,
              right: 0.0,
              bottom: bottom,
              child: prepareWidget(widget.underline,
                  parameter: selectedResult)
            ),
          ],
        ),
        valid
            ? const SizedBox.shrink()
            : validatorOutput is String
            ? Text(
          validatorOutput,
          style: const TextStyle(color: Colors.red, fontSize: 13),
        )
            : validatorOutput,
        displayMenu.first ? menuWidget : const SizedBox.shrink(),
      ],
    );
  }

  clearSelection() {
    selectedItems.clear();
    selectedVal = null;
    if (widget.onChanged != null) {
      widget.onChanged!(selectedResult??'');
    }
    if (widget.onClear != null) {
      widget.onClear!();
    }
    setState(() {});
  }
}

class DropdownDialog<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>>? items;
  final Widget? hint;
  final bool isCaseSensitiveSearch;
  final dynamic closeButton;
  final TextInputType? keyboardType;
  final Function? searchFn;
  final bool? multipleSelection;
  final List? selectedItems;
  final Function? displayItem;
  final dynamic doneButton;
  final Function? validator;
  final bool? dialogBox;
  final List<bool>? displayMenu;
  final BoxConstraints? menuConstraints;
  final Function? callOnPop;
  final Color? menuBackgroundColor;

  DropdownDialog({
    Key? key,
    this.items,
    this.hint,
    this.isCaseSensitiveSearch = false,
    this.closeButton,
    this.keyboardType,
    this.searchFn,
    this.multipleSelection,
    this.selectedItems,
    this.displayItem,
    this.doneButton,
    this.validator,
    this.dialogBox,
    this.displayMenu,
    this.menuConstraints,
    this.callOnPop,
    this.menuBackgroundColor,
  })  : assert(items != null),
        super(key: key);

  _DropdownDialogState<T> createState() => new _DropdownDialogState<T>();
}

class _DropdownDialogState<T> extends State<DropdownDialog> {
  TextEditingController txtSearch = TextEditingController();
  TextStyle defaultButtonStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  List<int> shownIndexes = [];
  Function? searchFn;

  _DropdownDialogState();

  dynamic get selectedResult {
    return (widget.multipleSelection!
        ? widget.selectedItems!
        : widget.selectedItems?.isNotEmpty ?? false
        ? widget.items![widget.selectedItems!.first].value
        : null);
  }

  void _updateShownIndexes(String keyword) {
    shownIndexes = searchFn!(keyword, widget.items);
  }

  @override
  void initState() {
    if (widget.searchFn != null) {
      searchFn = widget.searchFn!;
    } else {
      Function matchFn;
      if (widget.isCaseSensitiveSearch) {
        matchFn = (item, keyword) {
          return (item.child.data.toString().contains(keyword));
        };
      } else {
        matchFn = (item, keyword) {
          // print(item.child.data
          //     .toString()
          //     .toLowerCase()
          //     .contains(keyword.toLowerCase()));
          return (item.child.data
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()));
        };
      }
      searchFn = (keyword, items) {
        List<int> shownIndexes = [];
        int i = 0;
        widget.items!.forEach((item) {
          if (matchFn(item, keyword) || (keyword?.isEmpty ?? true)) {
            shownIndexes.add(i);
          }
          i++;
        });
        return (shownIndexes);
      };
    }
    assert(searchFn != null);
    _updateShownIndexes('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 300),
      child: Card(
        color: widget.menuBackgroundColor,
        margin: EdgeInsets.symmetric(
            vertical: widget.dialogBox! ? 10 : 5,
            horizontal: widget.dialogBox! ? 300 : 4),
        child:  Container(
          width: 800,
          height: 400,
          constraints: widget.menuConstraints,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              titleBar(),
              searchBar(),
              list(),
              closeButtonWrapper(),
            ],
          ),
        ),
      ),
    );
  }

  bool get valid {
    if (widget.validator == null) {
      return (true);
    }
    return (widget.validator!(selectedResult) == null);
  }

  Widget titleBar() {
    var validatorOutput;
    if (widget.validator != null) {
      validatorOutput = widget.validator!(selectedResult);
    }

    Widget validatorOutputWidget = valid
        ? const SizedBox.shrink()
        : validatorOutput is String
        ? Text(
      validatorOutput,
      style: const TextStyle(color: Colors.red, fontSize: 13),
    )
        : validatorOutput;

    Widget doneButtonWidget =
    widget.multipleSelection! || widget.doneButton != null
        ? prepareWidget(widget.doneButton,
        parameter: selectedResult!,
        context: context, stringToWidgetFunction: (string) {
          return (ElevatedButton.icon(
              onPressed: !valid
                  ? null
                  : () {
                pop();
                setState(() {});
              },
              icon: Icon(Icons.close),
              label: Text(string)));
        })
        : SizedBox.shrink();
    return widget.hint != null
        ?  Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            prepareWidget(widget.hint!),
            Column(
              children: <Widget>[doneButtonWidget, validatorOutputWidget],
            ),
          ]),
    )
        :  Container(
      child: Column(
        children: <Widget>[doneButtonWidget, validatorOutputWidget],
      ),
    );
  }

  Widget searchBar() {
    return  Container(
      child:  Stack(
        children: <Widget>[
           TextField(
            controller: txtSearch,
            decoration: const InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
            autofocus: true,
            onChanged: (value) {
              _updateShownIndexes(value);
              setState(() {});
            },
            keyboardType: widget.keyboardType,
          ),
      const Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child:  Icon(
                Icons.search,
                size: 24,
              ),
            ),
          ),
          txtSearch.text.isNotEmpty
              ? Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child:  Center(
              child:  InkWell(
                onTap: () {
                  _updateShownIndexes('');
                  setState(() {
                    txtSearch.text = '';
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                child:  Container(
                  width: 32,
                  height: 32,
                  child: const Center(
                    child:  Icon(
                      Icons.close,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          )
              : Container(),
        ],
      ),
    );
  }

  pop() {
    if (widget.dialogBox!) {
      Navigator.pop(context);
    } else {
      widget.displayMenu!.first = false;
      if (widget.callOnPop != null) {
        widget.callOnPop!();
      }
    }
  }

  Widget list() {
    return  Expanded(
      child: Scrollbar(
        child:  ListView.builder(
          itemBuilder: (context, index) {
            DropdownMenuItem item = widget.items![shownIndexes[index]];
            return  InkWell(
              onTap: () {
                if (widget.multipleSelection!) {
                  setState(() {
                    if (widget.selectedItems!.contains(shownIndexes[index])) {
                      widget.selectedItems!.remove(shownIndexes[index]);
                    } else {
                      widget.selectedItems!.add(shownIndexes[index]);
                    }
                  });
                } else {
                  widget.selectedItems!.clear();
                  widget.selectedItems!.add(shownIndexes[index]);
                  if (widget.doneButton == null) {
                    pop();
                  } else {
                    setState(() {});
                  }
                }
              },
              child: widget.multipleSelection!
                  ? widget.displayItem == null
                  ? (Row(children: [
                Icon(
                  widget.selectedItems!.contains(shownIndexes[index])
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                ),
                SizedBox(
                  width: 7,
                ),
                Flexible(child: item),
              ]))
                  : widget.displayItem!(item,
                  widget.selectedItems!.contains(shownIndexes[index]))
                  : widget.displayItem == null
                  ? item
                  : widget.displayItem!(item, item.value == selectedResult),
            );
          },
          itemCount: shownIndexes.length,
        ),
      ),
    );
  }

  Widget closeButtonWrapper() {
    return (prepareWidget(widget.closeButton, parameter: selectedResult!,
        stringToWidgetFunction: (string) {
          return (Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    pop();
                  },
                  child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2),
                      child: Text(
                        string,
                        style: defaultButtonStyle,
                        overflow: TextOverflow.ellipsis,
                      )),
                )
              ],
            ),
          ));
        }));
  }
}