import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:fun_android/config/storage_manager.dart';

import 'config/provider_manager.dart';
import 'config/router_manger.dart';
import 'generated/l10n.dart';
import 'view_model/locale_model.dart';
import 'view_model/theme_model.dart';

main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  //
  // todo: 初始化
  //
  await StorageManager.init();

  //
  //
  //
  runApp(App());
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.light));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///
    ///
    ///
    ///
    return OKToast(

        ///
        ///
        /// todo: 使用 [MultiProvider]
        ///
        child: MultiProvider(
            //
            // todo: 注意
            //
            providers: providers,

            //
            // todo: 注意 2个 model
            //
            child: Consumer2<ThemeModel, LocaleModel>(builder: (context, themeModel, localeModel, child) {
              return RefreshConfiguration(
                hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多

                ///
                /// todo: app
                ///
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  /// todo: 主题配置
                  theme: themeModel.themeData(),
                  darkTheme: themeModel.themeData(platformDarkMode: true),
                  locale: localeModel.locale,

                  //
                  // todo: 多语言支持
                  //
                  localizationsDelegates: const [
                    S.delegate, // todo: tool gen
                    RefreshLocalizations.delegate, //下拉刷新
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  supportedLocales: S.delegate.supportedLocales,

                  //
                  // todo: router
                  //
                  onGenerateRoute: RouterManger.generateRoute,
                  // todo: 默认初始路由
                  initialRoute: RouteName.splash,
                ),
              );
            })));
  }
}
