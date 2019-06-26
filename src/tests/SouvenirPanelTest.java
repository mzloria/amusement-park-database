/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package tests;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import gui.SouvenirPanel;

/**
 * This contains tests of the SouvenirPanel class.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class SouvenirPanelTest 
{
	/** The panel that will be used in the tests. */
	private SouvenirPanel myPanel;

    /**
     * This is the method that initializes the panel before each test.
     */
	@Before
	public void setUp()
	{
		myPanel = new SouvenirPanel(null, "");
	}

	/**
     * Test method one for generateSouvenir().
     */
	@Test
	public final void testGenerateSouvenir1() {
		String temp = "1, 'Magnet', 'A souvenir magnet', 14.99";
		myPanel.myTextFields.get(0).setText("1");
		myPanel.myTextFields.get(1).setText("Magnet");
		myPanel.myTextFields.get(2).setText("A souvenir magnet");
		myPanel.myTextFields.get(3).setText("14.99");
		assertEquals(temp, myPanel.generateSouvenir());
	}
	
	/**
     * Test method two for generateSouvenir().
     */
	@Test
	public final void testGenerateSouvenir2() {
		String temp = "2, 'Mug', 'A souvenir mug', 19.99";
		myPanel.myTextFields.get(0).setText("2");
		myPanel.myTextFields.get(1).setText("Mug");
		myPanel.myTextFields.get(2).setText("A souvenir mug");
		myPanel.myTextFields.get(3).setText("19.99");
		assertEquals(temp, myPanel.generateSouvenir());
	}
	
	/**
     * Test method three for generateSouvenir().
     */
	@Test
	public final void testGenerateSouvenir3() {
		String temp = "3, 'Candle', 'A souvenir candle', 24.99";
		myPanel.myTextFields.get(0).setText("3");
		myPanel.myTextFields.get(1).setText("Candle");
		myPanel.myTextFields.get(2).setText("A souvenir candle");
		myPanel.myTextFields.get(3).setText("24.99");
		assertEquals(temp, myPanel.generateSouvenir());
	}
}
