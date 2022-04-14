package com.yoonweb;

import org.junit.Test;

import java.sql.Connection;
import java.sql.DriverManager;

import static org.springframework.test.util.AssertionErrors.fail;

public class JDBCTest {

    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testConnection() {

        try(Connection con =
                    DriverManager.getConnection(
                            // Oracle19 버전인 경우 => "jdbc:oracle:thin:@localhost:1521:orcl"
                            // Oracle11 버전인 경우 => "jdbc:oracle:thin:@localhost:1521:XE"
                            "jdbc:oracle:thin:@localhost:1521:orcl",
                            "C##yoon",
                            "qwer1234")){
            System.out.println(con);
        } catch (Exception e) {
            fail(e.getMessage());
        }

    }

}
