abstract class MedStates {}

class MedInitialState extends MedStates {}

class ChangePasswordBehavior extends MedStates {}

class ChangeAuthBehavior extends MedStates {}

class LoginLoading extends MedStates {}

class LoginError extends MedStates {
  final String error;
  LoginError(this.error);
}

class LoginDone extends MedStates {
  final String uId;
  LoginDone(this.uId);
}

class CreateUserLoading extends MedStates {}

class CreateUserDone extends MedStates {
  final String uid;
  CreateUserDone(this.uid);
}

class SignupDoneState extends MedStates {
  final String uId;
  SignupDoneState(this.uId);
}

class CreateUserError extends MedStates {
  final String error;
  CreateUserError(this.error);
}

class GetUserLoading extends MedStates {}

class GetUserError extends MedStates {
  final String error;
  GetUserError(this.error);
}

class GetUserDone extends MedStates {}

class SignUpLoading extends MedStates {}

class SignUpError extends MedStates {
  final String error;
  SignUpError(this.error);
}

class GetParkerPosition extends MedStates {}

class CalculatedDistance extends MedStates {}

class ChangeBottomBar extends MedStates {}

class SignOutDone extends MedStates {}

class SignOutError extends MedStates {
  final String error;
  SignOutError(this.error);
}

class ChoosedDateTime extends MedStates {}

class InternetConenctionChanged extends MedStates {}

class GetAllPhoneNosLoadingState extends MedStates {}

class GetAllPhoneNosErrorState extends MedStates {
  final String error;
  GetAllPhoneNosErrorState(this.error);
}

class GetAllPhoneNosDone extends MedStates {}

class SendRecoveryLinkDone extends MedStates {}

class SendRecoveryLinkLoading extends MedStates {}

class SendRecoveryLinkError extends MedStates {
  final String error;
  SendRecoveryLinkError(this.error);
}

class AddMedDone extends MedStates {}

class AddMedLoading extends MedStates {}

class AddMedError extends MedStates {
  final String error;
  AddMedError(this.error);
}

class GetMedDone extends MedStates {}

class FoundMedicine extends MedStates {}

class ChangedPageViewIndex extends MedStates {}

class SetTakeTime extends MedStates {}

class AddReminderDone extends MedStates {}

class AddReminderError extends MedStates {
  final String error;
  AddReminderError(this.error);
}

class AddReminderLoading extends MedStates {}

class AddIntakesDone extends MedStates {}

class IntakeTimeSetDone extends MedStates {}

class RemovedIntakeDone extends MedStates {}
