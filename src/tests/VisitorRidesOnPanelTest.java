/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package tests;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import gui.VisitorRidesOnPanel;

/**
 * This contains tests of the VisitorRidesOnPanel class.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class VisitorRidesOnPanelTest 
{
	/** The panel that will be used in the tests. */
	private VisitorRidesOnPanel myPanel;

    /**
     * This is the method that initializes the panel before each test.
     */
	@Before
	public void setUp()
	{
		myPanel = new VisitorRidesOnPanel(null, "");
	}

	/**
     * Test method one for generateRidesOn().
     */
	@Test
	public final void testGenerateRidesOn1() {
		String temp = "1, 2";
		myPanel.myTextFields.get(0).setText("1");
		myPanel.myTextFields.get(1).setText("2");
		assertEquals(temp, myPanel.generateRidesOn());
	}
	
	/**
     * Test method two for generateRidesOn().
     */
	@Test
	public final void testGenerateRidesOn2() {
		String temp = "13, 23";
		myPanel.myTextFields.get(0).setText("13");
		myPanel.myTextFields.get(1).setText("23");
		assertEquals(temp, myPanel.generateRidesOn());
	}
	
	/**
     * Test method three for generateRidesOn().
     */
	@Test
	public final void testGenerateRidesOn3() {
		String temp = "8, 90";
		myPanel.myTextFields.get(0).setText("8");
		myPanel.myTextFields.get(1).setText("90");
		assertEquals(temp, myPanel.generateRidesOn());
	}
}
