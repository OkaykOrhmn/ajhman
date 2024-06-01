part of 'comments_bloc.dart';

@immutable
class CommentsState extends Equatable {
  final StateStatus status;
  final String type;
  final dynamic data;

  const CommentsState({this.status = StateStatus.loading, this.type = '', this.data});

  CommentsState copyWith(
      {required StateStatus status,required String type, dynamic data}) {
    return CommentsState(status: status , type: type, data: data ?? this.data);
  }

  @override
  List<Object> get props => [status, type];
}
