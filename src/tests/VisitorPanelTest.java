/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package tests;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import gui.VisitorPanel;

/**
 * This contains tests of the VisitorPanel class.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class VisitorPanelTest 
{
	/** The panel that will be used in the tests. */
	private VisitorPanel myPanel;

    /**
     * This is the method that initializes the panel before each test.
     */
	@Before
	public void setUp()
	{
		myPanel = new VisitorPanel(null, "");
	}

	/**
     * Test method one for generateVisitorUpdateOnly().
     */
	@Test
	public final void testGenerateVisitorUpdateOnly1() {
		String temp = "'Michael', 'Loria', 60, 25, ";
		myPanel.myTextFields.get(0).setText("Michael");
		myPanel.myTextFields.get(1).setText("Loria");
		myPanel.myTextFields.get(2).setText("60");
		myPanel.myTextFields.get(3).setText("25");
		assertEquals(temp, myPanel.generateVisitorUpdateOnly());
	}
	
	/**
     * Test method two for generateVisitorUpdateOnly().
     */
	@Test
	public final void testGenerateVisitorUpdateOnly2() {
		String temp = "'Jacob', 'Evans', 40, 6, ";
		myPanel.myTextFields.get(0).setText("Jacob");
		myPanel.myTextFields.get(1).setText("Evans");
		myPanel.myTextFields.get(2).setText("40");
		myPanel.myTextFields.get(3).setText("6");
		assertEquals(temp, myPanel.generateVisitorUpdateOnly());
	}
	
	/**
     * Test method three for generateVisitorUpdateOnly().
     */
	@Test
	public final void testGenerateVisitorUpdateOnly3() {
		String temp = "'Terry', 'Johnson', 70, 45, ";
		myPanel.myTextFields.get(0).setText("Terry");
		myPanel.myTextFields.get(1).setText("Johnson");
		myPanel.myTextFields.get(2).setText("70");
		myPanel.myTextFields.get(3).setText("45");
		assertEquals(temp, myPanel.generateVisitorUpdateOnly());
	}
	
	/**
     * Test method one for generateVehicleUpdate().
     */
	@Test
	public final void testGenerateVehicleUpdate1() {
		String temp = "'UPEW34CC', 6";
		myPanel.myTextFields.get(4).setText("UPEW34CC");
		myPanel.myTextFields.get(5).setText("6");
		assertEquals(temp, myPanel.generateVehicleUpdate());
	}
	
	/**
     * Test method two for generateVehicleUpdate().
     */
	@Test
	public final void testGenerateVehicleUpdate2() {
		String temp = "'Y2WEVEE', 3";
		myPanel.myTextFields.get(4).setText("Y2WEVEE");
		myPanel.myTextFields.get(5).setText("3");
		assertEquals(temp, myPanel.generateVehicleUpdate());
	}
	
	/**
     * Test method three for generateVehicleUpdate().
     */
	@Test
	public final void testGenerateVehicleUpdate3() {
		String temp = "'ABCDEFG', 1";
		myPanel.myTextFields.get(4).setText("ABCDEFG");
		myPanel.myTextFields.get(5).setText("1");
		assertEquals(temp, myPanel.generateVehicleUpdate());
	}
}
