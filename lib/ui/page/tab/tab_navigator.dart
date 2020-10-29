import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_android/generated/l10n.dart';
import 'package:fun_android/ui/widget/app_update.dart';

import 'home_page.dart';
import 'project_page.dart';
import 'structure_page.dart';
import 'user_page.dart';
import 'wechat_account_page.dart';

/// todo: tab 页面列表
List<Widget> pages = <Widget>[
  /// 首页
  HomePage(),
  /// 项目页
  ProjectPage(),
  /// 公众号
  WechatAccountPage(),
  /// 体系:
  StructurePage(),
  /// 我的:
  UserPage()
];

//
// todo: bottom nav bar 底部导航栏
//
class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController = PageController();
  int _selectedIndex = 0;
  DateTime _lastPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null || DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          //
          // todo: 页面列表
          //
          itemBuilder: (ctx, index) => pages[index],

          //
          //
          //
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),

          //
          //
          //
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        //
        // todo: 底部导航栏
        //
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(S.of(context).tabHome),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text(S.of(context).tabProject),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            title: Text(S.of(context).wechatAccount),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_split),
            title: Text(S.of(context).tabStructure),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_emoticon),
            title: Text(S.of(context).tabUser),
          ),
        ],
        currentIndex: _selectedIndex,

        //
        // todo: 页面跳转, 写法差异
        //
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  @override
  void initState() {
    checkAppUpdate(context);
    super.initState();
  }
}
