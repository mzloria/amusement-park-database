/*
 * Amusement Park Database
 */

package gui;

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.sql.Connection;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JPanel;

/**
 * The graphical user interface for Amusement Park program.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 *
 */
public final class GUI implements ItemListener
{
        
    /** The frame for the paint program. */
    private final JFrame myFrame;
    
    /** The panel that contains the cards. */
    private final JPanel myCards;
    
    /** The panel that contains the combo box. */
    private final JPanel myComboBoxPanel;
    
    /** The panel adding a visitor. */
    private final JPanel myVisitorPanel;
    
    /** The panel for adding a ticket for a visitor. */
    private final JPanel myTicketPanel;
    
    /** The panel for adding a ride for a visitor. */
    private final JPanel myVisitorRidesOnPanel;
    
    /** The panel for adding a souvenir order. */
    private final JPanel mySouvenirOrderPanel;
    
    /** The panel for adding a souvenir order item. */
    private final JPanel mySouvenirOrderItemPanel;
    
    /** The panel for adding a food order. */
    private final JPanel myFoodOrderPanel;
    
    /** The panel for adding a food order item. */
    private final JPanel myFoodOrderItemPanel;
    
    /** The panel for adding a food. */
    private final JPanel myFoodPanel;
    
    /** The panel for adding a souvenir. */
    private final JPanel mySouvenirPanel;
    
    /** The panel for adding a ride. */
    private final JPanel myRidePanel;
    
    /** The panel for adding a show. */
    private final JPanel myShowPanel;
    
    /** The connection needed to connect to the database. */
    private final Connection myConnection;
    
    /** The string label for amusement park. */
    private static final String AMUSEMENT_PARK = "Amusement Park: ";
    
    /** The string label for the add visitor tab. */
    private static final String ADD_VISITOR = "Add a Visitor";
    
    /** The string label for the visitor tickets tab. */
    private static final String ADD_TICKET = "Add a Ticket";
    
    /** The string label for the visitor tickets tab. */
    private static final String ADD_VISITOR_RIDES_ON = "Add a Ride for Visitor";
    
    /** The string label for the souvenir order tab. */
    private static final String ADD_SOUVENIR_ORDER = "Add a Souvenir Order";
    
    /** The string label for the souvenir order tab. */
    private static final String ADD_SOUVENIR_ORDER_ITEM = "Add a Souvenir Order Item";
    
    /** The string label for the food order tab. */
    private static final String ADD_FOOD_ORDER = "Add a Food Order";
    
    /** The string label for the food order tab. */
    private static final String ADD_FOOD_ORDER_ITEM = "Add a Food Order Item";
    
    /** The string label for the food tab. */
    private static final String ADD_FOOD = "Add Food";
    
    /** The string label for the souvenir tab. */
    private static final String ADD_SOUVENIR = "Add Souvenir";
    
    /** The string label for the ride tab. */
    private static final String ADD_RIDE = "Add Ride";
    
    /** The string label for the show tab. */
    private static final String ADD_SHOW = "Add Show";

    /**
     * Initializes the fields of the GUI
     * 
     * @theConnection The connection needed to connect to the database.
     */
    public GUI(Connection theConnection)
    {
    	myConnection = theConnection;
        myFrame = new JFrame("Amusement Park Database");
        myVisitorPanel = new VisitorPanel(theConnection, AMUSEMENT_PARK + ADD_VISITOR);
        myTicketPanel = new TicketPanel(theConnection, AMUSEMENT_PARK + ADD_TICKET);
        myVisitorRidesOnPanel = new VisitorRidesOnPanel(theConnection, AMUSEMENT_PARK + ADD_VISITOR_RIDES_ON);
        mySouvenirOrderPanel = new SouvenirOrderPanel(theConnection, AMUSEMENT_PARK + ADD_SOUVENIR_ORDER);
        mySouvenirOrderItemPanel = new SouvenirOrderItemPanel(theConnection, AMUSEMENT_PARK + ADD_SOUVENIR_ORDER_ITEM);
        myFoodOrderPanel = new FoodOrderPanel(theConnection, AMUSEMENT_PARK + ADD_FOOD_ORDER);
        myFoodOrderItemPanel = new FoodOrderItemPanel(theConnection, AMUSEMENT_PARK + ADD_FOOD_ORDER_ITEM);
        myFoodPanel = new FoodPanel(theConnection, AMUSEMENT_PARK + ADD_FOOD);
        mySouvenirPanel = new SouvenirPanel(theConnection, AMUSEMENT_PARK + ADD_SOUVENIR);
        myRidePanel = new RidePanel(theConnection, AMUSEMENT_PARK + ADD_RIDE);
        myShowPanel = new ShowPanel(theConnection, AMUSEMENT_PARK + ADD_SHOW);
        myCards = new JPanel(new CardLayout());
        myComboBoxPanel = new JPanel();
    }

    /**
     * Properly lays out the components of the GUI and displays
     * the GUI on the screen.
     */
    public void start()
    {           	   
        myFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        myFrame.setSize(500, 400);
        myFrame.setResizable(false);
        
        myFrame.addWindowListener(new WindowAdapter()
        {
            @Override
            public void windowClosing(WindowEvent e)
            {
                super.windowClosing(e);
        	    try
        	    {
        	    	myConnection.close();
                    System.out.println("Connection to database has been closed successfully.");
        	    } 
        	    catch (Exception exception) 
        	    { 
        	    	System.out.println("Connection was not closed successfully.");
    	    	}
                
            }
        });
        
        addPanelsToCards();
                
        myFrame.add(myComboBoxPanel, BorderLayout.PAGE_START);
        myFrame.add(myCards, BorderLayout.CENTER);
        
        myFrame.setLocationRelativeTo(null);
        myFrame.setVisible(true);
    }
    
    private void addPanelsToCards()
    {
        String comboBoxItems[] = {ADD_VISITOR, ADD_TICKET, ADD_VISITOR_RIDES_ON,
        		ADD_SOUVENIR_ORDER, ADD_SOUVENIR_ORDER_ITEM, ADD_FOOD_ORDER,
        		ADD_FOOD_ORDER_ITEM, ADD_FOOD, ADD_SOUVENIR, ADD_RIDE, ADD_SHOW};
        JComboBox<String> comboBox = new JComboBox<String>(comboBoxItems);
        comboBox.setEditable(false);
        comboBox.addItemListener(this);
        myComboBoxPanel.add(comboBox);
        
        myCards.add(myVisitorPanel, ADD_VISITOR);
        myCards.add(myTicketPanel, ADD_TICKET);
        myCards.add(myVisitorRidesOnPanel, ADD_VISITOR_RIDES_ON);
        myCards.add(mySouvenirOrderPanel, ADD_SOUVENIR_ORDER);
        myCards.add(mySouvenirOrderItemPanel, ADD_SOUVENIR_ORDER_ITEM);
        myCards.add(myFoodOrderPanel, ADD_FOOD_ORDER);
        myCards.add(myFoodOrderItemPanel, ADD_FOOD_ORDER_ITEM);
        myCards.add(myFoodPanel, ADD_FOOD);
        myCards.add(mySouvenirPanel, ADD_SOUVENIR);
        myCards.add(myRidePanel, ADD_RIDE);
        myCards.add(myShowPanel, ADD_SHOW);
    }
    
    @Override
    public void itemStateChanged(ItemEvent evt) 
    {
        CardLayout cl = (CardLayout)(myCards.getLayout());
        cl.show(myCards, (String)evt.getItem());
    }
}
