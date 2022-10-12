package com.metanet.shopping.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class JDBCTest {
	 
	   static { 
	        try { 
	            Class.forName("com.mysql.cj.jdbc.Driver"); 
	        } catch(Exception e) { 
	            e.printStackTrace(); 
	        } 
	    } 
	    
	    @Test
	    public void testConnection() { 
	        try(Connection conn = DriverManager.getConnection( 
	                "jdbc:mysql://localhost:3306/shopping?serverTimezone=Asia/Seoul", 
	                "root", 
	                "java")){ 
	            System.out.println(conn); 
	        } catch (Exception e) { 
	            fail(e.getMessage()); 
	        } 
	    
	    }    
}
