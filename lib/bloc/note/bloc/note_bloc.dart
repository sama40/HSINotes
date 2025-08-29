import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_notes/enum/status_enum.dart';
import 'package:light_notes/model/note_model.dart';
import 'package:light_notes/service/note/note_service.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc(this.service) : super(NoteState.initial()) {
    on<NoteEvent>((event, emit) async {
      final notes = await service.notes();

      emit(state.copyWith(notes: notes, status: StatusEnum.initial));
    });

    on<CreateNoteEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusEnum.loading));

        await service.create(content: event.content, title: event.title);

        emit(state.copyWith(status: StatusEnum.success));

        add(GetNoteEvent());
      } on Exception catch (e) {
        emit(state.copyWith(status: StatusEnum.failure, error: e));
      }
    });

    on<UpdateNoteEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusEnum.loading));

        await service.update(
          id: event.id,
          content: event.content,
          title: event.title,
        );

        emit(state.copyWith(status: StatusEnum.success));

        add(GetNoteEvent());
      } on Exception catch (e) {
        emit(state.copyWith(status: StatusEnum.failure, error: e));
      }
    });

    on<DeleteNoteEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusEnum.loading));

        await service.delete(event.id);

        emit(state.copyWith(status: StatusEnum.success));

        add(GetNoteEvent());
      } on Exception catch (e) {
        emit(state.copyWith(status: StatusEnum.failure, error: e));
      }
    });
  }

  final NoteService service;
}
