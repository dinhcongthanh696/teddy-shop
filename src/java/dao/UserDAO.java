package dao;

import entity.User;
import entity.UserRole;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBConnection {

    //Change current user information
    public void changeUserInformation(String currentUsername, String username, String email, String phoneNumber, String location) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "UPDATE [User]\n"
                + "SET userName = ? , email = ?, phoneNumber = ?, location = ?\n"
                + "WHERE userName = ?;";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, email);
            pre.setString(3, phoneNumber);
            pre.setString(4, location);
            pre.setString(5, currentUsername);
            pre.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    // This method retrieves the UserRole associated with a given user ID.
    public UserRole getRoleByUserID(int userId) {
        UserRole role = null;
        String sql = "SELECT r.id, r.roleName "
                + "FROM [User] u "
                + "JOIN UserRole r ON u.roleId = r.id "
                + "WHERE u.id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                role = new UserRole();
                role.setId(rs.getInt("id"));
                role.setUserRole(rs.getString("roleName"));
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return role;
    }

    public UserRole getRoleByID(int userId) {
        UserRole role = null;
        String sql = "select * from userRole where id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                role = new UserRole();
                role.setId(rs.getInt("id"));
                role.setUserRole(rs.getString("roleName"));
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return role;
    }

    // The checkLogin method that uses getRoleByUserID
    public User checkLogin(String email, String password) {
        User user = null;
        String sql = "SELECT id, username, profilePic, email, phoneNumber, location, createdDate "
                + "FROM [User] "
                + "WHERE email = ? AND password = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUserName(rs.getString("username"));
                user.setProfilePic(rs.getString("profilePic"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setLocation(rs.getString("location"));
                user.setCreatedDate(rs.getDate("createdDate"));

                // Call the helper method to get the role based on the user id.
                UserRole role = getRoleByUserID(user.getId());
                user.setRole(role);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return user;
    }

    public User getByEmail(String email) {
        User user = null;
        String sql = "SELECT id, username, profilePic, email, phoneNumber, location, createdDate "
                + "FROM [User] "
                + "WHERE email = ? ";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUserName(rs.getString("username"));
                user.setProfilePic(rs.getString("profilePic"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setLocation(rs.getString("location"));
                user.setCreatedDate(rs.getDate("createdDate"));

                // Call the helper method to get the role based on the user id.
                UserRole role = getRoleByUserID(user.getId());
                user.setRole(role);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return user;
    }

    public boolean registerUser(String username, String email, String password, String phone, String location) {
        // Adjust the SQL statement and column names if your table schema differs.
        String sql = "INSERT INTO [User] (username, email, password, roleId, phoneNumber, location) VALUES (?, ?, ?, ?, ? ,?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setInt(4, 1);
            ps.setString(5, phone);
            ps.setString(6, location);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    public boolean isUsernameExist(String username) {
        String sql = "SELECT id FROM [User] WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    // Check if an email already exists
    public boolean isEmailExist(String email) {
        String sql = "SELECT id FROM [User] WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    public boolean isPhoneNumberExist(String phoneNumber) {
        String sql = "SELECT id FROM [User] WHERE phoneNumber = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, phoneNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return false;
    }

    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        String sql = "UPDATE [User] SET password = ? WHERE id = ? AND password = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            ps.setString(3, oldPassword);  // This check ensures the old password is correct.
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
// Return all users with the Customer role (assuming roleId = 1)

    public List<User> getAllCustomers() throws Exception {
        List<User> customers = new ArrayList<>();
        String sql = "SELECT * FROM [User] WHERE roleId = 1";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUserName(rs.getString("username"));
                user.setProfilePic(rs.getString("profilePic"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setLocation(rs.getString("location"));
                user.setCreatedDate(rs.getDate("createdDate"));
                // Optionally set role if needed
                customers.add(user);
            }
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return customers;
    }

    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        System.out.println(userDAO.getByEmail("User1@gmail.com"));
    }
}
