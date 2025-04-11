package ebookshop;

// Imported necessary libraries for handling requests, sessions, and forward operations
import java.util.Vector;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;

// Imported custom Book class
import ebookshop.Book;

/**
 * Servlet implementation class ShoppingServlet
 * This servlet handles requests for the shopping cart system, such as adding/removing items and
 * performing checkout.
 */
@WebServlet("/eshop")
public class ShoppingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
     * @see HttpServlet#HttpServlet()
     * Default constructor
     * This is called when an instance of the servlet is created.
     */
	public ShoppingServlet() {
		super();
	}
    
	/**
	 * @see Servlet#init(ServletConfig)
	 * Initializes the servlet
	 * This method is invoked once when the servlet is loaded for the first time.
	 */
    public void init(ServletConfig conf) throws ServletException {
        super.init(conf);
    }
    
    /**
	 * @see Servlet#destroy()
	 * This method is called when the servlet is about to be destroyed (server shutdown)
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * Handles GET requests. It redirects the GET request to the POST handler.
	 * @param req (The HTTP request object).
	 * @param res (The HTTP response object).
	 */
	public void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		// Calls the doPost method to handle the GET request as if it were a POST request.
		doPost(req, res);
	}

	/**
	 * Handles POST requests. This method processes the shopping cart actions like adding/removing books or checking out.
	 * @param req (The HTTP request object).
	 * @param res (The HTTP response object).
	 */
	public void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		// Retrieves current session for request or if there is no current session then it creates a new session.
		HttpSession session = req.getSession(true);
		
		// Retrieves the shopping cart (which is a Vector of Book objects) from the session.
		// If null, then saves it as null
		@SuppressWarnings("unchecked")
		Vector<Book> shoplist =
				(Vector<Book>)session.getAttribute("ebookshop.cart");
		
		// Retrieves the "do_this" parameter from the request, which determines what action to perform.
		String do_this = req.getParameter("do_this");
		
		// If this is the first request (there is no "do_this" parameter), it initialize the list of books.
		if (do_this == null) {
			// Create a new Vector to hold a list of books.
			Vector<String> blist = new Vector<String>();
			
			// Add a few sample books to the list (these would normally come from a database).
			blist.addElement("Learn HTML5 and JavaScript for iOS. Scott Preston $39.99");
			blist.addElement("Java 7 for Absolute Beginners. Jay Bryant $39.99");
			blist.addElement("Beginning Android 4. Livingston $39.99");
			blist.addElement("Pro Spatial with SQL Server 2012. Alastair Aitchison $59.99");
			blist.addElement("Beginning Database Design. Clare Churcher $34.99");
			
			// Store the list of books in the session to make it available for subsequent requests.
			session.setAttribute("ebookshop.list", blist);
			
			// Get the servlet context (global application data/resources) and forward the request to the home page.
			ServletContext sc = req.getSession().getServletContext();
			RequestDispatcher rd = sc.getRequestDispatcher("/"); // forward slash means root of the application (homepage)
			rd.forward(req, res);
			
		} else {
			// If "do_this" is not null, perform actions related to either checkout or manipulating the cart.
			if (do_this.equals("checkout")) {
				
				// Check if the cart is null before proceeding.
				if (shoplist == null || shoplist.isEmpty()) {
					// Redirect to the shopping page if the cart is empty or null
					res.sendRedirect("/ebookshop/eshop");
					
				} else {
				
					// Initialize variables to store the total amount (dollars) and the number of books.
					float dollars = 0;
					int books = 0;
					
					// Loop through the items in the shopping cart and calculate the total cost and quantity.
					for (Book aBook : shoplist) {
						float price = aBook.getPrice();
						int qty = aBook.getQuantity();
						dollars += price * qty;
						books += qty;
					}
					
					// Precise Rounding for the total
					BigDecimal bD = new BigDecimal(Float.toString(dollars));
					bD = bD.setScale(2, RoundingMode.HALF_UP);
				
					// Concatenating variable books (int) with an empty string 
					// forces Java to treat it as a string. Then, store them as request attributes.
					req.setAttribute("dollars", bD.toPlainString());
					req.setAttribute("books", books + "");
					
					// Forward the request to the Checkout page.
					ServletContext sc = req.getSession().getServletContext();
					RequestDispatcher rd = sc.getRequestDispatcher("/Checkout.jsp");
					rd.forward(req, res);
				} // if (shoplist == null .. else
		
			} // if (..checkout..
			
			// If it is not a checkout request, it must be a request to manipulate the shopping cart (add or remove books).
			else {
				if (do_this.equals("remove")) {
					// Retrieve the position (index) of the book to be removed.
					String pos = req.getParameter("position");
					
					// prevents crashes when user refreshes page after removing item (Validates index)
					if (!shoplist.isEmpty() && Integer.parseInt(pos) >= 0 && Integer.parseInt(pos) < shoplist.size()) {
						// Remove the book from the shopping cart at the specified index.
						shoplist.removeElementAt(Integer.parseInt(pos));
					}
				}
				else if (do_this.equals("removeAll")) {
					// Remove all the books from the shopping cart.
					shoplist.clear();
				}
				else if (do_this.equals("add")) {
					// Flag to check if the book already exists in the cart.
					boolean found = false;
					// Get the book object from the request parameters.
					Book aBook = getBook(req);
					
					// If the shopping cart is empty (null), create a new one and add the book.
					if (shoplist == null) {
						shoplist = new Vector<Book>();
						shoplist.addElement(aBook);
					}
					else { // If the cart is not empty, check if the book is already in the cart.
						for (int i = 0; i < shoplist.size() && !found; i++) {
							Book b = (Book)shoplist.elementAt(i);
							
							// If the book is already in the cart, update its quantity.
							if (b.getTitle().equals(aBook.getTitle())) {
								b.setQuantity(b.getQuantity() + aBook.getQuantity());
								shoplist.setElementAt(b, i);
								found = true;
							}
						} // for (i..
						
						// If the book is not in the cart after looping through, add it as a new item.
						if (!found) {
							shoplist.addElement(aBook);
						}
					} // if (shoplist == null) .. else ..
				} // if (.. add ..
				
				// Save the updated shopping cart in the session
				session.setAttribute("ebookshop.cart", shoplist);
				
				// Get the servlet context and forward the request back to the home page.
				ServletContext sc = getServletContext();
				RequestDispatcher rd = sc.getRequestDispatcher("/");
				rd.forward(req, res);
			} // if (..checkout..else
		} // if (do_this..
	} // doPost
	
	/**
	 * Helper method to create a Book object from the request parameters.
	 * @param req (The HTTP request object).
	 * @return A Book object with title, price, and quantity based on the request parameters.
	 */
	private Book getBook(HttpServletRequest req) {
		// Retrieve the book details from the request parameter.
		String myBook = req.getParameter("book");
		int n = myBook.indexOf('$'); // Find the position of the '$' symbol in the string
		
		// Extract the book title (substring before the '$') and price (substring after the '$').
		String title = myBook.substring(0, n);
		String price = myBook.substring(n+1);
		
		// Get the quantity of the book from the request parameter.
		String qty = req.getParameter("qty");
		
		// Return a new Book object using the extracted details
		return new Book(title, Float.parseFloat(price), Integer.parseInt(qty));
	} // getBook
}