package com.bcwellness.utils;

import java.sql.Connection;

public class TestDBConnection {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ Database connection successful!");
            } else {
                System.out.println("❌ Failed to establish connection.");
            }
        } catch (Exception e) {
            System.out.println("❌ Exception occurred:");
            e.printStackTrace();
        }
    }
}
