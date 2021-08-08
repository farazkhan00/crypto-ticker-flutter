
  List<int> winningNumbers = [12, 6, 34, 22, 41, 9];

  void main() {

    List<int> ticket1 = [45, 2, 9, 18, 12, 33];
    List<int> ticket2 = [41, 17, 26, 32, 7, 35];

    checkNumbers(ticket1);

  }

  void checkNumbers(List<int> ticket){
    int i = 0;
    int matchingNumbers;
    for(i in winningNumbers){
      if(ticket[i] == winningNumbers[i]){
        matchingNumbers++;
      }
      print('$matchingNumbers found');
    }

  }
