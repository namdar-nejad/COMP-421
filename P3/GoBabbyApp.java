import java.sql.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Scanner;

public class GoBabbyApp {

    /** Connection Methods **/
    private static String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";
    private static String your_userid = null;
    private static String your_password = null;

    private static final Connection con = getConnection();
    private static final Statement stat = getStatement(con);

    // url for the DB2 instance
    private static Connection getConnection(){
        System.out.println("Connecting to DB...");

        // Register the driver.
        try {
            DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
        }
        catch (Exception cnfe){
            System.out.println("Class not found");
        }

        if(your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null) {
            System.err.println("Error!! do not have a username to connect to the database!");
            System.exit(1);
        }

        if(your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }

        Connection con = null;
        try {
            System.out.println("SOCSUSER: " + your_userid);
            System.out.println("SOCSPASSWD: " + your_password);
            con = (Connection) DriverManager.getConnection(url,your_userid,your_password);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("Successfully connected to the DB");
        return con;
    }

    public static void disconnect(Connection db){
        System.out.println("Disconnecting from DB...");
        try {
            db.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("Successfully closed DB connection");
    }

    public static void disconnect(Statement st){
        System.out.println("Disconnecting from statement...");
        try {
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("Successfully closed DB statement");
    }

    public static Statement getStatement(Connection db){
        Statement stat = null;

        try {
            stat = db.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return stat;
    }

    /** Scripting Methods **/
    private static int id = -1;
    private static int appNum = -1;
    private static String date = "";
    private static ArrayList<ArrayList<Object>> apps = null;

    public static ResultSet applyScript(String script){

        int sqlCode = 0000;
        String sqlState = "None";

        java.sql.ResultSet rs = null;

        try{
            rs = stat.executeQuery ( script ) ;
        }
        catch (SQLException e){
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.print("SQL Error:");
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
        }
        return rs;
    }

    public static void insertScript(String script){

        int sqlCode = 0000;
        String sqlState = "None";

        try{
            stat.executeUpdate(script) ;
        }
        catch (SQLException e){
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.print("SQL Error:");
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);

        }
    }

    public static void exit(Statement stat, Connection con){
        disconnect(stat);
        disconnect(con);

        System.exit(0);
    }

    /** Application Methods **/
    private static Boolean checkId(int id) throws Exception {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        String createSQL = "SELECT * FROM MIDWIFE";
        ResultSet rs = applyScript(createSQL);

        while(true){
            if (!rs.next()) break;
            ids.add(rs.getInt(1));
        }

        return ids.contains(id);
    }

    private ArrayList<ArrayList<Object>> getDate(int id){
        Scanner scan = new Scanner(System.in);
        String input;
        String date;
        ArrayList<ArrayList<Object>> apps = new ArrayList<>();

        while(true) {
            System.out.print("Please enter the date (year-month-day) for appointment list [E] to exit:");
            input = scan.nextLine();

            if (input.equals("E")) {
                exit(stat, con);
            } else {
                date = input;
                try {
                    apps = getAppointments(date, id);
                } catch (Exception e) {
                    ;
                }

                if (apps.isEmpty()) {
                    System.out.println("ERROR: no appointments on this date");
                }
                else {
                    break;
                }
            }
        }

        this.apps = apps;
        this.date = date;
        return apps;
    }

    private int getId(){
        Scanner scan = new Scanner(System.in);
        String input;
        int id = 0;

        while(true){
            System.out.print("Please enter your practitioner id [E] to exit:");
            input = scan.nextLine();

            try {
                if (input.equals("E")) {
                    exit(stat, con);
                } else {
                    id = Integer.parseInt(input);
                    if (!checkId(id)) {
                        System.out.println("ERROR: id doesn't exist");
                    } else {
                        break;
                    }
                }
            }
            catch (Exception e){
                System.out.println("ERROR: id doesn't exist");
            }
        }

        this.id = id;
        return id;
    }

    public static ArrayList<ArrayList<Object>> getAppointments(String date, int id) throws Exception {

        ArrayList<ArrayList<Object>> rtn = new ArrayList<ArrayList<Object>>();

        String createSQL =
                "SELECT DISTINCT a.Time, \n" +
                        "CASE\n" +
                        "WHEN PrimID = " + id + " THEN 'P'\n" +
                        "ELSE 'B'\n" +
                        "END, m.Name, m.Hcid, p.Cid, p.Num, a.Aid\n" +
                        "FROM Couple c, Pregnancy p, Mother m, Appointment a\n" +
                        "WHERE c.Cid = a.Cid\n" +
                        "AND c.Cid = p.Cid\n" +
                        "AND a.Num = p.Num\n" +
                        "AND c.Hcid = m.Hcid\n" +
                        "AND a.MIDID = " + id +"\n" +
                        "AND a.date = '"+ date + "'\n" +
                        "AND (PrimID = " + id + " OR BackupID = " + id + ")\n ORDER BY a.Time" ;

        ResultSet rs = applyScript(createSQL);

        while(true){
            ArrayList<Object> inner = new ArrayList<Object>();
            if (!rs.next()) break;
            inner.add(rs.getString(1));
            inner.add(rs.getString(2));
            inner.add(rs.getString(3));
            inner.add(rs.getInt(4));
            inner.add(rs.getInt(5));
            inner.add(rs.getInt(6));
            inner.add(rs.getInt(7));
            rtn.add(inner);
        }

        return rtn;
    }

    public static void printAppointments(ArrayList<ArrayList<Object>> apps){
        int i = 1;
        System.out.println("----------------------------------------");
        for(ArrayList<Object> inner : apps){
            System.out.print(i++ + ": ");
            System.out.print(inner.get(0));
            System.out.print("\t");
            System.out.print(inner.get(1));
            System.out.print("\t");
            System.out.print(inner.get(2));
            System.out.print("\t");
            System.out.print(inner.get(3));
            System.out.print("\n");
        }
        System.out.println("----------------------------------------");
    }

    private void options() {

        Scanner scan = new Scanner(System.in);
        String input;
        int option = -1;
        Boolean done = false;
        String str = null;

        try{
            str =
                    "\nFor " + (apps.get(appNum - 1)).get(2) + " " + (apps.get(appNum - 1)).get(3) + "\n\n" +
                            "1. Review notes\n" +
                            "2. Review tests\n" +
                            "3. Add a note\n" +
                            "4. Prescribe a test\n" +
                            "5. Go back to the appointments.\n" +
                            "Enter your choice:";
        }
        catch(Exception e){
            System.out.println ("ERROR: Invalid input");
        }


        while (!done) {
            try {
                System.out.print(str);
                input = scan.nextLine();

                int value = 0;
                switch (Integer.parseInt(input)) {
                    case 1:
                        listAllPregNotes();
                        break;
                    case 2:
                        printTests();
                        break;
                    case 3:
                        System.out.print("\nPlease type your observation:\n");
                        input = scan.nextLine();
                        insertNote(input);
                        break;
                    case 4:
                        System.out.print("\nPlease enter the type of test:\n");
                        input = scan.nextLine();
                        insertTest(input);
                        break;
                    case 5:
                        done = true;
                        break;
                    default :
                        System.out.print("ERROR: Invalid Input\n");
                        break;
                }
            } catch (Exception e) {
                System.out.print("ERROR: Invalid Input\n");
            }
        }
    }

    private void printTests(){
        int cid = (int) (apps.get(appNum-1)).get(4);
        int pNum = (int) (apps.get(appNum-1)).get(5);

       String createSQL =
               "SELECT T.PresDate, T.Ttype,\n" +
                       "    CASE\n" +
                       "        WHEN (T.Results IS NULL) THEN 'PENDING'\n" +
                       "        WHEN LENGTH(T.Results) > 50 THEN LEFT(T.Results, 50)\n" +
                       "        ELSE T.Results\n" +
                       "    END AS Result\n" +
                       "FROM Tests T\n" +
                       "WHERE T.Cid = " + cid + "\n" +
                       "  AND T.Num = " + pNum + "\n" +
                       "  AND (T.For = 'Mother' OR T.For = 'mother')";

        ResultSet rs = applyScript(createSQL);
        System.out.println("----------------------------------------");
        while(true){
            ArrayList<Object> inner = new ArrayList<Object>();
            try {
                if (!rs.next()) break;
            } catch (SQLException e) {
                ;
            }
            try {
                System.out.print(rs.getString(1));
                System.out.print("\t");
                System.out.print("["+rs.getString(2)+"]");
                System.out.print("\t");
                System.out.print(rs.getString(3));
                System.out.print("\n");

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        System.out.println("----------------------------------------");
    }

    private void insertTest(String test){
        int cid = (int) (apps.get(appNum-1)).get(4);
        int pNum = (int) (apps.get(appNum-1)).get(5);

        String createSQL = String.format(
                "INSERT INTO Tests(Tid, MidId, Num, Cid, Ttype, PresDate, SampDate, LabDate, TechId, Bid, Results, For) VALUES\n" +
                        "((SELECT MAX(Tid)+1 FROM Tests t), %d, %d, %d, '%s', DATE'%s', NULL, NULL, NULL, NULL, NULL, 'Mother')\n",id, pNum, cid, test, new java.sql.Date(System.currentTimeMillis()));

        insertScript(createSQL);
    }

    private void insertNote(String note){
        String createSQL =
                "INSERT INTO Notes(Aid, Date, Time, Text) VALUES\n" +
                "("+(int) (apps.get(appNum-1)).get(6)+", DATE'"+ new java.sql.Date(System.currentTimeMillis())+
                        "', Time'"+ (LocalTime.now().toString()).substring(0 , 8) +"', '" +note+ "')\n";

        insertScript(createSQL);
    }

    private void listAllPregNotes(){
        int cid = (int) (apps.get(appNum-1)).get(4);
        int pNum = (int) (apps.get(appNum-1)).get(5);

        String createSQL =
                "SELECT n.date, n.Time,\n" +
                "    CASE \n" +
                "        WHEN LENGTH(n.Text) > 50 THEN LEFT(n.Text, 50)\n" +
                "        ELSE n.Text \n" +
                "    END\n" +
                "\n" +
                "FROM Appointment a, Notes n\n" +
                "WHERE a.Cid = " + cid + "\n" +
                "  AND a.Num = " + pNum + "\n" +
                "  AND n.Aid = a.Aid\n" + "ORDER BY n.date DESC, n.time DESC\n";

        ResultSet rs = applyScript(createSQL);


        System.out.println("----------------------------------------");
        while(true){
            try {
                if (!rs.next()) break;
            } catch (SQLException e) {
                break;
            }
            try {
                System.out.print(rs.getString(1));
                System.out.print("\t");
                System.out.print(rs.getString(2));
                System.out.print("\t");
                System.out.print(rs.getString(3));
                System.out.print("\n");

            } catch (SQLException e) {
                ;
            }
        }
        System.out.println("----------------------------------------");
    }

    private int getAppNum(ArrayList<ArrayList<Object>> in){
        Scanner scan = new Scanner(System.in);
        String input;
        int appNum = -1;
        ArrayList<ArrayList<Object>> apps = (ArrayList<ArrayList<Object>>) in.clone();

        while(true){
            System.out.print("Enter the appointment number that you would like to work on.\n" +
                    "\t[E] to exit [D] to go back to another date :");

            input = scan.nextLine();

            try {
                if (input.equals("E")) {
                    exit(stat, con);
                }
                else if(input.equals("D")){
                    apps = getDate(id);
                    printAppointments(apps);
                }
                else {
                    appNum = Integer.parseInt(input);
                    if (apps.size() < appNum || appNum <= 0) {
                        System.out.println("ERROR: the index entered doesn't exist");
                    } else {
                        break;
                    }
                }
            }
            catch (Exception e){
                System.out.println("ERROR: the index entered doesn't exist");
            }
        }

        this.appNum = appNum;
        return appNum;
    }

    public void insideLoop(){
        Scanner scan = new Scanner(System.in);
        String input;

        getId();
        getDate(id);
        printAppointments(this.apps);

        while(true){
            getAppNum(apps);
            options();
            printAppointments(this.apps);
        }
    }

    public static void main(String[] args) throws SQLException{
        GoBabbyApp app = new GoBabbyApp();
        app.insideLoop();
    }
}
