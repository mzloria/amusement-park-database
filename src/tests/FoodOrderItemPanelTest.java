/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package tests;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import gui.FoodOrderItemPanel;

/**
 * This contains tests of the FoodOrderItemPanel class.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class FoodOrderItemPanelTest 
{
	/** The panel that will be used in the tests. */
	private FoodOrderItemPanel myPanel;

    /**
     * This is the method that initializes the panel before each test.
     */
	@Before
	public void setUp()
	{
		myPanel = new FoodOrderItemPanel(null, "");
	}

	/**
     * Test method one for generateFoodOrderItem().
     */
	@Test
	public final void testGenerateFoodOrderItem1() {
		String temp = "1, 1, 1";
		myPanel.myTextFields.get(0).setText("1");
		myPanel.myTextFields.get(1).setText("1");
		myPanel.myTextFields.get(2).setText("1");
		assertEquals(temp, myPanel.generateFoodOrderItem());
	}
	
	/**
     * Test method two for generateFoodOrderItem().
     */
	@Test
	public final void testGenerateFoodOrderItem2() {
		String temp = "44, 2, 3";
		myPanel.myTextFields.get(0).setText("2");
		myPanel.myTextFields.get(1).setText("44");
		myPanel.myTextFields.get(2).setText("3");
		assertEquals(temp, myPanel.generateFoodOrderItem());
	}
	
	/**
     * Test method three for generateFoodOrderItem().
     */
	@Test
	public final void testGenerateFoodOrderItem3() {
		String temp = "88, 55, 20";
		myPanel.myTextFields.get(0).setText("55");
		myPanel.myTextFields.get(1).setText("88");
		myPanel.myTextFields.get(2).setText("20");
		assertEquals(temp, myPanel.generateFoodOrderItem());
	}


}
