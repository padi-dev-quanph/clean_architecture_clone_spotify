import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/load_status.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/sign_in_type.dart';

class SignInState extends Equatable {
  final LoadStatus loadStatus;
  final String message;
  final SignInType signInType;

  const SignInState(
      {required this.loadStatus,
      required this.message,
      required this.signInType});

  @override
  List<Object?> get props => [loadStatus, message, signInType];

  factory SignInState.initial() {
    return const SignInState(
        loadStatus: LoadStatus.initial,
        message: '',
        signInType: SignInType.useEmailAndPassword);
  }

  // copyWith

  SignInState copyWith({
    LoadStatus? loadStatus,
    String? message,
    SignInType? signInType,
  }) {
    return SignInState(
        loadStatus: loadStatus ?? this.loadStatus,
        message: message ?? this.message,
        signInType: signInType ?? this.signInType);
  }
}
