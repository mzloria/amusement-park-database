/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package tests;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import gui.SouvenirOrderPanel;

/**
 * This contains tests of the SouvenirOrderPanel class.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class SouvenirOrderPanelTest 
{
	/** The panel that will be used in the tests. */
	private SouvenirOrderPanel myPanel;

    /**
     * This is the method that initializes the panel before each test.
     */
	@Before
	public void setUp()
	{
		myPanel = new SouvenirOrderPanel(null, "");
	}

	/**
     * Test method one for generateSouvenirOrderUpdate().
     */
	@Test
	public final void testGenerateSouvenirOrderUpdate1() {
		String temp = "'12-10-18', '20:00', 3, 23";
		myPanel.myTextFields.get(0).setText("12-10-18");
		myPanel.myTextFields.get(1).setText("20:00");
		myPanel.myTextFields.get(2).setText("3");
		myPanel.myTextFields.get(3).setText("23");
		assertEquals(temp, myPanel.generateSouvenirOrderUpdate());
	}
	
	/**
     * Test method two for generateSouvenirOrderUpdate().
     */
	@Test
	public final void testGenerateSouvenirOrderUpdate2() {
		String temp = "'08-01-19', '11:02', 10, 2";
		myPanel.myTextFields.get(0).setText("08-01-19");
		myPanel.myTextFields.get(1).setText("11:02");
		myPanel.myTextFields.get(2).setText("10");
		myPanel.myTextFields.get(3).setText("2");
		assertEquals(temp, myPanel.generateSouvenirOrderUpdate());
	}
	
	/**
     * Test method three for generateSouvenirOrderUpdate().
     */
	@Test
	public final void testGenerateSouvenirOrderUpdate3() {
		String temp = "'10-01-18', '4:02', 5, 1";
		myPanel.myTextFields.get(0).setText("10-01-18");
		myPanel.myTextFields.get(1).setText("4:02");
		myPanel.myTextFields.get(2).setText("5");
		myPanel.myTextFields.get(3).setText("1");
		assertEquals(temp, myPanel.generateSouvenirOrderUpdate());
	}
}
