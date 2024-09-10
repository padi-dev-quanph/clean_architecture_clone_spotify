import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  AuthCubitCubit() : super(AuthCubitInitial());
}
