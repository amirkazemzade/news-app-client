enum Category {
  sports,
  health,
  politics,
  economics,
  technology,
}

extension CategoryExtension on Category {
  int get id {
    final ids = {
      Category.sports: 0,
      Category.health: 1,
      Category.politics: 2,
      Category.economics: 3,
      Category.technology: 4,
    };
    return ids[this]!;
  }

  String get name {
    final names = {
      Category.sports: "Sports",
      Category.health: "Health",
      Category.politics: "Politics",
      Category.economics: "Economics",
      Category.technology: "Technology",
    };
    return names[this]!;
  }
}

Category categoryFromId(int id) {
  final categories = {
    0: Category.sports,
    1: Category.health,
    2: Category.politics,
    3: Category.economics,
    4: Category.technology,
  };
  return categories[id]!;
}
