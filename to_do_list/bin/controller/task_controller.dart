import 'dart:io';
import 'package:intl/intl.dart';
import 'package:colorize/colorize.dart';
import '../model/task.dart';

class TaskListController {
  List<Task> taskList = [];
  List<Task> taskRemovedList = [];
  DateTime? _listDateTime;
  String? date;
  String? updateDateVar;

  int showUpdateListAndReturnChoice() {
    print('\n');
    color(
      '********' * 5,
      front: Styles.BG_RED,
      isBold: true,
    );
    color('*              UPDATE-LIST              *',
        front: Styles.BG_RED, isBold: true);
    color('********' * 5, front: Styles.BG_RED, isBold: true);
    color('* 1- Update name                        *',
        front: Styles.BG_RED, isBold: true);
    color('* 2- Update description                 *',
        front: Styles.BG_RED, isBold: true);
    color('* 3- Update date                        *',
        front: Styles.BG_RED, isBold: true);
    color('* 4- Update start time                  *',
        front: Styles.BG_RED, isBold: true);
    color('* 5- Update end time                    *',
        front: Styles.BG_RED, isBold: true);
    print('\n');
    color('Enter your choice :                    *',
        front: Styles.LIGHT_GREEN, isBold: true, isReverse: true);
    int choice = int.parse(stdin.readLineSync()!);
    return choice;
  }

  int showListAndReturnChoice() {
    print('\n');
    color(
      '********' * 5,
      front: Styles.BG_RED,
      isBold: true,
    );
    color('*              TO-DO-LIST              *',
        front: Styles.BG_RED, isBold: true);
    color('********' * 5, front: Styles.BG_RED, isBold: true);
    color('* 1- My task                           *',
        front: Styles.BG_RED, isBold: true);
    color('* 2- Add task                          *',
        front: Styles.BG_RED, isBold: true);
    color('* 3- Task completion - Done            *',
        front: Styles.BG_RED, isBold: true);
    color('* 4- Remove task                       *',
        front: Styles.BG_RED, isBold: true);
    color('* 5- Update task                       *',
        front: Styles.BG_RED, isBold: true);
    print('\n');
    color('Enter your choice :                    *',
        front: Styles.LIGHT_GREEN, isBold: true, isReverse: true);
    int choice = int.parse(stdin.readLineSync()!);
    return choice;
  }

  void addTask() {
    Task task = Task();
    bool isDoneFlag = false;
    try {
      color('Enter the data for task  :        *',
          front: Styles.BG_LIGHT_GREEN, isBold: true);
      color('Enter Task name :                 *',
          front: Styles.BG_LIGHT_GREEN, isBold: true);
      task.name = stdin.readLineSync()!;
      color('Enter Task description :          *',
          front: Styles.BG_LIGHT_GREEN, isBold: true);
      task.description = stdin.readLineSync()!;
      color('is the task done :                *',
          front: Styles.BG_LIGHT_GREEN, isBold: true);
      color('''
1- Yes.
2- No.
''', front: Styles.BG_LIGHT_GREEN, isBold: true);

      color('Enter you choice :               *',
          front: Styles.BG_LIGHT_GREEN, isBold: true);
      int choice = int.parse(stdin.readLineSync()!);
      do {
        switch (choice) {
          case 1:
            task.isDone = true;
            break;
          case 2:
            task.isDone = false;
            break;
          default:
            {
              color('this choice not found,... try again       ',
                  front: Styles.BG_BLUE, isBold: true);
              isDoneFlag = true;
            }
        }
      } while (isDoneFlag);

      if (_listDateTime == null) {
        color('Enter the date (dd/MM/yyyy):    *',
            front: Styles.LIGHT_GREEN, isBold: true, isReverse: true);
        date = stdin.readLineSync()!;
        updateDateVar = date; //check
        DateFormat dateFormat = DateFormat('dd/MM/yyyy');
        DateTime dateTime = dateFormat.parse(date!);
        _listDateTime = dateTime;
      }
      color('Enter Start Time (h:mm a):      *',
          front: Styles.LIGHT_GREEN, isBold: true, isReverse: true);
      String from = stdin.readLineSync()!;
      from = '$date $from';
      DateFormat dateFromFormat = DateFormat('dd/MM/yyyy HH:mm a');
      DateTime dateTimeFrom = dateFromFormat.parse(from);
      task.dateFrom = dateTimeFrom;

      color('Enter End Time (h:mm a):        *',
          front: Styles.LIGHT_GREEN, isBold: true, isReverse: true);
      String end = stdin.readLineSync()!;
      end = '$date $end';
      DateFormat dateToFormat = DateFormat('dd/MM/yyyy HH:mm');
      DateTime dateTimeEnd = dateToFormat.parse(end);
      task.dateTo = dateTimeEnd;

      taskList.add(task);
    } catch (e) {
      Task.count--;
      color('something is wrong  ', front: Styles.BG_BLUE, isBold: true);
    }
  }

  int chooseTask() {
    showData();
    color('choose the number of task : :                    *',
        front: Styles.LIGHT_GREEN, isBold: true, isReverse: true);
    return int.parse(stdin.readLineSync()!);
  }

  void showData() {
    try {
      color('*      $_listDateTime          *', front: Styles.BG_YELLOW);
      for (int i = 0; i < taskList.length; i++) {
        color('*                                       *',
            front: Styles.BG_YELLOW);
        color('''Task # ${taskList[i].number} is :
      Name : ${taskList[i].name} ,      
      Description : ${taskList[i].description}
      Date : ${_listDateTime}
      Start Time : ${taskList[i].dateFrom.hour}:${taskList[i].dateFrom.second}
      End Time : ${taskList[i].dateTo.hour}:${taskList[i].dateTo.second}
      Is Done : ${taskList[i].isDone}''',
            front: Styles.RED, isBold: true, isItalic: true, isReverse: true);
        color('*                                       *',
            front: Styles.BG_YELLOW);
        print('\n');
      }
    } catch (e) {
      color('something is wrong  ', front: Styles.BG_BLUE, isBold: true);
    }
  }

  void myTask() {
    try {
      if (taskList.isEmpty) {
        color('this list is empty, no task to show',
            front: Styles.BG_BLUE, isBold: true);
      } else {
        showData();
      }
    } catch (e) {
      color('something is wrong  ', front: Styles.BG_BLUE, isBold: true);
    }
  }

  void removeTask() {
    try {
      showData();
      color('Enter the task number you want to remove : ',
          front: Styles.BG_LIGHT_GREEN, isBold: true);
      int taskNumber = int.parse(stdin.readLineSync()!);
      for (var task in List.from(taskList)) {
        if (task.number == taskNumber) {
          taskList.remove(task);
          color('Remove Success', front: Styles.BG_BLUE, isBold: true);
        }
      }
    } catch (e) {
      color('something is wrong  ', front: Styles.BG_BLUE, isBold: true);
    }
  }

  bool isDoneSwitch(Task task) {
    if (task.isDone == false) {
      return true;
    } else {
      return false;
    }
  }

  void updateDesc(int number) {
    try {
      color('Enter new description  ',
          front: Styles.BG_LIGHT_GREEN, isBold: true);

      String desc = stdin.readLineSync()!;
      taskList.forEach((element) {
        if (element.number == number) {
          element.description = desc;
        }
      });
    } catch (e) {
      color('something is wrong  ', front: Styles.BG_BLUE, isBold: true);
    }
  }

  void updateName(int number) {
    try {
      color('Enter new name  ', front: Styles.BG_LIGHT_GREEN, isBold: true);
      String name = stdin.readLineSync()!;
      taskList.forEach((element) {
        if (element.number == number) {
          element.name = name;
        }
      });
    } catch (e) {
      color('something is wrong  ', front: Styles.BG_BLUE, isBold: true);
    }
  }

  void updateDate() {
    try {
      color('Enter new date (dd/MM/yyyy):    *',
          front: Styles.LIGHT_GREEN, isBold: true, isReverse: true);
      updateDateVar = stdin.readLineSync()!;
      date = updateDateVar;
      DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      DateTime dateTime = dateFormat.parse(updateDateVar!);
      _listDateTime = dateTime;
      taskList.forEach((element) {
        element.dateFrom = element.dateFrom.copyWith(
            year: dateTime.year, day: dateTime.day, month: dateTime.month);
        element.dateTo = element.dateTo.copyWith(
            year: dateTime.year, day: dateTime.day, month: dateTime.month);
      });
    } catch (e) {
      color('something is wrong  ', front: Styles.BG_BLUE, isBold: true);
    }
  }

  void updateStartTime(int number) {
    try {
      color('Enter Start Time (h:mm a):    *',
          front: Styles.LIGHT_GREEN, isBold: true, isReverse: true);
      String from = stdin.readLineSync()!;
      from = '$updateDateVar $from';
      DateFormat dateFromFormat = DateFormat('dd/MM/yyyy HH:mm a');
      DateTime dateTimeFrom = dateFromFormat.parse(from);
      taskList.forEach((element) {
        if (element.number == number) {
          element.dateFrom = dateTimeFrom;
        }
      });
    } catch (e) {
      color('something is wrong  ', front: Styles.BG_BLUE, isBold: true);
    }
  }

  void endDate(int number) {
    try {
      color('Enter End Time (h:mm a):        *',
          front: Styles.LIGHT_GREEN, isBold: true, isReverse: true);
      String end = stdin.readLineSync()!;
      end = '$updateDateVar $end';
      DateFormat dateToFormat = DateFormat('dd/MM/yyyy HH:mm');
      DateTime dateTimeEnd = dateToFormat.parse(end);
      taskList.forEach((element) {
        if (element.number == number) {
          element.dateTo = dateTimeEnd;
        }
      });
    } catch (e) {
      color('something is wrong  ', front: Styles.BG_BLUE, isBold: true);
    }
  }

  void writeToFile() async {
    String fileContent = '';

    for (var i = 0; i < taskList.length; i++) {
      fileContent += ''' ** TASK ${taskList[i].number} **
      Name : ${taskList[i].name},
      Description : ${taskList[i].description},
      Date : ${_listDateTime},
      Start Time : ${taskList[i].dateFrom},
      End Time : ${taskList[i].dateTo},
      Is Done : ${taskList[i].isDone},
''';
      print('\n');
    }
    var file = await File('task.txt')
        .writeAsString(mode: FileMode.write, fileContent)
        .then((value) => print('Success'))
        .catchError((e) {
      print(e);
    });
  }

  void endScreen() {
    color(
      '*****************************************',
      front: Styles.BG_BLUE,
      isBold: true,
    );
    color(
      '*     Your data saved on task.txt file   *',
      front: Styles.BG_BLUE,
      isBold: true,
    );
    color(
      '*****************************************',
      front: Styles.BG_BLUE,
      isBold: true,
    );
  }
}
