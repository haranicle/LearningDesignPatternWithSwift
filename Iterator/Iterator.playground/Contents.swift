protocol Aggregate {
    func iterator() -> Iterator
}

protocol Iterator {
    func hasNext() -> Bool
    func next() -> AnyObject
}

enum Sex {
    case Male
    case Female
    
    
}

class Student {
    var name:String
    var sex:Sex
    
    init (name:String, sex:Sex) {
        self.name = name
        self.sex = sex
    }
}

class StudentList {
    var students:Array<Student> = []
    var last:Int = 0
    
    func add(student:Student) {
        self.students[last] = student
        last++
    }
    
    func getStudentAt(index:Int) -> Student {
        return students[index]
    }
}

class NewStudentList {
    var students:Array<Student> = []
    
    func add(student:Student) {
        students.append(student)
    }
    
    func getStudentAt(index:Int) -> Student {
        return students[index]
    }
}

class MyStudentList:NewStudentList, Aggregate {
    func iterator() -> Iterator {
        return MyStudentListIterator(list: self)
    }
}

class MyStudentListIterator:Iterator {
    var myStudentList:MyStudentList
    var index:Int
    
    init(list:MyStudentList) {
        myStudentList = list
        index = 0
    }
    
    func hasNext() -> Bool {
        return myStudentList.students.count > index
    }
    
    func next() -> AnyObject {
        return myStudentList.getStudentAt(index++)
    }
}

protocol Teacher {
    // var studentList:AnyObject {get set}
    func createStudentList()
    func callStudents()
}

class MyTeacher:Teacher {
    var studentList:MyStudentList = MyStudentList()
    
    func createStudentList() {
        studentList.add(Student(name: "Adam", sex: .Male))
        studentList.add(Student(name: "Brenda", sex: .Female))
        studentList.add(Student(name: "Chad", sex: .Male))
        studentList.add(Student(name: "Deanna", sex: .Female))
    }
    
    func callStudents() {
        let itr = studentList.iterator()
        while itr.hasNext() {
            let student = itr.next() as! Student
            print("name:\(student.name) sex:\(student.sex)")
        }
    }
}

let you = MyTeacher()
you.createStudentList()
you.callStudents()

