package utils;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDB {
    public static Connection getConnection() {
        Connection conn = null;

        String url = "jdbc:postgresql://aws-0-eu-central-1.pooler.supabase.com:5432/postgres";
        String user = "postgres.gnvpudqnanwcmfnamjfp";
        String password = "Jason1509";

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(url + "?sslmode=require", user, password);
            System.out.println("Connected to Supabase DB!");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Connection failed: " + e.getMessage());
            e.printStackTrace();
        }

        return conn;
    }
}
