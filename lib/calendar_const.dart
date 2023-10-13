List<String> giorniSettimanaAbbreviati = ['Lun', 'Mar', 'Mer', 'Gio', 'Ven', 'Sab', 'Dom'];

List<String> nomeMesi = ['Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno', 'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'];

int getDaysInMonth(DateTime dateTime) {
  if (dateTime.month == DateTime.february) {
    final bool isLeapYear = (dateTime.year % 4 == 0) && (dateTime.year % 100 != 0) || (dateTime.year % 400 == 0);
    return isLeapYear ? 29 : 28;
  }
  const List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  return daysInMonth[dateTime.month - 1];
}
