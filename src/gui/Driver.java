/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package gui;

import java.awt.EventQueue;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.swing.JOptionPane;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

/**
 * This class starts the application
 * for the database application.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public final class Driver
{
    /**
     * This is a private constructor to prevent
     * external instantiation.
     */
    private Driver()
    {
        throw new IllegalStateException();
    }

    /**
     * This method sets the look and feel of the
     * graphical user interface.
     */
    private static void setLookAndFeel()
    {
        try
        {
        	UIManager.setLookAndFeel("javax.swing.plaf.nimbus.NimbusLookAndFeel");
        }
        catch (final UnsupportedLookAndFeelException e)
        {
            System.out.println("UnsupportedLookAndFeelException");
        }
        catch (final ClassNotFoundException e)
        {
            System.out.println("ClassNotFoundException");
        }
        catch (final InstantiationException e)
        {
            System.out.println("InstantiationException");
        }
        catch (final IllegalAccessException e)
        {
            System.out.println("IllegalAccessException");
        }
    }

    /**
     * This main method starts the program, and also opens the
     * connection to the database. 
     * 
     * @param theArgs Command line arguments.
     */
    public static void main(final String[] theArgs)
    {
        EventQueue.invokeLater(new Runnable()
        {
            @Override
            public void run()
            {
            	String connectionUrl = "jdbc:sqlserver://localhost:1433;" +
						"databaseName=Loria_Michael_db;integratedSecurity=true";
    			Connection con = null;
            	try 
            	{
	        		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	            	con = DriverManager.getConnection(connectionUrl);
                    setLookAndFeel();
                    new GUI(con).start();
            	}
				catch (Exception e) 
	        	{
                    setLookAndFeel();
					new GUI(null).start();
					JOptionPane.showMessageDialog(null,  "Error connecting to database. Please ensure connection URL is\n"
							+ "correct. Viewing tables and submitting entries will not work.", 
							"Error Connecting to Database", JOptionPane.ERROR_MESSAGE);
				}
            }
        });
    }
}