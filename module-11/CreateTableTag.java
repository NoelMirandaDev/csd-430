package tags;

import javax.servlet.jsp.tagext.SimpleTagSupport;
import javax.servlet.jsp.PageContext;

import java.sql.Connection;
import java.sql.Statement;

import model.DBManager;


public class CreateTableTag extends SimpleTagSupport {
	@Override
	public void doTag() {
		// Try-with-resources to automatically close resources
		try (Connection conn = DBManager.getConnection(
				((PageContext) getJspContext()).getServletContext());
			 Statement stmt = conn.createStatement()) {
			
			String createTableSql = """
				CREATE TABLE IF NOT EXISTS applicants (
					id INT PRIMARY KEY AUTO_INCREMENT,
					first_name VARCHAR(50),
					last_name VARCHAR(50),
					email VARCHAR(100),
					phone VARCHAR(20),
					gender VARCHAR(10),
					dob DATE,
					city VARCHAR(50),
					state VARCHAR(50)
				)
			""";
			stmt.executeUpdate(createTableSql);
			
			String populateTableSql = """
				INSERT INTO applicants (first_name, last_name, email, phone, gender, dob, city, state)
				VALUES ('Noel', 'Test', 'noel@bellevue.edu', '1234567890', 'Male', '1998-01-05', 'Chicago', 'IL')
			""";
			
			stmt.executeUpdate(populateTableSql);
			
			getJspContext().setAttribute("createTableStatus", "success", PageContext.REQUEST_SCOPE);	
			
		} catch (Exception e) {
			e.printStackTrace();
			getJspContext().setAttribute("createTableStatus", "failure", PageContext.REQUEST_SCOPE);
		}
	}
}