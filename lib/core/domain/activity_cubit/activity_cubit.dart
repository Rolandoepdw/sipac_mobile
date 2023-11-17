import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipac_mobile_4/core/data/entities/activity.dart';
import 'package:sipac_mobile_4/core/data/repositories/activity_repository.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepository _activityRepository;

  ActivityCubit(this._activityRepository) : super(const ActivityInitial());

  Future<void> loadActivities() async {
    try {
      final activities = await _activityRepository.getAll();
      emit(ActivitiesLoaded(activities));
    } catch (e) {
      emit(ActivityError('Failed to load activities: $e'));
    }
  }

  Future<void> addActivity(Activity activity) async {
    try {
      await _activityRepository.insert(activity);
      emit(ActivityAdded(activity));
    } catch (e) {
      emit(ActivityError('Failed to add activity: $e'));
    }
  }

  Future<void> updateActivity(Activity activity) async {
    try {
      await _activityRepository.update(activity);
      emit(ActivityUpdated(activity));
    } catch (e) {
      emit(ActivityError('Failed to update activity: $e'));
    }
  }

  Future<void> deleteActivity(Activity activity) async {
    try {
      await _activityRepository.delete(activity);
      emit(ActivityDeleted(activity));
    } catch (e) {
      emit(ActivityError('Failed to delete activity: $e'));
    }
  }
}