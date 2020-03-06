import oracle.jdbc.*;
import java.math.*;
import java.io.*;
import java.awt.*;
import java.util.*;
import oracle.jdbc.pool.OracleDataSource;
import java.util.Scanner;
import java.sql.Types;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class mydemo3 {

  public static void main(String args[]) throws SQLException {
    try {

      int user_choice;
      boolean flag = true;

      OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
      ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:acad111");
      Connection conn = ds.getConnection("username", "password");

      while (flag) {
        Scanner input = new Scanner(System.in);
        System.out.println("***************************************************************");
        System.out.println(
            "\n 1. Print table data \n 2. TA Information \n 3. Prerequisite information \n 4. Student Enrollment \n 5. Drop Student \n 6. Delete Student \n 7. Exit \n\n Enter your choice.");
        user_choice = Integer.parseInt(input.nextLine());
        System.out.println("***************************************************************");

        switch (user_choice) {
        case 1:
          print_tables(conn);
          break;

        case 2:
          TA_info(conn);
          break;

        case 3:
          prerequisites(conn);
          break;

        case 4:
          enrollments(conn);
          break;

        case 5:
          drop_students(conn);
          break;

        case 6:
          delete_students(conn);
          break;

        case 7:
          flag = false;
          System.exit(1);
        }
      }
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }
  }

  public static void select_tables(Connection conn) {
    int table_choice;

    Scanner input = new Scanner(System.in);
    System.out.println("\n\t 1. Students \n\t 2. Teaching Assistants \n\t 3. Courses \n\t 4. Classes \n\t 5. Enrollments \n\t 6. Prerequisites \n\t 7. Logs \n\t 8. Exit \n\n\t Enter your choice.");
    table_choice = Integer.parseInt(input.nextLine());

    switch (table_choice) {
    case 1:
      show_students(conn);
      break;
    case 2:
      show_tas(conn);
      break;
    case 3:
      show_courses(conn);
      break;
    case 4:
      show_classes(conn);
      break;
    case 5:
      show_enrollments(conn);
      break;
    case 6:
      show_prerequisites(conn);
      break;
    case 7:
      show_logs(conn);
      break;
    case 8:
      System.exit(1);
    }
  }

  public static void show_logs(Connection conn) {
    try {
      CallableStatement cs = conn.prepareCall("begin database.show_logs(?); END;");
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.execute();
      ResultSet rs = ((OracleCallableStatement) cs).getCursor(1);
      System.out.println("Log# \t Op_Name \t Op_Time \t Table_Name \t Operation \t Key_Value");
      while (rs.next()) {
        System.out.print(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t" + rs.getString(4) + "\t" + rs.getString(5) + rs.getString(6) + "\n");
      }
      rs.close();
      cs.close();
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }
  }

  public static void show_students(Connection conn) {
    try {
      CallableStatement cs = conn.prepareCall("begin database.show_students(?); END;");
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.execute();
      ResultSet rs = ((OracleCallableStatement) cs).getCursor(1);
      System.out.println("***************** STUDENTS ******************");
      System.out.println("B# \t FirstName \t Last Name \t Status \t GPA \t Email \t Birthdate \t Dept");
      while (rs.next()) {
        System.out.print(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t"
            + rs.getString(4) + "\t" + rs.getString(5) + "\n");
      }
      rs.close();
      cs.close();
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }
  }

  public static void show_tas(Connection conn) {
    try {
      CallableStatement cs = conn.prepareCall("begin database.show_tas(?); END;");
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.execute();
      ResultSet rs = ((OracleCallableStatement) cs).getCursor(1);
      System.out.println("***************** Teaching Assistants ******************");
      System.out.println("B# \t TA \t Office");
      while (rs.next()) {
        System.out.print(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\n");
      }
      rs.close();
      cs.close();
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }
  }

  public static void show_courses(Connection conn) {
    try {
      CallableStatement cs = conn.prepareCall("begin database.show_courses(?); END;");
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.execute();
      ResultSet rs = ((OracleCallableStatement) cs).getCursor(1);
      System.out.println("***************** Courses ******************");
      System.out.println("Dept \t Course \t Title");
      while (rs.next()) {
        System.out.print(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\n");
      }
      rs.close();
      cs.close();
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }
  }

  public static void show_classes(Connection conn) {
    try {
      CallableStatement cs = conn.prepareCall("begin database.show_classes(?); END;");
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.execute();
      ResultSet rs = ((OracleCallableStatement) cs).getCursor(1);
      System.out.println("***************** Classes ******************");
      System.out.println(
          "Class \t Dept \t Course# \t Section \t Year \t Semester \t Limit \t Class Size \t Room \t TA_B");
      while (rs.next()) {
        System.out.print(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t"
            + rs.getString(4) + "\t" + rs.getString(5) + "\t" + rs.getString(6) + "\t" + rs.getString(7)
            + "\t" + rs.getString(8) + "\t" + rs.getString(9) + "\t" + rs.getString(10) + "\n");
      }
      rs.close();
      cs.close();
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }
  }

  public static void show_prerequisites(Connection conn) {
    try {
      CallableStatement cs = conn.prepareCall("begin database.show_prerequisites(?); END;");
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.execute();
      ResultSet rs = ((OracleCallableStatement) cs).getCursor(1);
      System.out.println("***************** Prerequisites ******************");
      System.out.println(
          "Dept \t Course# \t Pre_ \t Pre_Course#");
      while (rs.next()) {
        System.out.print(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t" + rs.getString(4) + "\n");
      }
      rs.close();
      cs.close();
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }
  }

  public static void show_enrollments(Connection conn) {
    try {
      CallableStatement cs = conn.prepareCall("begin database.show_enrollments(?); END;");
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.execute();
      ResultSet rs = ((OracleCallableStatement) cs).getCursor(1);
      System.out.println("***************** Enrollments ******************");
      System.out.println("B# \t Class \t LG");
      while (rs.next()) {
        System.out.print(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\n");
      }

      rs.close();
      cs.close();
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }
  }

  public static void print_tables(Connection conn) {
    select_tables(conn);
  }

  public static void TA_info(Connection conn) {
    try {

      Scanner input = new Scanner(System.in);
      System.out.println("\n Enter class id: ");
      String cid = input.nextLine();

      CallableStatement cs = conn.prepareCall("begin database.student_tas(?,?); END;");
      cs.setString(1, cid);
    //  cs.registerOutParameter(2, Types.VARCHAR);
      cs.registerOutParameter(2, OracleTypes.CURSOR);
      cs.execute();

    /*  String result = cs.getString(2);
      if (result != null) {
        System.out.println(result);
      }*/

      ResultSet rs = null;
      rs = ((OracleCallableStatement)cs).getCursor(2);
      while (rs.next()) 
      {
        System.out.print(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\n");
      }
      rs.close();
      cs.close();
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }
  }

  public static void prerequisites(Connection conn) {

    try {
      Scanner input = new Scanner(System.in);
      System.out.println("\n Enter department code: ");
      String deptcode = input.nextLine();
      System.out.println("\n Enter course number: ");
      String course_num = input.nextLine();

      CallableStatement ts = conn.prepareCall("delete from prerequisites_temp");
      ts.execute();
     // System.out.println("Table truncated");

      CallableStatement cs = conn.prepareCall("begin database.p_prerequisites(?,?,?); END;");
      cs.setString(1, deptcode);
      cs.setString(2, course_num);
      cs.registerOutParameter(3, OracleTypes.CURSOR);
      cs.execute();

      ResultSet rs = null;
      rs = ((OracleCallableStatement)cs).getCursor(3);
      System.out.println("Dept Code \t Course Number");
      while (rs.next()) 
      {
        System.out.println(rs.getString(1) + "\t\t" + rs.getString(2) + "\n");
      }

      rs.close();
      cs.close();
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }


  }

  public static void enrollments(Connection conn) {
    try {
      Scanner input = new Scanner(System.in);
      System.out.println("\n Enter B number: ");
      String bnum = input.nextLine();
      System.out.println("\n Enter class id: ");
      String cid = input.nextLine();

      CallableStatement cs = conn.prepareCall("begin database.Students_enrollments(?,?,?); END;");
      cs.setString(1, bnum);
      cs.setString(2, cid);
      cs.registerOutParameter(3, Types.VARCHAR);
      cs.execute();

      String result = cs.getString(3);

      if (result != null) {
        System.out.println(result);
      } 

      cs.close();
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }
  }

  public static void drop_students(Connection conn) {
    try {

      Scanner input = new Scanner(System.in);
      System.out.println("\n Enter B number: ");
      String bnum = input.nextLine();
      System.out.println("\n Enter class id: ");
      String cid = input.nextLine();

      CallableStatement cs = conn.prepareCall("begin database.drop_student(?,?,?); END;");
      cs.setString(1, bnum);
      cs.setString(2, cid);
      cs.registerOutParameter(3, Types.VARCHAR);
      cs.execute();

      String result = cs.getString(3);
      if (result != null) {
        System.out.println(result);
      } else {
        System.out.println("Student dropped");
      }

      // result.close();
      cs.close();
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }
  }

  public static void delete_students(Connection conn) {
    try {
      Scanner input = new Scanner(System.in);
      System.out.println("\n Enter B number: ");
      String bnum = input.nextLine();

      CallableStatement cs = conn.prepareCall("begin database.delete_stud(?); END;");
      cs.setString(1, bnum);
      //cs.registerOutParameter(2, Types.VARCHAR);
      cs.execute();

    /*  String result = cs.getString(2);
      if (result != null) {
        System.out.println(result);
      } else {
      }*/
      System.out.println("Deletion was successful");

      cs.close();
    } catch (InputMismatchException exp) {
      System.out.println("\nException : Enter valid numeric value");
    } catch (SQLException ex) {
      System.out.println("\nSQLException caught" + ex.getMessage());
    } catch (Exception e) {
      System.out.println("\nOther exception caught");
    }
  }
}
