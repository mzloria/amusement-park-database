/*
 * Amusement Park Database
 */

package gui;

import java.awt.Container;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JButton;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;

/**
 * An interface for the panels used for querying
 * data and adding data to the amusement park
 * database.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public interface Panel
{
	/**
	 * Sets up the main panel.
	 */
	void setUpPanel();
	
	/**
	 * Sets up the panel that contains the form,
	 * which contains buttons and text fields.
	 */
	void setUpFormPanel();
	
	/** 
	 * Sets up the panel that contains the submit
	 * and view buttons.
	 */
	void setUpButtonPanel();

	/**
	 * Adds a text field to the correct location
	 * in the correct panel. 
	 * 
	 * @param theLabelText The text that is used for the label of the text field.
	 * @param theTextField The JTextField that will be added to the panel.
	 * @param theY The y location of text field.
	 * @param theContainingPanel The panel where the JTextField will be added.
	 */
	void addJTextField(String theLabelText, JTextField theTextField, int theY, Container theContainingPanel);

	/**
	 * Adds a label to the correct location
	 * in the correct panel. 
	 * 
	 * @param theLabelText The text that is used for the JLabel.
	 * @param theY The y location of JLabel.
	 * @param theContainingPanel The panel where the JLabel will be added.
	 */
	void addJLabel(String theLabelText, int theY, Container theContainingPanel);

	/**
	 * Generates the a submit button that
	 * updates the tables as necessary with
	 * the data entered in the JTextFields.
	 * 
	 * @return The submit button performs the proper actions.
	 */
	JButton createSubmitButton();

	/**
	 * Adds a button that allows the user to 
	 * view a specific table.
	 * 
	 * @param theButtonText The text placed on the button.
	 * @param theTable The table that we will be querying from.
	 * @param theTitle The title for the JOptionPane of the table.
	 * @return The button that performs the proper actions and displays the corresponding table.
	 */
	JButton addViewTableButton(String theButtonText, String theTable, String theTitle);
	
	/**
	 * Creates the table model based on the 
	 * resulting set of the update statement.
	 * 
	 * @param theResultSet The set that will be used to generate the table.
	 * @return The table model used to create the table.
	 * @throws SQLException SQLException for the result set.
	 */
	DefaultTableModel createTableModel(ResultSet theResultSet) throws SQLException;
}
