/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package usermanagement;

import dao.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBConnection{
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.id, u.userName, u.email, u.phoneNumber, r.id AS roleId, r.roleName, u.status " +
                     "FROM [User] u JOIN UserRole r ON u.roleId = r.id WHERE u.status = 1";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                users.add(new User(rs.getInt("id"), rs.getString("userName"),
                        rs.getString("email"), rs.getString("phoneNumber"),
                        rs.getInt("roleId"), rs.getString("roleName"), rs.getBoolean("status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public int addUser(String userName, String email, String phoneNumber, int roleId) {
        String sql = "INSERT INTO [User] (userName, email, phoneNumber, roleId, status , password) VALUES (?, ?, ?, ?, 1 , ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, userName);
            stmt.setString(2, email);
            stmt.setString(3, phoneNumber);
            stmt.setInt(4, roleId);
            stmt.setString(5, "1");
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void updateUser(int id, String userName, String email, String phoneNumber, int roleId) {
        String sql = "UPDATE [User] SET userName=?, email=?, phoneNumber=?, roleId=? WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, userName);
            stmt.setString(2, email);
            stmt.setString(3, phoneNumber);
            stmt.setInt(4, roleId);
            stmt.setInt(5, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteUser(int id) {
        String sql = "UPDATE [User] SET status=0 WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

