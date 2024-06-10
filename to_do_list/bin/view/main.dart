import 'dart:io';
import 'package:colorize/colorize.dart';
import '../controller/task_controller.dart';

bool isContinue(String str) {
  color(str, front: Styles.LIGHT_GREEN, isBold: true, isReverse: true);
  int ch = int.parse(stdin.readLineSync()!);
  switch (ch) {
    case 1:
      return false;
    case 2:
      return true;
    default:
      return false;
  }
}

void main(List<String> args) {
  TaskListController taskListObj = TaskListController();
  bool finsh = true;
  bool updateFinsh;
  while (finsh) {
    updateFinsh = true;
    switch (taskListObj.showListAndReturnChoice()) {
      case 1:
        taskListObj.myTask();
        if (isContinue(
            '''Do you want to choose another option or exit from TO-DO-LIST,
                  1- Exit from TO-DO-LIST.
                  2- Continue.''')) {
          continue;
        } else {
          taskListObj.writeToFile();
          taskListObj.endScreen();
          finsh = false;
        }
        break;
      case 2:
        taskListObj.addTask();
        if (isContinue(
            '''Do you want to choose another option or exit from TO-DO-LIST,
                  1- Exit from TO-DO-LIST.
                  2- Continue.''')) {
          continue;
        } else {
          taskListObj.writeToFile();
          taskListObj.endScreen();
          finsh = false;
        }
        break;
      case 3:
        if (taskListObj.taskList.isEmpty) {
          color('No tasks to switch ', front: Styles.BG_RED, isBold: true);
          if (isContinue(
              '''Do you want to choose another option or exit from TO-DO-LIST,
                  1- Exit from TO-DO-LIST.
                  2- Continue.''')) {
            continue;
          } else {
            taskListObj.writeToFile();
            taskListObj.endScreen();
            finsh = false;
          }
        } else {
          int index = taskListObj.chooseTask();
          bool isDone =
              taskListObj.isDoneSwitch(taskListObj.taskList[index - 1]);
          taskListObj.taskList[index - 1].isDone = isDone;
          if (isDone) {
            color('this task is done...', front: Styles.BG_BLUE, isBold: true);
          }
          if (isContinue(
              '''Do you want to choose another option or exit from TO-DO-LIST,
                  1- Exit from TO-DO-LIST.
                  2- Continue.''')) {
            continue;
          } else {
            taskListObj.writeToFile();
            taskListObj.endScreen();
            finsh = false;
          }
        }

        break;
      case 4:
        taskListObj.removeTask();
        if (isContinue(
            '''Do you want to choose another option or exit from TO-DO-LIST,
                       1- Exit from TO-DO-LIST.
                       2- Continue.''')) {
          continue;
        } else {
          taskListObj.writeToFile();
          taskListObj.endScreen();
          finsh = false;
        }
        break;
      case 5:
        if (taskListObj.taskList.isEmpty) {
          color(
            'No tasks to update.             ',
            front: Styles.BG_RED,
            isBold: true,
          );
        } else {      int taskNumber = taskListObj.chooseTask();
        while (updateFinsh) {
          switch (taskListObj.showUpdateListAndReturnChoice()) {
            case 1:
              taskListObj.updateName(taskNumber);
              if (isContinue(
                  '''Do you want to update another data or exit from UPDATE-LIST,
                        1- Exit from UPDATE-LIST.
                        2- Continue.
                  ''')) {
                continue;
              } else {
                updateFinsh = false;
              }
              break;
            case 2:
              taskListObj.updateDesc(taskNumber);
              if (isContinue(
                  '''Do you want to update another data or exit from UPDATE-LIST,
                        1- Exit from UPDATE-LIST.
                        2- Continue.
                  ''')) {
                continue;
              } else {
                updateFinsh = false;
              }
              break;
            case 3:
              taskListObj.updateDate();
              if (isContinue(
                  '''Do you want to update another data or exit from UPDATE-LIST,
                        1- Exit from UPDATE-LIST.
                        2- Continue.
                  ''')) {
                continue;
              } else {
                updateFinsh = false;
              }
              break;
            case 4:
              taskListObj.updateStartTime(taskNumber);
              if (isContinue(
                  '''Do you want to update another data or exit from UPDATE-LIST,
                        1- Exit from UPDATE-LIST.
                        2- Continue.
                  ''')) {
                continue;
              } else {
                updateFinsh = false;
              }
              break;
            case 5:
              taskListObj.endDate(taskNumber);
              if (isContinue(
                  '''Do you want to update another data or exit from UPDATE-LIST,
                        1- Exit from UPDATE-LIST.
                        2- Continue.
                  ''')) {
                continue;
              } else {
                updateFinsh = false;
              }
              break;
            default:
              color(
                'This option was not found,choose correct number...             ',
                front: Styles.BG_RED,
                isBold: true,
              );
          }
        }}
  
        if (isContinue(
            '''Do you want to choose another option or exit from TO-DO-LIST,
                  1- Exit from TO-DO-LIST.
                  2- Continue.''')) {
          continue;
        } else {
          taskListObj.writeToFile();
          taskListObj.endScreen();
          finsh = false;
        }
        break;

      default:
        color(
          'This option was not found...Try again.            ',
          front: Styles.BG_RED,
          isBold: true,
        );
    }
  }
}
