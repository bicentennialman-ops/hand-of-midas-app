import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/database/category.dart';
import 'package:handofmidas/models/Category.dart';

import '../localizations.dart';

class SelectCategoryScreen extends StatefulWidget {
  final selectCateogry;
  SelectCategoryScreen(this.selectCateogry);
  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen>
    with SingleTickerProviderStateMixin {
  Map<int, List<Category>> _groupCateogries;

  _SelectCategoryScreenState() {
    CategoryProvider().getGroupCategories().then((groupCateogries) {
      this.setState(() {
        _groupCateogries = groupCateogries;
      });
    });
  }

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: PreferredSize(
            preferredSize: Size(null, appBarHeigh * 1.2),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(null),
                          ),
                          Text(AppLocalizations.of(context).selectCategory,
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(color: Colors.black)),
                          SizedBox(
                            width: iconSize,
                          )
                        ]),
                    Container(
                      height: appBarHeigh * 0.6,
                      child: TabBar(
                        controller: _tabController,
                        tabs: <Widget>[
                          Container(
                            height: appBarHeigh,
                            child: Text(AppLocalizations.of(context).debtLoan,
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(
                                        color: ((_tabController != null) &&
                                                (_tabController.index == 0))
                                            ? Theme.of(context).primaryColor
                                            : AppColors.gray[100])),
                          ),
                          Container(
                            height: appBarHeigh,
                            child: Text(AppLocalizations.of(context).expense,
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(
                                        color: ((_tabController != null) &&
                                                (_tabController.index == 1))
                                            ? Theme.of(context).primaryColor
                                            : AppColors.gray[100])),
                          ),
                          Container(
                            height: appBarHeigh,
                            child: Text(AppLocalizations.of(context).income,
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(
                                        color: ((_tabController != null) &&
                                                (_tabController.index == 2))
                                            ? Theme.of(context).primaryColor
                                            : AppColors.gray[100])),
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ListView.builder(
                itemCount:
                    _groupCateogries == null ? 0 : _groupCateogries[-1].length,
                itemBuilder: (cxt, index) {
                  if (_groupCateogries == null) return null;
                  var category = _groupCateogries[-1][index];
                  return Container(
                    margin: Layout.mt1,
                    decoration: BoxDecoration(color: Colors.white),
                    child: FlatButton(
                      padding: EdgeInsets.all(Layout.p2),
                      onPressed: () => widget.selectCateogry(category),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: iconSize,
                            width: iconSize,
                            margin: Layout.mr1,
                            child: SvgPicture.asset(
                                "${Strings.AVATAR_CATEGORY}/${category.avatar}"),
                          ),
                          Text(
                            category.code != null
                                ? AppLocalizations.of(context)
                                    .categoryName(category.code)
                                : category.name,
                            style: Theme.of(context).textTheme.body1,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              ListView.builder(
                itemCount:
                    _groupCateogries == null ? 0 : _groupCateogries[0].length,
                itemBuilder: (cxt, index) {
                  if (_groupCateogries == null) return null;
                  var category = _groupCateogries[0][index];
                  return Container(
                    margin: Layout.mt1,
                    decoration: BoxDecoration(color: Colors.white),
                    child: FlatButton(
                      padding: EdgeInsets.all(Layout.p2),
                      onPressed: () => widget.selectCateogry(category),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: iconSize,
                            width: iconSize,
                            margin: Layout.mr1,
                            child: SvgPicture.asset(
                                "${Strings.AVATAR_CATEGORY}/${category.avatar}"),
                          ),
                          Text(
                            category.code != null
                                ? AppLocalizations.of(context)
                                    .categoryName(category.code)
                                : category.name,
                            style: Theme.of(context).textTheme.body1,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              ListView.builder(
                itemCount:
                    _groupCateogries == null ? 0 : _groupCateogries[1].length,
                itemBuilder: (cxt, index) {
                  if (_groupCateogries == null) return null;
                  var category = _groupCateogries[1][index];
                  return Container(
                    margin: Layout.mt1,
                    decoration: BoxDecoration(color: Colors.white),
                    child: FlatButton(
                      padding: EdgeInsets.all(Layout.p2),
                      onPressed: () => widget.selectCateogry(category),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: iconSize,
                            width: iconSize,
                            margin: Layout.mr1,
                            child: SvgPicture.asset(
                                "${Strings.AVATAR_CATEGORY}/${category.avatar}"),
                          ),
                          Text(
                            category.code != null
                                ? AppLocalizations.of(context)
                                    .categoryName(category.code)
                                : category.name,
                            style: Theme.of(context).textTheme.body1,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
