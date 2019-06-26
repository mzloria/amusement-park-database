/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package tests;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import gui.RidePanel;

/**
 * This contains tests of the RidePanel class.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class RidePanelTest 
{
	/** The panel that will be used in the tests. */
	private RidePanel myPanel;

    /**
     * This is the method that initializes the panel before each test.
     */
	@Before
	public void setUp()
	{
		myPanel = new RidePanel(null, "");
	}

	/**
     * Test method one for generateRide().
     */
	@Test
	public final void testGenerateRide1() {
		String temp = "1, 'Coaster', 'Fast and scary.', 50, 20, 45, 1";
		myPanel.myTextFields.get(0).setText("1");
		myPanel.myTextFields.get(1).setText("Coaster");
		myPanel.myTextFields.get(2).setText("Fast and scary.");
		myPanel.myTextFields.get(3).setText("50");
		myPanel.myTextFields.get(4).setText("20");
		myPanel.myTextFields.get(5).setText("45");
		myPanel.myTextFields.get(6).setText("1");
		assertEquals(temp, myPanel.generateRide());
	}
	
	/**
     * Test method two for generateRide().
     */
	@Test
	public final void testGenerateRide2() {
		String temp = "10, 'Teacup', 'Spinning.', 40, 10, 30, 3";
		myPanel.myTextFields.get(0).setText("10");
		myPanel.myTextFields.get(1).setText("Teacup");
		myPanel.myTextFields.get(2).setText("Spinning.");
		myPanel.myTextFields.get(3).setText("40");
		myPanel.myTextFields.get(4).setText("10");
		myPanel.myTextFields.get(5).setText("30");
		myPanel.myTextFields.get(6).setText("3");
		assertEquals(temp, myPanel.generateRide());
	}
	
	/**
     * Test method three for generateRide().
     */
	@Test
	public final void testGenerateRide3() {
		String temp = "5, 'Drive', 'Car driving', 60, 30, 10, 10";
		myPanel.myTextFields.get(0).setText("5");
		myPanel.myTextFields.get(1).setText("Drive");
		myPanel.myTextFields.get(2).setText("Car driving");
		myPanel.myTextFields.get(3).setText("60");
		myPanel.myTextFields.get(4).setText("30");
		myPanel.myTextFields.get(5).setText("10");
		myPanel.myTextFields.get(6).setText("10");
		assertEquals(temp, myPanel.generateRide());
	}
}
