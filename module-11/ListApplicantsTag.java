package tags;

import javax.servlet.jsp.tagext.SimpleTagSupport;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.JspException;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.DBManager;
import model.ApplicantBean;

public class ListApplicantsTag extends SimpleTagSupport {
	@Override
	public void doTag() throws JspException {
		List <ApplicantBean> applicantList = new ArrayList<>();
		
		// Try-with-Resources to automatically close resources
		try (Connection conn = DBManager.getConnection(
			  ((PageContext) getJspContext()).getServletContext());
			 Statement stmt = conn.createStatement();
			 ResultSet rs = stmt.executeQuery("SELECT * FROM applicants")) {
			
			while (rs.next()) {
				ApplicantBean applicant = new ApplicantBean();
				applicant.setId(rs.getInt("id"));
				applicant.setFirstName(rs.getString("first_name"));
				applicant.setLastName(rs.getString("last_name"));
				applicant.setEmail(rs.getString("email"));
				applicant.setPhone(rs.getString("phone"));
				applicant.setGender(rs.getString("gender"));
				applicant.setDob((rs.getDate("dob")).toString()); // Converts type sql.Date from database back to string
				applicant.setCity(rs.getString("city"));
				applicant.setState(rs.getString("state"));
				
				applicantList.add(applicant);
			}
			
			getJspContext().setAttribute("applicantList", applicantList, PageContext.REQUEST_SCOPE);
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
}