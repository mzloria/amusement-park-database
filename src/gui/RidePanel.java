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
 * The panel for adding a ticket.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class RidePanel extends AbstractPanel
{

	/** A generated serial version ID. */
	private static final long serialVersionUID = 6027327597081119359L;
	
	/**
	 * Constructs an new ride panel.
	 * 
	 * @param theConnection The connection needed to make queries.
	 * @param theTitle The title of the panel.
	 */
	public RidePanel(Connection theConnection, String theTitle)
	{
		super(theConnection, theTitle);
		setUpPanel(); 
	}
	
	@Override
	public void setUpFormPanel()
	{
		JPanel ridePanel = new JPanel();
        
        GridBagLayout layout = new GridBagLayout();
        layout.columnWidths = new int[] {150, 200};
        layout.rowHeights = new int[] {20, 20, 20, 20, 20, 20, 20};
        ridePanel.setLayout(layout);
        
        addJTextField("Ride ID:", new JTextField(), 1, ridePanel);
        addJTextField("Name:", new JTextField(), 2, ridePanel);
        addJTextField("Description:", new JTextField(), 3, ridePanel);
        addJTextField("Minimum Height: ", new JTextField(), 4, ridePanel);
        addJTextField("Duration: ", new JTextField(), 5, ridePanel);
        addJTextField("Maximum Capacity: ", new JTextField(), 6, ridePanel);
        addJTextField("Ride Type ID: ", new JTextField(), 7, ridePanel);
 
        add(ridePanel, BorderLayout.CENTER);
	}
	
	@Override
	public void setUpButtonPanel()
	{
		JPanel buttonHolder = new JPanel(new FlowLayout());
        buttonHolder.add(createSubmitButton());
        buttonHolder.add(addViewTableButton("View Ride", "[RIDE]", "Ride Table"));
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
	            		SQL = "INSERT INTO [dbo].[RIDE] VALUES (" + generateRide() + ")";
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
	 * Ride table.
	 * 
	 * @return String that will be used in the SQL statement.
	 */
	public String generateRide()
	{
		String temp = "";
		// Ride ID
		temp = temp + Integer.parseInt(myTextFields.get(0).getText()) + ", ";
		// Name
		temp = temp + "'" + myTextFields.get(1).getText() + "', ";
		// Description
		temp = temp + "'" + myTextFields.get(2).getText() + "', ";
		// Minimum Height
		temp = temp + Integer.parseInt(myTextFields.get(3).getText()) + ", ";
		// Duration
		temp = temp + Integer.parseInt(myTextFields.get(4).getText()) + ", ";
		// Maximum Capacity
		temp = temp + Integer.parseInt(myTextFields.get(5).getText()) + ", ";
		// Ride Type ID
		temp = temp + Integer.parseInt(myTextFields.get(6).getText());
		return temp;
	}
}
