package usermanagement;

import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private UserRoleDAO userRoleDAO = new UserRoleDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        List<UserRole> roles = userRoleDAO.getAllRoles();
        JSONArray jsonArray = new JSONArray();
        for (User user : users) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", user.getId());
            jsonObject.put("userName", user.getUserName());
            jsonObject.put("email", user.getEmail());
            jsonObject.put("phoneNumber", user.getPhoneNumber());
            jsonObject.put("roleName", user.getRoleName());
            jsonObject.put("roleId", user.getRoleId());
            jsonArray.put(jsonObject);
        }

        JSONArray rolesJsonArray = new JSONArray();
        for (UserRole role : roles) {
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("id", role.getId());
            jsonObj.put("roleName", role.getRoleName());
            rolesJsonArray.put(jsonObj);
        }
        String rolesString = rolesJsonArray.toString();
        request.setAttribute("rolesJSON", rolesString);
        request.setAttribute("roles", roles);
        request.setAttribute("usersJson", jsonArray.toString()); // Lưu JSON vào request
        request.getRequestDispatcher("userList.jsp").forward(request, response); // Chuyển tiếp đến JSP
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String contentType = request.getContentType();
        String action;

        if (contentType != null && contentType.contains("application/json")) {
            // Nếu dữ liệu là JSON, đọc từ request body
            BufferedReader reader = request.getReader();
            StringBuilder json = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                json.append(line);
            }

            // Chuyển JSON thành đối tượng JSONObject
            JSONObject jsonObject = new JSONObject(json.toString());
            action = jsonObject.getString("action");

            if ("add".equals(action)) {
                String userName = jsonObject.getString("userName");
                String email = jsonObject.getString("email");
                String phoneNumber = jsonObject.getString("phoneNumber");
                int roleId = jsonObject.getInt("roleId");
                int result = userDAO.addUser(userName, email, phoneNumber, roleId);
                if(result == 0){
                    response.sendError(400);
                    return;
                }
            } else if ("edit".equals(action)) {
                int id = jsonObject.getInt("id");
                String userName = jsonObject.getString("userName");
                String email = jsonObject.getString("email");
                String phoneNumber = jsonObject.getString("phoneNumber");
                int roleId = jsonObject.getInt("roleId");
                userDAO.updateUser(id, userName, email, phoneNumber, roleId);
            } else if ("delete".equals(action)) {
                int id = jsonObject.getInt("id");
                userDAO.deleteUser(id);
            }
        } else {
            // Nếu dữ liệu là Form Data (application/x-www-form-urlencoded)
            action = request.getParameter("action");

            if ("add".equals(action)) {
                userDAO.addUser(request.getParameter("userName"), request.getParameter("email"),
                        request.getParameter("phoneNumber"), Integer.parseInt(request.getParameter("roleId")));
            } else if ("edit".equals(action)) {
                userDAO.updateUser(Integer.parseInt(request.getParameter("id")), request.getParameter("userName"),
                        request.getParameter("email"), request.getParameter("phoneNumber"), Integer.parseInt(request.getParameter("roleId")));
            } else if ("delete".equals(action)) {
                userDAO.deleteUser(Integer.parseInt(request.getParameter("id")));
            }
        }

        // Phản hồi JSON về client
        response.setContentType("application/json");
        response.getWriter().write("{\"message\": \"Thao tác thành công!\"}");
    }
}
