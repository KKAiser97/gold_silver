import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_silver/src/utils/router/app_router.dart';
import 'package:gold_silver/src/utils/extensions/exts.dart';
import 'package:gold_silver/src/utils/widgets/app_widgets.dart';

class AppDialog {
  static const AppDialog _instance = AppDialog._();

  factory AppDialog() => _instance;

  const AppDialog._();

  Future<T?>? show<T>({
    BuildContext? context,
    DialogConfiguration? config,
    bool showClose = false,
    Widget? dialog,
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    TraversalEdgeBehavior? traversalEdgeBehavior,
  }) {
    assert(config == null || dialog == null);
    assert(AppRouter.context != null);
    try {
      return showDialog(
        context: context ?? AppRouter.context!,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        useSafeArea: useSafeArea,
        routeSettings: routeSettings,
        anchorPoint: anchorPoint,
        traversalEdgeBehavior: traversalEdgeBehavior,
        builder: (c) => PopScope(
          canPop: barrierDismissible,
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.hardEdge,
            insetPadding: const EdgeInsets.symmetric(horizontal: 28),
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: dialog ?? (config == null ? const SizedBox() : _buildDialog(c, config)),
                  ),
                  if (showClose) _closeButton(c, config),
                ],
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Widget _closeButton(BuildContext context, DialogConfiguration? config) {
    return Positioned(
      top: 4,
      right: 4,
      child: IconButton(
        onPressed: () {
          config?.closeDialog == null ? Navigator.of(context).pop() : config?.closeDialog?.call();
        },
        icon: SvgPicture.asset(
          'assets/svgs/ic_close.svg',
          width: 16,
          height: 16,
        ),
      ),
    );
  }

  Widget _buildDialog(BuildContext context, DialogConfiguration config) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (config.showImage == true)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: config.image ?? const SizedBox(),
          ),
        Text(
          config.title ?? "'thong_bao'.i18n()",
          style: config.titleStyle ??
              const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 28,
              ),
        ),
        if (config.contentString.isNotEmptyOrNull)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Align(
              alignment: config.contentAlignment,
              child: Text(
                config.contentString ?? '',
                style: const TextStyle(fontSize: 16, height: 24),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        if (config.contentWidget != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Align(alignment: config.contentAlignment, child: config.contentWidget),
          ),
        config.comboButton ??
            ComboButton(
              padding: const EdgeInsets.only(top: 20),
              buttons: [
                if (config.cancel.isNotEmptyOrNull || config.onCancel != null)
                  MyButton.white(
                    title: config.cancel ?? "'bo_qua'.i18n()",
                    onTap: () {
                      config.closeDialog == null ? Navigator.of(context).pop() : config.closeDialog?.call();
                      config.onCancel?.call();
                    },
                  ),
                if (config.ok.isNotEmptyOrNull || config.onOk != null)
                  MyButton(
                    title: config.ok ?? "'xac_nhan'.i18n()",
                    onTap: () {
                      config.closeDialog == null ? Navigator.of(context).pop() : config.closeDialog?.call();
                      config.onOk?.call();
                    },
                  ),
              ],
            )
      ],
    );
  }
}

class DialogConfiguration {
  final String? ok;
  final String? cancel;
  final VoidCallback? onOk;
  final VoidCallback? onCancel;
  final ComboButton? comboButton;
  final Widget? image;
  final bool showImage;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? contentWidget;
  final String? contentString;
  final VoidCallback? closeDialog;
  final AlignmentGeometry contentAlignment;

  const DialogConfiguration({
    this.ok,
    this.cancel,
    this.onOk,
    this.onCancel,
    this.comboButton,
    this.image,
    this.showImage = true,
    this.title,
    this.titleStyle,
    this.contentString,
    this.contentWidget,
    this.closeDialog,
    this.contentAlignment = Alignment.centerLeft,
  })  : assert(contentWidget == null || contentString == null),
        assert(comboButton == null || (ok == null && cancel == null && onOk == null && onCancel == null));

  DialogConfiguration copyWith({
    String? ok,
    String? cancel,
    VoidCallback? onOk,
    VoidCallback? onCancel,
    ComboButton? comboButton,
    Widget? image,
    bool? showImage,
    String? title,
    TextStyle? titleStyle,
    Widget? contentWidget,
    String? contentString,
    VoidCallback? closeDialog,
    AlignmentGeometry? contentAlignment,
  }) {
    return DialogConfiguration(
      ok: ok ?? this.ok,
      cancel: cancel ?? this.cancel,
      onOk: onOk ?? this.onOk,
      onCancel: onCancel ?? this.onCancel,
      comboButton: comboButton ?? this.comboButton,
      image: image ?? this.image,
      showImage: showImage ?? this.showImage,
      title: title ?? this.title,
      titleStyle: titleStyle ?? this.titleStyle,
      contentWidget: contentWidget ?? this.contentWidget,
      contentString: contentString ?? this.contentString,
      closeDialog: closeDialog ?? this.closeDialog,
      contentAlignment: contentAlignment ?? this.contentAlignment,
    );
  }
}
