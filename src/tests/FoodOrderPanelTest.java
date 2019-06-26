/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package tests;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import gui.FoodOrderPanel;

/**
 * This contains tests of the FoodOrderPanel class.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class FoodOrderPanelTest 
{
	/** The panel that will be used in the tests. */
	private FoodOrderPanel myPanel;

    /**
     * This is the method that initializes the panel before each test.
     */
	@Before
	public void setUp()
	{
		myPanel = new FoodOrderPanel(null, "");
	}

	/**
     * Test method one for generateFoodOrderUpdate().
     */
	@Test
	public final void testGenerateFoodOrder1() {
		String temp = "'06-01-19', '19:02', 1, 2";
		myPanel.myTextFields.get(0).setText("06-01-19");
		myPanel.myTextFields.get(1).setText("19:02");
		myPanel.myTextFields.get(2).setText("1");
		myPanel.myTextFields.get(3).setText("2");
		assertEquals(temp, myPanel.generateFoodOrderUpdate());
	}
	
	/**
     * Test method two for generateFoodOrderUpdate().
     */
	@Test
	public final void testGenerateFoodOrder2() {
		String temp = "'06-10-19', '20:00', 3, 23";
		myPanel.myTextFields.get(0).setText("06-10-19");
		myPanel.myTextFields.get(1).setText("20:00");
		myPanel.myTextFields.get(2).setText("3");
		myPanel.myTextFields.get(3).setText("23");
		assertEquals(temp, myPanel.generateFoodOrderUpdate());
	}
	
	/**
     * Test method three for generateFoodOrderUpdate().
     */
	@Test
	public final void testGenerateFoodOrder3() {
		String temp = "'07-01-18', '11:02', 11, 4";
		myPanel.myTextFields.get(0).setText("07-01-18");
		myPanel.myTextFields.get(1).setText("11:02");
		myPanel.myTextFields.get(2).setText("11");
		myPanel.myTextFields.get(3).setText("4");
		assertEquals(temp, myPanel.generateFoodOrderUpdate());
	}


}
