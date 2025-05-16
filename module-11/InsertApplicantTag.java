package tags;

import javax.servlet.jsp.tagext.SimpleTagSupport;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.JspException;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.ApplicantBean;
import model.DBManager;

public class InsertApplicantTag extends SimpleTagSupport {
	private ApplicantBean applicant;
	
	// Method to insert applicant object and use its fields for database insertion
	// this is set by the tag attribute
	public void setApplicant(ApplicantBean applicant) {
		this.applicant = applicant;
	}
	
	@Override
	public void doTag() throws JspException {
		try (Connection conn = DBManager.getConnection(
				((PageContext) getJspContext()).getServletContext());
			// PreparedStatement utilized for a more secure database insertion of input fields	
			 PreparedStatement pstmt = conn.prepareStatement(
				"INSERT INTO applicants (first_name, last_name, email, phone, gender, dob, city, state) "
				+ "VALUES (?,?,?,?,?,?,?,?)")) {
			
			pstmt.setString(1, applicant.getFirstName());
			pstmt.setString(2, applicant.getLastName());
			pstmt.setString(3, applicant.getEmail());
			pstmt.setString(4, applicant.getPhone());
			pstmt.setString(5, applicant.getGender());
			pstmt.setDate(6, Date.valueOf(applicant.getDob())); // converts to sql.Date type as expected from database
			pstmt.setString(7, applicant.getCity());
			pstmt.setString(8, applicant.getState());
			
			pstmt.executeUpdate();
			
			getJspContext().setAttribute("insertStatus", "success", PageContext.REQUEST_SCOPE);
		} catch (SQLException e) {
			e.printStackTrace();
			getJspContext().setAttribute("insertStatus", "sql_error", PageContext.REQUEST_SCOPE);
		} catch (Exception e) {
			e.printStackTrace();
			getJspContext().setAttribute("insertStatus", "failure", PageContext.REQUEST_SCOPE);
		}
	}
}