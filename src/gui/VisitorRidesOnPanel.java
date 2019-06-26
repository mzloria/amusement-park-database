/*
 * TCSS 445 Spring 2019
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

import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;

/**
 * The panel for adding a ride for a visitor.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class VisitorRidesOnPanel extends AbstractPanel
{

	/** A generated serial version ID. */
	private static final long serialVersionUID = 6027327597081119359L;
	
	/**
	 * Constructs an new ticket panel.
	 * 
	 * @param theConnection The connection needed to make queries.
	 * @param theTitle The title of the panel.
	 */
	public VisitorRidesOnPanel(Connection theConnection, String theTitle)
	{
		super(theConnection, theTitle);
		setUpPanel(); 
	}
	
	@Override
	public void setUpFormPanel()
	{
		JPanel visitorRidesOnFormPanel = new JPanel();
        
        GridBagLayout layout = new GridBagLayout();
        layout.columnWidths = new int[] {150, 200};
        layout.rowHeights = new int[] {20, 20};
        visitorRidesOnFormPanel.setLayout(layout);
        
        addJTextField("Visitor ID:", new JTextField(), 1, visitorRidesOnFormPanel);
        addJTextField("Ride Cycle ID:", new JTextField(), 2, visitorRidesOnFormPanel);
 
        add(visitorRidesOnFormPanel, BorderLayout.CENTER);
	}
	
	@Override
	public void setUpButtonPanel()
	{
		JPanel buttonHolder = new JPanel(new FlowLayout());
        buttonHolder.add(createSubmitButton());
        buttonHolder.add(addViewTableButton("View Rides On", "[RIDES_ON]", "Rides Visitor Has Rode On Table"));
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
	            		SQL = "INSERT INTO [dbo].[RIDES_ON] VALUES (" + generateRidesOn() + ")";
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
	 * Rides On table.
	 * 
	 * @return String that will be used in the SQL statement.
	 */
	public String generateRidesOn()
	{
		String temp = "";
		// Visitor ID
		temp = temp + Integer.parseInt(myTextFields.get(0).getText()) + ", ";
		// Ride Cycle ID
		temp = temp + Integer.parseInt(myTextFields.get(1).getText());
		return temp;
	}
}
