/*
 * TCSS 445 Spring 2019
 * Amusement Park Database
 */

package tests;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import gui.ShowPanel;

/**
 * This contains tests of the ShowPanel class.
 * 
 * @author Michael Zachary Loria
 * @version June 5 2019
 */
public class ShowPanelTest 
{
	/** The panel that will be used in the tests. */
	private ShowPanel myPanel;

    /**
     * This is the method that initializes the panel before each test.
     */
	@Before
	public void setUp()
	{
		myPanel = new ShowPanel(null, "");
	}

	/**
     * Test method one for generateShow().
     */
	@Test
	public final void testGenerateShow1() {
		String temp = "1, 'The Book', 'Page turning action', 2";
		myPanel.myTextFields.get(0).setText("1");
		myPanel.myTextFields.get(1).setText("The Book");
		myPanel.myTextFields.get(2).setText("Page turning action");
		myPanel.myTextFields.get(3).setText("2");
		assertEquals(temp, myPanel.generateShow());
	}
	
	/**
     * Test method two for generateShow().
     */
	@Test
	public final void testGenerateShow2() {
		String temp = "10, 'Lion King', 'A classic', 4";
		myPanel.myTextFields.get(0).setText("10");
		myPanel.myTextFields.get(1).setText("Lion King");
		myPanel.myTextFields.get(2).setText("A classic");
		myPanel.myTextFields.get(3).setText("4");
		assertEquals(temp, myPanel.generateShow());
	}
	
	/**
     * Test method three for generateShow().
     */
	@Test
	public final void testGenerateShow3() {
		String temp = "10, 'Incredibles', 'Superheroes.', 22";
		myPanel.myTextFields.get(0).setText("10");
		myPanel.myTextFields.get(1).setText("Incredibles");
		myPanel.myTextFields.get(2).setText("Superheroes.");
		myPanel.myTextFields.get(3).setText("22");
		assertEquals(temp, myPanel.generateShow());
	}
}
