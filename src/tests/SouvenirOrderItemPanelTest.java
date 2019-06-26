/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package tests;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import gui.SouvenirOrderItemPanel;

/**
 * This contains tests of the SouvenirOrderItemPanel class.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class SouvenirOrderItemPanelTest 
{
	/** The panel that will be used in the tests. */
	private SouvenirOrderItemPanel myPanel;

    /**
     * This is the method that initializes the panel before each test.
     */
	@Before
	public void setUp()
	{
		myPanel = new SouvenirOrderItemPanel(null, "");
	}

	/**
     * Test method one for generateSouvenirOrderItem().
     */
	@Test
	public final void testGenerateSouvenirOrderItem1() {
		String temp = "1, 2, 3";
		myPanel.myTextFields.get(0).setText("1");
		myPanel.myTextFields.get(1).setText("2");
		myPanel.myTextFields.get(2).setText("3");
		assertEquals(temp, myPanel.generateSouvenirOrderItem());
	}
	
	/**
     * Test method two for generateSouvenirOrderItem().
     */
	@Test
	public final void testGenerateSouvenirOrderItem2() {
		String temp = "20, 40, 1";
		myPanel.myTextFields.get(0).setText("20");
		myPanel.myTextFields.get(1).setText("40");
		myPanel.myTextFields.get(2).setText("1");
		assertEquals(temp, myPanel.generateSouvenirOrderItem());
	}
	
	/**
     * Test method three for generateSouvenirOrderItem().
     */
	@Test
	public final void testGenerateSouvenirOrderItem3() {
		String temp = "10, 25, 29";
		myPanel.myTextFields.get(0).setText("10");
		myPanel.myTextFields.get(1).setText("25");
		myPanel.myTextFields.get(2).setText("29");
		assertEquals(temp, myPanel.generateSouvenirOrderItem());
	}
}
