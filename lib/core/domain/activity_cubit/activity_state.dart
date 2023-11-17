part of 'activity_cubit.dart';

@immutable
abstract class ActivityState {
  const ActivityState();
}

class ActivityInitial extends ActivityState {
  const ActivityInitial();
}

class ActivitiesLoaded extends ActivityState {
  final List<Activity> activities;

  const ActivitiesLoaded(this.activities);
}

class ActivityAdded extends ActivityState {
  final Activity activity;

  const ActivityAdded(this.activity);
}

class ActivityUpdated extends ActivityState {
  final Activity activity;

  const ActivityUpdated(this.activity);
}

class ActivityDeleted extends ActivityState {
  final Activity activity;

  const ActivityDeleted(this.activity);
}

class ActivityError extends ActivityState {
  final String message;

  const ActivityError(this.message);
}
