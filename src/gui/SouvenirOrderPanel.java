/*
 * Amusement Park Database
 */

package gui;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;

/**
 * The panel for adding a souvenir order.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class SouvenirOrderPanel extends AbstractPanel
{

	/** A generated serial version ID. */
	private static final long serialVersionUID = 6027327597081119359L;
	
    /** The local date. */
    private final LocalDateTime myTime; 
    
    
    /** The date formatter used for inputting the date. */
    private static final DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd"); 
    
    /** The time formatter used for inputting the time. */
    private static final DateTimeFormatter TIME_FORMAT = DateTimeFormatter.ofPattern("HH:mm:ss"); 
	
	/**
	 * Constructs an new ticket panel.
	 * 
	 * @param theConnection The connection needed to make queries.
	 * @param theTitle The title of the panel.
	 */
	public SouvenirOrderPanel(Connection theConnection, String theTitle)
	{
		super(theConnection, theTitle);
		myTime = LocalDateTime.now(); 
		setUpPanel(); 
	}
	
	@Override
	public void setUpFormPanel()
	{
		JPanel souvenirOrderFormPanel = new JPanel();
        
        GridBagLayout layout = new GridBagLayout();
        layout.columnWidths = new int[] {150, 200};
        layout.rowHeights = new int[] {20, 20, 20, 20};
        souvenirOrderFormPanel.setLayout(layout);
        
        addJTextField("Date: ", new JTextField(DATE_FORMAT.format(myTime)), 1, souvenirOrderFormPanel);
        addJTextField("Time:", new JTextField(TIME_FORMAT.format(myTime)), 2, souvenirOrderFormPanel);
        addJTextField("Visitor ID:", new JTextField(), 3, souvenirOrderFormPanel);
        addJTextField("Souvenir Shop ID: ", new JTextField(), 4, souvenirOrderFormPanel);
 
        add(souvenirOrderFormPanel, BorderLayout.CENTER);
	}
	
	@Override
	public void setUpButtonPanel()
	{
		JPanel buttonHolder = new JPanel(new FlowLayout());
        buttonHolder.add(createSubmitButton());
        buttonHolder.add(addViewTableButton("View Souvenir Orders", "[SOUVENIR_ORDER]", "Souvenir Order Table"));
        add(buttonHolder, BorderLayout.SOUTH);
	}
	
	@Override
	public JButton createSubmitButton()
	{
        JButton submitButton = new JButton("Submit Entry");
        submitButton.setPreferredSize(new Dimension(110,30));
        
        submitButton.addActionListener(new ActionListener() {
        		public void actionPerformed(ActionEvent arg0)
        		{
		        	try 
		        	{
		        		String SQL;
	            		SQL = "INSERT INTO [dbo].[SOUVENIR_ORDER] VALUES (" + generateSouvenirOrderUpdate() + ")";
	            		Statement stmt = myConnection.createStatement();
	            		stmt.executeUpdate(SQL);  
		        		
			        	for(JTextField j: myTextFields)
			        	{
		        			j.setText(null);
		        		}
	        			JOptionPane.showMessageDialog(null, "Update Complete!");
		        	}
	    			catch (Exception e) 
		        	{
	        			JOptionPane.showMessageDialog(null, "Error: One or more required fields are missing, "
	        					+ "the input is invalid, \nor the string length is too long. Please try again.");
		        	}
        		}
        });
      	return submitButton;
	}
	
	/**
	 * Generates the string to update the 
	 * Ticket table.
	 * 
	 * @return String that will be used in the SQL statement.
	 */
	public String generateSouvenirOrderUpdate()
	{
		String temp = "";
		// Date
		temp = temp + "'" + myTextFields.get(0).getText() + "', ";
		// Time
		temp = temp + "'" + myTextFields.get(1).getText() + "', ";
		// Visitor ID
		temp = temp + Integer.parseInt(myTextFields.get(2).getText()) + ", ";
		// Souvenir Shop ID
		temp = temp + Integer.parseInt(myTextFields.get(3).getText());
		return temp;
	}
}
