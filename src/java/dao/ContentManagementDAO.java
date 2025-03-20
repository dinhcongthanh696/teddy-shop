package dao;

import entity.ContentManagement;
import java.beans.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ContentManagementDAO extends DBConnection {
    
    public ContentManagement getContent() {
        String sql = "SELECT TOP 1 * FROM ContentManagement";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                ContentManagement content = new ContentManagement();
                content.setId(rs.getInt("id"));
                content.setHeaderTextColor(rs.getString("header_text_color"));
                content.setHeaderBackgroundColor(rs.getString("header_background_color"));
                content.setFooterTextColor(rs.getString("footer_text_color"));
                content.setFooterBackgroundColor(rs.getString("footer_background_color"));
                content.setWebName(rs.getString("web_name"));
                return content;
            } else {
                // If no record exists, create a default one
                ContentManagement defaultContent = new ContentManagement();
                defaultContent.setWebName("Teddy Shop");
                defaultContent.setHeaderTextColor("#ff6699");
                defaultContent.setHeaderBackgroundColor("#fed6e3");
                defaultContent.setFooterTextColor("#FFFFFF");
                defaultContent.setFooterBackgroundColor("#feb5c0");
                
                String insertSql = "INSERT INTO ContentManagement (web_name, header_text_color, header_background_color, footer_text_color, footer_background_color) "
                        + "VALUES (?, ?, ?, ?, ?)";
                PreparedStatement insertSt = connection.prepareStatement(insertSql);
                insertSt.setString(1, defaultContent.getWebName());
                insertSt.setString(2, defaultContent.getHeaderTextColor());
                insertSt.setString(3, defaultContent.getHeaderBackgroundColor());
                insertSt.setString(4, defaultContent.getFooterTextColor());
                insertSt.setString(5, defaultContent.getFooterBackgroundColor());
                insertSt.executeUpdate();
                
                ResultSet generatedKeys = insertSt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    defaultContent.setId(generatedKeys.getInt(1));
                }
                
                return defaultContent;
            }
        } catch (SQLException e) {
            System.out.println("Error getting content: " + e.getMessage());
            return null;
        }
    }
    
    public void updateContent(ContentManagement content) {
        String sql = "UPDATE ContentManagement SET header_text_color=?, header_background_color=?, "
                + "footer_text_color=?, footer_background_color=?, web_name=? WHERE id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, content.getHeaderTextColor());
            st.setString(2, content.getHeaderBackgroundColor());
            st.setString(3, content.getFooterTextColor());
            st.setString(4, content.getFooterBackgroundColor());
            st.setString(5, content.getWebName());
            st.setInt(6, content.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating content: " + e.getMessage());
        }
    }
}