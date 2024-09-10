import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/load_status.dart';
import 'package:flutter_clean_architecture_spotify/data/models/create_user_req.dart';
import 'package:flutter_clean_architecture_spotify/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState.initial());

  Future<void> signup(CreateUserReq req) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await sl<SignUpUsecase>().call(params: req);
    result.fold((error) {
      emit(state.copyWith(loadStatus: LoadStatus.failed, message: error));
    }, (response) {
      emit(state.copyWith(loadStatus: LoadStatus.success, message: response));
    });
  }
}
