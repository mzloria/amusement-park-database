/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package tests;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import gui.FoodPanel;

/**
 * This contains tests of the FoodPanel class.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class FoodPanelTest 
{
	/** The panel that will be used in the tests. */
	private FoodPanel myPanel;

    /**
     * This is the method that initializes the panel before each test.
     */
	@Before
	public void setUp()
	{
		myPanel = new FoodPanel(null, "");
	}

	/**
     * Test method one for generateFood().
     */
	@Test
	public final void testGenerateFood1() {
		String temp = "1, 'Chicken Teriyaki', 'Juicy chicken teriyaki.', 9.99";
		myPanel.myTextFields.get(0).setText("1");
		myPanel.myTextFields.get(1).setText("Chicken Teriyaki");
		myPanel.myTextFields.get(2).setText("Juicy chicken teriyaki.");
		myPanel.myTextFields.get(3).setText("9.99");
		assertEquals(temp, myPanel.generateFood());
	}
	
	/**
     * Test method two for generateFood().
     */
	@Test
	public final void testGenerateFood2() {
		String temp = "5, 'Cotton Candy', 'Sweet.', 2.99";
		myPanel.myTextFields.get(0).setText("5");
		myPanel.myTextFields.get(1).setText("Cotton Candy");
		myPanel.myTextFields.get(2).setText("Sweet.");
		myPanel.myTextFields.get(3).setText("2.99");
		assertEquals(temp, myPanel.generateFood());
	}
	
	/**
     * Test method three for generateFood().
     */
	@Test
	public final void testGenerateFood3() {
		String temp = "30, 'Orange', 'Tangy', 1.99";
		myPanel.myTextFields.get(0).setText("30");
		myPanel.myTextFields.get(1).setText("Orange");
		myPanel.myTextFields.get(2).setText("Tangy");
		myPanel.myTextFields.get(3).setText("1.99");
		assertEquals(temp, myPanel.generateFood());
	}
}
