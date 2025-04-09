# Dynamic Web Project: Online Bookstore Application
Constructed and edited by: Noel Miranda  
Course: Server Side Development  
Bellevue University  
April 8, 2025

#### Description
This is a dynamic web project from the Beginning Jakarta EE Web Development book by Luciano Manelli and Giulio Zambon.
It follows a MVC (Model-View-Controller) structure. 
It is also modified slightly for better readability and optimization.

#### Tech Used 
- Java (JavaSE-15)
- JSP & Servlets
- Apache Tomcat (v9.0)
- Eclipse IDE
- Html / CSS

#### Project Structure
- **Model** - Java class that handles business logic and data (Book.java)
- **View** - JSP files for the user interface (index.jsp, Checkout.jsp)
- **Controller** - Servlets that control the flow (ShoppingServlet.java)

#### Modifications made to original E-bookshop Application (Fixed in this Application)
- In index.jsp, the first scriptlet originally used session.getValue("ebookshop.list");, which is deprecated. It has been updated to session.getAttribute("ebookshop.list"); to align with current JSP standards and avoid compatibility issues.
- In index.jsp, in the second Scriptlet, the code attempts to loop through the Vector<ebookshop.Book> named booklist (set in Scriptlet 1) and casts each element to String. This is incorrect because the elements are Book objects, not strings.
To fix this, I went back to Scriptlet 1 and changed the vector type from Vector<ebookshop.Book> to Vector<String>, as the list is meant to store book details as plain strings. Then, in Scriptlet 2, I removed the cast to String, since the elements are now already strings. After making these changes, the page loads and loops through the list correctly.
- In index.jsp, Scriptlet 3 was missing the generic type declaration for the Vector instance shoplist. It was declared without specifying the type, which can lead to type-safety issues and warnings. To fix this, I added the type parameter <ebookshop.Book> to make it Vector<ebookshop.Book> shoplist. This ensures the list handles only Book objects and improves code clarity and safety.
- Modified the Book.java file to include an overridden toString() method. This method returns a string representation of the book with its name, author, and price, making it easier to display book details when needed (such as in JSP pages or debugging).
- After some experimenting, I optimized the application by removing the internal styling from the JSP files. Instead, I created a separate CSS file and placed it in the content directory (which is the ebookshop folder in my project structure). In the JSP files, I then linked to this external CSS file within the <head> tag. This approach improves code organization and makes future styling adjustments easier.

#### How to Run 
1. Open Eclipse and import the project as a Dynamic Web Project.
2. Set up and start the Tomcat server.
3. Right-click the project > Run As > Run on Server.
4. Go to `http://localhost:8080/ebookshop`.