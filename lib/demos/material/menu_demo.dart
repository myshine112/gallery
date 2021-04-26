// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:gallery/demos/material/material_demo_types.dart';

enum SimpleValue {
  one,
  two,
  three,
}

enum CheckedValue {
  one,
  two,
  three,
  four,
}

class MenuDemo extends StatefulWidget {
  const MenuDemo({Key key, this.type}) : super(key: key);

  final MenuDemoType type;

  @override
  _MenuDemoState createState() => _MenuDemoState();
}

class _MenuDemoState extends State<MenuDemo> {
  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget demo;
    switch (widget.type) {
      case MenuDemoType.contextMenu:
        demo = _ContextMenuDemo(showInSnackBar: showInSnackBar);
        break;
      case MenuDemoType.sectionedMenu:
        demo = _SectionedMenuDemo(showInSnackBar: showInSnackBar);
        break;
      case MenuDemoType.simpleMenu:
        demo = _SimpleMenuDemo(showInSnackBar: showInSnackBar);
        break;
      case MenuDemoType.checklistMenu:
        demo = _ChecklistMenuDemo(showInSnackBar: showInSnackBar);
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(GalleryLocalizations.of(context).demoMenuTitle),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: demo,
        ),
      ),
    );
  }
}

// BEGIN menuDemoContext

// Pressing the PopupMenuButton on the right of this item shows
// a simple menu with one disabled item. Typically the contents
// of this "contextual menu" would reflect the app's state.
class _ContextMenuDemo extends StatelessWidget {
  const _ContextMenuDemo({Key key, this.showInSnackBar}) : super(key: key);

  final void Function(String value) showInSnackBar;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(GalleryLocalizations.of(context)
          .demoMenuAnItemWithAContextMenuButton),
      trailing: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        onSelected: (value) => showInSnackBar(
          GalleryLocalizations.of(context).demoMenuSelected(value),
        ),
        itemBuilder: (context) => <PopupMenuItem<String>>[
          PopupMenuItem<String>(
            value: GalleryLocalizations.of(context).demoMenuContextMenuItemOne,
            child: Text(
              GalleryLocalizations.of(context).demoMenuContextMenuItemOne,
            ),
          ),
          PopupMenuItem<String>(
            enabled: false,
            child: Text(
              GalleryLocalizations.of(context).demoMenuADisabledMenuItem,
            ),
          ),
          PopupMenuItem<String>(
            value:
                GalleryLocalizations.of(context).demoMenuContextMenuItemThree,
            child: Text(
              GalleryLocalizations.of(context).demoMenuContextMenuItemThree,
            ),
          ),
        ],
      ),
    );
  }
}

// END

// BEGIN menuDemoSectioned

// Pressing the PopupMenuButton on the right of this item shows
// a menu whose items have text labels and icons and a divider
// That separates the first three items from the last one.
class _SectionedMenuDemo extends StatelessWidget {
  const _SectionedMenuDemo({Key key, this.showInSnackBar}) : super(key: key);

  final void Function(String value) showInSnackBar;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          GalleryLocalizations.of(context).demoMenuAnItemWithASectionedMenu),
      trailing: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        onSelected: (value) => showInSnackBar(
            GalleryLocalizations.of(context).demoMenuSelected(value)),
        itemBuilder: (context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: GalleryLocalizations.of(context).demoMenuPreview,
            child: ListTile(
              leading: const Icon(Icons.visibility),
              title: Text(
                GalleryLocalizations.of(context).demoMenuPreview,
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: GalleryLocalizations.of(context).demoMenuShare,
            child: ListTile(
              leading: const Icon(Icons.person_add),
              title: Text(
                GalleryLocalizations.of(context).demoMenuShare,
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: GalleryLocalizations.of(context).demoMenuGetLink,
            child: ListTile(
              leading: const Icon(Icons.link),
              title: Text(
                GalleryLocalizations.of(context).demoMenuGetLink,
              ),
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: GalleryLocalizations.of(context).demoMenuRemove,
            child: ListTile(
              leading: const Icon(Icons.delete),
              title: Text(
                GalleryLocalizations.of(context).demoMenuRemove,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// END

// BEGIN menuDemoSimple

// This entire list item is a PopupMenuButton. Tapping anywhere shows
// a menu whose current value is highlighted and aligned over the
// list item's center line.
class _SimpleMenuDemo extends StatefulWidget {
  const _SimpleMenuDemo({Key key, this.showInSnackBar}) : super(key: key);

  final void Function(String value) showInSnackBar;

  @override
  _SimpleMenuDemoState createState() => _SimpleMenuDemoState();
}

class _SimpleMenuDemoState extends State<_SimpleMenuDemo> {
  SimpleValue _simpleValue;

  void showAndSetMenuSelection(BuildContext context, SimpleValue value) {
    setState(() {
      _simpleValue = value;
    });
    widget.showInSnackBar(
      GalleryLocalizations.of(context)
          .demoMenuSelected(simpleValueToString(context, value)),
    );
  }

  String simpleValueToString(BuildContext context, SimpleValue value) => {
        SimpleValue.one: GalleryLocalizations.of(context).demoMenuItemValueOne,
        SimpleValue.two: GalleryLocalizations.of(context).demoMenuItemValueTwo,
        SimpleValue.three:
            GalleryLocalizations.of(context).demoMenuItemValueThree,
      }[value];

  @override
  void initState() {
    super.initState();
    _simpleValue = SimpleValue.two;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SimpleValue>(
      padding: EdgeInsets.zero,
      initialValue: _simpleValue,
      onSelected: (value) => showAndSetMenuSelection(context, value),
      itemBuilder: (context) => <PopupMenuItem<SimpleValue>>[
        PopupMenuItem<SimpleValue>(
          value: SimpleValue.one,
          child: Text(simpleValueToString(
            context,
            SimpleValue.one,
          )),
        ),
        PopupMenuItem<SimpleValue>(
          value: SimpleValue.two,
          child: Text(simpleValueToString(
            context,
            SimpleValue.two,
          )),
        ),
        PopupMenuItem<SimpleValue>(
          value: SimpleValue.three,
          child: Text(simpleValueToString(
            context,
            SimpleValue.three,
          )),
        ),
      ],
      child: ListTile(
        title: Text(
            GalleryLocalizations.of(context).demoMenuAnItemWithASimpleMenu),
        subtitle: Text(simpleValueToString(context, _simpleValue)),
      ),
    );
  }
}

// END

// BEGIN menuDemoChecklist

// Pressing the PopupMenuButton on the right of this item shows a menu
// whose items have checked icons that reflect this app's state.
class _ChecklistMenuDemo extends StatefulWidget {
  const _ChecklistMenuDemo({
    Key key,
    this.showInSnackBar,
  }) : super(key: key);

  final void Function(String value) showInSnackBar;

  @override
  _ChecklistMenuDemoState createState() => _ChecklistMenuDemoState();
}

class _RestorableCheckedValues extends RestorableProperty<Set<CheckedValue>> {
  Set<CheckedValue> _checked = <CheckedValue>{};

  void check(CheckedValue value) {
    _checked.add(value);
    notifyListeners();
  }

  void uncheck(CheckedValue value) {
    _checked.remove(value);
    notifyListeners();
  }

  bool isChecked(CheckedValue value) => _checked.contains(value);

  Iterable<String> checkedValuesToString(BuildContext context) {
    return _checked.map((value) {
      return {
        CheckedValue.one: GalleryLocalizations.of(context).demoMenuOne,
        CheckedValue.two: GalleryLocalizations.of(context).demoMenuTwo,
        CheckedValue.three: GalleryLocalizations.of(context).demoMenuThree,
        CheckedValue.four: GalleryLocalizations.of(context).demoMenuFour,
      }[value];
    });
  }

  @override
  Set<CheckedValue> createDefaultValue() => _checked;

  @override
  Set<CheckedValue> initWithValue(Set<CheckedValue> a) {
    _checked = a;
    return _checked;
  }

  @override
  Object toPrimitives() => _checked.map((value) => value.index).toList();

  @override
  Set<CheckedValue> fromPrimitives(Object data) {
    final checkedValues = data as List<dynamic>;
    return Set.from(checkedValues.map<CheckedValue>((dynamic id) {
      return CheckedValue.values[id as int];
    }));
  }
}

class _ChecklistMenuDemoState extends State<_ChecklistMenuDemo>
    with RestorationMixin {
  final _RestorableCheckedValues _checkedValues = _RestorableCheckedValues()
    ..check(CheckedValue.three);

  @override
  String get restorationId => 'checklist_menu_demo';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_checkedValues, 'checked_values');
  }

  void showCheckedMenuSelections(BuildContext context, CheckedValue value) {
    if (_checkedValues.isChecked(value)) {
      setState(() {
        _checkedValues.uncheck(value);
      });
    } else {
      setState(() {
        _checkedValues.check(value);
      });
    }

    widget.showInSnackBar(
      GalleryLocalizations.of(context).demoMenuChecked(
        _checkedValues.checkedValuesToString(context),
      ),
    );
  }

  String checkedValueToString(BuildContext context, CheckedValue value) {
    return {
      CheckedValue.one: GalleryLocalizations.of(context).demoMenuOne,
      CheckedValue.two: GalleryLocalizations.of(context).demoMenuTwo,
      CheckedValue.three: GalleryLocalizations.of(context).demoMenuThree,
      CheckedValue.four: GalleryLocalizations.of(context).demoMenuFour,
    }[value];
  }

  @override
  void dispose() {
    _checkedValues.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        GalleryLocalizations.of(context).demoMenuAnItemWithAChecklistMenu,
      ),
      trailing: PopupMenuButton<CheckedValue>(
        padding: EdgeInsets.zero,
        onSelected: (value) => showCheckedMenuSelections(context, value),
        itemBuilder: (context) => <PopupMenuItem<CheckedValue>>[
          CheckedPopupMenuItem<CheckedValue>(
            value: CheckedValue.one,
            checked: _checkedValues.isChecked(CheckedValue.one),
            child: Text(
              checkedValueToString(context, CheckedValue.one),
            ),
          ),
          CheckedPopupMenuItem<CheckedValue>(
            value: CheckedValue.two,
            enabled: false,
            checked: _checkedValues.isChecked(CheckedValue.two),
            child: Text(
              checkedValueToString(context, CheckedValue.two),
            ),
          ),
          CheckedPopupMenuItem<CheckedValue>(
            value: CheckedValue.three,
            checked: _checkedValues.isChecked(CheckedValue.three),
            child: Text(
              checkedValueToString(context, CheckedValue.three),
            ),
          ),
          CheckedPopupMenuItem<CheckedValue>(
            value: CheckedValue.four,
            checked: _checkedValues.isChecked(CheckedValue.four),
            child: Text(
              checkedValueToString(context, CheckedValue.four),
            ),
          ),
        ],
      ),
    );
  }
}

// END
