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
 * The panel for adding a visitor.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class VisitorPanel extends AbstractPanel
{

	/** A generated serial version ID. */
	private static final long serialVersionUID = 6027327597081119359L;
	
	/**
	 * Constructs an new visitor panel.
	 * 
	 * @param theConnection The connection needed to make queries.
	 * @param theTitle THe title of the panel.
	 */
	public VisitorPanel(Connection theConnection, String theTitle)
	{
		super(theConnection, theTitle);
		setUpPanel(); 
	}
	
	@Override
	public void setUpFormPanel()
	{
		JPanel visitorFormPanel = new JPanel();
        
        GridBagLayout layout = new GridBagLayout();
        layout.columnWidths = new int[] {150, 200};
        layout.rowHeights = new int[] {20, 20, 20, 20, 20, 20, 20};
        visitorFormPanel.setLayout(layout);
        
        addJTextField("First Name:", new JTextField(), 1, visitorFormPanel);
        addJTextField("Last Name:", new JTextField(), 2, visitorFormPanel);
        addJTextField("Height:", new JTextField(), 3, visitorFormPanel);
        addJTextField("Age:", new JTextField(), 4, visitorFormPanel);
        addJLabel("If applicable, please enter the information below.", 5, visitorFormPanel);
        addJTextField("License Plate Number:", new JTextField(), 6, visitorFormPanel);
        addJTextField("Parking Garage ID:", new JTextField(), 7, visitorFormPanel);
 
        add(visitorFormPanel, BorderLayout.CENTER);
	}
	
	@Override
	public void setUpButtonPanel()
	{
		JPanel buttonHolder = new JPanel(new FlowLayout());
        buttonHolder.add(createSubmitButton());
        buttonHolder.add(addViewTableButton("View Visitors", "[VISITOR]", "Visitor Table"));
        buttonHolder.add(addViewTableButton("View Vehicles", "[VEHICLE]", "Vehicle Table"));
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
		        		// Case Where We Only Update Visitors
		        		String SQL;
		        		if(myTextFields.get(4).getText().isEmpty() && 
		        				myTextFields.get(5).getText().isEmpty())
		        		{
		            		SQL = "INSERT INTO [dbo].[VISITOR] VALUES ("
		            				+ generateVisitorUpdateOnly() + "null)";
		            		Statement stmt = myConnection.createStatement();
		            		stmt.executeUpdate(SQL);  
		        		}
		        		
		        		// Case Where We Update Both Visitors and Vehicle
		        		else
		        		{
		        			// Update Vehicle Table First
		        			Statement stmt = null;
		            		SQL = "INSERT INTO [dbo].[VEHICLE] VALUES ("
		            				+ generateVehicleUpdate() + ")";
		            		stmt = myConnection.createStatement();
		            		stmt.executeUpdate(SQL);  
		        			// Update Visitor Table Second
		            		SQL = "INSERT INTO [dbo].[VISITOR] VALUES ("
		            				+ generateVisitorUpdateOnly() + "'" +
		            				myTextFields.get(4).getText() + "')";
		            		stmt = myConnection.createStatement();
		            		stmt.executeUpdate(SQL); 
		        		}
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
	 * Visitor table.
	 * 
	 * @return String that will be used in the SQL statement.
	 */
	public String generateVisitorUpdateOnly()
	{
		String temp = "";
		// First Name
		if(myTextFields.get(0).getText().length() > 30)
		{
			temp = temp + "'" + myTextFields.get(0).getText().substring(0,30) + "', ";
		}
		else
		{
			temp = temp + "'" + myTextFields.get(0).getText() + "', ";
		}
		// Last Name
		if(myTextFields.get(1).getText().length() > 20)
		{
			temp = temp + "'" + myTextFields.get(1).getText().substring(0,20) + "', ";
		}
		else
		{
			temp = temp + "'" + myTextFields.get(1).getText() + "', ";
		}
		// Height
		temp = temp + Integer.parseInt(myTextFields.get(2).getText()) + ", ";
		// Age
		temp = temp + Integer.parseInt(myTextFields.get(3).getText()) + ", ";
		return temp;
	}
	
	/**
	 * Generates the string to update the 
	 * Vehicle table.
	 * 
	 * @return String that will be used in the SQL statement.
	 */
	public String generateVehicleUpdate()
	{
		String temp = "";
		// License Plate
		temp = temp + "'" + myTextFields.get(4).getText() + "', ";
		// Parking Garage ID
		temp = temp + Integer.parseInt(myTextFields.get(5).getText());
		return temp;
	}
}
