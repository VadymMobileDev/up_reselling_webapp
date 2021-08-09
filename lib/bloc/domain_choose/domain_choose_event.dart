import 'package:equatable/equatable.dart';

abstract class DomainChooseEvent extends Equatable {
  const DomainChooseEvent();

  @override
  List<Object> get props => [];
}

class LoadDomains extends DomainChooseEvent {}
