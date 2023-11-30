import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/routes/app_routes.dart';

class MyAppScaffold extends StatelessWidget {
  const MyAppScaffold({
    super.key,
    this.backgroundColor,
    this.bottomSheet,
    this.body,
    this.resizeToAvoidBottomInset,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.appBar,
  });

  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final Widget? bottomSheet;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor ?? transparentGrey,
      bottomSheet: bottomSheet,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      appBar: appBar,
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    super.key,
    this.showMenu,
    this.showDisplayPicture,
    this.child,
    this.showText,
    this.showTextWidget,
    this.showTopPadding,
    this.showCardPadding,
    this.showSaveBtn,
    this.onTap,
    this.showBack,
    this.image,
  });
  final bool? showMenu;
  final bool? showDisplayPicture;
  final Widget? child;
  final bool? showText;
  final Widget? showTextWidget;
  final bool? showTopPadding;
  final bool? showCardPadding;
  final bool? showSaveBtn;
  final Function()? onTap;
  final bool? showBack;
  final Widget? image;

  void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor();
    return MyAppScaffold(
      // bottomSheet: showSaveBtn ?? false
      //     ? MyFillButton(
      //         buttonStyle: MyButtonStyle.primary,
      //         height: 45,
      //         text: AppStrings.save,
      //         onPressed: onTap,
      //       ).paddingSymmetric(horizontal: 20, vertical: 8)
      //     : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(right: 7, left: 7, top: 60),
                  child: Container(
                    //elevation: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7.r),
                        topRight: Radius.circular(7.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: showCardPadding ?? true ? 10 : 0,
                        right: showCardPadding ?? true ? 10 : 0,
                        top: showTopPadding ?? true
                            ? showDisplayPicture ?? true
                                ? 55
                                : 35
                            : 10,
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: showBack ?? false ? 10 : 20,
                left: 5,
                child: Visibility(
                  visible: showMenu ?? showBack ?? false,
                  child: showBack ?? false
                      ? IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: stdwhite,
                          ),
                        )
                      : popMenuWidget(context),
                  // InkWell(
                  //   onTap: () {
                  //     popMenuWidget(context);
                  //   },
                  //   child: const Icon(
                  //     Icons.menu,
                  //     size: 30,
                  //     color: Colors.white,
                  //   ),
                  // ),
                ),
              ),
              Positioned(
                top: 21,
                left: 45,
                child: Visibility(
                  visible: showText ?? false,
                  child: showTextWidget ?? Container(),
                ),
              ),
              Positioned(
                top: 20,
                right: 18,
                child: Visibility(
                  visible: showDisplayPicture ?? true,
                  child: Container(
                    height: 80,
                    width: 80,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: const [
                        BoxShadow(color: stdwhite, spreadRadius: 1.5),
                      ],
                    ),
                    child: image,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget popMenuWidget(context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        // popupmenu item 1
        const PopupMenuItem(
          value: 1,
          child: Center(
            child: MyText(
              WordStrings.profileLblHome,
              fontWeight: FontWeight.bold,
              fontFamily: FontFamilyConstant.sinkinSansMedium,
            ),
          ),
        ),
        // popupmenu item 2
        const PopupMenuItem(
          value: 2,
          // row has two child icon and text
          child: Center(
            child: MyText(
              WordStrings.bottomHome,
              fontWeight: FontWeight.bold,
              fontFamily: FontFamilyConstant.sinkinSansMedium,
            ),
          ),
        ),
      ],
      offset: const Offset(15, 20),
      elevation: 2,
      onSelected: (value) {
        Get.offAllNamed(AppRoutes.homeScreen);
        // if value 1 show dialog
      },
      child: const Icon(
        Icons.menu,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
