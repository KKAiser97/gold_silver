import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class NewsEvent extends Equatable {
  final BuildContext context;

  const NewsEvent(this.context);

  @override
  List<Object?> get props => [context];
}
