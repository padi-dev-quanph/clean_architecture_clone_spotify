part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final LoadStatus loadStatus;
  final String message;

  const SignUpState({
    required this.loadStatus,
    required this.message,
  });

  @override
  List<Object?> get props => [loadStatus, message];

  factory SignUpState.initial() {
    return const SignUpState(
      loadStatus: LoadStatus.initial,
      message: '',
    );
  }

  // copyWith

  SignUpState copyWith({
    LoadStatus? loadStatus,
    String? message,
  }) {
    return SignUpState(
      loadStatus: loadStatus ?? this.loadStatus,
      message: message ?? this.message,
    );
  }
}
