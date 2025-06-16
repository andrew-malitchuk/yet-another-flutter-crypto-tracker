import 'package:equatable/equatable.dart';

class OperatorValue extends Equatable {
  final String icon;
  final String label;

  const OperatorValue({
    required this.icon,
    required this.label,
  });

  @override
  List<Object?> get props => [
        icon,
        label,
      ];
}
