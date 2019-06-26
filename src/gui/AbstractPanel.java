/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package gui;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Vector;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;

/**
 * The panel for adding a visitor.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public abstract class AbstractPanel extends JPanel implements Panel
{
	/** A generated serial version ID. */
	private static final long serialVersionUID = -6839035325525786543L;

	/** The connection needed to connect to the database. */
	protected final Connection myConnection;
	
	/** The array list of text fields for the panel. */
	public final ArrayList<JTextField> myTextFields;
	
	/** The title that is used for the panel. */
	private final String myTitle;

	/**
	 * The constructor that initializes the connection
	 * and the title. 
	 * 
	 * @param theConnection The connection used to connect to the database.
	 * @param theTitle The title of the panel.
	 */
	public AbstractPanel(Connection theConnection, String theTitle)
	{
		myConnection = theConnection;
		myTitle = theTitle;
		myTextFields = new ArrayList<JTextField>();
	}
	
	@Override
	public void setUpPanel()
	{
		setLayout(new BorderLayout());
		setBorder(BorderFactory.createEmptyBorder(0,10,10,10));
		
        JLabel title = new JLabel(myTitle);
        title.setHorizontalAlignment(JLabel.CENTER);
        add(title, BorderLayout.NORTH);
        
        setUpFormPanel();
        setUpButtonPanel();
	}
	
	@Override
    public void addJTextField(String theLabelText, JTextField theTextField, int theY, Container theContainingPanel) 
    {
    	myTextFields.add(theTextField);
    	
        JLabel label = new JLabel(theLabelText);
        GridBagConstraints labelConstraints = new GridBagConstraints();
        labelConstraints.fill = GridBagConstraints.BOTH;
        labelConstraints.insets = new Insets(0, 0, 5, 5);
        labelConstraints.gridx = 0;
        labelConstraints.gridy = theY;
        theContainingPanel.add(label, labelConstraints);

        GridBagConstraints textConstraints = new GridBagConstraints();
        textConstraints.fill = GridBagConstraints.BOTH;
        textConstraints.insets = new Insets(0, 0, 5, 0);
        textConstraints.gridx = 1;
        textConstraints.gridy = theY;
        theContainingPanel.add(theTextField, textConstraints);
        theTextField.setColumns(10);
    }
    
	@Override
    public void addJLabel(String theLabelText, int theY, Container theContainingPanel) 
    {    	
        JLabel label = new JLabel(theLabelText);
        GridBagConstraints labelConstraints = new GridBagConstraints();
        labelConstraints.fill = GridBagConstraints.BOTH;
        labelConstraints.insets = new Insets(5, 0, 10, 0);
        labelConstraints.gridx = 0;
        labelConstraints.gridy = theY;
        labelConstraints.gridwidth = 2;
        theContainingPanel.add(label, labelConstraints);
    }
    
	@Override
    public JButton addViewTableButton(String theButtonText, String theTable, String theTitle)
    {
        JButton viewTable = new JButton(theButtonText);
        viewTable.setPreferredSize(new Dimension(140,30));
        viewTable.addActionListener(new ActionListener() {
    		public void actionPerformed(ActionEvent arg0)
    		{    		
				try 
				{
            		String SQL = "SELECT * FROM [dbo]." + theTable;
            		Statement stmt = myConnection.createStatement();
            		ResultSet resultSet = stmt.executeQuery(SQL);
            		JTable myJTable = new JTable(createTableModel(resultSet));	            		
            		JOptionPane.showMessageDialog(null, new JScrollPane(myJTable), theTitle, 
            				JOptionPane.PLAIN_MESSAGE);
				}
				catch (Exception e) 
	        	{
					JOptionPane.showMessageDialog(null, "Error Retrieving Data. Please try again.", 
							"Error Retrieving Data", JOptionPane.WARNING_MESSAGE);
				}
    		}
        });
        return viewTable;     
    }
    
	@Override
    public DefaultTableModel createTableModel(ResultSet theResultSet) throws SQLException 
    {
        ResultSetMetaData metaData = theResultSet.getMetaData();
        Vector<String> columnNames = new Vector<String>();
        int columnCount = metaData.getColumnCount();
        for (int column = 1; column <= columnCount; column++) {
            columnNames.add(metaData.getColumnName(column));
        }

        Vector<Vector<Object>> tableData = new Vector<Vector<Object>>();
        while (theResultSet.next()) {
            Vector<Object> vector = new Vector<Object>();
            for (int columnIndex = 1; columnIndex <= columnCount; columnIndex++) {
                vector.add(theResultSet.getObject(columnIndex));
            }
            tableData.add(vector);
        }
        return new DefaultTableModel(tableData, columnNames);
    }
}
