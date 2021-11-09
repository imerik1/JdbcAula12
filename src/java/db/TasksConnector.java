/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.*;
import java.util.ArrayList;
import web.DbListener;

/**
 *
 * @author erik_
 */
public class TasksConnector {
    
    public static ArrayList<String> getTasks () throws Exception {
        ArrayList<String> list = new ArrayList();
        Connection con = DbListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from tasks");
        while(rs.next()){
            list.add(rs.getString("name"));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    
    public static void addTasks(String taskName) throws Exception {
        Connection con = DbListener.getConnection();
        Statement stmt = con.createStatement();
        stmt.execute("insert into tasks values('"+taskName+"')");
        stmt.close();
        con.close();
    }
    
    public static void removeTasks(String taskName) throws Exception {
        Connection con = DbListener.getConnection();
        Statement stmt = con.createStatement();
        stmt.execute("delete from tasks where name = '" + taskName +"'");
        stmt.close();
        con.close();
    }
    
}
