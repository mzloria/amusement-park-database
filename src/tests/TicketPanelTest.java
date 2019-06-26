/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package tests;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import gui.TicketPanel;

/**
 * This contains tests of the TicketPanel class.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class TicketPanelTest 
{
	/** The panel that will be used in the tests. */
	private TicketPanel myPanel;

    /**
     * This is the method that initializes the panel before each test.
     */
	@Before
	public void setUp()
	{
		myPanel = new TicketPanel(null, "");
	}

	/**
     * Test method one for generateTicketUpdate().
     */
	@Test
	public final void testGenerateTicketUpdate1() {
		String temp = "'06-09-18', '06-09-18', 1, 2";
		myPanel.myTextFields.get(2).setText("06-09-18");
		myPanel.myTextFields.get(3).setText("06-09-18");
		myPanel.myTextFields.get(1).setText("1");
		myPanel.myTextFields.get(0).setText("2");
		assertEquals(temp, myPanel.generateTicketUpdate());
	}
	
	/**
     * Test method two for generateTicketUpdate().
     */
	@Test
	public final void testGenerateTicketUpdate2() {
		String temp = "'04-09-19', '12-09-19', 100, 12";
		myPanel.myTextFields.get(2).setText("04-09-19");
		myPanel.myTextFields.get(3).setText("12-09-19");
		myPanel.myTextFields.get(1).setText("100");
		myPanel.myTextFields.get(0).setText("12");
		assertEquals(temp, myPanel.generateTicketUpdate());
	}
	
	/**
     * Test method three for generateTicketUpdate().
     */
	@Test
	public final void testGenerateTicketUpdate3() {
		String temp = "'08-19-18', '08-19-19', 4, 10";
		myPanel.myTextFields.get(2).setText("08-19-18");
		myPanel.myTextFields.get(3).setText("08-19-19");
		myPanel.myTextFields.get(1).setText("4");
		myPanel.myTextFields.get(0).setText("10");
		assertEquals(temp, myPanel.generateTicketUpdate());
	}
}
