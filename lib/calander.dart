import 'package:flutter/material.dart';

class Calander extends StatefulWidget {
  
  // User Parameters.
  final DateTime focusedDate;

  const Calander({
    super.key,
    required this.focusedDate
  });

  @override
  State<Calander> createState() => _CalanderState();
}

class _CalanderState extends State<Calander> {
  
  @override
  Widget build(BuildContext context) {
    
    // ScreenSize
    final Size size = MediaQuery.of(context).size;

    // Full Year Calander View.
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height*0.8,
        child: ListView.builder(
          itemCount: 12,
          itemBuilder: (context, index){
             // Month Wise Calander View;
             return Column(
                children: [
                    MonthlyCalView(focusedDate: widget.focusedDate, month: index),
                    const SizedBox(height: 50,)
                ]);
          }
        ),
      )
    );
  }
}

class MonthlyCalView extends StatelessWidget {
  const MonthlyCalView({
    super.key,
    required this.focusedDate,
    required this.month,
  });
    
  // final List<int> monthDayCount;
  final DateTime focusedDate;
  final int month;

  @override
  Widget build(BuildContext context) {
    
    int curYear = focusedDate.year;
    
    // Total days in a month
    List<int> monthDayCount; 
    if(curYear%400==0){
        monthDayCount = [31,29,31,30,31,30,31,31,30,31,30,31];
    }else if(curYear%4==0 && curYear%100!=0){
        monthDayCount = [31,29,31,30,31,30,31,31,30,31,30,31];
    }else{
        monthDayCount = [31,28,31,30,31,30,31,31,30,31,30,31];
    }

    // WeekDay Initials
    List<String> dayInitials = ["M", "T", "W", "T", "F", "S", "S"];
    
    // Month Descriptions 
    List<String> monthDesc = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    
    // Weekday for 1st of the month.
    var startDay = DateTime(curYear, month+1, 1).weekday;
    
    return Container(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(
                monthDesc[month] + " " + curYear.toString(),
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                )),
      
              Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(top: 20),
                height: 250,
                child: GridView.count(
                  crossAxisCount: 7,
                  childAspectRatio: 3.5/3,
                  children: List.generate(7 + startDay-1 + monthDayCount[month], (ind){
                      if(ind < 7){
                        return Text(dayInitials[ind]);
                      }else if(ind - 6 < startDay){
                        return const Text("");
                      }else{
                        String date = (ind - 5 - startDay).toString();
                        
                        if(date == focusedDate.day.toString() && (month+1) == focusedDate.month){
                           return Text(
                                date,
                                style: TextStyle(
                                    background: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..color = Colors.red
                                    ..strokeJoin = StrokeJoin.round
                                    ..strokeWidth = 18
                                ),
                            );
                        } else {
                          return Text(date);
                        }
                      }
                  })
                )  
              ),
        ],
      ),
    );
  }
}
