/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Packages;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConnectionDB {
    private static final String URL = "jdbc:postgresql://localhost:5432/postgres ";
    private static final String USER = "postgres";
    private static final String PASSWORD = "Jason1509";

//    public static Connection getConnection() throws SQLException {
//        return DriverManager.getConnection(URL, USER, PASSWORD);
//    }
    
    public static Connection getConnection() throws SQLException {
    try {
        Class.forName("org.postgresql.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        throw new SQLException("PostgreSQL JDBC Driver not found.");
    }
    return DriverManager.getConnection(URL, USER, PASSWORD);
}
}
