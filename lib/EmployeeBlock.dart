import 'dart:async';
import 'Employee.dart';


class EmployeeBloc {

  //sink to add in pipe
  //stream to get data from pipe
  //by pipe means data flow

  List<Employee> _employeeList = [
    Employee(1, 'employee1', 10300.2),
    Employee(2, 'employee2', 20040.0),
    Employee(3, 'employee3', 25000.1),
    Employee(4, 'employee4', 20600.0),
    Employee(5, 'employee5', 13000.0),
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();

  // for inc and dec
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();


  //getters
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

  //constructor
  EmployeeBloc(){
    this._employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  //logical components
  _incrementSalary(Employee employee){
      double salary = employee.salary;
      double incrementedSalary = salary * 20/100;

      _employeeList[employee.id-1].salary = salary + incrementedSalary;

      employeeListSink.add(_employeeList);
  }

  //logical components
  _decrementSalary(Employee employee){
    double salary = employee.salary;
    double decrementedSalary = salary * 20/100;

    _employeeList[employee.id-1].salary = salary - decrementedSalary;

    employeeListSink.add(_employeeList);
  }

  //dispose
  void dispose(){
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }


}
