package edu.bellevue.beans;

import javax.faces.bean.ManagedBean; // tells JSF to manage this class as a bean
import javax.faces.bean.RequestScoped;
import java.util.ArrayList;
import java.util.List;

// @ManagedBean registers this class as a JSF managed bean which makes it accessible in XHTML files using the 
// name attribute value.
@ManagedBean (name="participant")
@RequestScoped // This bean has a request scope meaning it resets every new request
public class ParticipantResponseBean {
	private String studentID;
	private String course;
	private int rating;
	private String feedBack;
	
	public String getStudentID() {
		return studentID;
	}
	public void setStudentID(String studentID) {
		this.studentID = studentID;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getFeedBack() {
		return feedBack;
	}
	public void setFeedBack(String feedBack) {
		this.feedBack = feedBack;
	}
	
	// This method runs when the user clicks the "Submit" button
	// It simulates inserting the data entered by the user into a database and redirecting to a
	// success page.
	public String dbInsert() {
		// Database logic will be here
		
		return "thankyou"; // faces-config handles navigation of outcome "thankyou"
	}
	
	public List<Integer> getRatingOptions() {
		List<Integer> ratings = new ArrayList<>();
		
		for (int i = 1; i <= 10; i++) {
			ratings.add(i);
		}
		return ratings;
	}
}