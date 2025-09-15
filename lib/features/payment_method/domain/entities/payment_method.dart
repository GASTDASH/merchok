// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  const PaymentMethod({
    required this.id,
    required this.name,
    required this.information,
    this.description,
    this.iconPath,
  });

  final String id;
  final String name;
  final String information;
  final String? description;
  final String? iconPath;

  @override
  List<Object?> get props {
    return [id, name, information, description, iconPath];
  }

  PaymentMethod copyWith({
    String? id,
    String? name,
    String? information,
    String? description,
    String? iconPath,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      information: information ?? this.information,
      description: description ?? this.description,
      iconPath: iconPath ?? this.iconPath,
    );
  }
}
