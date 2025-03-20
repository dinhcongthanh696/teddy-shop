/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package usermanagement;

import dao.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Admin
 */
public class UserRoleDAO extends DBConnection{
    public List<UserRole> getAllRoles() {
        List<UserRole> roles = new ArrayList<>();
        String sql = "SELECT * FROM UserRole";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                roles.add(new UserRole(rs.getInt("id"), rs.getString("roleName")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }
}
