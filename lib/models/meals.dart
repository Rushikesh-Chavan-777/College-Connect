class Meals {
  const Meals(
      {required this.day,
      required this.breakfast,
      required this.breakfastExtras,
      required this.lunch,
      required this.lunchExtras,
      required this.snacks,
      required this.snacksExtras,
      required this.dinner,
      required this.dinnerExtras});
  final String day;
  final List<String> breakfast;
  final List<String> breakfastExtras;
  final List<String> lunch;
  final List<String> lunchExtras;
  final List<String> snacks;
  final List<String> snacksExtras;
  final List<String> dinner;
  final List<String> dinnerExtras;
}
