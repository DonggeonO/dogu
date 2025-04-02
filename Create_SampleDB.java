import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Create_SampleDB {
    public static void main(String args[]) {
        StringBuilder sb = null;
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.sqlite.JDBC");
            conn = DriverManager.getConnection("jdbc:sqlite:/D:/apache-tomcat-9.0.100/sample.db");
            stmt = conn.createStatement();
            System.out.println("✔ Opened database successfully");

            // dept 테이블 생성
            sb = new StringBuilder();
            sb.append("CREATE TABLE IF NOT EXISTS dept(");
            sb.append("deptno INTEGER PRIMARY KEY NOT NULL,");
            sb.append("dname TEXT NOT NULL,");
            sb.append("loc TEXT)");
            stmt.executeUpdate(sb.toString());
            System.out.println("✔ dept 테이블 생성 완료");

            // emp 테이블 생성
            sb = new StringBuilder();
            sb.append("CREATE TABLE IF NOT EXISTS emp(");
            sb.append("empno INTEGER PRIMARY KEY NOT NULL,");
            sb.append("ename TEXT NOT NULL,");
            sb.append("job TEXT,");
            sb.append("mgr INTEGER,");
            sb.append("hiredate TEXT,");
            sb.append("sal INTEGER,");
            sb.append("comm INTEGER,");
            sb.append("deptno INTEGER REFERENCES dept)");
            stmt.executeUpdate(sb.toString());
            System.out.println("✔ emp 테이블 생성 완료");

            // emp_audit 테이블 생성
            sb = new StringBuilder();
            sb.append("CREATE TABLE IF NOT EXISTS emp_audit(");
            sb.append("empno INTEGER PRIMARY KEY NOT NULL,");
            sb.append("ename TEXT NOT NULL,");
            sb.append("job TEXT,");
            sb.append("mgr INTEGER,");
            sb.append("hiredate TEXT,");
            sb.append("sal INTEGER,");
            sb.append("comm INTEGER,");
            sb.append("deptno INTEGER REFERENCES dept,");
            sb.append("create_id TEXT NOT NULL,");
            sb.append("create_ip TEXT NOT NULL,");
            sb.append("create_dt TEXT NOT NULL,");
            sb.append("update_id TEXT NOT NULL,");
            sb.append("update_ip TEXT NOT NULL,");
            sb.append("update_dt TEXT NOT NULL)");
            stmt.executeUpdate(sb.toString());
            System.out.println("✔ emp_audit 테이블 생성 완료");

            // user 테이블 생성
            sb = new StringBuilder();
            sb.append("CREATE TABLE IF NOT EXISTS user (");
            sb.append("id TEXT PRIMARY KEY,");
            sb.append("password TEXT NOT NULL,");
            sb.append("name TEXT,");
            sb.append("email TEXT,");
            sb.append("regDate DATETIME DEFAULT CURRENT_TIMESTAMP)");
            stmt.executeUpdate(sb.toString());
            System.out.println("✔ user 테이블 생성 완료");

            // 샘플 dept 데이터
            stmt.executeUpdate("INSERT INTO dept(deptno, dname, loc) VALUES (10,'ACCOUNTING','NEW YORK')");
            stmt.executeUpdate("INSERT INTO dept(deptno, dname, loc) VALUES (20,'RESEARCH','DALLAS')");
            stmt.executeUpdate("INSERT INTO dept(deptno, dname, loc) VALUES (30,'SALES','CHICAGO')");
            stmt.executeUpdate("INSERT INTO dept(deptno, dname, loc) VALUES (40,'OPERATIONS','BOSTON')");
            System.out.println("✔ dept 샘플 데이터 입력 완료");

            // 외래키 활성화
            stmt.execute("PRAGMA foreign_keys = ON");

            // 샘플 emp 데이터
            stmt.executeUpdate("INSERT INTO emp VALUES(7782,'CLARK','MANAGER',7839,'1981-06-09',2450,NULL,10)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000,NULL,10)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7934,'MILLER','CLERK',7782,'1982-01-23',1300,NULL,10)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7369,'SMITH','CLERK',7902,'1980-12-17',800,NULL,20)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7566,'JONES','MANAGER',7839,'1981-04-02',2975,NULL,20)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7788,'SCOTT','ANALYST',7566,'1987-07-13',3000,NULL,20)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7876,'ADAMS','CLERK',7788,'1987-07-13',1100,NULL,20)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7902,'FORD','ANALYST',7566,'1981-12-03',3000,NULL,20)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,500,30)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,1400,30)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,NULL,30)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30)");
            stmt.executeUpdate("INSERT INTO emp VALUES(7900,'JAMES','CLERK',7698,'1981-12-03',950,NULL,30)");
            System.out.println("✔ emp 샘플 데이터 입력 완료");

            // 샘플 로그인 계정
            stmt.executeUpdate("INSERT INTO user (id, password, name, email) VALUES ('admin', '1234', '관리자', 'admin@example.com')");
            System.out.println("✔ admin 계정 생성 완료");

            // 샘플 출력
            rs = stmt.executeQuery("SELECT * FROM dept");
            System.out.println("deptno | dname | loc");
            while (rs.next()) {
                System.out.println(rs.getInt("deptno") + " | " + rs.getString("dname") + " | " + rs.getString("loc"));
            }

            rs = stmt.executeQuery("SELECT * FROM emp");
            System.out.println("empno | ename | job | mgr | hiredate | sal | comm | deptno");
            while (rs.next()) {
                System.out.println(
                    rs.getInt("empno") + " | " +
                    rs.getString("ename") + " | " +
                    rs.getString("job") + " | " +
                    rs.getString("mgr") + " | " +
                    rs.getString("hiredate") + " | " +
                    rs.getString("sal") + " | " +
                    rs.getString("comm") + " | " +
                    rs.getInt("deptno")
                );
            }

            System.out.println("✔ 전체 작업 완료");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (stmt != null) stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        System.out.println("🎉 DONE");
    }
}
