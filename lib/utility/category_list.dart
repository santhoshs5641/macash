class Categories {
  static final List<String> incomeItems = [
    'Salary',
    'Bonus',
    'Investments',
    'Other Income',
  ];

  static final List<String> expenseItems = [
    'Food',
    'Rent',
    'Transportation',
    'Education',
    'Other Expenses',
  ];
  // Method to add a category to the specified list
  static void addCategory(String category, bool isIncome) {
    if (isIncome) {
      incomeItems.add(category);
    } else {
      expenseItems.add(category);
    }
  }
}
