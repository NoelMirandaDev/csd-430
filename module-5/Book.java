package ebookshop;

public class Book {
	// Declared attributes
	String title;
	float price;
	int quantity;
	
	// public constructor
	public Book(String t, float p, int q) {
		title = t;
		price = p;
		quantity = q;
	}
	
	// Getter and setter methods
	public String getTitle() { return title; }
	public void setTitle(String t) { title = t; }
	
	public float getPrice() { return price; }
	public void setPrice(float p) { price = p; }
	
	public int getQuantity() { return quantity; }
	public void setQuantity(int q) { quantity = q; }
	
	
	// To String method
	@Override
	public String toString() {
		return (title + " $" + price + " " + quantity);
	}
	
	/* Testing purposes only 
	public static void main(String[] args) {
		Book test1 = new Book("Cat in the hat", 34.99f, 1);
		
		System.out.println("Title: " + test1.getTitle() + "\n" + 
							"Price: $" + test1.getPrice() + "\n" + 
							"Quantity: " + test1.getQuantity() + "\n");
		
		
		test1.setPrice(99.99f);
		test1.setQuantity(100);
		test1.setTitle("Cat in the Hat Version 2");
		
		System.out.println("Title: " + test1.getTitle() + "\n" + 
				"Price: $" + test1.getPrice() + "\n" + 
				"Quantity: " + test1.getQuantity() + "\n");
		
		test1.setPrice(50.99f);
		test1.setQuantity(5);
		test1.setTitle("Cat in the Hat Version 3");
		
		System.out.println(test1);
	}
	*/

}
